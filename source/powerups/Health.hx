package powerups;

class Health extends PowerUp {
  public function new() {
    super("health", "Heal");
  }

  override function affect() {
    player.Player.instance.heal();
  }
}
