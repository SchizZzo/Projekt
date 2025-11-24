import { useEffect, useRef, useState } from 'react';
import MordeczkiAsset from '../assets/mordeczki4.riv';

const RIVE_MODULE_URL = 'https://cdn.jsdelivr.net/npm/@rive-app/canvas@2.17.6/+esm';

function MordeczkiAnimation() {
  const canvasRef = useRef(null);
  const [status, setStatus] = useState('loading');

  useEffect(() => {
    let riveInstance;
    let isMounted = true;

    async function loadAnimation() {
      try {
        const { Rive } = await import(/* @vite-ignore */ RIVE_MODULE_URL);
        if (!isMounted) return;

        const canvas = canvasRef.current;
        if (!canvas) return;

        riveInstance = new Rive({
          src: MordeczkiAsset,
          canvas,
          autoplay: true,
          fitCanvasToArtboardHeight: true,
        });

        setStatus('ready');
      } catch (error) {
        console.error('Nie udało się załadować animacji Rive:', error);
        if (isMounted) {
          setStatus('error');
        }
      }
    }

    loadAnimation();

    return () => {
      isMounted = false;
      if (riveInstance?.cleanup) {
        riveInstance.cleanup();
      }
    };
  }, []);

  return (
    <div className="mordeczki-player" data-state={status}>
      <canvas ref={canvasRef} width={480} height={360} aria-label="Animacja Mordeczki" />
      {status !== 'ready' && (
        <div className="mordeczki-placeholder">
          <p>{status === 'error' ? 'Nie udało się załadować animacji.' : 'Ładowanie animacji...'}</p>
          <small>Plik: mordeczki4.riv</small>
        </div>
      )}
    </div>
  );
}

export default MordeczkiAnimation;
