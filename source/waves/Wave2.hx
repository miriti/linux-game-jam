package waves;

import enemies.*;
import motion.Actuate;
import player.Player;

class Wave2 extends Wave1 {
  var xs:Array<Float> = [240];
  public function new (game: GameMain) {
    super(game);

    count = 1;
  }

  override function start() {
    Player.instance.deactivateGuns();

    Actuate.timer(2).onComplete(function() {
      var getReady = ui.Font.getTextField(60);
      getReady.text = "Get ready!";
      getReady.x = (480 - getReady.width) / 2;
      getReady.y = (640 - getReady.height) / 2;
      getReady.alpha = 0;

      GameMain.instance.addChild(getReady);

      Actuate.tween(getReady, 1, {alpha: 1});
      Actuate.tween(getReady, 1, {alpha: 0}, false).delay(3).onComplete(function() {
        Player.instance.activateGuns();
        spawn();
      });
    });
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
