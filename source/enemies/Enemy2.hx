package enemies;

import guns.*;
import motion.Actuate;
import motion.easing.*;

class Enemy2 extends Enemy1 {
  public function new() {
    super();

    var secondGun = new SlowGun(this);
    secondGun.direction = 180;

    mountGun(secondGun, -20, 0);

    for(gun in guns) {
      gun.active = false;
    }
  }

  override function startMotion() {
    Actuate.timer(2).onComplete(function() {
      for(gun in guns) {
        gun.active = true;
      }
    });

    Actuate.tween(this, 5, {y: 350}).ease(Sine.easeInOut).onComplete(function() {
      Actuate.tween(this, 3, {y: 100}).ease(Sine.easeInOut).repeat().reflect();
    });
  }

}
