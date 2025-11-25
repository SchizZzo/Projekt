import { useEffect, useMemo, useRef, useState } from 'react';
import { apiRequest } from '../api/client.js';
import CharacterMarker from '../components/CharacterMarker.jsx';
import RiveVehiclesWidget from '../components/RiveVehiclesWidget.jsx';
import mapPlaceholder from '../assets/map-placeholder.svg';

const AVAILABLE_USERS_ENDPOINT = '/joker-login-api/available-users/';
const MAP_SIZE = { width: 865, height: 512 };
const MAP_ZOOM = 13;

const MAP_DEFAULT_CENTER = {
  lat: 52.22977,
  lon: 21.01178,
};

const buildMapUrl = (_, center) => {
  // OSM udostępnia wyłącznie kafelki mapy – markery rysujemy po stronie frontendu.
  const baseUrl = 'https://staticmap.openstreetmap.de/osm/staticmap.php';

  const params = new URLSearchParams();
  params.set('center', `${center.lat},${center.lon}`);
  params.set('zoom', MAP_ZOOM.toString());
  params.set('size', `${MAP_SIZE.width}x${MAP_SIZE.height}`);
  params.set('maptype', 'mapnik');

  return `${baseUrl}?${params.toString()}`;
};

const projectLatLon = (lat, lon) => {
  const sinLat = Math.sin((lat * Math.PI) / 180);
  const mapScale = 256 * 2 ** MAP_ZOOM;

  const x = ((lon + 180) / 360) * mapScale;
  const y = (0.5 - Math.log((1 + sinLat) / (1 - sinLat)) / (4 * Math.PI)) * mapScale;

  return { x, y };
};

function MapPage() {
  const [availableUsers, setAvailableUsers] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState('');
  const [mapLoadError, setMapLoadError] = useState(false);
  const [useFallbackMap, setUseFallbackMap] = useState(false);
  const [lastUpdated, setLastUpdated] = useState(null);
  const [frameSize, setFrameSize] = useState(MAP_SIZE);
  const mapFrameRef = useRef(null);

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
  const mapImageUrl = useMemo(() => buildMapUrl(availableMarkers, mapCenter), [availableMarkers, mapCenter]);

  useEffect(() => {
    setMapLoadError(false);
    setUseFallbackMap(false);
  }, [mapImageUrl]);

  useEffect(() => {
    if (!mapFrameRef.current || typeof ResizeObserver === 'undefined') return undefined;

    const observer = new ResizeObserver((entries) => {
      const [entry] = entries;
      if (!entry) return;

      const { width, height } = entry.contentRect;
      setFrameSize({ width, height });
    });

    observer.observe(mapFrameRef.current);
    return () => observer.disconnect();
  }, []);

  const positionedMarkers = useMemo(() => {
    const centerPoint = projectLatLon(mapCenter.lat, mapCenter.lon);
    const scaleX = frameSize.width / MAP_SIZE.width;
    const scaleY = frameSize.height / MAP_SIZE.height;

    return availableMarkers.map((marker) => {
      const point = projectLatLon(marker.lat, marker.lon);
      const left = MAP_SIZE.width / 2 + (point.x - centerPoint.x);
      const top = MAP_SIZE.height / 2 + (point.y - centerPoint.y);

      return {
        ...marker,
        position: {
          left: left * scaleX,
          top: top * scaleY,
        },
      };
    });
  }, [availableMarkers, frameSize.height, frameSize.width, mapCenter.lat, mapCenter.lon]);

  const mapSrc = useFallbackMap ? mapPlaceholder : mapImageUrl;

  const bannerMessage =
    error ||
    (mapLoadError
      ? 'Nie udało się pobrać obrazu mapy z OpenStreetMap. Wyświetlamy widok zastępczy.'
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
        <div className="map-frame" ref={mapFrameRef}>
          <img
            src={mapSrc}
            alt="Mapa z oznaczonymi dostępnymi Mordeczkami"
            loading="lazy"
            referrerPolicy="no-referrer"
            onLoad={() => {
              if (!useFallbackMap) {
                setMapLoadError(false);
              }
            }}
            onError={() => {
              if (!useFallbackMap) {
                setMapLoadError(true);
                setUseFallbackMap(true);
              }
            }}
          />
          <div className="map-markers" aria-hidden="true">
            {positionedMarkers.map(({ id, name, character, position }) => (
              <div
                key={id}
                className="map-marker"
                style={{ left: `${position.left}px`, top: `${position.top}px` }}
              >
                <CharacterMarker character={character} name={name} />
                <span className="map-marker__label">{name}</span>
              </div>
            ))}
          </div>
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
