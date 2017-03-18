package guns;

import common.GameSprite;
import openfl.display.Sprite;

class GunSprite extends GameSprite {
  public var muzzle:Sprite = new Sprite();

  public function new() {
    super();
    muzzle.graphics.beginFill(0xff0000, 0);
    muzzle.graphics.drawRect(0, 0, 1, 1);
    muzzle.graphics.endFill();
  }
}
