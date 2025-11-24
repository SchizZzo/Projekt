function SettingsPage() {
  return (
    <div className="card">
      <p className="badge">Ustawienia</p>
      <h1>Panel konfiguracji</h1>
      <p className="subtitle">Zarządzaj preferencjami aplikacji oraz bezpieczeństwem.</p>

      <div className="settings-grid">
        <section className="setting-block">
          <div className="setting-header">
            <h3>Profil</h3>
            <p>Uzupełnij dane widoczne dla innych użytkowników.</p>
          </div>
          <div className="stack">
            <label className="field">
              <span>Imię i nazwisko</span>
              <input type="text" placeholder="Jan Kowalski" />
            </label>
            <label className="field">
              <span>Stanowisko</span>
              <input type="text" placeholder="Administrator" />
            </label>
          </div>
        </section>

        <section className="setting-block">
          <div className="setting-header">
            <h3>Powiadomienia</h3>
            <p>Zarządzaj powiadomieniami push oraz e-mail.</p>
          </div>
          <div className="toggle-row">
            <label className="switch">
              <input type="checkbox" defaultChecked />
              <span className="slider" />
            </label>
            <div>
              <strong>Alerty bezpieczeństwa</strong>
              <p>Informuj mnie o nietypowych logowaniach.</p>
            </div>
          </div>
          <div className="toggle-row">
            <label className="switch">
              <input type="checkbox" />
              <span className="slider" />
            </label>
            <div>
              <strong>Aktualizacje produktu</strong>
              <p>Chcę otrzymywać informacje o nowych funkcjach.</p>
            </div>
          </div>
        </section>
      </div>
    </div>
  );
}

export default SettingsPage;
