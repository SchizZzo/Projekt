import { useEffect, useMemo, useState } from 'react';
import MordeczkiAnimation from '../components/MordeczkiAnimation';

const defaultCharacter = {
  kolorSkory: 0,
  kolorWlosow: 0,
  usta: 0,
  dodatek: 0,
  twarz: 0,
  wlosy: 0,
};

function SettingsPage() {
  const [character, setCharacter] = useState(defaultCharacter);
  const [nickname, setNickname] = useState('');
  const [opis, setOpis] = useState('');
  const [info, setInfo] = useState('');
  const [isLoading, setIsLoading] = useState(true);
  const [notificationsEnabled, setNotificationsEnabled] = useState(true);
  const [showDialog, setShowDialog] = useState(false);
  const [confirmDelete, setConfirmDelete] = useState(false);

  const palettes = useMemo(
    () => ({
      kolorSkory: ['#f2d0c4', '#d1a28f', '#8d5524'],
      kolorWlosow: ['#1f2933', '#a55728', '#d6b370', '#fed766'],
      usta: ['#ffb4a2', '#ff7b9c', '#e84855'],
      dodatek: ['#e0f2fe', '#c7d2fe', '#d9f99d', '#fecdd3', '#fef9c3'],
      twarz: ['#fde68a', '#86efac', '#bfdbfe', '#fecdd3'],
      wlosy: ['#111827', '#1f2937', '#374151', '#4b5563', '#6b7280', '#9ca3af', '#cbd5e1', '#e5e7eb', '#f3f4f6'],
    }),
    [],
  );

  const optionLimits = {
    kolorSkory: 3,
    kolorWlosow: 4,
    usta: 3,
    dodatek: 5,
    twarz: 4,
    wlosy: 9,
  };

  useEffect(() => {
    const fetchUserAvatar = async () => {
      // Symulacja pobierania danych jak w aplikacji Flutter.
      await new Promise((resolve) => setTimeout(resolve, 450));
      const storedCooldown = Number(localStorage.getItem('nicknameCooldownUntil') ?? 0);
      const mockUser = {
        user_id: 'demo-user',
        poziom: 4,
        display_name: 'Mordeczka',
        opis: 'Tworzę swoje alter ego na podstawie Rive.',
        notifications: true,
        character: {
          kolorSkory: 1,
          kolorWlosow: 2,
          usta: 0,
          dodatek: 3,
          twarz: 1,
          wlosy: 4,
        },
        cooldownUntil: storedCooldown,
      };

      setCharacter(mockUser.character);
      setNickname(mockUser.display_name);
      setOpis(mockUser.opis);
      setNotificationsEnabled(mockUser.notifications);
      setIsLoading(false);
    };

    fetchUserAvatar();
  }, []);

  const handleCycle = (key) => {
    setCharacter((prev) => ({
      ...prev,
      [key]: (prev[key] + 1) % optionLimits[key],
    }));
  };

  const saveNotificationPreference = (value) => {
    setNotificationsEnabled(value);
    localStorage.setItem('notificationsEnabled', value ? 'true' : 'false');
  };

  const handleNicknameHistory = (nextNickname) => {
    const now = Date.now();
    const cooldownUntil = Number(localStorage.getItem('nicknameCooldownUntil') ?? 0);

    if (cooldownUntil > now && nextNickname !== nickname) {
      const minutesLeft = Math.ceil((cooldownUntil - now) / 60000);
      return `Możesz zmienić nick za ${minutesLeft} min.`;
    }

    const newCooldown = now + 10 * 60 * 1000; // 10 minut na kolejną zmianę.
    localStorage.setItem('nicknameCooldownUntil', `${newCooldown}`);
    return 'Zapisano zmiany nazwy użytkownika.';
  };

  const handleSave = () => {
    if (!nickname.trim()) {
      setInfo('Wpisz nazwę użytkownika, aby zapisać zmiany.');
      return;
    }

    if (!opis.trim()) {
      setInfo('Dodaj opis, aby inni wiedzieli kim jesteś.');
      return;
    }

    const nicknameStatus = handleNicknameHistory(nickname.trim());
    setInfo(nicknameStatus);

    const payload = {
      ...character,
      nickname: nickname.trim(),
      opis: opis.trim(),
      notificationsEnabled,
    };

    localStorage.setItem('mordeczkaDraft', JSON.stringify(payload));
  };

  const avatarStyle = useMemo(
    () => ({
      '--skin': palettes.kolorSkory[character.kolorSkory],
      '--hair': palettes.kolorWlosow[character.kolorWlosow],
      '--accent': palettes.dodatek[character.dodatek],
      '--mouth': palettes.usta[character.usta],
      '--frame': palettes.twarz[character.twarz],
    }),
    [character, palettes],
  );

  return (
    <div className="card">
      <p className="badge">Ustawienia</p>
      <h1>Panel kreatora Mordeczki</h1>
      <p className="subtitle">
        Odwzoruj logikę znaną z aplikacji Flutter: edytuj avatar, opis oraz opcje dodatkowe.
      </p>

      <div className="settings-grid">
        <section className="setting-block">
          <div className="setting-header">
            <h3>Profil</h3>
            <p>Uzupełnij nazwę i opis widoczny dla innych użytkowników.</p>
          </div>
          <div className="stack">
            <label className="field">
              <span>Nazwa (nickname)</span>
              <input
                type="text"
                value={nickname}
                onChange={(event) => setNickname(event.target.value)}
                placeholder="Wpisz swoją nazwę"
              />
            </label>
            <label className="field">
              <span>Opis profilu</span>
              <input
                type="text"
                value={opis}
                onChange={(event) => setOpis(event.target.value)}
                placeholder="Wpisz swój opis"
              />
            </label>
            <div className="status" data-variant="warning">
              <strong>Dodatkowe ustawienia</strong>
              <p>
                Powiadomienia i usuwanie konta dostępne są w sekcji dialogu inspirowanej przyciskiem
                "inne ustawienia" z Fluttera.
              </p>
              <div className="actions-row">
                <button className="ghost-button" type="button" onClick={() => setShowDialog(true)}>
                  Otwórz ustawienia
                </button>
              </div>
            </div>
          </div>
        </section>

        <section className="setting-block">
          <div className="setting-header">
            <h3>Mordeczka</h3>
            <p>Zmiana cech poprzez inkrementację wartości tak jak w sterowaniu StateMachine.</p>
          </div>

          <div className="avatar-preview" style={avatarStyle}>
            <div className="avatar-frame">
              <div className="avatar-face" />
              <div className="avatar-mouth" />
              <div className="avatar-hair" />
              <div className="avatar-accent" />
            </div>
            {isLoading && <div className="avatar-loading">Wczytywanie...</div>}
          </div>

          <div className="avatar-player">
            <p className="subtitle">Podgląd z oryginalnego pliku Rive (mordeczki4.riv)</p>
            <MordeczkiAnimation />
          </div>

          <div className="controls-grid">
            {Object.entries(optionLimits).map(([key, limit]) => (
              <button
                key={key}
                className="control-button"
                type="button"
                onClick={() => handleCycle(key)}
                disabled={isLoading}
              >
                {key} ({character[key] + 1}/{limit})
              </button>
            ))}
          </div>
        </section>
      </div>

      <div className="settings-footer">
        <div className="status" data-variant={info.includes('Możesz') ? 'warning' : 'success'}>
          <strong>Informacja</strong>
          <p>{info || 'Zmiany nie zostały jeszcze zapisane.'}</p>
        </div>
        <button className="primary" type="button" onClick={handleSave} disabled={isLoading}>
          Zapisz ustawienia
        </button>
      </div>

      {showDialog && (
        <div className="dialog-backdrop" role="dialog" aria-modal="true">
          <div className="dialog-card">
            <div className="dialog-header">
              <h3>Dodatkowe ustawienia</h3>
              <button type="button" className="ghost-button" onClick={() => setShowDialog(false)}>
                Zamknij
              </button>
            </div>
            <div className="dialog-body">
              <label className="toggle-row">
                <span>
                  Powiadomienia (po zmianie zaloguj się ponownie)
                  <br />
                  <small>Stan synchronizowany lokalnie tak jak w Flutterze.</small>
                </span>
                <label className="switch">
                  <input
                    type="checkbox"
                    checked={notificationsEnabled}
                    onChange={(event) => saveNotificationPreference(event.target.checked)}
                  />
                  <span className="slider" />
                </label>
              </label>

              <div className="danger-zone">
                <div>
                  <strong>Usuwanie konta</strong>
                  <p>
                    Symulacja dialogu potwierdzenia. W prawdziwej aplikacji tutaj następuje wywołanie
                    FirebaseAuth oraz API usuwania.
                  </p>
                </div>
                <button className="danger-button" type="button" onClick={() => setConfirmDelete(true)}>
                  Usuń konto
                </button>
              </div>

              {confirmDelete && (
                <div className="confirm-card">
                  <p>Czy na pewno chcesz usunąć konto?</p>
                  <div className="actions-row">
                    <button className="ghost-button" type="button" onClick={() => setConfirmDelete(false)}>
                      Anuluj
                    </button>
                    <button
                      className="danger-button"
                      type="button"
                      onClick={() => setInfo('Konto zostałoby usunięte po stronie serwera.')}
                    >
                      Usuń
                    </button>
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

export default SettingsPage;
