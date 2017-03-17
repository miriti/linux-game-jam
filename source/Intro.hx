package;

import openfl.display.Bitmap;
import openfl.Assets;

import motion.Actuate;
import motion.easing.*;
import motion.actuators.IGenericActuator;

class Intro extends common.State {
  var logo:Bitmap;
  var timer:IGenericActuator;
  var _skipped:Bool = false;

  public function new() {
    super();

    logo = new Bitmap(Assets.getBitmapData("assets/jam-logo.png"));
    addChild(logo);

    Actuate.tween(logo, 20, {x: -logo.width, scaleX: 1.1, scaleY: 1.1}).ease(Linear.easeNone);

    timer = Actuate.timer(5).onComplete(function() {
      if(!_skipped) {
        skip();
      }
    });
  }

  function skip(instant:Bool = false) {
    Actuate.stop(timer);
    Main.instance.setState(new MenuMain(), !instant, 5);
  }

  override public function keyDown(keyCode: Int): Void {
    if(!_skipped) {
      _skipped = true;
      skip(true);
    }
  }
}
