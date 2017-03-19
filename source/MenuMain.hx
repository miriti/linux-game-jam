package;

import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.system.System;

class MenuItem extends Sprite {
  public function new(title: String, action: Void -> Void) {
    super();

    var text = ui.Font.getTextField();
    text.text = title;

    text.x = -text.width/2;
    text.y = -text.height/2;
    addChild(text);

    alpha = 0.6;

    buttonMode = true;

    addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
    addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);

    addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
      Lib.current.stage.focus = Lib.current.stage;
      action();
    });
  }

  function onMouseOver(e:MouseEvent) {
    alpha = 1;
  }

  function onMouseOut(e:MouseEvent) {
    alpha = 0.6;
  }
}

class MenuMain extends common.State {
  var items: Sprite = new Sprite();

  public function new () {
    super();

    var new_game = new MenuItem("New Game", function() {
      Main.instance.setState(new GameMain());
    });

    var quit = new MenuItem("Quit", function() {
      System.exit(0);
    });

    quit.y = new_game.height + 10;

    items.addChild(new_game);
    items.addChild(quit);

    items.x = (Lib.current.stage.stageWidth) / 2;
    items.y = (Lib.current.stage.stageHeight) / 2;

    addChild(items);
  }
}
