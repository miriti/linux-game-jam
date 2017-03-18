package;

import common.Centered;
import common.GameSprite;

class Engine extends GameSprite {
  var body:Centered;

  public function new() {
    super();

    body = new Centered("assets/s/engine.png");
    addChild(body);
  }
}
