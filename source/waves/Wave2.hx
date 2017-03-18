package waves;

import enemies.*;
import motion.Actuate;

class Wave2 extends Wave1 {
  var xs:Array<Float> = [240];
  public function new (game: GameMain) {
    super(game);

    count = 1;
  }

  override function start() {
    spawn();
  }

  override function genEnemy():Enemy {
    var e = new enemies.Enemy2();
    e.x = xs.pop();
    e.y = -e.height;
    return e;
  }

  override function getNextWave():Wave {
    return new Wave1(game);
  }
}
