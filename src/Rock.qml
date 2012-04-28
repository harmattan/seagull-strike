import Qt 4.7
import Box2D 1.0

Body {
	id: body
	width: 56;
	height: 36;
	sleepingAllowed: false
	bodyType: Body.Static

	signal hit();

	fixtures: Circle {
		anchors.fill: parent
		density: 1;
		friction: 0.3;
		restitution: 0.5;
		onBeginContact: {
			body.hit();
		}
	}


	Image { 
		anchors.fill: parent; 
		source: "rock.svg"
	}

	MouseArea {
		anchors.fill: parent;
		drag.target: body
		drag.maximumX: 830 - body.width
		drag.minimumX: 500
		drag.maximumY: 460 - body.height
		drag.minimumY: 350

		onReleased: {
			body.bodyType = Body.Dynamic;
			body.applyLinearImpulse(Qt.point(10 * (600 - body.x), 10 * (350 - body.y)), Qt.point(body.x, body.y));	
		}
	}
}

