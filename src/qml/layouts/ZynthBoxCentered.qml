import QtQuick 2.4
import QtQuick.Layouts 1.4
import QtQuick.Controls 2.4 as QQC2
import org.kde.kirigami 2.4 as Kirigami
import org.zynthbox.norns.qmlshield 1.0

LayoutBase {
    id: component
    matronX: 0.5
    matronY: 0.5
    property int buttonSize: fakeNornsDisplay.height / 4
    property int dialSize: fakeNornsDisplay.height / 3
    Row {
        anchors {
            top: parent.top
            right: parent.right
            margins: Kirigami.Units.largeSpacing
        }
        width: height *  3
        height: parent.height / 8
        visible: component.showExtraActions
        spacing: 0
        PushSlideControl {
            text: "Start\nFates"
            enabled: !component.fatesStarter.isRunning
            onClicked: component.fatesStarter.start()
            height: parent.height
            width: height
        }
        PushSlideControl {
            text: "Stop\nFates"
            onClicked: component.fatesEnder.start()
            enabled: component.fatesStarter.isRunning
            height: parent.height
            width: height
        }
        PushSlideControl {
            text: "Exit"
            onClicked: {
                component.requestQuit()
            }
            height: parent.height
            width: height
        }
    }
    RowLayout {
        anchors {
            right: fakeNornsDisplay.right
            bottom: fakeNornsDisplay.top
            bottomMargin: Kirigami.Units.largeSpacing
        }
        width: height * 2
        height: component.dialSize + Kirigami.Units.largeSpacing * 2
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitWidth: parent.width / 2
            PushSlideControl {
                anchors.centerIn: parent
                width: component.buttonSize
                height: width
                palette: component.palette
                onPressed: component.keySender.sendKeyDown("z");
                onReleased: component.keySender.sendKeyUp("z");
            }
            QQC2.Label {
                anchors {
                    bottom: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
                text: "K1"
            }
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitWidth: parent.width / 2
            PushSlideControl {
                anchors.centerIn: parent
                width: component.dialSize
                height: width
                palette: component.palette
                showRidges: true
                onPressed: component.keySender.activateWindow()
                onTick: {
                    var key = "q";
                    if (value > 0) {
                        key = "a";
                    }
                    for (var i = 0; i < Math.abs(value); ++i) {
                        component.keySender.sendKey(key);
                    }
                }
            }
            QQC2.Label {
                anchors {
                    bottom: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
                text: "E1"
            }
        }
    }

    Rectangle {
        id: fakeNornsDisplay
        anchors.centerIn: parent
        height: 64 * 3
        width: 128 * 3
        color: "black"
    }

    RowLayout {
        anchors {
            top: fakeNornsDisplay.bottom
            left: fakeNornsDisplay.left
            right: fakeNornsDisplay.right
            topMargin: Kirigami.Units.largeSpacing
        }
        height: component.dialSize
        spacing: 0
        Item {
            Layout.fillHeight: true
            implicitWidth: parent.height
            PushSlideControl {
                anchors.centerIn: parent
                height: component.buttonSize
                width: height
                palette: component.palette
                onPressed: component.keySender.sendKeyDown("x");
                onReleased: component.keySender.sendKeyUp("x");
            }
            QQC2.Label {
                anchors {
                    top: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                text: "K2"
            }
        }
        Item {
            Layout.fillHeight: true
            implicitWidth: parent.height
            PushSlideControl {
                anchors.centerIn: parent
                height: component.buttonSize
                width: height
                palette: component.palette
                onPressed: component.keySender.sendKeyDown("c");
                onReleased: component.keySender.sendKeyUp("c");
            }
            QQC2.Label {
                anchors {
                    top: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                text: "K3"
            }
        }
        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        Item {
            Layout.fillHeight: true
            implicitWidth: parent.height
            PushSlideControl {
                anchors.centerIn: parent
                height: component.dialSize
                width: height
                palette: component.palette
                showRidges: true
                onPressed: component.keySender.activateWindow()
                onTick: {
                    var key = "w";
                    if (value > 0) {
                        key = "s";
                    }
                    for (var i = 0; i < Math.abs(value); ++i) {
                        component.keySender.sendKey(key);
                    }
                }
            }
            QQC2.Label {
                anchors {
                    top: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                text: "E2"
            }
        }
        Item {
            Layout.fillHeight: true
            implicitWidth: parent.height
            PushSlideControl {
                anchors.centerIn: parent
                height: component.dialSize
                width: height
                palette: component.palette
                showRidges: true
                onPressed: component.keySender.activateWindow()
                onTick: {
                    var key = "e";
                    if (value > 0) {
                        key = "d";
                    }
                    for (var i = 0; i < Math.abs(value); ++i) {
                        component.keySender.sendKey(key);
                    }
                }
            }
            QQC2.Label {
                anchors {
                    top: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }
                text: "E3"
            }
        }
    }
}
