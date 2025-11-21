from django.urls import path

from .views import CurrentUserAPIView, LoginAPIView, RegisterAPIView


app_name = "login"

urlpatterns = [
    path("login/", LoginAPIView.as_view(), name="login"),
    path("register/", RegisterAPIView.as_view(), name="register"),
    path("me/", CurrentUserAPIView.as_view(), name="current_user"),
]
