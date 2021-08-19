import QtQuick 2.4
import org.kde.kirigami 2.4 as Kirigami

Item {
    id: component

    property QtObject keySender;
    property QtObject fatesStarter;
    property QtObject fatesEnder;
    property real matronX: Kirigami.Units.largeSpacing
    property real matronY: -Kirigami.Units.largeSpacing
    property bool showExit;
    signal requestQuit();
}