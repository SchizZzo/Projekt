import { useEffect, useMemo, useState } from 'react';
import { MapContainer, Marker, Popup, TileLayer, useMap } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import L from 'leaflet';
import { apiRequest } from '../api/client.js';
import CharacterMarker from '../components/CharacterMarker.jsx';
import RiveVehiclesWidget from '../components/RiveVehiclesWidget.jsx';

const AVAILABLE_USERS_ENDPOINT = '/joker-login-api/available-users/';
const MAP_ZOOM = 13;

const MAP_DEFAULT_CENTER = {
  lat: 52.22977,
  lon: 21.01178,
};

const FACE_ICON_SIZE = 56;

function createFaceIcon() {
  return L.divIcon({
    html: '<div class="map-marker-face" role="img" aria-label="Lokalizacja mordeczki">😎</div>',
    className: 'map-marker-face-wrapper',
    iconSize: [FACE_ICON_SIZE, FACE_ICON_SIZE],
    iconAnchor: [FACE_ICON_SIZE / 2, FACE_ICON_SIZE - 4],
    popupAnchor: [0, -(FACE_ICON_SIZE - 16)],
  });
}

function MapBoundsUpdater({ markers, fallbackCenter }) {
  const map = useMap();

  useEffect(() => {
    if (!map) return;

    if (markers.length === 0) {
      map.setView([fallbackCenter.lat, fallbackCenter.lon], MAP_ZOOM);
      return;
    }

    const bounds = L.latLngBounds(markers.map((marker) => [marker.lat, marker.lon]));
    map.fitBounds(bounds, { padding: [40, 40] });
  }, [fallbackCenter.lat, fallbackCenter.lon, map, markers]);

  return null;
}

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
        character: user.character ?? user.charakter,
      }))
      .filter(
        (marker) =>
          Number.isFinite(marker.lat) && Number.isFinite(marker.lon) && Boolean(marker.character),
      );

    return markers;
  }, [availableUsers]);

  const mapCenter = useMemo(() => availableMarkers[0] ?? MAP_DEFAULT_CENTER, [availableMarkers]);
  const faceMarkerIcon = useMemo(() => createFaceIcon(), []);

  const bannerMessage =
    error ||
    (mapLoadError
      ? 'Nie udało się pobrać kafelków mapy z OpenStreetMap. Spróbuj ponownie za chwilę.'
      : 'Sprawdź połączenie i spróbuj ponownie.');

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
          <MapContainer
            center={[mapCenter.lat, mapCenter.lon]}
            zoom={MAP_ZOOM}
            className="leaflet-map"
            scrollWheelZoom
          >
            <TileLayer
              attribution="&copy; OpenStreetMap contributors"
              url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
              eventHandlers={{
                tileerror: () => setMapLoadError(true),
                load: () => setMapLoadError(false),
              }}
            />

            <MapBoundsUpdater markers={availableMarkers} fallbackCenter={MAP_DEFAULT_CENTER} />

            {availableMarkers.map(({ id, name, lat, lon, character, opis }) => (
              <Marker key={id} position={[lat, lon]} icon={faceMarkerIcon}>
                <Popup>
                  <div className="map-popup">
                    <CharacterMarker character={character} name={name} />
                    <div className="map-popup__details">
                      <strong>{name}</strong>
                      <p className="muted">{opis || 'Brak opisu.'}</p>
                      <p className="muted">{`Pozycja: ${lat.toFixed(4)}, ${lon.toFixed(4)}`}</p>
                    </div>
                  </div>
                </Popup>
              </Marker>
            ))}
          </MapContainer>

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
              <p className="muted">{bannerMessage}</p>
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
