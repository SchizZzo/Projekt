import { useMemo, useState } from 'react';
import './App.css';

const API_HOST = 'http://localhost';
const LOGIN_ENDPOINT = `${API_HOST}/joker-login-api/login/`;

function App() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [status, setStatus] = useState({ type: 'info', message: 'Wprowadź dane logowania.' });
  const [isSubmitting, setIsSubmitting] = useState(false);

  const isFormValid = useMemo(() => username.trim() !== '' && password.trim() !== '', [username, password]);

  const handleSubmit = async (event) => {
    event.preventDefault();
    if (!isFormValid || isSubmitting) return;

    setIsSubmitting(true);
    setStatus({ type: 'info', message: 'Trwa logowanie...' });

    try {
      const response = await fetch(LOGIN_ENDPOINT, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ username, password }),
      });

      if (!response.ok) {
        throw new Error('Nieprawidłowe dane logowania.');
      }

      const data = await response.json();
      const detail = data?.message || 'Zalogowano pomyślnie!';
      setStatus({ type: 'success', message: detail });
    } catch (error) {
      setStatus({ type: 'error', message: error.message || 'Wystąpił błąd podczas logowania.' });
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="layout">
      <div className="login-card">
        <div className="login-card__header">
          <p className="badge">Nowy ekran logowania</p>
          <h1>Zaloguj się</h1>
          <p className="subtitle">Uzyskaj dostęp do panelu Joker, korzystając z dedykowanego API.</p>
        </div>

        <div className="login-card__body">
          <form className="login-form" onSubmit={handleSubmit}>
            <label className="field">
              <span>Login</span>
              <input
                name="username"
                autoComplete="username"
                value={username}
                onChange={(event) => setUsername(event.target.value)}
                placeholder="Wpisz login"
                required
              />
            </label>

            <label className="field">
              <span>Hasło</span>
              <input
                type="password"
                name="password"
                autoComplete="current-password"
                value={password}
                onChange={(event) => setPassword(event.target.value)}
                placeholder="Wpisz hasło"
                required
              />
            </label>

            <button type="submit" className="primary" disabled={!isFormValid || isSubmitting}>
              {isSubmitting ? 'Logowanie...' : 'Zaloguj się'}
            </button>
          </form>

          <div className="status" data-variant={status.type}>
            <span>{status.message}</span>
            <small>Endpoint: {LOGIN_ENDPOINT}</small>
          </div>
        </div>
      </div>

      <aside className="info-panel">
        <div className="info-panel__title">Szybkie informacje</div>
        <ul>
          <li>
            Zmienna hosta API:
            <strong>{API_HOST}</strong>
          </li>
          <li>Adres logowania: <strong>/joker-login-api/login/</strong></li>
          <li>Żądanie wysyłane metodą <strong>POST</strong> w formacie JSON.</li>
          <li>Komunikaty o błędach i sukcesie prezentowane są poniżej formularza.</li>
        </ul>
      </aside>
    </div>
  );
}

export default App;
