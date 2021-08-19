import QtQuick 2.4
import QtQuick.Layouts 1.4
import QtQuick.Controls 2.4 as QQC2
import org.kde.kirigami 2.4 as Kirigami
import org.zynthbox.norns.qmlshield 1.0

LayoutBase {
    id: component
    property int buttonSize: height / 9
    property int dialSize: height / 6
    Row {
        anchors {
            top: parent.top
            right: parent.right
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
    RowLayout {
        anchors {
            left: parent.left
            leftMargin: Kirigami.Units.largeSpacing
            bottom: parent.verticalCenter
        }
        width: height * 2
        height: parent.height / 6
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitWidth: parent.width / 2
            PushSlideControl {
                anchors.centerIn: parent
                width: component.buttonSize
                height: width
                palette: component.palette
                onClicked: component.keySender.sendKey("z");
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
        }
    }
    Grid {
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: Kirigami.Units.largeSpacing
        }
        height: width / 2
        width: parent.width / 2
        columns: 4
        rows: 2
        spacing: 0
        Item {
            height: parent.height / 2
            width: parent.width / 4
        }
        Item {
            height: parent.height / 2
            width: parent.width / 4
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
        }
        Item {
            height: parent.height / 2
            width: parent.width / 4
        }
        Item {
            height: parent.height / 2
            width: parent.width / 4
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
        }
        Item {
            height: parent.height / 2
            width: parent.width / 4
            PushSlideControl {
                anchors.centerIn: parent
                height: component.buttonSize
                width: height
                palette: component.palette
                onClicked: component.keySender.sendKey("x");
            }
        }
        Item {
            height: parent.height / 2
            width: parent.width / 4
        }
        Item {
            height: parent.height / 2
            width: parent.width / 4
            PushSlideControl {
                anchors.centerIn: parent
                height: component.buttonSize
                width: height
                palette: component.palette
                onClicked: component.keySender.sendKey("c");
            }
        }
        Item {
            height: parent.height / 2
            width: parent.width / 4
        }
    }
}
