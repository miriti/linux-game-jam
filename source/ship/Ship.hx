package ship;

import openfl.events.Event;

import common.GameSprite;
import guns.Gun;
import ui.Bar;

class Ship extends GameSprite {
  public var team:Team;
  public var hitObjects:Array<HitObject> = [];
  public var cockpit: HitObject;
  public var sprite:GameSprite = new GameSprite();

  var guns:Array<Gun> = [];
  var healthBar:Bar;

  public function new() {
    super();

    addChild(sprite);
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

  public function addHitObject(hitObject:HitObject, atx: Float = 0, aty: Float = 0) {
    hitObject.x = atx;
    hitObject.y = aty;
    sprite.addChild(hitObject);
    hitObjects.push(hitObject);

    hitObject.addEventListener('destroy', function(e:Event) {
      removeChild(hitObject);
      hitObjects.remove(hitObject);
      equipmentDestroyed(hitObject);
    });
  }

  function equipmentDestroyed(equip: HitObject) {
  }
}

