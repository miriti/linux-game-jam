package powerups;

import openfl.events.Event;

import common.GameSprite;
import common.Centered;

import player.Player;

import motion.Actuate;
import motion.actuators.IGenericActuator;
import motion.easing.*;

class PowerUp extends GameSprite {
  var image:Centered;
  var tween:IGenericActuator;

  public static function random(): PowerUp {
    var classes:Array<Class<PowerUp>> = [Health, Shield, Upgrade];
    classes.sort(function(a:Class<PowerUp>, b:Class<PowerUp>) {
      return Math.random() > 0.5 ? 1 : -1;
    });

    return Type.createInstance(classes.pop(), []);
  }

  public function new(icon:String, name: String) {
    super();

    image = new Centered("assets/s/powerups/" + icon + ".png");
    addChild(image);

    var caption = ui.Font.getTextField(8);
    caption.text = name;
    caption.y = height / 2 + 3;
    caption.x = -caption.width / 2;
    addChild(caption);

    alpha = 0.5;

    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  function onAddedToStage(e:Event) {
    Actuate.timer(15).onComplete(end);

    if(x > 480) {
      tween = Actuate.tween(this, 3, { x: -width }).ease(Linear.easeNone).repeat().reflect();
    } else {
      tween = Actuate.tween(this, 3, { x: 480 + width }).ease(Linear.easeNone).repeat().reflect();
    }
  }

  function end() {
    Actuate.stop(tween);
    if(parent != null) {
      parent.removeChild(this);
    }
  }

  function affect() {
  }

  override function update(delta: Float) {
    if(image.getBounds(GameMain.instance).intersects(Player.instance.getBounds(GameMain.instance))) {
      affect();
      end();
    }
  }
}
