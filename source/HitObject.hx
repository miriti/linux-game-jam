package;

import openfl.events.Event;

import common.GameSprite;
import motion.Actuate;

class HitObject extends GameSprite {
  var maxHealth:Float = 100;
  var health:Float = 100;

  public function new () {
    super();
  }

  public function hit(amount: Float) {
    health -= amount;

    if(health <= 0) {
      dispose();
    }

    alpha = 0.5;

    Actuate.tween(this, 0.2, { alpha : 1 });
  }

  function dispose() {
    dispatchEvent(new Event('destroy'));
  }
}
