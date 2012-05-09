import Qt 4.7
import Box2D 1.0

Body {
	width: 126;
	height: 88;
	sleepingAllowed: false
	angularDamping: 1;
	property int beat: 1;

	fixtures: Box {
		anchors.fill: parent
		density: 0.1;
		friction: 0.3;
		restitution: 0.5;
	}

	Image { 
		id: gullImg;
		anchors.fill: parent;
		source: "seagull1.svg";
	}

	Timer { 
		interval: 300;
		running: true;
		repeat: true;
		onTriggered: {
			if (Qt.application.active) {
				gullImg.source = "seagull" + beat + ".svg";
				beat++;
				if (beat == 3) {
					beat = 1;
				}
			}
		}
	}

}

