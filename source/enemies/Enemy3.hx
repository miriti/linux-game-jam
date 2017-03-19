package enemies;

import openfl.events.Event;

import common.Centered;
import common.Vector;

import guns.*;

import player.Player;

import motion.Actuate;
import motion.easing.*;

class Enemy3 extends Enemy {
  var _guns:Array<Gun> = [];

  public function new() {
    super();

    var body = new Centered("assets/s/enemy3/body.png");
    sprite.addChild(body);

    cockpit = HitObject.withCentered("assets/s/enemy3/cockpit.png");
    addHitObject(cockpit);

    _guns.push(new SerialGun(this));
    _guns.push(new SerialGun(this));

    _guns[0].active = false;
    _guns[1].active = false;

    mountGun(_guns[0], -10, -20);
    mountGun(_guns[1], -10, 20);

    var engine1 = new Engine();
    engine1.x = -30;
    engine1.y = -30;
    sprite.addChild(engine1);

    var engine2 = new Engine();
    engine2.x = -30;
    engine2.y = 30;
    sprite.addChild(engine2);

    initHealthBar();

    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  function onAddedToStage(e:Event) {
    aim();
    move();

    Actuate.timer(3).onComplete(function() {
      for(gun in _guns) {
        gun.active = true;
      }
    });
  }

  function move() {
    Actuate.tween(this, 3, {x: 80, y: 550}).ease(Sine.easeInOut).onComplete(function() {
      Actuate.tween(this, 3, {x: 400, y: 550}).ease(Sine.easeInOut).onComplete(function() {
        Actuate.tween(this, 3, {x: 400, y: 80}).ease(Sine.easeInOut).onComplete(function() {
          Actuate.tween(this, 3, {x: 80, y: 80}).ease(Sine.easeInOut).onComplete(move);
        });
      });
    });
  }

  function aim() {
    var target_rotation = Vector.between(this, Player.instance).rotation;
    Actuate.tween(sprite, 0.4, {rotation: target_rotation}).smartRotation().onComplete(aim);
  }
}
