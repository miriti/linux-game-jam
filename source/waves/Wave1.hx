package waves;

import openfl.events.Event;

import motion.Actuate;

import enemies.*;

class Wave1 extends Wave {
  var count:Int = 3;
  public function new(game: GameMain) {
    super(game);

    start();
  }

  function start() {
    spawn();
    Actuate.timer(7).onComplete(function() {
      spawn();
      Actuate.timer(7).onComplete(function() {
        spawn();
      });
    });
  }

  function genEnemy(): Enemy {
    var e = new Enemy1();
    e.x = 480 / 2;
    e.y = -200;
    return e;
  }

  function getNextWave(): Wave {
    return new Wave3(game);
  }

  function spawn() {
    var e:Enemy = genEnemy();
    game.addShip(e);

    e.addEventListener("destroyed", function(event:Event) {
      count--;

      if(count == 0) {
        game.wave = getNextWave();
      }
    });
  }
}
