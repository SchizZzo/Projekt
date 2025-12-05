import { useEffect, useState } from 'react';
import { NavLink, Outlet, useLocation, useNavigate } from 'react-router-dom';
import { apiRequest } from '../api/client.js';

const menuItems = [
  { path: '/map', label: 'Mapa' },
  { path: '/chat', label: 'Czat' },
  { path: '/settings', label: 'Ustawienia' },
];

const footerLinks = [
  { path: '/documents/regulamin', label: 'Regulamin' },
  { path: '/documents/polityka-prywatnosci', label: 'Polityka prywatności' },
  {
    path: '/documents/standardy-ochrony-maloletnich',
    label: 'Standardy ochrony małoletnich',
  },
];

function BaseLayout() {
  const location = useLocation();
  const navigate = useNavigate();
  const isMapPage = location.pathname.startsWith('/map');
  const [userProfile, setUserProfile] = useState(null);

  useEffect(() => {
    const accessToken = localStorage.getItem('accessToken');

    if (!accessToken) {
      setUserProfile(null);
      return undefined;
    }

    const controller = new AbortController();

    const fetchProfile = async () => {
      try {
        const response = await apiRequest('/joker-login-api/me/', { signal: controller.signal });

        if (!response.ok) {
          throw new Error('Nie udało się pobrać profilu użytkownika.');
        }

        const data = await response.json();
        setUserProfile(data);
      } catch (error) {
        if (error.name !== 'AbortError') {
          setUserProfile(null);
        }
      }
    };

    fetchProfile();

    return () => controller.abort();
  }, []);

  const handleLogout = () => {
    localStorage.removeItem('accessToken');
    localStorage.removeItem('refreshToken');
    setUserProfile(null);
    navigate('/login', { replace: true });
  };

  return (
    <div className="app-shell">
      <header className="app-header">
        <div className="brand">Panel Joker</div>
        <nav className="main-nav">
          {menuItems.map((item) => (
            <NavLink
              key={item.path}
              to={item.path}
              className={({ isActive }) => (isActive ? 'nav-link active' : 'nav-link')}
            >
              {item.label}
            </NavLink>
          ))}
        </nav>
        <div className="auth-links">
          {userProfile ? (
            <>
              <span className="pill">
                {userProfile.display_name || userProfile.username || 'Użytkownik'}
              </span>
              <button type="button" className="ghost-button" onClick={handleLogout}>
                Wyloguj
              </button>
            </>
          ) : (
            <>
              <NavLink to="/login" className="ghost-button">Logowanie</NavLink>
              <NavLink to="/register" className="primary-button">Rejestracja</NavLink>
            </>
          )}
        </div>
      </header>

      <main className={isMapPage ? 'app-content app-content--full' : 'app-content'}>
        <Outlet />
      </main>

      <footer className="app-footer">
        <div className="footer-content">
          <div>
            <div className="footer-title">Panel Joker</div>
            <p className="footer-text">
              Zapoznaj się z kluczowymi dokumentami prawnymi naszego serwisu.
            </p>
          </div>
          <div className="footer-links">
            {footerLinks.map((item) => (
              <NavLink key={item.path} to={item.path} className="footer-link">
                {item.label}
              </NavLink>
            ))}
          </div>
        </div>
      </footer>
    </div>
  );
}

export default BaseLayout;
