package ship;

import openfl.events.Event;

import common.GameSprite;
import common.Centered;

import guns.Gun;
import ui.Bar;

import motion.Actuate;

class Ship extends GameSprite {
  public var team:Team;
  public var hitObjects:Array<HitObject> = [];
  public var cockpit: HitObject;
  public var sprite:GameSprite = new GameSprite();

  public var shielded:Bool = false;

  var guns:Array<Gun> = [];
  var healthBar:Bar;

  var _shield:Centered;

  public function new() {
    super();

    addChild(sprite);
    _shield = new Centered("assets/s/shield.png");
    _shield.visible = false;
    addChild(_shield);
  }

  public function shield() {
    if(!shielded) {
      _shield.alpha = 0;
      _shield.scaleX = _shield.scaleY = 0;

      Actuate.tween(_shield, 0.3, { alpha: 1, scaleX: 1, scaleY: 1 }).onComplete(function() {
        shielded = true;

        Actuate.timer(7).onComplete(function() {
          Actuate.tween(_shield, 0.10, {alpha: 0.1}).repeat().reflect();
        });

        Actuate.timer(10).onComplete(function() {
          shielded = false;
          Actuate.tween(_shield, 0.3, { alpha: 0, scaleX: 0, scaleY: 0 }).onComplete(function() {
          });
        });
      });
    }
  }

  function initHealthBar() {
    healthBar = new Bar(100, 5, cockpit.maxHealth);
    healthBar.y = -sprite.height/2 - 20;
    healthBar.x = -healthBar.width / 2;
    addChild(healthBar);
  }

  override function update(delta: Float) {
    super.update(delta);

    if(healthBar != null) {
      healthBar.value = cockpit.health;
    }

    for(gun in guns) {
      gun.update(delta);
    }
  }

  public function mountGun(gun:Gun, atx:Float, aty:Float) {
    gun.sprite.x = atx;
    gun.sprite.y = aty;
    sprite.addChild(gun.sprite);
    guns.push(gun);
  }

  public function unmountGun(gun:Gun) {
    if(guns.indexOf(gun) != -1) {
      sprite.removeChild(gun.sprite);
      guns.remove(gun);
    }
  }

  public function addHitObject(hitObject:HitObject, atx: Float = 0, aty: Float = 0) {
    hitObject.x = atx;
    hitObject.y = aty;
    sprite.addChild(hitObject);
    hitObjects.push(hitObject);

    hitObject.addEventListener('destroy', function(e:Event) {
      hitObject.parent.removeChild(hitObject);
      hitObjects.remove(hitObject);
      equipmentDestroyed(hitObject);
    });
  }

  public function deactivateGuns() {
    for(gun in guns) {
      gun.active = false;
    }
  }

  public function activateGuns() {
    for(gun in guns) {
      gun.active = true;
    }
  }

  function equipmentDestroyed(equip: HitObject) {
  }
}

