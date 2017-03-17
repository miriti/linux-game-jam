package;

import common.Centered;
import common.Vector;

class Bullet extends Centered {
  var speed: Float = 750;
  var lifetime: Float = 1;
  var team:Team;
  public var vector:Vector;

  public function new(vector:Vector, team: Team) {
    super("assets/s/bullet.png");
    this.vector = vector;
    this.team = team;
  }

  override function update(delta: Float) {
    if(lifetime > 0) {
      var new_x = x + speed * delta * vector.x;
      var new_y = y + speed * delta * vector.y;
      // TODO Find collisions inbetween
      x = new_x;
      y = new_y; 

      for(enemy in GameMain.instance.battleShips.filter(function(ship) {
        return ship.team != team;
      })) {
        var b = getBounds(GameMain.instance);
        var sb = enemy.getBounds(GameMain.instance);

        if(b.intersects(sb)) {
          for(ho in enemy.hitObjects) {
            if(ho.getBounds(GameMain.instance).intersects(b)) {
              ho.hit(1);
              dispose();
              return;
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
