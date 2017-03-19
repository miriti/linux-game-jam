package powerups;

class Upgrade extends PowerUp {
  public function new() {
    super("guns", "Upgrade guns");
  }

  override function affect() {
    player.Player.instance.upgrade();
  }
}
