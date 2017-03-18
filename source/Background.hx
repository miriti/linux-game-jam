package;

import common.GameSprite;

import openfl.display.Bitmap;
import openfl.Assets;

class StarTrail extends GameSprite {
  var speed: Float;

  public function new() {
    super();

    var img = new Bitmap(Assets.getBitmapData("assets/s/star-trail.png"));
    addChild(img);

    speed = 400 + Math.random() * 400;

    alpha = 0.25;
  }

  override function update(delta: Float) {
    y += speed * delta;

    if(y >= 640) {
      y = -height;
    }
  }
}

class Background extends GameSprite {
  public function new() {
    super();

    for(i in 0...75) {
      var st = new StarTrail();
      st.x = Math.random() * 480;
      st.y = Math.random() * 640;

      addChild(st);
    }
  }
}
