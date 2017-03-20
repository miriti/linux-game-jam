package;

class Win extends common.State {
  public function new() {
    super();

    var win = ui.Font.getTextField(60, 0xcccb75, "upheavtt.ttf");
    win.text = "You Win!";

    win.x = (480 - win.width) / 2;
    win.y = (680 - win.height) / 2;

    addChild(win);
  }
}
