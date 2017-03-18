package guns;

import openfl.events.Event;

import common.GameSprite;
import common.Centered;
import common.Vector;

import ship.Ship;

class Gun {
  public var sprite(default, set):GunSprite;
  public var direction(default, set):Float = 0;
  public var active: Bool = true;

  var bulletDelay:Float = 0.1;
  var spread: Float = 5;
  var cooldown: Float = 0;
  var serieSize: Int = 0;
  var serieDelay: Float = 0.5;

  var ship: Ship;

  private var bulletTime: Float = 0;
  private var cooldownTime: Float = 0;
  private var bulletsShot: Int = 0;

  public function new(ship: Ship) {
    this.ship = ship;
    sprite = new guns.sprites.Basic(); 
  }

  function set_direction(value: Float): Float {
    if(sprite != null) {
      sprite.rotation = value;
    }
    return direction = value;
  }

  function fire() {
    var bullets:Array<Bullet> = generateBullets();

    for(bullet in bullets) {
      GameMain.instance.add(bullet);
    }
  }

  function getVector():Vector {
    return Vector.fromRotation((ship.sprite.rotation + direction) + (-spread/2 + Math.random() * spread));
  }

  function produceBullet():Bullet {
    return new Bullet(getVector(), ship.team);
  }

  function generateBullets():Array<Bullet> {
    var b = produceBullet();
    b.x = sprite.muzzle.getBounds(GameMain.instance).x;
    b.y = sprite.muzzle.getBounds(GameMain.instance).y;
    b.rotation = ship.sprite.rotation + direction;
    return [b];
  }

  public function update(delta: Float) {
    if(active) {
      if(cooldownTime <= 0) {
        if((serieSize == 0) || (bulletsShot < serieSize)) {
          if(bulletTime <= 0) {
            bulletTime = bulletDelay + bulletTime;
            bulletsShot++;
            fire();
          } else {
            bulletTime -= delta;
          }
        } else {
          bulletsShot = 0;
          cooldownTime = cooldown + cooldownTime;
        }
      } else {
        cooldownTime -= delta;
      }
    } 
  }

  function set_sprite(value: GunSprite): GunSprite {
    if(sprite != null) {
      // TODO Remove event listener
    }
    sprite = value;
    sprite.rotation = direction;
    sprite.addEventListener('destroy', function(e: Event) {
      active = false;
    });

    return sprite;
  }
}
