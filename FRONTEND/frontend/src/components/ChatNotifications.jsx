import { useEffect, useRef, useState } from 'react';
import { apiRequest } from '../api/client.js';
import newMessageSound from '../assets/nowy_dzwiek_wiadomosci.mp3';
import { loadChatPreferences, subscribeToChatPreferences } from '../utils/chatPreferences.js';

function ChatNotifications({ isChatPage }) {
  const [userId, setUserId] = useState('');
  const [preferences, setPreferences] = useState(() => loadChatPreferences());
  const [isWindowFocused, setIsWindowFocused] = useState(() =>
    typeof document !== 'undefined' ? document.hasFocus() : true,
  );
  const socketRef = useRef(null);
  const messageSoundRef = useRef(null);

  useEffect(() => {
    const unsubscribe = subscribeToChatPreferences(setPreferences);
    return unsubscribe;
  }, []);

  useEffect(() => {
    setPreferences(loadChatPreferences());
  }, [isChatPage]);

  useEffect(() => {
    messageSoundRef.current = new Audio(newMessageSound);
    messageSoundRef.current.preload = 'auto';

    return () => {
      if (messageSoundRef.current) {
        messageSoundRef.current.pause();
        messageSoundRef.current = null;
      }
    };
  }, []);

  useEffect(() => {
    if (!messageSoundRef.current) return;

    messageSoundRef.current.muted = !preferences.sound;
  }, [preferences.sound]);

  useEffect(() => {
    const handleFocus = () => setIsWindowFocused(true);
    const handleBlur = () => setIsWindowFocused(false);

    window.addEventListener('focus', handleFocus);
    window.addEventListener('blur', handleBlur);

    return () => {
      window.removeEventListener('focus', handleFocus);
      window.removeEventListener('blur', handleBlur);
    };
  }, []);

  useEffect(() => {
    if (!preferences.notifications || typeof Notification === 'undefined') return;

    if (Notification.permission === 'default') {
      Notification.requestPermission().catch((error) =>
        console.error('Nie udało się uzyskać zgody na powiadomienia.', error),
      );
    }
  }, [preferences.notifications]);

  useEffect(() => {
    if (isChatPage) return undefined;

    const controller = new AbortController();

    const fetchUserId = async () => {
      try {
        const response = await apiRequest('/joker-login-api/me/', { signal: controller.signal });

        if (!response.ok) {
          throw new Error('Błąd pobierania profilu użytkownika.');
        }

        const data = await response.json();
        const resolvedId = data?.id ?? data?.user_id ?? data?.userId ?? '';

        setUserId(String(resolvedId));
      } catch (error) {
        if (error.name !== 'AbortError') {
          console.error('Nie udało się pobrać identyfikatora użytkownika do powiadomień.', error);
          setUserId('');
        }
      }
    };

    fetchUserId();

    return () => controller.abort();
  }, [isChatPage]);

  useEffect(() => {
    if (isChatPage || !userId) {
      if (socketRef.current) {
        socketRef.current.close();
        socketRef.current = null;
      }
      return undefined;
    }

    const playMessageSound = () => {
      if (!preferences.sound || !messageSoundRef.current) return;

      try {
        messageSoundRef.current.currentTime = 0;
        void messageSoundRef.current.play();
      } catch (error) {
        console.error('Nie udało się odtworzyć dźwięku wiadomości.', error);
      }
    };

    const socket = new WebSocket(`wss://czat-backend.michalowicz.dev/ws/chat/${userId}/`);
    socketRef.current = socket;

    socket.onmessage = (event) => {
      try {
        const data = JSON.parse(event.data);
        const senderKey =
          data?.nadawca ?? data?.sender ?? data?.author ?? data?.user ?? data?.user_id ?? data?.from;

        if (userId && senderKey?.toString?.() === userId.toString()) {
          return;
        }

        const isBackground = document.hidden || !isWindowFocused;
        const shouldShowNotification =
          isBackground &&
          preferences.notifications &&
          typeof Notification !== 'undefined' &&
          Notification.permission === 'granted';

        playMessageSound();

        if (shouldShowNotification) {
          const title = data?.nadawca ? `Nowa wiadomość od ${data.nadawca}` : 'Nowa wiadomość';
          const body = data?.message || 'Otrzymałeś nową wiadomość.';

          try {
            new Notification(title, { body, silent: false });
          } catch (notificationError) {
            console.error('Nie udało się wyświetlić powiadomienia.', notificationError);
          }
        }
      } catch (error) {
        console.error('Nieprawidłowy komunikat WebSocket (powiadomienia).', error);
      }
    };

    socket.onerror = () => {
      console.error('Wystąpił problem z połączeniem WebSocket (powiadomienia).');
    };

    socket.onclose = () => {
      socketRef.current = null;
    };

    return () => {
      socketRef.current = null;
      socket.close();
    };
  }, [isChatPage, isWindowFocused, preferences.notifications, preferences.sound, userId]);

  return null;
}

export default ChatNotifications;
