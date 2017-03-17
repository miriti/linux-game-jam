package ship;

import openfl.events.Event;

import common.GameSprite;
import guns.Gun;

class Ship extends GameSprite {

  public var team:Team;
  public var hitObjects:Array<HitObject> = [];

  var guns:Array<Gun> = [];

  override function update(delta: Float) {
    super.update(delta);

    for(gun in guns) {
      gun.update(delta);
    }
  }

  public function mountGun(gun:Gun, atx:Float, aty:Float) {
    addHitObject(gun.sprite, atx, aty);
    guns.push(gun);
  }

  public function addHitObject(hitObject:HitObject, atx: Float, aty: Float) {
    hitObject.x = atx;
    hitObject.y = aty;
    addChild(hitObject);
    hitObjects.push(hitObject);

    hitObject.addEventListener('destroy', function(e:Event) {
      removeChild(hitObject);
      hitObjects.remove(hitObject);

      if(hitObjects.length == 0) {
        // TODO Everything is destroyed
      }
    });
  }
}

