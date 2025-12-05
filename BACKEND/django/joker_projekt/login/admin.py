from django.contrib import admin
from django.contrib.auth import get_user_model

from .models import SiteDocument

user = get_user_model()


@admin.register(user)
class UserAdmin(admin.ModelAdmin):
    list_display = ("id", "username", "email", "first_name", "last_name")
    search_fields = ("username", "email")


@admin.register(SiteDocument)
class SiteDocumentAdmin(admin.ModelAdmin):
    list_display = ("title", "document_type", "updated_at")
    list_filter = ("document_type",)
    search_fields = ("title", "content")
