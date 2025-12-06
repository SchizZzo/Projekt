import { useMemo, useState } from 'react';
import { API_HOST, apiRequest } from '../api/client.js';

const REGISTER_PATH = '/joker-login-api/register/';
const REGISTER_ENDPOINT = `${API_HOST}${REGISTER_PATH}`;

function RegisterPage() {
  const [formData, setFormData] = useState({ email: '', password: '', confirm: '', name: '' });
  const [status, setStatus] = useState({ type: 'info', message: 'Uzupełnij dane, aby utworzyć konto.' });
  const [isSubmitting, setIsSubmitting] = useState(false);

  const isFormValid = useMemo(() => {
    return (
      formData.name.trim() !== '' &&
      formData.email.trim() !== '' &&
      formData.password.trim() !== '' &&
      formData.confirm.trim() !== '' &&
      formData.password === formData.confirm
    );
  }, [formData]);

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    if (!isFormValid || isSubmitting) {
      setStatus({ type: 'error', message: 'Hasła muszą być zgodne, a pola wypełnione.' });
      return;
    }

    setIsSubmitting(true);
    setStatus({ type: 'info', message: 'Trwa tworzenie konta...' });

    try {
      const response = await apiRequest(
        REGISTER_PATH,
        {
          method: 'POST',
          body: JSON.stringify({
            name: formData.name,
            email: formData.email,
            password: formData.password,
          }),
        },
        { useAuth: false }
      );

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data?.message || 'Nie udało się utworzyć konta.');
      }

      setStatus({ type: 'success', message: 'Konto utworzone. Możesz teraz się zalogować.' });
      setFormData({ email: '', password: '', confirm: '', name: '' });
    } catch (error) {
      setStatus({ type: 'error', message: error.message || 'Wystąpił błąd podczas rejestracji.' });
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="form-shell">
      <div className="card">
        <p className="badge">Nowa rejestracja</p>
        <h1>Utwórz konto</h1>
        <p className="subtitle">Przygotowana sekcja do integracji z API rejestracji użytkowników.</p>

        <form className="stack" onSubmit={handleSubmit}>
          <label className="field">
            <span>Imię lub nazwa</span>
            <input
              type="text"
              name="name"
              value={formData.name}
              onChange={handleChange}
              placeholder="Twoje imię"
              required
            />
          </label>

          <label className="field">
            <span>Email</span>
            <input
              type="email"
              name="email"
              value={formData.email}
              onChange={handleChange}
              placeholder="podaj email"
              required
            />
          </label>

          <div className="grid-two">
            <label className="field">
              <span>Hasło</span>
              <input
                type="password"
                name="password"
                value={formData.password}
                onChange={handleChange}
                placeholder="wpisz hasło"
                required
              />
            </label>
            <label className="field">
              <span>Powtórz hasło</span>
              <input
                type="password"
                name="confirm"
                value={formData.confirm}
                onChange={handleChange}
                placeholder="powtórz hasło"
                required
              />
            </label>
          </div>

          <button type="submit" className="primary" disabled={!isFormValid || isSubmitting}>
            {isSubmitting ? 'Wysyłanie...' : 'Utwórz konto'}
          </button>
        </form>

        <div className="status" data-variant={status.type}>
          <span>{status.message}</span>
          <small>Połączenie z <strong>{REGISTER_ENDPOINT}</strong></small>
          {formData.password !== formData.confirm && (
            <small>Hasła nie są takie same.</small>
          )}
        </div>
      </div>
    </div>
  );
}

export default RegisterPage;
