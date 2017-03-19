package;

import common.State;
import common.StateMachine;
import openfl.display.FPS;

class Main extends StateMachine {
  public static var instance:Main;

	public function new () {
		super ();

    instance = this;

    State.target_width = 480;
    State.target_height = 640;

    setState(new Intro(), true, 5);
//    setState(new GameMain());

    addChild(new FPS(10, 10, 0xe8dd35));
	}
}
