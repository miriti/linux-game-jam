package guns;

import common.Vector;

class SlowBullet extends Bullet {
  public function new(vector:Vector, team: Team) {
    super(vector, team);

    speed = 250;
    lifetime = 5;
    damage = 5;
  }
}
