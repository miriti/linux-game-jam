package guns;

import openfl.events.Event;

import common.GameSprite;
import common.Centered;
import common.Vector;

import ship.Ship;

class Gun {
  public var sprite(default, set):GunSprite;

  var cooldown:Float = 0.05;
  var ship: Ship;
  var spread: Float = 5;
  var functioning: Bool = true;

  private var time:Float = 0;

  public function new(ship: Ship) {
    this.ship = ship;

    sprite = new guns.sprites.Basic(); 
  }

  function fire() {
    var bullets:Array<Bullet> = generateBullets();

    for(bullet in bullets) {
      GameMain.instance.addChild(bullet);
    }
  }

  function generateBullets():Array<Bullet> {
    var b = new Bullet(Vector.fromRotation(ship.rotation + (-spread/2 + Math.random() * spread)), ship.team);
    b.x = sprite.muzzle.getBounds(GameMain.instance).x;
    b.y = sprite.muzzle.getBounds(GameMain.instance).y;
    b.rotation = ship.rotation;
    return [b];
  }

  public function update(delta: Float) {
    if(functioning) {
      if(time <= 0) {
        time = cooldown + time;
        fire();
      } else {
        time -= delta;
      }
    }
  }

  function set_sprite(value: GunSprite): GunSprite {
    if(sprite != null) {
      // TODO Remove event listener
    }
    sprite = value;
    sprite.addEventListener('destroy', function(e: Event) {
      functioning = false;
    });

    return sprite;
  }
}
