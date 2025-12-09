const STORAGE_KEY = 'chatPreferences';

export const defaultChatPreferences = {
  notifications: true,
  sound: true,
  compact: false,
  typingPreview: true,
  theme: 'ciemny',
};

export function loadChatPreferences() {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (!raw) return defaultChatPreferences;

    const parsed = JSON.parse(raw);
    return { ...defaultChatPreferences, ...parsed };
  } catch (error) {
    console.error('Nie udało się odczytać preferencji czatu.', error);
    return defaultChatPreferences;
  }
}

export function saveChatPreferences(preferences) {
  try {
    const mergedPreferences = { ...defaultChatPreferences, ...preferences };
    localStorage.setItem(STORAGE_KEY, JSON.stringify(mergedPreferences));
  } catch (error) {
    console.error('Nie udało się zapisać preferencji czatu.', error);
  }
}

export function subscribeToChatPreferences(callback) {
  const handleStorage = (event) => {
    if (event.key !== STORAGE_KEY) return;
    callback(loadChatPreferences());
  };

  window.addEventListener('storage', handleStorage);
  return () => window.removeEventListener('storage', handleStorage);
}

