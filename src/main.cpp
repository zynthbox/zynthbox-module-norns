#include <QGuiApplication>
#include <QDebug>
#include <QUrl>
#include <QQmlApplicationEngine>

#include "process.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qmlRegisterType<Process>("Process", 1, 0, "Process");

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load the main qml file, exiting";
        return -1;
    }

    return app.exec();
}
