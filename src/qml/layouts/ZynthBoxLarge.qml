import QtQuick 2.4
import QtQuick.Layouts 1.4
import QtQuick.Controls 2.4 as QQC2
import org.kde.kirigami 2.4 as Kirigami
import org.zynthbox.norns.qmlshield 1.0

LayoutBase {
    id: component
    matronX: 0.5
    matronY: 0.5
    property int buttonSize: height / 9
    property int dialSize: height / 6
    Row {
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            margins: Kirigami.Units.largeSpacing
        }
        spacing: 0
        width: height * (component.showExit ? 3 : 2)
        height: parent.height / 8
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
            visible: component.showExit
            onClicked: {
                component.requestQuit()
            }
            height: parent.height
            width: height
        }
    }
    ColumnLayout {
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            margins: Kirigami.Units.largeSpacing
        }
        width: component.buttonSize + Kirigami.Units.largeSpacing * 2
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitHeight: parent.height / 3
            PushSlideControl {
                anchors.centerIn: parent
                width: component.buttonSize
                height: width
                palette: component.palette
                onClicked: component.keySender.sendKey("z");
            }
            QQC2.Label {
                anchors {
                    left: parent.right
                    verticalCenter: parent.verticalCenter
                }
                text: "K1"
            }
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitHeight: parent.height / 3
            PushSlideControl {
                anchors.centerIn: parent
                width: component.buttonSize
                height: width
                palette: component.palette
                onClicked: component.keySender.sendKey("x");
            }
            QQC2.Label {
                anchors {
                    left: parent.right
                    verticalCenter: parent.verticalCenter
                }
                text: "K2"
            }
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitHeight: parent.height / 3
            PushSlideControl {
                anchors.centerIn: parent
                width: component.buttonSize
                height: width
                palette: component.palette
                onClicked: component.keySender.sendKey("c");
            }
            QQC2.Label {
                anchors {
                    left: parent.right
                    verticalCenter: parent.verticalCenter
                }
                text: "K3"
            }
        }
    }
    ColumnLayout {
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            margins: Kirigami.Units.largeSpacing
        }
        width: component.dialSize + Kirigami.Units.largeSpacing * 2
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitWidth: parent.height / 3
            PushSlideControl {
                anchors.centerIn: parent
                width: component.dialSize
                height: width
                palette: component.palette
                showRidges: true
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
                    right: parent.left
                    verticalCenter: parent.verticalCenter
                }
                text: "E1"
            }
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitWidth: parent.height / 3
            PushSlideControl {
                anchors.centerIn: parent
                height: component.dialSize
                width: height
                palette: component.palette
                showRidges: true
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
                    right: parent.left
                    verticalCenter: parent.verticalCenter
                }
                text: "E2"
            }
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitWidth: parent.height / 3
            PushSlideControl {
                anchors.centerIn: parent
                height: component.dialSize
                width: height
                palette: component.palette
                showRidges: true
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
                    right: parent.left
                    verticalCenter: parent.verticalCenter
                }
                text: "E3"
            }
        }
    }
}
