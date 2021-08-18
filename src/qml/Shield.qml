import QtQuick 2.4 
import QtQuick.Layouts 1.4
import QtQuick.Window 2.11
import QtQuick.Controls 2.4 as QQC2
import org.kde.kirigami 2.4 as Kirigami
import org.zynthbox.norns.qmlshield 1.0

QQC2.Control {
    id: component
    Component.onCompleted: fatesProcess.start()

    property bool showExit: false
    property int buttonSize: height / 9
    property int dialSize: height / 6

    XSendKey {
        id: keySender
        windowName: "matron"
    }

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
            enabled: !fatesProcess.isRunning
            onClicked: fatesProcess.start()
            height: parent.height
            width: height
            Process {
                id: fatesProcess
                executableFile: "/home/we/fates-start.sh"
            }
        }
        PushSlideControl {
            text: "Stop\nFates"
            onClicked: fatesEnderProcess.start()
            enabled: fatesProcess.isRunning
            height: parent.height
            width: height
            Process {
                id: fatesEnderProcess
                executableFile: "/home/we/fates-end.sh"
            }
        }
        PushSlideControl {
            text: "Exit"
            visible: component.showExit
            onClicked: {
                fatesEnderProcess.start()
                quitTimer.start()
            }
            height: parent.height
            width: height
            Timer {
                id: quitTimer
                interval: 100
                repeat: true
                running: false
                onTriggered: {
                    if (!fatesEnderProcess.isRunning) {
                        Qt.quit()
                    }
                }
            }
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
                onClicked: keySender.sendKey("z");
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
                        keySender.sendKey(key);
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
                        keySender.sendKey(key);
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
                        keySender.sendKey(key);
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
                onClicked: keySender.sendKey("x");
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
                onClicked: keySender.sendKey("c");
            }
        }
        Item {
            height: parent.height / 2
            width: parent.width / 4
        }
    }
}
