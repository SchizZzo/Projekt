function MapPage() {
  const locations = [
    {
      name: 'Centrum operacyjne',
      status: 'Aktywne',
      description: 'Monitoruje ruch w centrum miasta i zbiera dane o zdarzeniach.',
    },
    {
      name: 'Strefa zachodnia',
      status: 'Weryfikacja',
      description: 'Węzły przesyłają niepełne telemetrie, wymagają kontroli.',
    },
    {
      name: 'Nowe wdrożenie',
      status: 'Planowane',
      description: 'Zespół terenowy przygotowuje montaż kolejnych czujników.',
    },
  ];

  return (
    <div className="map-page">
      <div className="map-hero">
        <p className="badge">Mapa</p>
        <h1>Podgląd lokalizacji</h1>
        <p className="subtitle">
          Na stronie mapa znajduje się mapa OpenStreetMap — możesz tu śledzić infrastrukturę i statusy zespołów w
          terenie.
        </p>
      </div>

      <div className="map-workspace">
        <div className="map-frame">
          <iframe
            title="OpenStreetMap"
            src="https://www.openstreetmap.org/export/embed.html?bbox=21.0020,52.2200,21.0400,52.2400&layer=mapnik&marker=52.22977,21.01178"
            allowFullScreen
            loading="lazy"
          />
          <div className="map-overlay">
            <div>
              <p className="muted">Aktualizacja danych</p>
              <strong>Przed chwilą</strong>
            </div>
            <a
              className="ghost-button"
              href="https://www.openstreetmap.org/?mlat=52.22977&mlon=21.01178#map=14/52.2298/21.0118"
              target="_blank"
              rel="noreferrer"
            >
              Otwórz w OSM
            </a>
          </div>
        </div>

        <div className="map-sidebar">
          <div className="map-legend">
            <div className="legend-item">
              <span className="legend-dot success" />
              <div>
                <strong>Aktywne urządzenia</strong>
                <p>Elementy przesyłające dane w czasie rzeczywistym.</p>
              </div>
            </div>
            <div className="legend-item">
              <span className="legend-dot warning" />
              <div>
                <strong>Wymaga uwagi</strong>
                <p>Punkty wymagające weryfikacji operatora.</p>
              </div>
            </div>
          </div>

          <div className="map-list">
            <div className="map-list__header">
              <div>
                <p className="muted">Zgłoszenia terenowe</p>
                <strong>3 lokalizacje</strong>
              </div>
              <span className="badge">Live</span>
            </div>

            <ul>
              {locations.map((location) => (
                <li key={location.name}>
                  <div className="location-top">
                    <strong>{location.name}</strong>
                    <span className={`pill pill-${location.status.toLowerCase()}`}>
                      {location.status}
                    </span>
                  </div>
                  <p className="muted">{location.description}</p>
                </li>
              ))}
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
}

export default MapPage;
