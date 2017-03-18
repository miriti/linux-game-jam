package guns;

import ship.Ship;

class SlowGun extends Gun {
  public function new(ship: Ship) {
    super(ship);

    bulletDelay = 0.15;
  }

  override function produceBullet():Bullet {
    return new SlowBullet(getVector(), ship.team);
  }
}
