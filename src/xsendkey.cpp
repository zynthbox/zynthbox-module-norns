/*
*  (C) 2000-2004 Alan Donovan
*
*  Author: Alan Donovan <adonovan@lcs.mit.edu>
*
*  With thanks to:	T.Sato <VEF00200@nifty.ne.jp>.
*			http://member.nifty.ne.jp/tsato/tools/xvkbd-e.html
*  and:		Derek Martin (derek_martin at agilent dot com)
* 			(for -count and XGetInputFocus)
*  and:		Hanno Hecker <h.hecker@bee.de>
*                      (for symbolic keysym and modifier lookup.)
*
*  xsendkey.cxx -- General purpose keypress generator
*
*  This program is free software; you can redistribute it and/or
*  modify it under the terms of the GNU General Public License
*  as published by the Free Software Foundation; either version 2
*  of the License, or any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
*  See the GNU General Public License for more details.
*  <http://www.gnu.org/copyleft/gpl.html>.
*
*  $Id: xsendkey.c,v 1.3 2004/11/11 16:10:01 adonovan Exp $
*
*/

#include "xsendkey.h"

#include <QDebug>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef WIN32
#  include "windows_x11.h"
#else
#  define NeedFunctionPrototypes 1
#  include <X11/Xlib.h>
#  if XlibSpecificationRelease != 6
#      error Requires X11R6
#  endif
#endif
extern "C" {
#include <xdo.h>
}

class XSendKey::Private {
public:
    Private() {}
    ~Private() {
        xdo_free(xdo);
    }
    xdo_t *xdo{nullptr};
    QString windowName;
    Window window{0};
    Display *display{nullptr};

    void findWindow()
    {
        if (!xdo) {
            xdo = xdo_new(nullptr);
        }
        Window *windows;
        unsigned int windowCount{0};
        xdo_search_t search;
        memset(&search, 0, sizeof(xdo_search_t));
        search.winname = "matron";
        search.searchmask = SEARCH_NAME;
        search.require = xdo_search::SEARCH_ANY;
        search.max_depth = 100;
        xdo_search_windows(xdo, &search, &windows, &windowCount);
        if (windowCount == 1) {
            qDebug() << "Found our window! Ready to send keys.";
            window = windows[0];
        } else {
            qWarning() << "We could not find a window named matron";
        }
        free(windows);
    }
};

XSendKey::XSendKey(QObject* parent)
    : QObject(parent)
    , d(new Private)
{
    QString displayname = getenv("DISPLAY");
    if(displayname == NULL)
        displayname = ":0.0";
    d->display = XOpenDisplay(displayname.toLocal8Bit());

    if(d->display == NULL)
    {
        qWarning() << "Can't open display" << displayname;
        exit(1);
    }
}

XSendKey::~XSendKey()
{
    delete d;
    XCloseDisplay(d->display);
}

QString XSendKey::windowName() const
{
    return d->windowName;
}

void XSendKey::setWindowName(const QString& windowName)
{
    if (d->windowName != windowName) {
        d->windowName = windowName;
        Q_EMIT windowNameChanged();
    }
    d->findWindow();
}

void XSendKey::sendKey(const QString& key)
{
    if (!d->window) {
        d->findWindow();
    }
    if (d->window) {
        xdo_send_keysequence_window(d->xdo, d->window, key.toLatin1(), 0);
    } else {
        qWarning() << "You can't send a key to a window you've not identified";
    }
}
