package;

import openfl.display.Bitmap;
import openfl.Assets;

import motion.Actuate;
import motion.easing.*;

class Intro extends common.State {
  var logo:Bitmap;
  public function new() {
    super();

    logo = new Bitmap(Assets.getBitmapData("assets/jam-logo.png"));
    addChild(logo);

    Actuate.tween(logo, 20, {x: -logo.width, scaleX: 1.1, scaleY: 1.1}).ease(Linear.easeNone);

    Actuate.timer(5).onComplete(function() {
      Main.instance.setState(new MenuMain(), true, 5);
    });
  }
}
