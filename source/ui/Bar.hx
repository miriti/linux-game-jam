package ui;

import openfl.display.Sprite;

class Bar extends Sprite {
  public var value(default, set): Float;
  public var barMax:Float;

  var barWidth:Float;
  var barHeight:Float;
  var borderSize:Float = 1;

  public function new(barWidth: Float = 460, barHeight: Float = 30, barMax: Float = 100) {
    super();

    this.barWidth = barWidth;
    this.barHeight = barHeight;
    this.barMax = barMax;

    value = 0;
  }

  function set_value(newValue: Float): Float {
    if(newValue != value) {
      graphics.clear();

      graphics.beginFill(0xcccb75);
      graphics.drawRect(0, 0, barWidth, barHeight);
      graphics.endFill();

      graphics.beginFill(0xc2272a);
      graphics.drawRect(borderSize, borderSize, newValue / barMax * barWidth - borderSize * 2, barHeight - borderSize * 2);
      graphics.endFill();
    }

    return value = newValue;
  }
}
