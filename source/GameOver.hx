package;

class GameOver extends common.State {
  public function new() {
    super();

    var gameOver = ui.Font.getTextField(42);
    gameOver.text = "Game Over";

    gameOver.x = (480 - gameOver.width) / 2;
    gameOver.y = (680 - gameOver.height) / 2;
    addChild(gameOver);
  }
}
