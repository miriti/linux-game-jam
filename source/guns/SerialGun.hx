package guns;

import ship.Ship;

class SerialGun extends Gun {
  public function new(ship: Ship) {
    super(ship);

    serieSize = 10;
    cooldown = 0.5;
  }

  override function produceBullet():Bullet {
    return new SlowBullet(getVector(), ship.team);
  }
}
