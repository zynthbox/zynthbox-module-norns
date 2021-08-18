import QtQuick 2.4 
import QtQuick.Layouts 1.4
import QtQuick.Window 2.11
import QtQuick.Controls 2.4 as QQC2
import org.kde.kirigami 2.4 as Kirigami
import org.zynthbox.norns.qmlshield 1.0

QQC2.ApplicationWindow {
    id: component
    x: 0
    y: 0
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    visible: true
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
    Shield {
        anchors.fill: parent
        palette: component.palette
    }
}
