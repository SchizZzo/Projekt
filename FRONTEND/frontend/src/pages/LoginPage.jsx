import { useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { API_HOST, apiRequest } from '../api/client.js';
import JokerImg from '../assets/joker_logo.png';

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
    <div className="layout login-layout">
      <div className="login-card card">
        <div className="login-card__header">
          <div className="login-hero">
            <p className="badge">Nowy ekran logowania</p>
            <h1>Zaloguj się</h1>
            <p className="subtitle">Uzyskaj dostęp do panelu Joker, korzystając z dedykowanego API.</p>

            <div className="login-meta">
              <div className="login-meta__item">
                <small>Host API</small>
                <strong>{API_HOST}</strong>
              </div>
              <div className="login-meta__item">
                <small>Ścieżka logowania</small>
                <strong>{LOGIN_PATH}</strong>
              </div>
              <div className="login-meta__item">
                <small>Status formularza</small>
                <strong className="pill pill-outline">{isFormValid ? 'Przyjmie dane' : 'Uzupełnij pola'}</strong>
              </div>
            </div>
          </div>

          <div className="login-graphic">
            <img src={JokerImg} alt="Logo Joker" className="login-graphic__badge" />
          </div>
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
              <small className="field__hint">Użyj adresu powiązanego z Twoim kontem.</small>
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
              <small className="field__hint">Hasło nigdy nie jest przechowywane na serwerze w postaci jawnej.</small>
            </label>

            <button type="submit" className="primary" disabled={!isFormValid || isSubmitting}>
              {isSubmitting ? 'Logowanie...' : 'Zaloguj się'}
            </button>
          </form>

          <div className="status status--inline" data-variant={status.type}>
            <div>
              <p className="status__label">{status.message}</p>
              <small>Połączenie z <strong>{LOGIN_ENDPOINT}</strong></small>
            </div>
            <span className="status__dot" aria-hidden />
          </div>

          {tokens.access && (
            <div className="tokens">
              <div className="token-pill">
                <p className="token-label">Access token</p>
                <p className="token-value">{tokens.access}</p>
              </div>
              <div className="token-pill">
                <p className="token-label">Refresh token</p>
                <p className="token-value">{tokens.refresh}</p>
              </div>
            </div>
          )}
        </div>
      </div>

      <aside className="info-panel card">
        <div className="info-panel__title">Szybkie informacje</div>
        <div className="info-grid">
          <div className="info-chip">
            <p className="info-chip__label">Aktualny host</p>
            <p className="info-chip__value">{API_HOST}</p>
          </div>
          <div className="info-chip">
            <p className="info-chip__label">Ścieżka logowania</p>
            <p className="info-chip__value">{LOGIN_PATH}</p>
          </div>
          <div className="info-chip">
            <p className="info-chip__label">Formularz gotowy</p>
            <p className="info-chip__value">{isFormValid ? 'Tak' : 'Nie'}</p>
          </div>
          <div className="info-chip">
            <p className="info-chip__label">Tokeny w pamięci</p>
            <p className="info-chip__value">{tokens.access ? 'Tak' : 'Nie'}</p>
          </div>
        </div>

        <div className="callout">
          <p className="callout__label">Pełny endpoint</p>
          <a className="callout__link" href={LOGIN_ENDPOINT} target="_blank" rel="noreferrer">
            {LOGIN_ENDPOINT}
          </a>
        </div>

        <ul className="info-list">
          <li>W trakcie wysyłania: <strong>{isSubmitting ? 'Tak' : 'Nie'}</strong></li>
          <li>Oczekiwane pola odpowiedzi: <strong>access</strong>, <strong>refresh</strong></li>
          <li>Magazyn tokenów: <strong>localStorage</strong></li>
        </ul>
      </aside>
    </div>
  );
}

export default LoginPage;
