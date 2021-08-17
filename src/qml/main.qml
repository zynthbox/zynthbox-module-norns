import QtQuick 2.4 
import QtQuick.Layouts 1.4
import QtQuick.Window 2.11
import QtQuick.Controls 2.4 as QQC2
import org.kde.kirigami 2.4 as Kirigami
import Shield 1.0

QQC2.ApplicationWindow {
    id: component
    x: 0
    y: 0
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    visible: true
    Component.onCompleted: fatesProcess.start()
    palette {
        alternateBase: "#091010"
        base: "silver"
        brightText: "white"
        button: "#091010"
        buttonText: "white"
        dark: "#091010"
        highlight: "#091010"
        highlightedText: "silver"
        light: "silver"
        link: "darkblue"
        linkVisited: "blue"
        mid: "gray"
        midlight: "silver"
        shadow: "#091010"
        text: "#091010"
        toolTipBase: "#091010"
        toolTipText: "white"
        window: "silver"
        windowText: "#091010"
    }

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
        width: height * 3
        height: parent.height / 8
        PushSlideControl {
            text: "Start Fates"
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
            text: "Stop Fates"
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
                        keySender.sendKey("");
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
                        keySender.sendKey("");
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
                        keySender.sendKey("");
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
