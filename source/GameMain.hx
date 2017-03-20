package;

import ship.Ship;

import player.Player;

import enemies.*;
import waves.*;

import powerups.PowerUp;

import common.GameSprite;
import common.State;
import common.Centered;
import common.Vector;

import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.ui.Keyboard;
import openfl.ui.Mouse;
import openfl.Assets;

import motion.Actuate;

class GameMain extends State {
  public static var instance: GameMain;

  public var battleShips:Array<Ship> = [];
  public var gameLayer:GameSprite = new GameSprite();

  var player:Player;

  var buttonsDown:Map<Int, Bool> = new Map<Int, Bool>();
  var crosshair:Centered;

  var shaking:Bool = false;
  var shakePhase:Vector = new Vector(0, 0);
  public var shakeAmpl:Float = 0;

  public var wave:Wave;

  var bar:ui.Bar;

  public function new() {
    super();

    showCursor = false;

    instance = this;

    // gameLayer.addChild(new Background());
    addChild(gameLayer);

    player = new Player();
    player.x = Lib.current.stage.stageWidth / 2;
    player.y = Lib.current.stage.stageHeight * 0.85;
    addShip(player);

    bar = new ui.Bar();
    bar.barMax = player.cockpit.maxHealth;
    bar.value = player.cockpit.health;
    bar.x = (480 - bar.width) / 2;
    bar.y = 640 - bar.height - 10;
    bar.alpha = 0.6;

    addChild(bar);

    player.addEventListener('hit', function(e:Event) {
      shake(1, 5);
      bar.value = player.cockpit.health;

      Assets.getSound("assets/sfx/hit.wav").play();
    });

    crosshair = new Centered("assets/s/crosshair.png");
    crosshair.x = 240;
    crosshair.y = 100;
    addChild(crosshair);

    wave = new Wave2(this);

    spawnPowerUp();
  }

  public function spawnPowerUp() {
    Actuate.timer(20).onComplete(function() {
      var pup = PowerUp.random();
      pup.y = 100 + Math.random() * 500;
      pup.x = Math.random() > 0.5 ? -pup.width : 480 + pup.width;
      gameLayer.addChild(pup);
      spawnPowerUp();
    });
  }

  public function shake(time: Float = 2, amp: Float = 30) {
    shaking = true;
    shakeAmpl = amp;

    Actuate.tween(this, time, { shakeAmpl: 0 }).onComplete(function() {
      shaking = false;
    });
  }

  public function add(obj: GameSprite) {
    gameLayer.addChild(obj);
  }

  public function addShip(ship: Ship) {
    add(ship);
    battleShips.push(ship);
  }

  override public function keyDown(keyCode: Int) {
    buttonsDown.set(keyCode, true);
  }

  override public function keyUp(keyCode: Int) {
    buttonsDown.set(keyCode, false);
  }

  override function update(delta: Float) {
    super.update(delta);

    if(shaking) {
      gameLayer.x = Math.sin(shakePhase.x) * shakeAmpl;
      gameLayer.y = Math.cos(shakePhase.y) * shakeAmpl;

      shakePhase.x += Math.PI * Math.random() * 20 * delta;
      shakePhase.y += Math.PI * Math.random() * 20 * delta;
    }

    crosshair.x = Main.instance.mouseX;
    crosshair.y = Main.instance.mouseY;

    player.sprite.rotation = Math.atan2(crosshair.y - player.y, crosshair.x - player.x) * (180 / Math.PI);

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
