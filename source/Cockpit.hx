package;

import common.Centered;

class Cockpit extends HitObject {
  public function new() {
    super();

    var image = new Centered("assets/s/cockpit.png");
    addChild(image);
  }
}
