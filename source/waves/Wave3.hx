package waves;

class Wave3 extends Wave2 {
  public function new(game:GameMain) {
    super(game);

    count = 2;
  }

  override function getNextWave(): Wave {
    return new Wave4(game);
  }

  override function start() {
    xs = [400, 80];
    spawn();
    spawn();
  }
}
