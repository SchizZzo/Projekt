from django.contrib.auth import authenticate, get_user_model
from django.contrib.auth.password_validation import validate_password
from django.core.exceptions import ValidationError as DjangoValidationError
from decimal import Decimal, InvalidOperation

from django.utils.translation import gettext_lazy as _
from rest_framework import serializers

from .models import SiteDocument


class LoginSerializer(serializers.Serializer):
    """Serializer used to validate login credentials."""

    email = serializers.EmailField()
    password = serializers.CharField(write_only=True, style={"input_type": "password"})

    def validate(self, attrs):
        email = attrs.get("email")
        password = attrs.get("password")

        if email and password:
            user_model = get_user_model()
            users = user_model.objects.filter(email__iexact=email)

            if users.count() > 1:
                msg = _(
                    "Multiple accounts are associated with this email. Please log in using your username."
                )
                raise serializers.ValidationError(msg, code="authorization")

            user = users.first()

            if user:
                username_field = user_model.USERNAME_FIELD
                user = authenticate(
                    request=self.context.get("request"),
                    username=getattr(user, username_field),
                    password=password,
                )
        else:
            msg = _("Email and password are required.")
            raise serializers.ValidationError(msg, code="authorization")

        if not user:
            msg = _("Unable to log in with provided credentials.")
            raise serializers.ValidationError(msg, code="authorization")

        attrs["user"] = user
        return attrs


class RegisterSerializer(serializers.ModelSerializer):
    """Serializer used to register new users."""

    email = serializers.EmailField(required=True)
    password = serializers.CharField(
        write_only=True,
        style={"input_type": "password"},
    )
    password_confirm = serializers.CharField(
        write_only=True,
        style={"input_type": "password"},
    )

    class Meta:
        model = get_user_model()
        fields = ("username", "email", "password", "password_confirm")

    def validate_email(self, value):
        user_model = self.Meta.model
        if user_model.objects.filter(email__iexact=value).exists():
            raise serializers.ValidationError(
                _("A user with that email address already exists.")
            )
        return value

    def validate_username(self, value):
        user_model = self.Meta.model
        if user_model.objects.filter(username=value).exists():
            raise serializers.ValidationError(_("A user with that username already exists."))
        return value

    def validate(self, attrs):
        password = attrs.get("password")
        password_confirm = attrs.pop("password_confirm", None)

        if password != password_confirm:
            raise serializers.ValidationError({"password_confirm": _("Passwords do not match.")})

        return attrs

    def create(self, validated_data):
        password = validated_data.pop("password")
        user_model = self.Meta.model
        user = user_model(**validated_data)

        try:
            validate_password(password, user)
        except DjangoValidationError as exc:
            raise serializers.ValidationError({"password": list(exc.messages)}) from exc

        user.set_password(password)
        user.save()
        return user


class CurrentUserSerializer(serializers.ModelSerializer):
    """Serializer used to update and return data for the currently authenticated user."""

    display_name = serializers.CharField(required=False, allow_blank=True, allow_null=True)

    class Meta:
        model = get_user_model()
        fields = (
            "id",
            "username",
            "email",
            "display_name",
            "opis",
            "status",
            "character",
            "latitude",
            "longitude",
            "location_type",
        )
        read_only_fields = ("username",)

    def validate_display_name(self, value):
        user_model = self.Meta.model
        if value:
            qs = user_model.objects.filter(display_name__iexact=value).exclude(
                pk=self.instance.pk if self.instance else None
            )
            if qs.exists():
                raise serializers.ValidationError(
                    _("A user with that display name already exists.")
                )
        return value

    def validate(self, attrs):
        """Normalize coordinates so they can be saved without validation errors.

        The Decimal fields on the model accept up to 14 decimal places. Browsers
        can send coordinates with more precision, which previously caused a 400
        response when attempting to save the profile. By rounding both latitude
        and longitude to 14 decimal places we keep the value accurate while
        matching the database constraints.
        """

        latitude = attrs.get("latitude")
        longitude = attrs.get("longitude")

        if latitude is None and longitude is None:
            return attrs

        if latitude is None or longitude is None:
            raise serializers.ValidationError(
                {"location": _("Both latitude and longitude are required to update location.")}
            )

        try:
            quantize_exp = Decimal("1.00000000000000")  # 14 decimal places
            attrs["latitude"] = Decimal(str(latitude)).quantize(quantize_exp)
            attrs["longitude"] = Decimal(str(longitude)).quantize(quantize_exp)
        except (InvalidOperation, TypeError, ValueError) as exc:
            raise serializers.ValidationError(
                {"location": _("Invalid coordinates provided.")}
            ) from exc

        return attrs


class AvailableUserSerializer(serializers.ModelSerializer):
    """Read-only serializer exposing public data for available users."""

    distance = serializers.SerializerMethodField()

    class Meta:
        model = get_user_model()
        fields = (
            "id",

            "username",
            
            "display_name",
            "opis",
            "status",
            "character",
            "latitude",
            "longitude",
            "location_type",
            "distance",
        )
        read_only_fields = fields

    def get_distance(self, obj):
        distance = getattr(obj, "distance", None)
        if distance is None:
            return None
        return distance.km


class SiteDocumentSerializer(serializers.ModelSerializer):
    """Serializer exposing public legal documents."""

    class Meta:
        model = SiteDocument
        fields = ("title", "slug", "document_type", "content", "updated_at")
        read_only_fields = fields
