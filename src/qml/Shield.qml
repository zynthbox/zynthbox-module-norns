import QtQuick 2.4 
import QtQuick.Window 2.11
import QtQuick.Controls 2.4 as QQC2
import org.kde.kirigami 2.4 as Kirigami
import org.zynthbox.norns.qmlshield 1.0

import "layouts" as ShieldLayouts

QQC2.Control {
    id: component
    Component.onCompleted: fatesProcess.start()
    Component.onDestruction: fatesEnderProcess.startDetached()

    property bool showExit: false

    Process {
        id: fatesEnderProcess
        executableFile: "/home/we/fates-end.sh"
    }
    Process {
        id: fatesProcess
        executableFile: "/home/we/fates-start.sh"
    }
    XSendKey {
        id: mainKeySender
        windowName: fatesProcess.isRunning ? "matron" : ""
        onWindowLocated: component.updateMatronPosition();
    }
    function updateMatronPosition() {
        var xPos = layoutLoader.item.matronX;
        if (xPos > 0 && xPos < 1) {
            // Relative positioning
            xPos = component.width * xPos - mainKeySender.windowSize.width * xPos;
            xPos = component.x + xPos;
        } else if (xPos < 0) {
            // Absolute positioning, from the bottom
            xPos = component.x + component.width - mainKeySender.windowSize.width - xPos;
        } else {
            xPos = component.x + xPos;
        }
        var yPos = layoutLoader.item.matronY;
        if (yPos > 0 && yPos < 1) {
            // Relative positioning
            yPos = component.height * yPos - mainKeySender.windowSize.height * yPos;
            yPos = component.y + yPos;
        } else if (yPos < 0) {
            // Absolute positioning, from the bottom
            yPos = component.y + component.height - mainKeySender.windowSize.height - yPos;
        } else {
            yPos = component.y + yPos;
        }
        var mappedPosition = mapToGlobal(xPos, yPos);
        mainKeySender.windowPosition = mappedPosition;
        //console.log(mappedPosition);
    }
    onXChanged: updateMatronPosition()
    onYChanged: updateMatronPosition()
    onHeightChanged: updateMatronPosition()
    onWidthChanged: updateMatronPosition()

    contentItem: Loader {
        id: layoutLoader
        sourceComponent: zynthBoxLargeLayout
    }
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
    Connections {
        target: layoutLoader.item
        onRequestQuit: {
            fatesEnderProcess.start()
            quitTimer.start()
        }
    }

    Component {
        id: zynthBoxLargeLayout
        ShieldLayouts.ZynthBoxLarge {
            keySender: mainKeySender
            fatesStarter: fatesProcess
            fatesEnder: fatesEnderProcess
            showExit: component.showExit
        }
    }
    Component {
        id: nornsLayout
        ShieldLayouts.Norns {
            keySender: mainKeySender
            fatesStarter: fatesProcess
            fatesEnder: fatesEnderProcess
            showExit: component.showExit
        }
    }
}
