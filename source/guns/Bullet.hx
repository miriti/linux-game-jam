package guns;

import common.Centered;
import common.Vector;

class Bullet extends Centered {
  public var vector: Vector;
  public var damage: Float = 1;

  var speed: Float = 750;
  var lifetime: Float = 1;
  var team:Team;

  public function new(vector:Vector, team: Team) {
    super("assets/s/bullet.png");
    this.vector = vector;
    this.team = team;
  }

  override function update(delta: Float) {
    if(lifetime > 0) {
      rotation += 1000 * delta;
      var new_x = x + speed * delta * vector.x;
      var new_y = y + speed * delta * vector.y;
      // TODO Find collisions inbetween
      x = new_x;
      y = new_y; 

      for(enemy in GameMain.instance.battleShips.filter(function(ship) {
        return ship.team != team;
      })) {
        if(enemy.shielded) {
          if(Vector.between(this, enemy).length < 50) {
            dispose();
          }
        } else {
          var b = getBounds(GameMain.instance);
          var sb = enemy.getBounds(GameMain.instance);
          if(b.intersects(sb)) {
            for(ho in enemy.hitObjects) {
              if(ho.getBounds(GameMain.instance).intersects(b)) {
                ho.hit(damage);
                dispose();
                return;
              }
            }
          }
        }
      }

      lifetime -= delta;
    } else {
      dispose();
    }
  }

  function dispose() {
    parent.removeChild(this);
  }
}
