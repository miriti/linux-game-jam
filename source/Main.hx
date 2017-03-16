package;

import common.State;
import common.StateMachine;

class Main extends StateMachine {
  public static var instance:Main;

	public function new () {
		super ();

    instance = this;

    State.target_width = 480;
    State.target_height = 640;

    setState(new Intro(), true, 5);
	}
}
