package player;

import openfl.events.Event;

import ship.Ship;

import common.Centered;

import guns.Gun;

class Player extends Ship {
  public static var instance:Player;

  public var axisX: Float = 0;
  public var axisY: Float = 0;
  public var speed: Float = 300;

  var image:Centered;

  var level = 0;


  public function new() {
    super();

    instance = this;

    team = Player;

    image = new Centered("assets/s/player/body.png");
    sprite.addChild(image);

    cockpit = HitObject.withCentered("assets/s/player/cockpit.png");
    addHitObject(cockpit);

    var engine1:Engine = new Engine();
    engine1.x = -30;
    engine1.y = -20;
    sprite.addChild(engine1);

    var engine2:Engine = new Engine();
    engine2.x = -30;
    engine2.y = 20;
    sprite.addChild(engine2);

    mountGun(new Gun(this), 25, 0);
  }

  function unmountGuns() {
    for(gun in guns) {
      unmountGun(gun);
    }
  }

  public function upgrade() {
    level++;

    switch(level) {
      case 1: 
        unmountGuns();
        mountGun(new Gun(this), -10, -20);
        mountGun(new Gun(this), -10, 20);
      case 2:
        unmountGuns();
        mountGun(new Gun(this), 25, 0);
        mountGun(new Gun(this), -10, -20);
        mountGun(new Gun(this), -1, 20);
    }
  }


  public function heal() {
    cockpit.health = cockpit.maxHealth;
    dispatchEvent(new Event("hit"));
  }

  override function update(delta: Float) {
    x += speed * delta * axisX;
    y += speed * delta * axisY;

    super.update(delta);
  }

  override function equipmentDestroyed(equip: HitObject) {
    if(equip == cockpit) {
      // TODO Game over
    }
  }
}
