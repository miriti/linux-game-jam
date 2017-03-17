package;

import ship.Ship;

import common.State;
import common.Centered;

import openfl.Lib;
import openfl.ui.Keyboard;
import openfl.ui.Mouse;

class GameMain extends State {
  public static var instance: GameMain;

  public var battleShips:Array<Ship> = [];

  var player:Player;
  var enemy:Enemy;

  var buttonsDown:Map<Int, Bool> = new Map<Int, Bool>();
  var crosshair:Centered;

  public function new() {
    super();

    instance = this;

    player = new Player();

    player.x = Lib.current.stage.stageWidth / 2;
    player.y = Lib.current.stage.stageHeight * 0.85;
    addChild(player);

    battleShips.push(player);

    enemy = new Enemy();
    enemy.x = Lib.current.stage.stageWidth / 2;
    enemy.y = Lib.current.stage.stageHeight * 0.25;
    addChild(enemy);

    battleShips.push(enemy);

    crosshair = new Centered("assets/s/crosshair.png");
    addChild(crosshair);

    Mouse.hide();
  }

  override public function keyDown(keyCode: Int) {
    buttonsDown.set(keyCode, true);
  }

  override public function keyUp(keyCode: Int) {
    buttonsDown.set(keyCode, false);
  }

  override function update(delta: Float) {
    super.update(delta);

    crosshair.x = mouseX;
    crosshair.y = mouseY;

    player.rotation = Math.atan2(crosshair.y - player.y, crosshair.x - player.x) * (180 / Math.PI);

    var axisX:Float = 0;
    var axisY:Float = 0;

    if((buttonsDown.get(Keyboard.LEFT) || buttonsDown.get(Keyboard.A))) {
      axisX = -1;
    }
    if((buttonsDown.get(Keyboard.RIGHT) || buttonsDown.get(Keyboard.D))) {
      axisX += 1;
    }
    if((buttonsDown.get(Keyboard.UP) || buttonsDown.get(Keyboard.W))) {
      axisY = -1;
    }
    if((buttonsDown.get(Keyboard.DOWN) || buttonsDown.get(Keyboard.S))) {
      axisY += 1;
    }

    player.axisX = axisX;
    player.axisY = axisY;
  }
}
