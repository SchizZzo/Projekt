import { useEffect, useMemo, useState } from 'react';
import { apiRequest } from '../api/client.js';
import RiveVehiclesWidget from '../components/RiveVehiclesWidget.jsx';

const AVAILABLE_USERS_ENDPOINT = '/joker-login-api/available-users/';

const MAP_DEFAULT_CENTER = {
  lat: 52.22977,
  lon: 21.01178,
};

const buildMapUrl = (markers) => {
  const baseUrl = 'https://staticmap.openstreetmap.de/staticmap.php';
  const center = markers[0] ?? MAP_DEFAULT_CENTER;
  const markersParam = markers
    .map(({ lat, lon, character }) => {
      const label = character?.[0]?.toUpperCase() ?? 'X';
      return `${lat},${lon},lightblue1-${encodeURIComponent(label)}`;
    })
    .join('|');

  const params = new URLSearchParams({
    center: `${center.lat},${center.lon}`,
    zoom: '13',
    size: '865x512',
  });

  if (markersParam) {
    params.set('markers', markersParam);
  }

  return `${baseUrl}?${params.toString()}`;
};

function MapPage() {
  const [availableUsers, setAvailableUsers] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState('');
  const [mapLoadError, setMapLoadError] = useState(false);
  const [lastUpdated, setLastUpdated] = useState(null);

  useEffect(() => {
    const fetchAvailableUsers = async () => {
      setIsLoading(true);
      setError('');

      try {
        const response = await apiRequest(AVAILABLE_USERS_ENDPOINT);

        if (!response.ok) {
          throw new Error('Nie udało się pobrać listy Mordeczek.');
        }

        const data = await response.json();
        setAvailableUsers(data);
        setLastUpdated(new Date());
      } catch (apiError) {
        setError(apiError.message || 'Wystąpił błąd podczas ładowania mapy.');
      } finally {
        setIsLoading(false);
      }
    };

    fetchAvailableUsers();
  }, []);

  const availableMarkers = useMemo(() => {
    const markers = availableUsers
      .map((user) => ({
        id: user.id ?? user.username,
        lat: Number(user.latitude),
        lon: Number(user.longitude),
        name: user.display_name || user.username,
        opis: user.opis,
        character: user.character,
      }))
      .filter((marker) => Number.isFinite(marker.lat) && Number.isFinite(marker.lon));

    return markers;
  }, [availableUsers]);

  const mapImageUrl = useMemo(() => buildMapUrl(availableMarkers), [availableMarkers]);

  useEffect(() => {
    setMapLoadError(false);
  }, [mapImageUrl]);

  return (
    <div className="map-page">
      <div className="map-hero">
        <p className="badge">Mapa</p>
        <h1>Podgląd lokalizacji</h1>
        <p className="subtitle">
          Zobacz wszystkie Mordeczki ze statusem „dostępny”. Dane są pobierane bezpośrednio z API i nanoszone na mapę
          OpenStreetMap.
        </p>
      </div>

      <div className="map-workspace">
        <div className="map-frame">
          <img
            src={mapImageUrl}
            alt="Mapa z oznaczonymi dostępnymi Mordeczkami"
            loading="lazy"
            onLoad={() => setMapLoadError(false)}
            onError={() => setMapLoadError(true)}
          />
          <div className="map-overlay">
            <div>
              <p className="muted">Aktualizacja danych</p>
              <strong>{lastUpdated ? lastUpdated.toLocaleTimeString() : 'Oczekiwanie...'}</strong>
            </div>
            <div className="pill pill-outline">{isLoading ? 'Ładowanie...' : `${availableMarkers.length} na mapie`}</div>
          </div>
          {(error || mapLoadError) && (
            <div className="map-banner" role="status">
              <strong>Nie udało się załadować mapy</strong>
              <p className="muted">{error || 'Sprawdź połączenie i spróbuj ponownie.'}</p>
            </div>
          )}
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
                <p className="muted">Dostępne Mordeczki</p>
                <strong>{availableUsers.length} lokalizacje</strong>
              </div>
              <span className="badge">Live</span>
            </div>

            <ul>
              {isLoading && <li className="muted">Ładowanie dostępnych lokalizacji...</li>}
              {!isLoading && availableUsers.length === 0 && (
                <li className="muted">Brak Mordeczek ze statusem „dostępny”.</li>
              )}

              {availableUsers.map((user) => {
                const displayName = user.display_name || user.username;
                const hasCoordinates = user.latitude !== null && user.longitude !== null;

                return (
                  <li key={user.id ?? user.username}>
                    <div className="location-top">
                      <strong>{displayName}</strong>
                      <span className="pill pill-outline">{user.status}</span>
                    </div>
                    <p className="muted">{user.opis || 'Brak opisu.'}</p>
                    <p className="muted">
                      {hasCoordinates
                        ? `Pozycja: ${Number(user.latitude).toFixed(4)}, ${Number(user.longitude).toFixed(4)}`
                        : 'Brak aktualnej lokalizacji.'}
                    </p>
                  </li>
                );
              })}
            </ul>
          </div>

          <RiveVehiclesWidget />
        </div>
      </div>
    </div>
  );
}

export default MapPage;
