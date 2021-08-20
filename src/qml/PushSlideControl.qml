import QtQuick 2.4 
import QtQuick.Controls 2.4 as QQC2

QQC2.AbstractButton {
    id: component
    signal pressed();
    signal clicked();
    signal cancelled();
    signal released();
    signal slideStarted(point startPoint);
    signal slideUpdated(point updatedPoint);
    signal slideEnded();
    signal tick(int value);
    property real currentPointDistance
    property real currentPointAngle
    property bool showRidges: false
    property bool circular: true
    background: Item {
        Rectangle {
            anchors.fill: parent
            radius: component.circular ? height / 2 : 0
            color: "transparent"
            border {
                width: 2
                color: component.palette.highlight
            }
            visible: component.down
        }
        Rectangle {
            anchors {
                fill: parent
                margins: 4
            }
            radius: component.circular ? height / 2 : 0
            opacity: component.enabled ? 1 : 0.3
            color: component.palette.button
            Item {
                id: ridges
                anchors.fill: parent
                visible: component.showRidges
                rotation: component.currentPointDistance// + component.currentPointAngle
                Repeater {
                    model: 4
                    Item {
                        anchors.centerIn: parent
                        width: ridges.width
                        height: 5
                        rotation: 45 * index
                        Rectangle {
                            anchors {
                                left: parent.left
                                leftMargin: -1
                            }
                            height: parent.height
                            width: 3
                            color: component.palette.window
                            radius: height
                        }
                        Rectangle {
                            anchors {
                                right: parent.right
                                rightMargin: -1
                            }
                            height: parent.height
                            width: 3
                            color: component.palette.window
                            radius: height
                        }
                    }
                }
            }
        }
    }
    contentItem: QQC2.Label {
        text: component.text
        font: component.font
        color: component.palette.buttonText
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.Wrap
    }
    MultiPointTouchArea {
        anchors.fill: parent
        touchPoints: [
            TouchPoint {
                id: pushSlidePoint;
            }
        ]
        property point centerPoint: Qt.point(width / 2, height / 2)
        property point startPoint
        property point updatedPoint
        function pointDistance(point1, point2) {
            //var a = point1.x - point2.x;
            var b = point1.y - point2.y;
            return b;
            //return Math.sqrt( a*a + b*b );
        }
        function pointAngle(point1, point2) {
            //console.log(centerPoint + " " + point2);
            return Math.atan2(point2.y - point1.y, point2.x - point1.x) * 180 / Math.PI;
        }
        property int mostRecentTickTotal;
        function updateTick() {
            //var updatedTick = Math.round(component.currentPointAngle / 20 + component.currentPointDistance / 20);
            var updatedTick = Math.round(component.currentPointDistance / 10);
            if (updatedTick != mostRecentTickTotal) {
                component.tick(-(mostRecentTickTotal - updatedTick));
                mostRecentTickTotal = updatedTick;
            }
        }
        onPressed: {
            if (pushSlidePoint.pressed) {
                mostRecentTickTotal = 0;
                startPoint = updatedPoint = Qt.point(pushSlidePoint.x, pushSlidePoint.y);
                component.currentPointDistance = 0;
                component.currentPointAngle = 0;
                component.pressed();
                component.slideStarted(startPoint);
                component.down = true;
                focus = true;
            }
        }
        onUpdated: {
            updatedPoint = Qt.point(pushSlidePoint.x, pushSlidePoint.y);
            component.currentPointDistance = pointDistance(startPoint, updatedPoint);
            component.currentPointAngle = pointAngle(centerPoint, updatedPoint);
            component.slideUpdated(updatedPoint);
            updateTick();
        }
        onReleased: {
            if (!pushSlidePoint.pressed) {
                if (pointDistance(startPoint, updatedPoint) < 5) {
                    component.clicked();
                    component.released();
                } {
                    component.cancelled();
                }
                component.slideEnded();
                component.down = false;
                focus = false;
            }
        }
    }
}
