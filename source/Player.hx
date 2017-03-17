package;

import ship.Ship;

import common.Centered;

import guns.Gun;

class Player extends Ship {
  public var axisX: Float = 0;
  public var axisY: Float = 0;

  public var speed: Float = 200;

  var image:Centered;

  var gun:Gun;

  public function new() {
    super();

    team = Player;

    image = new Centered("assets/s/player.png");
    addChild(image);

   // mountGun(new Gun(this), width / 2 - 40, -height * 0.25);
    // mountGun(new Gun(this), width / 2 - 40, height * 0.25);
    mountGun(new Gun(this), width / 2 - 10, 0);
  }

  override function update(delta: Float) {
    x += speed * delta * axisX;
    y += speed * delta * axisY;

    super.update(delta);
  }
}
