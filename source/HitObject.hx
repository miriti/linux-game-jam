package;

import openfl.events.Event;
import openfl.Assets;

import common.GameSprite;
import common.Centered;

import motion.Actuate;

class HitObject extends GameSprite {
  public var maxHealth:Float = 100;
  public var health:Float = 100;
  public var sound:Bool = false;

  public static function withCentered(asset: String, hor: Bool = true, ver: Bool = true) {
    var ho = new HitObject();
    var ce = new Centered(asset, hor, ver);
    ho.addChild(ce);

    return ho;
  }

  public function new () {
    super();
  }

  public function hit(amount: Float) {
    health -= amount;

    if(health <= 0) {
      dispose();
    }

    alpha = 0.5;

    dispatchEvent(new Event('hit', true));

    if(sound) {
      Assets.getSound("assets/sfx/hit2.wav").play();
    }

    Actuate.tween(this, 0.2, { alpha : 1 });
  }

  function dispose() {
    GameMain.instance.shake();
    dispatchEvent(new Event('destroy', true));
    Assets.getSound("assets/sfx/explosion.wav").play();
  }
}
