import { useMemo, useState } from 'react';

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

function ChatPage() {
  const [selected, setSelected] = useState(contacts[0].id);
  const [draft, setDraft] = useState('');

  const messages = useMemo(() => history[selected] ?? [], [selected]);

  const handleSend = (event) => {
    event.preventDefault();
    if (!draft.trim()) return;
    setDraft('');
  };

  return (
    <div className="chat-layout">
      <aside className="contacts">
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

      <section className="chat-window">
        <header className="chat-header">
          <div className="chat-title">Czat</div>
          <p className="subtitle">Lista kontaktów + okno czatu</p>
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
      </section>
    </div>
  );
}

export default ChatPage;
