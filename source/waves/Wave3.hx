package waves;

import enemies.*;

import motion.Actuate;

class Wave3 extends Wave2 {
  public function new(game:GameMain) {
    super(game);

    count = 2;
  }

  override function genEnemy(): Enemy {
    var e = new Enemy4();
    e.x = xs.pop();
    e.y = -e.height;
    return e;
  }

  override function getNextWave(): Wave {
    return new Wave4(game);
  }

  override function start() {
    xs = [400, 80];
    spawn();

    Actuate.timer(5).onComplete(function() {
      spawn();
    });
  }
}
