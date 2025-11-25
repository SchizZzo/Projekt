import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { apiRequest } from '../api/client.js';
import MordkaPreview from '../components/MordkaPreview';

const panelLimits = {
  contacts: { min: 220, max: 420 },
  preferences: { min: 260, max: 520 },
};

function ChatPage() {
  const [contacts, setContacts] = useState([]);
  const [contactsLoading, setContactsLoading] = useState(false);
  const [contactsError, setContactsError] = useState('');
  const [selected, setSelected] = useState(null);
  const [userId, setUserId] = useState('');
  const [userIdLoading, setUserIdLoading] = useState(false);
  const [socketStatus, setSocketStatus] = useState('disconnected');
  const [socketError, setSocketError] = useState('');
  const [messagesByContact, setMessagesByContact] = useState({});
  const [messagesLoading, setMessagesLoading] = useState(false);
  const [messagesError, setMessagesError] = useState('');
  const socketRef = useRef(null);
  const contactsRef = useRef([]);
  const [draft, setDraft] = useState('');
  const [quickReplies, setQuickReplies] = useState(['Jestem na mapie', 'Potwierdzam odbiór', 'Dodaję punkt']);
  const [newReply, setNewReply] = useState('');
  const [panelSizes, setPanelSizes] = useState({ contacts: 260, preferences: 320 });
  const [sidebarWidth] = useState(240);
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
  const [lastInvitationsUpdate, setLastInvitationsUpdate] = useState('');
  const [activeInvitationKey, setActiveInvitationKey] = useState(null);
  const [invitationActionState, setInvitationActionState] = useState({ status: 'idle', message: '' });

  const getContactKey = useCallback((contact, fallbackIndex) => {
    return (
      contact?.friend_id ??
      contact?.friend_user_id ??
      contact?.friend_uuid ??
      contact?.id ??
      contact?.uuid ??
      contact?.friend_username ??
      fallbackIndex
    );
  }, []);

  const getContactId = useCallback((contact) => {
    if (!contact) return null;

    return (
      contact.friend_id ??
      contact.friend_user_id ??
      contact.friend_uuid ??
      contact.uuid ??
      contact.id ??
      null
    );
  }, []);

  const getContactDisplayName = useCallback((contact, fallback = 'Nieznany kontakt') => {
    if (!contact) return fallback;

    return (
      contact.friend_display_name ||
      contact.friend_username ||
      contact.username ||
      contact.display_name ||
      contact.name ||
      fallback
    );
  }, []);

  const getContactByKey = useCallback(
    (contactKey) => {
      const stringKey = contactKey?.toString?.();
      if (!stringKey) return null;

      return (
        contactsRef.current.find((contact, index) => {
          const key = getContactKey(contact, index);
          return key?.toString?.() === stringKey;
        }) ?? null
      );
    },
    [getContactKey],
  );

  const getCreatedLabel = useCallback((invitation) => {
    const rawDate = invitation.created_at || invitation.created;
    if (!rawDate) return '';

    try {
      const parsed = new Date(rawDate);
      if (Number.isNaN(parsed.getTime())) return rawDate;

      return parsed.toLocaleString();
    } catch (error) {
      return rawDate;
    }
  }, []);

  const resolveStatus = useCallback((invitation) => {
    const rawStatus =
      invitation.status ||
      invitation.state ||
      invitation.decision_status ||
      invitation.invitation_status ||
      '';

    const lowered = rawStatus.toString().trim().toLowerCase();
    const labeledStatus =
      {
        pending: 'Oczekujące',
        accepted: 'Zaakceptowane',
        rejected: 'Odrzucone',
        declined: 'Odrzucone',
        canceled: 'Anulowane',
      }[lowered] || '';

    if (labeledStatus) return labeledStatus;
    if (invitation.accepted) return 'Zaakceptowane';
    if (invitation.rejected || invitation.declined) return 'Odrzucone';

    return rawStatus || 'Oczekujące';
  }, []);

  const fetchInvitations = useCallback(
    async (signal) => {
      setInvitationsLoading(true);
      setInvitationsError('');

      try {
        const response = await apiRequest(
          '/joker-chat-api/joker-chat/friendships/invitations/',
          { signal },
        );

        if (!response.ok) {
          throw new Error(`Błąd pobierania zaproszeń (${response.status})`);
        }

        const data = await response.json();
        setInvitations(Array.isArray(data) ? data : []);
        setLastInvitationsUpdate(new Date().toLocaleString());
      } catch (error) {
        if (error.name !== 'AbortError') {
          setInvitations([]);
          setInvitationsError('Nie udało się pobrać zaproszeń.');
        }
      } finally {
        setInvitationsLoading(false);
      }
    },
    [resolveStatus],
  );

  const fetchUserId = useCallback(async (signal) => {
    setUserIdLoading(true);

    try {
      const response = await apiRequest('/joker-login-api/me/', { signal });

      if (!response.ok) {
        throw new Error('Błąd pobierania profilu użytkownika.');
      }

      const data = await response.json();
      const resolvedId = data?.id ?? data?.user_id ?? data?.userId ?? '';

      if (resolvedId) {
        setUserId(String(resolvedId));
        setSocketError('');
      }
    } catch (error) {
      if (error.name !== 'AbortError') {
        setSocketError('Nie udało się pobrać identyfikatora użytkownika.');
      }
    } finally {
      setUserIdLoading(false);
    }
  }, []);

  useEffect(() => {
    const controller = new AbortController();

    fetchInvitations(controller.signal);

    return () => {
      controller.abort();
    };
  }, [fetchInvitations]);

  const fetchContacts = useCallback(async (signal) => {
    setContactsLoading(true);
    setContactsError('');

    try {
      const response = await apiRequest('/joker-chat-api/joker-chat/friendships/friends/', { signal });

      if (!response.ok) {
        throw new Error(`Błąd pobierania kontaktów (${response.status})`);
      }

      const data = await response.json();
      const normalized = Array.isArray(data) ? data : [];

      setContacts(normalized);

      if (normalized.length) {
        const firstContactKey = getContactKey(normalized[0], 0);

        setSelected((prev) => (prev === null ? firstContactKey : prev));
      }
    } catch (error) {
      if (error.name !== 'AbortError') {
        setContactsError('Nie udało się pobrać kontaktów.');
        setContacts([]);
      }
    } finally {
      setContactsLoading(false);
    }
  }, [getContactKey]);

  useEffect(() => {
    const controller = new AbortController();

    fetchContacts(controller.signal);
    fetchUserId(controller.signal);

    return () => controller.abort();
  }, [fetchContacts, fetchUserId]);

  useEffect(() => {
    if (userId || userIdLoading) return undefined;

    const controller = new AbortController();
    fetchUserId(controller.signal);

    return () => controller.abort();
  }, [fetchUserId, userId, userIdLoading]);

  const coerceId = useCallback((rawId) => {
    const numericId = Number(rawId);
    return Number.isNaN(numericId) ? rawId : numericId;
  }, []);

  useEffect(() => {
    contactsRef.current = contacts;
  }, [contacts]);

  const appendMessage = useCallback((conversationKey, message) => {
    if (!conversationKey) return;

    setMessagesByContact((prev) => {
      const key = conversationKey.toString();
      const existing = prev[key] ?? [];
      return {
        ...prev,
        [key]: [...existing, message],
      };
    });
  }, []);

  useEffect(() => {
    if (!userId) {
      if (socketRef.current) {
        socketRef.current.close();
        socketRef.current = null;
      }
      setSocketStatus('disconnected');
      return undefined;
    }

    setSocketStatus('connecting');
    setSocketError('');

    const socket = new WebSocket(`ws://localhost/ws/chat/${userId}/`);
    socketRef.current = socket;

    socket.onopen = () => setSocketStatus('open');

    socket.onerror = () => {
      setSocketStatus('error');
      setSocketError('Wystąpił problem z połączeniem WebSocket.');
    };

    socket.onclose = () => {
      setSocketStatus('closed');
    };

    socket.onmessage = (event) => {
      try {
        const data = JSON.parse(event.data);
        const senderKey = data?.nadawca ?? data?.sender ?? 'nieznany';
        const senderContact = getContactByKey(senderKey);
        const senderName = getContactDisplayName(senderContact, senderKey || 'Nieznany kontakt');
        const readableTime = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

        appendMessage(senderKey, {
          from: senderName,
          content: data?.message ?? '',
          time: readableTime,
        });
      } catch (error) {
        console.error('Nieprawidłowy komunikat WebSocket:', error);
      }
    };

    return () => {
      socketRef.current = null;
      socket.close();
    };
  }, [appendMessage, getContactByKey, getContactDisplayName, userId]);

  const selectedContact = useMemo(
    () => contacts.find((contact, index) => getContactKey(contact, index) === selected) ?? null,
    [contacts, getContactKey, selected],
  );

  const messages = useMemo(
    () => messagesByContact[selected?.toString?.() ?? selected] ?? [],
    [messagesByContact, selected],
  );

  const displayedMessages = useMemo(
    () => (Array.isArray(messages) ? [...messages].reverse() : []),
    [messages],
  );

  const formatApiMessage = useCallback(
    (message, contactName) => {
      const senderId =
        message?.nadawca ??
        message?.sender ??
        message?.author ??
        message?.user ??
        message?.user_id ??
        message?.from ??
        '';

      const rawTimestamp =
        message?.created_at ?? message?.created ?? message?.timestamp ?? message?.time ?? '';
      const parsedDate = rawTimestamp ? new Date(rawTimestamp) : null;
      const readableTime =
        parsedDate && !Number.isNaN(parsedDate.getTime())
          ? parsedDate.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
          : '';

      return {
        from: senderId?.toString?.() === userId?.toString?.() ? 'Ty' : contactName,
        content: message?.message ?? message?.content ?? message?.text ?? '',
        time: readableTime || '—',
      };
    },
    [userId],
  );

  useEffect(() => {
    const activeKey = selected?.toString?.();
    if (!activeKey) return undefined;

    const selectedContact = getContactByKey(activeKey);
    const contactId = getContactId(selectedContact);

    if (!selectedContact || !contactId) {
      setMessagesError('Wybrany kontakt nie ma przypisanego identyfikatora.');
      return undefined;
    }

    const controller = new AbortController();
    const contactName = getContactDisplayName(selectedContact, 'Nieznany znajomy');

    const getMessageTimestamp = (message) => {
      const rawTimestamp =
        message?.created_at ?? message?.created ?? message?.timestamp ?? message?.time ?? '';
      const parsed = rawTimestamp ? Date.parse(rawTimestamp) : Number.NaN;
      return Number.isNaN(parsed) ? 0 : parsed;
    };

    const fetchMessages = async () => {
      setMessagesLoading(true);
      setMessagesError('');

      try {
        const response = await apiRequest(
          `/joker-chat-api/joker-chat/messages/conversation/${contactId}/25/`,
          { signal: controller.signal },
        );

        if (!response.ok) {
          throw new Error(`Nie udało się pobrać wiadomości (${response.status}).`);
        }

        const data = await response.json();
        const normalized = Array.isArray(data) ? data : [];
        const sorted = normalized.slice().sort((a, b) => getMessageTimestamp(a) - getMessageTimestamp(b));
        const formatted = sorted.map((message) => formatApiMessage(message, contactName));

        setMessagesByContact((prev) => {
          const existing = prev[activeKey] ?? [];
          const buildKey = (message) => `${message.from}||${message.time}||${message.content}`;
          const seen = new Set();
          const merged = [];

          [...formatted, ...existing].forEach((message) => {
            const key = buildKey(message);
            if (seen.has(key)) return;
            seen.add(key);
            merged.push(message);
          });

          return { ...prev, [activeKey]: merged };
        });
      } catch (error) {
        if (error.name === 'AbortError') return;
        setMessagesError('Nie udało się pobrać wiadomości.');
      } finally {
        setMessagesLoading(false);
      }
    };

    fetchMessages();

    return () => controller.abort();
  }, [formatApiMessage, getContactByKey, getContactDisplayName, getContactId, selected]);

  const invitationCounters = useMemo(() => {
    const counters = {
      total: invitations.length,
      pending: 0,
      accepted: 0,
      rejected: 0,
      other: 0,
    };

    invitations.forEach((invitation) => {
      const status = resolveStatus(invitation).toLowerCase();

      if (status.includes('oczek')) counters.pending += 1;
      else if (status.includes('zaakcept')) counters.accepted += 1;
      else if (status.includes('odrzu') || status.includes('declin')) counters.rejected += 1;
      else counters.other += 1;
    });

    return counters;
  }, [invitations, resolveStatus]);

  const handleSend = (event) => {
    event.preventDefault();
    if (!draft.trim()) return;

    if (!selectedContact) {
      setSocketError('Wybierz odbiorcę przed wysłaniem wiadomości.');
      return;
    }

    if (!userId) {
      setSocketError('Uzupełnij swój identyfikator użytkownika.');
      return;
    }

    const readableTime = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    const recipientId = getContactId(selectedContact);

    if (!recipientId) {
      setSocketError('Wybrany kontakt nie ma przypisanego identyfikatora.');
      return;
    }
    const senderId = coerceId(userId);
    const payload = {
      message: draft.trim(),
      nadawca: senderId,
      odbiorca: coerceId(recipientId),
    };

    if (socketRef.current && socketRef.current.readyState === WebSocket.OPEN) {
      socketRef.current.send(JSON.stringify(payload));
      appendMessage(selected, { from: 'Ty', content: draft.trim(), time: readableTime });
      setSocketError('');
    } else {
      setSocketError('Brak aktywnego połączenia WebSocket.');
    }

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
      '--sidebar-width': `${sidebarWidth}px`,
    }),
    [panelSizes, sidebarWidth],
  );

  const addQuickReply = (event) => {
    event.preventDefault();
    if (!newReply.trim()) return;
    setQuickReplies((prev) => [...prev, newReply.trim()]);
    setNewReply('');
  };

  const selectInvitation = (invitationKey) => {
    setActiveInvitationKey((prev) => (prev === invitationKey ? null : invitationKey));
    setInvitationActionState({ status: 'idle', message: '' });
  };

  const handleAcceptInvitation = async (invitationId) => {
    if (!invitationId) {
      setInvitationActionState({ status: 'error', message: 'Nie można zaakceptować zaproszenia bez identyfikatora.' });
      return;
    }

    setInvitationActionState({ status: 'loading', message: 'Trwa akceptowanie zaproszenia...' });

    try {
      const response = await apiRequest(`/joker-chat-api/joker-chat/friendships/${invitationId}/`, {
        method: 'PATCH',
        body: JSON.stringify({ accepted: true }),
      });

      if (!response.ok) {
        throw new Error('Nie udało się zaakceptować zaproszenia.');
      }

      setInvitationActionState({ status: 'success', message: 'Zaproszenie zostało zaakceptowane.' });
      fetchInvitations();
    } catch (error) {
      setInvitationActionState({ status: 'error', message: 'Akceptacja zaproszenia nie powiodła się.' });
    }
  };

  const handleDeleteInvitation = async (invitationId) => {
    if (!invitationId) {
      setInvitationActionState({ status: 'error', message: 'Nie można usunąć zaproszenia bez identyfikatora.' });
      return;
    }

    setInvitationActionState({ status: 'loading', message: 'Trwa usuwanie zaproszenia...' });

    try {
      const response = await apiRequest(`/joker-chat-api/joker-chat/friendships/${invitationId}/`, {
        method: 'DELETE',
      });

      if (!response.ok) {
        throw new Error('Nie udało się usunąć zaproszenia.');
      }

      setInvitationActionState({ status: 'success', message: 'Zaproszenie zostało usunięte.' });
      fetchInvitations();
    } catch (error) {
      setInvitationActionState({ status: 'error', message: 'Usunięcie zaproszenia nie powiodło się.' });
    }
  };

  return (
    <div className="chat-layout" style={layoutStyle}>
      <aside className="chat-sidebar">
        <div className="sidebar__header">
          <div>
            <p className="muted">Panel czatu</p>
            <strong>Twoje centrum rozmów</strong>
          </div>
          <span className="pill pill-outline">Live</span>
        </div>

        <div className="sidebar__section">
          <p className="muted">Status połączenia</p>
          <div className="sidebar__status-card">
            <div className="sidebar__status-row">
              <span className={socketStatus === 'open' ? 'status-dot online' : 'status-dot offline'} />
              <div>
                <strong>{socketStatus === 'open' ? 'Połączono' : 'Oczekiwanie na połączenie'}</strong>
                <p className="muted">{socketError || 'Kanał WebSocket jest monitorowany.'}</p>
              </div>
            </div>
            <div className="sidebar__status-meta">
              <span className="pill">ID: {userId || 'Nieznany'}</span>
              <span className="pill pill-outline">Kontakty: {contacts.length}</span>
            </div>
          </div>
        </div>

        <div className="sidebar__section">
          <p className="muted">Skróty</p>
          <div className="sidebar__actions">
            <button
              type="button"
              className="ghost-button"
              onClick={() => setDraft('Hej! Masz chwilę na rozmowę?')}
            >
              Przywitaj się
            </button>
            <button type="button" className="ghost-button" onClick={() => fetchInvitations()}>
              Odśwież zaproszenia
            </button>
            <button
              type="button"
              className="ghost-button"
              onClick={() => selected && setDraft(`Cześć ${getContactDisplayName(selectedContact)}!`)}
              disabled={!selectedContact}
            >
              Personalizuj wiadomość
            </button>
          </div>
        </div>

        <div className="sidebar__section sidebar__tiles">
          <div className="sidebar__tile">
            <p className="muted">Zaproszenia</p>
            <strong>{invitationCounters.total}</strong>
            <span className="pill pill-outline">{invitationCounters.pending} oczekuje</span>
          </div>
          <div className="sidebar__tile">
            <p className="muted">Szybkie odpowiedzi</p>
            <strong>{quickReplies.length}</strong>
            <span className="pill">do użycia</span>
          </div>
          <div className="sidebar__tile">
            <p className="muted">Preferencje</p>
            <strong>{preferences.theme}</strong>
            <span className="pill">{preferences.notifications ? 'Powiadomienia on' : 'Powiadomienia off'}</span>
          </div>
        </div>
      </aside>

      <div className="resize-handle" aria-hidden="true">
        <span className="handle-line" />
      </div>

      <aside className="contacts resizable-panel">
        <div className="contacts__header">Kontakty</div>
        {contactsLoading && <p className="muted">Ładowanie kontaktów...</p>}
        {contactsError && <p className="error-text">{contactsError}</p>}
        {!contactsLoading && !contactsError && !contacts.length && <p className="muted">Brak kontaktów do wyświetlenia.</p>}
        <ul>
          {contacts.map((contact, index) => {
            const contactKey = getContactKey(contact, index);
            const isActive = selected === contactKey;

            return (
              <li
                key={contactKey}
                className={isActive ? 'contact active' : 'contact'}
                onClick={() => setSelected(contactKey)}
              >
                <div className="avatar">
                  <MordkaPreview config={contact.friend_mordka} size={64} />
                </div>
                <div>
                  <div className="contact-name">{contact.friend_display_name || 'Nieznany znajomy'}</div>
                  <div className="contact-preview">{contact.friend_opis || 'Brak opisu'}</div>
                </div>
                <span className="status-dot online" />
              </li>
            );
          })}
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

        <div className="connection-bar">
          <div className="connection-summary">
            <div className="connection-label">Identyfikator użytkownika</div>
            <div className="connection-value">{userId || '—'}</div>
          </div>
          <div className="connection-status pill pill-outline">
            <span className={socketStatus === 'open' ? 'status-dot online' : 'status-dot offline'} />
            <span>
              {socketStatus === 'open'
                ? 'Połączono z WebSocket'
                : socketStatus === 'connecting'
                  ? 'Łączenie...'
                  : socketStatus === 'error'
                    ? 'Błąd połączenia'
                    : 'Rozłączono'}
            </span>
          </div>
        </div>

        {socketError && <p className="error-text">{socketError}</p>}

        <div className="messages">
          {messagesLoading && <p className="muted">Ładowanie wiadomości...</p>}
          {messagesError && <p className="error-text">{messagesError}</p>}
          {displayedMessages.map((message, index) => (
            <div key={index} className={message.from === 'Ty' ? 'message outgoing' : 'message incoming'}>
              <div className="message-meta">
                <strong>{message.from}</strong>
                <span>{message.time}</span>
              </div>
              <p>{message.content}</p>
            </div>
          ))}
          {!messagesLoading && !messages.length && !messagesError && <p className="muted">Brak wiadomości.</p>}
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
              <button key={reply} type="button" className="ghost-button" onClick={() => setDraft(reply)}>
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

          <div className="invitations-overview">
            <div className="overview-row">
              <div className="overview-card">
                <span className="muted">Łącznie</span>
                <strong>{invitationCounters.total}</strong>
              </div>
              <div className="overview-card">
                <span className="muted">Oczekujące</span>
                <strong>{invitationCounters.pending}</strong>
              </div>
              <div className="overview-card">
                <span className="muted">Zaakceptowane</span>
                <strong>{invitationCounters.accepted}</strong>
              </div>
              <div className="overview-card">
                <span className="muted">Odrzucone</span>
                <strong>{invitationCounters.rejected}</strong>
              </div>
            </div>

            <div className="overview-actions">
              <button
                type="button"
                className="ghost-button"
                onClick={() => fetchInvitations()}
                disabled={invitationsLoading}
              >
                {invitationsLoading ? 'Odświeżanie...' : 'Odśwież dane'}
              </button>
              {lastInvitationsUpdate && (
                <span className="muted">Ostatnie pobranie: {lastInvitationsUpdate}</span>
              )}
            </div>
          </div>

          {invitationsLoading && <p>Ładowanie zaproszeń...</p>}
          {invitationsError && <p className="error-text">{invitationsError}</p>}

          {!invitationsLoading && !invitationsError && !invitations.length && (
            <p className="muted">Brak nowych zaproszeń.</p>
          )}

          {!!invitations.length && (
            <ul className="invitations-list">
              {invitations.map((invitation, index) => {
                const invitationKey = invitation.id ?? invitation.uuid ?? index;
                const isActive = invitationKey === activeInvitationKey;

                return (
                  <li
                    key={invitationKey}
                    className={isActive ? 'invitation-item active' : 'invitation-item'}
                    onClick={() => selectInvitation(invitationKey)}
                  >
                    <div className="invitation-row">
                      <div className="invitation-avatar">
                        <MordkaPreview config={invitation.friend_mordka} size={140} />
                      </div>

                      <div className="invitation-content">
                        <div className="invitation-header">
                          <div>
                            <strong>
                              {invitation.friend_display_name ||
                                invitation.friend_username ||
                                invitation.sender ||
                                invitation.username ||
                                invitation.friend ||
                                'Nieznajomy użytkownik'}
                            </strong>
                            <p className="muted small-text">
                              {invitation.email ||
                                invitation.friend_email ||
                                invitation.sender_email ||
                                invitation.friend ||
                                'Brak adresu e-mail'}
                            </p>
                          </div>
                          <div className="invitation-meta">
                            {getCreatedLabel(invitation) && (
                              <span className="pill">{getCreatedLabel(invitation)}</span>
                            )}
                            <span className="pill pill-outline">{resolveStatus(invitation)}</span>
                          </div>
                        </div>

                        {invitation.friend_message || invitation.message ? (
                          <p className="muted">{invitation.friend_message || invitation.message}</p>
                        ) : (
                          <p className="muted">Zaproszenie do znajomych czeka na Twoją reakcję.</p>
                        )}

                        <dl className="invitation-details">
                          {invitation.uuid && (
                            <div>
                              <dt>UUID</dt>
                              <dd>{invitation.uuid}</dd>
                            </div>
                          )}
                          {invitation.receiver && (
                            <div>
                              <dt>Odbiorca</dt>
                              <dd>{invitation.receiver}</dd>
                            </div>
                          )}
                          {invitation.role && (
                            <div>
                              <dt>Rola</dt>
                              <dd>{invitation.role}</dd>
                            </div>
                          )}
                          {invitation.friend && (
                            <div>
                              <dt>Użytkownik</dt>
                              <dd>{invitation.friend}</dd>
                            </div>
                          )}
                        </dl>

                        {isActive && (
                          <div className="invitation-actions">
                            <p className="muted">
                              Wybierz, czy zaakceptować zaproszenie czy je usunąć. Operacje wykonają odpowiednie
                              wywołania API.
                            </p>
                            <div className="invitation-actions__buttons">
                              <button
                                type="button"
                                className="primary-button"
                                disabled={invitationActionState.status === 'loading'}
                                onClick={(event) => {
                                  event.stopPropagation();
                                  handleAcceptInvitation(invitation.id);
                                }}
                              >
                                {invitationActionState.status === 'loading'
                                  ? 'Przetwarzanie...'
                                  : 'Zaakceptuj zaproszenie'}
                              </button>
                              <button
                                type="button"
                                className="danger-button"
                                disabled={invitationActionState.status === 'loading'}
                                onClick={(event) => {
                                  event.stopPropagation();
                                  handleDeleteInvitation(invitation.id);
                                }}
                              >
                                Usuń zaproszenie
                              </button>
                            </div>
                            {invitationActionState.message && (
                              <p
                                className={
                                  invitationActionState.status === 'error'
                                    ? 'error-text'
                                    : 'success-text'
                                }
                              >
                                {invitationActionState.message}
                              </p>
                            )}
                          </div>
                        )}
                      </div>
                    </div>
                  </li>
                );
              })}
            </ul>
          )}
        </div>
      </aside>
    </div>
  );
}

export default ChatPage;
