from django.urls import path

from .views import (
    AvailableUsersAPIView,
    CurrentUserAPIView,
    LoginAPIView,
    RegisterAPIView,
)


app_name = "login"

urlpatterns = [
    path("login/", LoginAPIView.as_view(), name="login"),
    path("register/", RegisterAPIView.as_view(), name="register"),
    path("me/", CurrentUserAPIView.as_view(), name="current_user"),
    path(
        "available-users/",
        AvailableUsersAPIView.as_view(),
        name="available_users",
    ),
]
