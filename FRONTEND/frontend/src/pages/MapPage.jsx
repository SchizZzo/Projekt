function MapPage() {
  return (
    <div className="card">
      <p className="badge">Mapa</p>
      <h1>Podgląd lokalizacji</h1>
      <p className="subtitle">Tutaj możesz podpiąć komponent mapowy i wizualizować dane terenowe.</p>

      <div className="map-placeholder">
        <div className="map-grid">
          <div className="grid-cell" />
          <div className="grid-cell" />
          <div className="grid-cell" />
          <div className="grid-cell" />
        </div>
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
      </div>
    </div>
  );
}

export default MapPage;
