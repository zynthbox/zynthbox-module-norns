/*
 * Copyright (C) 2021 Dan Leinir Turthra Jensen <admin@leinir.dk>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) version 3, or any
 * later version accepted by the membership of KDE e.V. (or its
 * successor approved by the membership of KDE e.V.), which shall
 * act as a proxy defined in Section 6 of version 3 of the license.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#include "qmlplugin.h"

#include <QtQml/qqml.h>
#include <QQmlEngine>
#include <QQmlContext>
#include <QDir>

#include "process.h"
#include "xdowrapper.h"

void QmlPlugins::initializeEngine(QQmlEngine *engine, const char *)
{
    QString start_script = qgetenv("NORNS_START_SCRIPT");
    if (start_script.isEmpty()) {
        start_script = QDir::homePath() + "/fates-start.sh";
    }

    engine->rootContext()->setContextProperty("NORNS_START_SCRIPT", start_script);

    QString stop_script = qgetenv("NORNS_STOP_SCRIPT");
    if (stop_script.isEmpty()) {
        stop_script = QDir::homePath() + "/fates-end.sh";
    }

    engine->rootContext()->setContextProperty("NORNS_STOP_SCRIPT", stop_script);

    // Set this to file:///some/directory/with/apicture.jpg or similar to use that image as a background
    QString background_image = qgetenv("NORNS_BACKGROUND_IMAGE");
    engine->rootContext()->setContextProperty("NORNS_BACKGROUND_IMAGE", background_image);
}

void QmlPlugins::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/qml/Shield.qml"), uri, 1, 0, "Shield");
    qmlRegisterType(QUrl("qrc:/qml/PushSlideControl.qml"), uri, 1, 0, "PushSlideControl");
    qmlRegisterType<Process>(uri, 1, 0, "Process");
    qmlRegisterType<XDoWrapper>(uri, 1, 0, "XDoWrapper");
}
