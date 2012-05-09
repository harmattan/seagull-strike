import Qt 4.7
import Box2D 1.0
import com.nokia.meego 1.0

Image {
	id: screen;
	width: 854;
	height: 480;

	source: "title.jpg";
	property int lives: 10;
	property int score: 0;
	property bool collided: false;
	property bool playing: false;

	Label {
		id: scoreLabel;
		text: "Score: 0";
		x: 25;
		y: 25;
	}

	Label {
		id: hiscoreLabel;
		text: "Hiscore: " + hiscore.getScore();
		x: 700;
		y: 25;
	}

	Label {
		id: gameOver;
		text: "Game Over";
		anchors.centerIn: parent;
		anchors.verticalCenterOffset: -180;
		visible: false;
		font.weight: Font.Bold;
		font.pixelSize: 70;
	}

	Label {
		id: credits;
		anchors.centerIn: parent;
		anchors.verticalCenterOffset: 50;
		text: "<center><b>Design & Programming:</b><br />Mike Sheldon<br /><br /><b>Artwork:</b><br />Mike Sheldon<br />Lee Zher Huei<br />Mishonis<br /><br />www.mikeasoft.com<br />www.opengameart.org</center>"
		visible: false;
		font.pixelSize: 24;
	}

	Rectangle {
		id: pause;
		visible: false;
		anchors.centerIn: parent;
		color: "black";
		opacity: 0.5;
		radius: 20;
		width: 300;
		height: 200;

		Label {
			anchors.centerIn: parent;
			color: "white";
			text: "Paused";
			font.weight: Font.Bold;
			font.pixelSize: 70;
		}
	}

	Timer {
		id: checkPause;
		interval: 200;
		running: true;
		repeat: true;
		onTriggered: {
			if(playing) {
				if (!Qt.application.active) {
					world.timeStep = 0;
					birdtime.running = false;
					rocktime.running = false;
					pause.visible = true;
				} else {
					world.timeStep = 0.0166;
					birdtime.running = true;
					rocktime.running = true;
					pause.visible = false;
				}
			}
		}
	}

	World {
		id: world;
		anchors.fill: parent;
		timeStep: 0;

		Seagull {
			id: seagull;
			x: -200;
			y: 100;
		}

		Rock {
			id: rock;
			x: -600;
			y: 350;
			onHit: {
				if(!collided) {
					score += 10;
					scoreLabel.text = "Score: " + score;
					collided = true;
				}
			}
		}

		Timer {
			id: birdtime;
			interval: 5000; 
			running: false;
			repeat: true;
			onTriggered: {
				seagull.x = -100;
				seagull.y = 240;
				seagull.rotation = -20;
				seagull.linearVelocity = Qt.point(0, 0);
				seagull.applyLinearImpulse(Qt.point(450 + Math.random() * 100, -450 + Math.random() * 100), Qt.point(seagull.x + 75, seagull.y + 16));
				collided = false;
				birdtime.interval = 3000 + Math.random() * 4000;
			}
		}

		Timer {
			id: rocktime;
			interval: 100;
			running: false;
			repeat: true;
			onTriggered: {
				if(rock.x < 0 || rock.y > 480 || rock.x > 854) {
					rock.bodyType = Body.Static;
					rock.x = 600;
					rock.y = 350;
				}
				if(seagull.x > 870 && !collided && lives > 0) {
					lives--;
					chips.itemAt(lives).visible = false;
					collided = true;
				}
				if(lives == 0) {
					birdtime.running = false;
					rocktime.running = false;
					playing = false;
					world.timeStep = 0;
					gameOver.visible = true;
					credits.visible = true;
					rock.x = -200;
					gamestart.enabled = true;
					if (score > hiscore.getScore()) {
						hiscore.saveScore(score);
						hiscoreLabel.text = "Hiscore: " + score;
					}
				}
			}
		}

		MouseArea {
			id: gamestart
			anchors.fill: parent;
			property int i;
			onReleased: {
				gameOver.visible = false;
				credits.visible = false;
				world.timeStep = 0.0166;
				score = 0;
				scoreLabel.text = "Score: " + score;
				lives = 10;
				for(i = 0; i < 10; i++) {
					chips.itemAt(i).visible = true;
				}
				screen.source = "background.jpg";
				rocktime.running = true;
				birdtime.running = true;
				playing = true;
				enabled = false;
			}
		}
	}

	Repeater {
		id: chips;
		model: 10;
		delegate: Image {
			source: "chip.svg";
			scale: 1.5;
			x: 30 + Math.random() * 20;
			y: 425 + Math.random() * 10;
			rotation: 45 - Math.random() * 90;
			visible: false;
		}
	}
}
