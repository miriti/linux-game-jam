package enemies;

import openfl.events.Event;

import common.Centered;

import guns.SlowGun;

import motion.Actuate;

class Enemy1 extends Enemy {
  var phase: Float = 0;
  public function new () {
    super();

    var body = new Centered("assets/s/enemy1/body.png");
    sprite.addChild(body);

    cockpit = HitObject.withCentered("assets/s/enemy1/cockpit.png");
    addHitObject(cockpit);

    mountGun(new SlowGun(this), 20, 0);

    sprite.rotation = 90;

    startMotion();

    initHealthBar();
  }

  override function update(delta: Float) {
    sprite.rotation += 200 * delta;
    super.update(delta);
  }

  function startMotion() {
    Actuate.tween(this, 7, {x: 70, y: 300}).onComplete(function() {
      Actuate.tween(this, 7, {x: 380, y: 300}).onComplete(function() {
        Actuate.tween(this, 7, {x: 240, y: 50}).onComplete(function() {
          startMotion();
        });
      });
    });
  }

  override function equipmentDestroyed(e: HitObject) {
    if(e == cockpit) {
      dispatchEvent(new Event("destroyed"));
      parent.removeChild(this);
    }
  }
}
