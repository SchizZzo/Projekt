import { useEffect, useMemo, useState } from 'react';

const contacts = [
  { id: 1, name: 'Alice', status: 'online', preview: 'Hej, jak wygląda mapa?' },
  { id: 2, name: 'Bob', status: 'offline', preview: 'Wyślę raport po 16:00.' },
  { id: 3, name: 'Charlie', status: 'online', preview: 'Możemy dodać kolejny punkt.' },
];

const history = {
  1: [
    { from: 'Alice', content: 'Hej, jak wygląda mapa?', time: '09:12' },
    { from: 'Ty', content: 'Sprawdzam nowe dane', time: '09:14' },
  ],
  2: [{ from: 'Bob', content: 'Wyślę raport po 16:00.', time: '08:55' }],
  3: [{ from: 'Charlie', content: 'Możemy dodać kolejny punkt.', time: '10:22' }],
};

const panelLimits = {
  contacts: { min: 220, max: 420 },
  preferences: { min: 260, max: 520 },
};

function ChatPage() {
  const [selected, setSelected] = useState(contacts[0].id);
  const [draft, setDraft] = useState('');
  const [quickReplies, setQuickReplies] = useState(['Jestem na mapie', 'Potwierdzam odbiór', 'Dodaję punkt']);
  const [newReply, setNewReply] = useState('');
  const [panelSizes, setPanelSizes] = useState({ contacts: 260, preferences: 320 });
  const [preferences, setPreferences] = useState({
    notifications: true,
    sound: true,
    compact: false,
    typingPreview: true,
    theme: 'ciemny',
  });
  const [invitations, setInvitations] = useState([]);
  const [invitationsLoading, setInvitationsLoading] = useState(false);
  const [invitationsError, setInvitationsError] = useState('');

  useEffect(() => {
    const controller = new AbortController();

    const fetchInvitations = async () => {
      setInvitationsLoading(true);
      setInvitationsError('');

      try {
        const response = await fetch(
          'http://localhost/joker-chat-api/joker-chat/friendships/invitations/',
          { signal: controller.signal },
        );

        if (!response.ok) {
          throw new Error(`Błąd pobierania zaproszeń (${response.status})`);
        }

        const data = await response.json();
        setInvitations(Array.isArray(data) ? data : []);
      } catch (error) {
        if (error.name !== 'AbortError') {
          setInvitations([]);
          setInvitationsError('Nie udało się pobrać zaproszeń.');
        }
      } finally {
        setInvitationsLoading(false);
      }
    };

    fetchInvitations();

    return () => {
      controller.abort();
    };
  }, []);

  const messages = useMemo(() => history[selected] ?? [], [selected]);

  const handleSend = (event) => {
    event.preventDefault();
    if (!draft.trim()) return;
    setDraft('');
  };

  const togglePreference = (key) => {
    setPreferences((prev) => ({
      ...prev,
      [key]: !prev[key],
    }));
  };

  const startResize = (panel) => (event) => {
    event.preventDefault();
    const startX = event.clientX;
    const startWidth = panel === 'contacts' ? panelSizes.contacts : panelSizes.preferences;
    const limits = panelLimits[panel];

    const onMouseMove = (moveEvent) => {
      const delta = moveEvent.clientX - startX;
      const nextWidth = Math.min(limits.max, Math.max(limits.min, startWidth + delta));

      setPanelSizes((prev) => ({
        ...prev,
        [panel]: nextWidth,
      }));
    };

    const onMouseUp = () => {
      window.removeEventListener('mousemove', onMouseMove);
      window.removeEventListener('mouseup', onMouseUp);
    };

    window.addEventListener('mousemove', onMouseMove);
    window.addEventListener('mouseup', onMouseUp);
  };

  const layoutStyle = useMemo(
    () => ({
      '--contacts-width': `${panelSizes.contacts}px`,
      '--preferences-width': `${panelSizes.preferences}px`,
    }),
    [panelSizes],
  );

  const addQuickReply = (event) => {
    event.preventDefault();
    if (!newReply.trim()) return;
    setQuickReplies((prev) => [...prev, newReply.trim()]);
    setNewReply('');
  };

  return (
    <div className="chat-layout" style={layoutStyle}>
      <aside className="contacts resizable-panel">
        <div className="contacts__header">Kontakty</div>
        <ul>
          {contacts.map((contact) => (
            <li
              key={contact.id}
              className={selected === contact.id ? 'contact active' : 'contact'}
              onClick={() => setSelected(contact.id)}
            >
              <div className="avatar">{contact.name.slice(0, 1)}</div>
              <div>
                <div className="contact-name">{contact.name}</div>
                <div className="contact-preview">{contact.preview}</div>
              </div>
              <span className={`status-dot ${contact.status}`} />
            </li>
          ))}
        </ul>
      </aside>

      <div className="resize-handle" aria-hidden="true" onMouseDown={startResize('contacts')}>
        <span className="handle-line" />
      </div>

      <section className="chat-window">
        <header className="chat-header">
          <div className="chat-title">Czat</div>
          <p className="subtitle">Czat można dostosowywać — ustaw powiadomienia, dźwięki i układ wiadomości.</p>
        </header>

        <div className="messages">
          {messages.map((message, index) => (
            <div key={index} className={message.from === 'Ty' ? 'message outgoing' : 'message incoming'}>
              <div className="message-meta">
                <strong>{message.from}</strong>
                <span>{message.time}</span>
              </div>
              <p>{message.content}</p>
            </div>
          ))}
          {!messages.length && <p className="muted">Brak wiadomości.</p>}
        </div>

        <form className="message-form" onSubmit={handleSend}>
          <input
            type="text"
            value={draft}
            onChange={(e) => setDraft(e.target.value)}
            placeholder="Napisz wiadomość..."
          />
          <button type="submit" className="primary-button" disabled={!draft.trim()}>
            Wyślij
          </button>
        </form>

        <div className="quick-replies">
          <p className="muted">Szybkie odpowiedzi</p>
          <div className="quick-replies__chips">
            {quickReplies.map((reply) => (
              <button key={reply} type="button" className="ghost-button">
                {reply}
              </button>
            ))}
          </div>
          <form className="quick-replies__form" onSubmit={addQuickReply}>
            <input
              type="text"
              placeholder="Dodaj kolejną presetową wiadomość"
              value={newReply}
              onChange={(event) => setNewReply(event.target.value)}
            />
            <button type="submit" className="primary-button" disabled={!newReply.trim()}>
              Dodaj
            </button>
          </form>
        </div>
      </section>

      <div className="resize-handle" aria-hidden="true" onMouseDown={startResize('preferences')}>
        <span className="handle-line" />
      </div>

      <aside className="chat-preferences resizable-panel">
        <div className="pref-header">
          <div>
            <p className="muted">Ustawienia czatu</p>
            <strong>Dostosuj zachowanie</strong>
          </div>
          <span className="badge">Live</span>
        </div>

        <div className="preferences-grid">
          <div className="pref-row">
            <div>
              <strong>Powiadomienia</strong>
              <p className="muted">Poinformuj mnie o nowych wiadomościach.</p>
            </div>
            <label className="switch">
              <input
                type="checkbox"
                checked={preferences.notifications}
                onChange={() => togglePreference('notifications')}
              />
              <span className="slider" />
            </label>
          </div>

          <div className="pref-row">
            <div>
              <strong>Dźwięk</strong>
              <p className="muted">Krótki sygnał dźwiękowy dla ważnych kontaktów.</p>
            </div>
            <label className="switch">
              <input type="checkbox" checked={preferences.sound} onChange={() => togglePreference('sound')} />
              <span className="slider" />
            </label>
          </div>

          <div className="pref-row">
            <div>
              <strong>Widok kompaktowy</strong>
              <p className="muted">Ściśnij odstępy w wątku czatu.</p>
            </div>
            <label className="switch">
              <input type="checkbox" checked={preferences.compact} onChange={() => togglePreference('compact')} />
              <span className="slider" />
            </label>
          </div>

          <div className="pref-row">
            <div>
              <strong>Podgląd pisania</strong>
              <p className="muted">Wyświetlaj, gdy ktoś pisze wiadomość.</p>
            </div>
            <label className="switch">
              <input
                type="checkbox"
                checked={preferences.typingPreview}
                onChange={() => togglePreference('typingPreview')}
              />
              <span className="slider" />
            </label>
          </div>

          <div className="pref-row select-row">
            <div>
              <strong>Motyw</strong>
              <p className="muted">Wybierz styl okna rozmowy.</p>
            </div>
            <select
              value={preferences.theme}
              onChange={(event) => setPreferences((prev) => ({ ...prev, theme: event.target.value }))}
            >
              <option value="ciemny">Ciemny</option>
              <option value="kontrastowy">Kontrastowy</option>
              <option value="pastelowy">Pastelowy</option>
            </select>
          </div>
        </div>

        <div className="pref-summary">
          <p className="muted">Podgląd ustawień</p>
          <ul>
            <li>
              <span>Powiadomienia</span>
              <strong>{preferences.notifications ? 'Włączone' : 'Wyłączone'}</strong>
            </li>
            <li>
              <span>Dźwięk</span>
              <strong>{preferences.sound ? 'Włączony' : 'Wyłączony'}</strong>
            </li>
            <li>
              <span>Widok</span>
              <strong>{preferences.compact ? 'Kompaktowy' : 'Standardowy'}</strong>
            </li>
            <li>
              <span>Podgląd pisania</span>
              <strong>{preferences.typingPreview ? 'Widzoczny' : 'Ukryty'}</strong>
            </li>
            <li>
              <span>Motyw</span>
              <strong className="pill pill-outline">{preferences.theme}</strong>
            </li>
          </ul>
        </div>

        <div className="pref-summary invitations-section">
          <p className="muted">Otrzymane zaproszenia</p>

          {invitationsLoading && <p>Ładowanie zaproszeń...</p>}
          {invitationsError && <p className="error-text">{invitationsError}</p>}

          {!invitationsLoading && !invitationsError && !invitations.length && (
            <p className="muted">Brak nowych zaproszeń.</p>
          )}

          {!!invitations.length && (
            <ul className="invitations-list">
              {invitations.map((invitation, index) => (
                <li key={invitation.id ?? invitation.uuid ?? index} className="invitation-item">
                  <div className="invitation-header">
                    <strong>
                      {invitation.friend_username || invitation.sender || invitation.username || 'Nieznajomy użytkownik'}
                    </strong>
                    {invitation.created_at && <span className="pill">{invitation.created_at}</span>}
                  </div>
                  {invitation.friend_message || invitation.message ? (
                    <p className="muted">{invitation.friend_message || invitation.message}</p>
                  ) : (
                    <p className="muted">Zaproszenie do znajomych czeka na Twoją reakcję.</p>
                  )}
                </li>
              ))}
            </ul>
          )}
        </div>
      </aside>
    </div>
  );
}

export default ChatPage;
