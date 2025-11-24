import { useMemo } from 'react';
import { useRive, useStateMachineInput } from '@rive-app/react-canvas';
import MordeczkiAsset from '../assets/mordeczki4.riv';

const STATE_MACHINE_NAME = 'State Machine 1';

function MordeczkiAnimation() {
  const { rive, RiveComponent } = useRive({
    src: MordeczkiAsset,
    stateMachines: STATE_MACHINE_NAME,
    autoplay: true,
  });

  const controls = useMemo(
    () => [
      { name: 'kolorSkory', limit: 3, label: 'Kolor skóry' },
      { name: 'kolorWlosow', limit: 4, label: 'Kolor włosów' },
      { name: 'usta', limit: 3, label: 'Usta' },
      { name: 'dodatek', limit: 5, label: 'Dodatek' },
      { name: 'twarz', limit: 4, label: 'Twarz' },
      { name: 'wlosy', limit: 9, label: 'Włosy' },
    ],
    [],
  );

  const inputs = controls.map(({ name }) =>
    useStateMachineInput(rive, STATE_MACHINE_NAME, name, 0),
  );

  const cycleInput = (index, limit) => {
    const input = inputs[index];
    if (!input) return;

    const current = typeof input.value === 'number' ? input.value : 0;
    input.value = (current + 1) % limit;
  };

  return (
    <div className="mordeczki-player" data-state="ready">
      <div className="mordeczki-player__canvas" role="img" aria-label="Animacja Mordeczki">
        <RiveComponent style={{ width: 480, height: 360 }} />
      </div>

      <div className="mordeczki-player__controls" aria-label="Sterowanie Mordeczki">
        {controls.map(({ label, limit }, index) => (
          <button
            key={label}
            type="button"
            onClick={() => cycleInput(index, limit)}
            disabled={!inputs[index]}
            className="mordeczki-player__control"
          >
            {label}
          </button>
        ))}
      </div>
    </div>
  );
}

export default MordeczkiAnimation;
