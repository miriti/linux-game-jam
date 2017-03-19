package powerups;

class Shield extends PowerUp {
  public function new() {
    super("shield", "Shield");
  }

  override function affect() {
    player.Player.instance.shield();
  }
}
