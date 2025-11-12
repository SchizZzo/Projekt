from rest_framework import status
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.tokens import RefreshToken

from .serializers import LoginSerializer, RegisterSerializer


class LoginAPIView(APIView):
    """
    API endpoint providing JWT authentication tokens to clients.
    This POST endpoint accepts user credentials and issues both access and refresh tokens.
    Usage example:
        POST /login/ with JSON payload:
            {
                "email": "user@example.com",
                "password": "secure_password"
            }
    Returns:
        JSON object containing:
            - access: Short-lived access token for authenticated requests.
            - refresh: Long-lived refresh token for obtaining new access tokens.
    """
    

    permission_classes = [AllowAny]

    def post(self, request, *args, **kwargs):
        serializer = LoginSerializer(data=request.data, context={"request": request})
        serializer.is_valid(raise_exception=True)

        user = serializer.validated_data["user"]
        refresh = RefreshToken.for_user(user)

        return Response(
            {"access": str(refresh.access_token), "refresh": str(refresh)},
            status=status.HTTP_200_OK,
        )


class RegisterAPIView(APIView):
    """Handle user registration requests, validating payload with RegisterSerializer and creating a new user via the public API endpoint."""

    permission_classes = [AllowAny]

    def post(self, request, *args, **kwargs):
        serializer = RegisterSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
