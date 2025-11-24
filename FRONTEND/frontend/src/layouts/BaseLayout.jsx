import { NavLink, Outlet, useLocation } from 'react-router-dom';

const menuItems = [
  { path: '/map', label: 'Mapa' },
  { path: '/chat', label: 'Czat' },
  { path: '/settings', label: 'Ustawienia' },
];

function BaseLayout() {
  const location = useLocation();
  const isMapPage = location.pathname.startsWith('/map');

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
          <NavLink to="/login" className="ghost-button">Logowanie</NavLink>
          <NavLink to="/register" className="primary-button">Rejestracja</NavLink>
        </div>
      </header>

      <main className={isMapPage ? 'app-content app-content--full' : 'app-content'}>
        <Outlet />
      </main>
    </div>
  );
}

export default BaseLayout;
