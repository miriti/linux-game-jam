package player;

import common.Centered;

class Cockpit extends HitObject {
  public function new() {
    super();

    var image = new Centered("");
    addChild(image);
  }
}
