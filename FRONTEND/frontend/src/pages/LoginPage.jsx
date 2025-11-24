import { useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { API_HOST, apiRequest } from '../api/client.js';
import JokerImg from '../assets/joker_logo.png';
import MordeczkiAnimation from '../components/MordeczkiAnimation.jsx';

const LOGIN_PATH = '/joker-login-api/login/';
const LOGIN_ENDPOINT = `${API_HOST}${LOGIN_PATH}`;

function LoginPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [status, setStatus] = useState({ type: 'info', message: 'Wprowadź dane logowania.' });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [tokens, setTokens] = useState({ access: null, refresh: null });
  const navigate = useNavigate();

  const isFormValid = useMemo(
    () => email.trim() !== '' && password.trim() !== '',
    [email, password]
  );

  const handleSubmit = async (event) => {
    event.preventDefault();
    if (!isFormValid || isSubmitting) return;

    setIsSubmitting(true);
    setStatus({ type: 'info', message: 'Trwa logowanie...' });

    try {
      const response = await apiRequest(
        LOGIN_PATH,
        {
          method: 'POST',
          body: JSON.stringify({ email, password }),
        },
        { useAuth: false }
      );

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data?.message || 'Nieprawidłowe dane logowania.');
      }

      const { access, refresh } = data;

      if (access && refresh) {
        localStorage.setItem('accessToken', access);
        localStorage.setItem('refreshToken', refresh);
        setTokens({ access, refresh });
        setStatus({ type: 'success', message: 'Zalogowano. Przekierowuję na mapę...' });
        navigate('/map', { replace: true });
      } else {
        setStatus({ type: 'warning', message: 'Brak tokenów w odpowiedzi.' });
      }
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
          <div className="login-graphic">
            <MordeczkiAnimation />
            <img src={JokerImg} alt="Logo Joker" className="login-graphic__badge" />
          </div>
          <p className="badge">Nowy ekran logowania</p>
          <h1>Zaloguj się</h1>
          <p className="subtitle">Uzyskaj dostęp do panelu Joker, korzystając z dedykowanego API.</p>
        </div>

        <div className="login-card__body">
          <form className="login-form" onSubmit={handleSubmit}>
            <label className="field">
              <span>Email</span>
              <input
                type="email"
                name="email"
                autoComplete="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="Wpisz adres e-mail"
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
                onChange={(e) => setPassword(e.target.value)}
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

          {tokens.access && (
            <div className="tokens">
              <p><strong>Access:</strong> {tokens.access}</p>
              <p><strong>Refresh:</strong> {tokens.refresh}</p>
            </div>
          )}
        </div>
      </div>

      <aside className="info-panel">
        <div className="info-panel__title">Szybkie informacje</div>
        <ul>
          <li>Host API: <strong>{API_HOST}</strong></li>
          <li>Ścieżka logowania: <strong>{LOGIN_PATH}</strong></li>
          <li>Pełny endpoint: <strong>{LOGIN_ENDPOINT}</strong></li>
          <li>Formularz poprawny: <strong>{isFormValid ? 'Tak' : 'Nie'}</strong></li>
          <li>W trakcie wysyłania: <strong>{isSubmitting ? 'Tak' : 'Nie'}</strong></li>
          <li>Tokeny zapisane: <strong>{tokens.access ? 'Tak' : 'Nie'}</strong></li>
          <li>Oczekiwane pola odpowiedzi: <strong>access</strong>, <strong>refresh</strong></li>
          <li>Magazyn tokenów: <strong>localStorage</strong></li>
        </ul>
      </aside>
    </div>
  );
}

export default LoginPage;
