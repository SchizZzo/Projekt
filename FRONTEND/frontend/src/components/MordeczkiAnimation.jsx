import Rive from '@rive-app/react-canvas';
import MordeczkiAsset from '../assets/mordeczki4.riv';

function MordeczkiAnimation() {
  return (
    <div className="mordeczki-player" data-state="ready">
      <div className="mordeczki-player__canvas" role="img" aria-label="Animacja Mordeczki">
        <Rive src={MordeczkiAsset} stateMachines="State Machine 1" style={{ width: 480, height: 360 }} />
      </div>
    </div>
  );
}

export default MordeczkiAnimation;
