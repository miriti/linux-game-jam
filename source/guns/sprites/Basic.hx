package guns.sprites;

import common.Centered;

class Basic extends guns.GunSprite {
  public function new() {
    super();

    var image = new Centered("assets/s/gun.png", false, true);
    addChild(image);

    muzzle.x = image.width;
    addChild(muzzle);
  }
}
