from rest_framework.routers import DefaultRouter


from .api_views import ChatMessageViewSet, FriendshipViewSet, MessageViewSet
from django.urls import include, path

router = DefaultRouter()
router.register(r'messages', ChatMessageViewSet, basename='chat-message')
router.register(r'friendships', FriendshipViewSet, basename='friendships')
router.register(r'wiadomosci', MessageViewSet, basename='wiadomosci')


urlpatterns = [
    path('joker-chat/', include(router.urls)),

]