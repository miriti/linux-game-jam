package;

import openfl.events.Event;

import ship.Ship;
import common.Centered;
import guns.Gun;

class Enemy extends Ship {
  var phase: Float = 0;
  var cx: Float = 0;

  public function new() {
    super();

    team = Enemy;

    var image = new Centered("assets/s/enemy.png");
    addChild(image);

    addHitObject(new Cockpit(), 0, 0);

    mountGun(new Gun(this), 0, -100);
    mountGun(new Gun(this), 0, 100);

    rotation = 90;

    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  function onAddedToStage(e:Event) {
    cx = x;
  }

  override function update(delta: Float) {
    super.update(delta);

    x = cx + Math.sin(phase) * 150;

    phase += (Math.PI/10) * delta;
  }
}
