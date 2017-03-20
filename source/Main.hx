package;

import common.State;
import common.StateMachine;

import openfl.events.Event;
import openfl.media.SoundTransform;
import openfl.Assets;

class Main extends StateMachine {
  public static var instance:Main;

	public function new () {
		super ();

    instance = this;

    State.target_width = 480;
    State.target_height = 640;

    setState(new Intro(), true, 5);

    startMusic();
	}

  function startMusic(e:Event = null) {
    var sndTransform = new SoundTransform(0.7);
    var sndChannel = Assets.getMusic("assets/music.ogg").play(0, 0, sndTransform);
    sndChannel.addEventListener(Event.SOUND_COMPLETE, startMusic);
  }
}
