package ui;

import openfl.text.*;
import openfl.Assets;

class Font {
  public static function getTextField(size: Int = 20, color:Int = 0xcccb75, fontFile:String = "upheavtt.ttf"): TextField {
    var textField = new TextField();
    var f = new TextFormat(Assets.getFont("assets/fonts/" + fontFile).fontName, size, color);
    textField.setTextFormat(f);
    textField.selectable = false;
    textField.autoSize = TextFieldAutoSize.LEFT;

    return textField;
  }
}
