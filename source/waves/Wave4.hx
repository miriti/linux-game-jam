package waves;

import openfl.events.Event;

import enemies.Enemy3;

class Wave4 extends Wave {
  public function new(game: GameMain) {
    super(game);

    var enemy = new Enemy3();
    enemy.x = 240;
    enemy.y = -100;
    game.addShip(enemy);

    enemy.cockpit.addEventListener("destroy", function(e:Event) {
      enemy.parent.removeChild(enemy);
      Main.instance.setState(new Win(), true, 5);
    });
 }
}
