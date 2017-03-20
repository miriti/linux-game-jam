package;

import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.system.System;

import motion.Actuate;
import motion.easing.*;

class MenuItem extends Sprite {
  public function new(title: String, action: Void -> Void) {
    super();

    var text = ui.Font.getTextField(30);
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

    var title = ui.Font.getTextField(120);
    title.text = "A*VOID";

    var credit = ui.Font.getTextField(21, 0xcccb75, "upheavtt.ttf");
    credit.text = "by Michael Miriti";
    credit.alpha = 0;

    var twitter = ui.Font.getTextField(21, 0xcccb75, "upheavtt.ttf");
    twitter.text = "@michael_miriti";
    twitter.alpha = 0;

    title.x = (480 - title.width) / 2;
    title.y = (640 - title.height) / 2;

    twitter.x = (480 - twitter.width) / 2;
    twitter.y = 640 - twitter.height;
    credit.x = (480 - credit.width) / 2;
    credit.y = twitter.y - credit.height;

    addChild(title);
    addChild(credit);
    addChild(twitter);

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

    items.alpha = 0;

    Actuate.tween(title, 4, {y: 200}).ease(Sine.easeOut).delay(1);
    Actuate.tween(items, 4, {alpha: 1}).ease(Sine.easeOut).delay(2);
    Actuate.tween(credit, 4, {alpha: 1}).ease(Sine.easeOut).delay(2);
    Actuate.tween(twitter, 4, {alpha: 1}).ease(Sine.easeOut).delay(2);
  }
}
