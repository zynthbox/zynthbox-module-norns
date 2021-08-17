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
#  include <X11/keysym.h>
#  if XlibSpecificationRelease != 6
#      error Requires X11R6
#  endif
#endif

int	MyErrorHandler(Display *my_display, XErrorEvent *event)
{
    fprintf(stderr, "Failed to send the X event.\n");
    return 1;
}

class XSendKey::Private {
public:
    Private() {}
    QString windowName;
    Window window{0};
    Display *display{nullptr};

    void findWindow()
    {
        // Sniff window ID out using... ?
        QString windowID = windowName.toLocal8Bit();
        window = (Window)strtoul(windowID.toLocal8Bit(), NULL, 0);
        if(window == 0) {
            qWarning() << "No window found by that name! We will try again once you attempt to send keys, but this seems suboptimal.";
        }
    }

    char *progname{nullptr};
    char *displayname{nullptr};

    void	SendEvent(XKeyEvent *event)
    {
        XSync(display, False);
        XSetErrorHandler(MyErrorHandler);
        XSendEvent(display, window, True, KeyPressMask, (XEvent*)event);
        XSync(display, False);
        XSetErrorHandler(NULL);
    }

    void	SendKeyPressedEvent(KeySym keysym, unsigned int shift)
    {
        XKeyEvent		event;

        // Meta not yet implemented (Alt used instead ;->)
        int meta_mask=0;

        event.display	= display;
        event.window	= window;
        event.root		= RootWindow(display, 0); // XXX nonzero screens?
        event.subwindow	= None;
        event.time		= CurrentTime;
        event.x		= 1;
        event.y		= 1;
        event.x_root	= 1;
        event.y_root	= 1;
        event.same_screen	= True;
        event.type		= KeyPress;
        event.state		= 0;

        //
        // press down shift keys one at a time...
        //

        if (shift & ShiftMask) {
            event.keycode = XKeysymToKeycode(display, XK_Shift_L);
            SendEvent(&event);
            event.state |= ShiftMask;
        }
        if (shift & ControlMask) {
            event.keycode = XKeysymToKeycode(display, XK_Control_L);
            SendEvent(&event);
            event.state |= ControlMask;
        }

        if (shift & Mod1Mask) {
            event.keycode = XKeysymToKeycode(display, XK_Alt_L);
            SendEvent(&event);
            event.state |= Mod1Mask;
        }
        if (shift & meta_mask) {
            event.keycode = XKeysymToKeycode(display, XK_Meta_L);
            SendEvent(&event);
            event.state |= meta_mask;
        }

        //
        //  Now with shift keys held down, send event for the key itself...
        //


        // fprintf(stderr, "sym: 0x%x, name: %s\n", keysym, keyname);
        if (keysym != NoSymbol) {
            event.keycode = XKeysymToKeycode(display, keysym);
            // fprintf(stderr, "code: 0x%x, %d\n", event.keycode, event.keycode );
            SendEvent(&event);

            event.type = KeyRelease;
            SendEvent(&event);
        }

        //
        // Now release all the shift keys...
        //

        if (shift & ShiftMask) {
            event.keycode = XKeysymToKeycode(display, XK_Shift_L);
            SendEvent(&event);
            event.state &= ~ShiftMask;
        }
        if (shift & ControlMask) {
            event.keycode = XKeysymToKeycode(display, XK_Control_L);
            SendEvent(&event);
            event.state &= ~ControlMask;
        }
        if (shift & Mod1Mask) {
            event.keycode = XKeysymToKeycode(display, XK_Alt_L);
            SendEvent(&event);
            event.state &= ~Mod1Mask;
        }
        if (shift & meta_mask) {
            event.keycode = XKeysymToKeycode(display, XK_Meta_L);
            SendEvent(&event);
            event.state &= ~meta_mask;
        }
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
    if (d->window) {
        char keyname[1024];
        int shift{0};
        int keysym{0};
        int c, i;
        char *temp;

        strncpy(keyname, key.toLocal8Bit(), 1023);
        keysym = 0;
        shift  = 0;
        // fprintf(stderr, "keyname: %s\n", keyname);
        temp = strtok((char *)keyname, "+");
        while (temp != NULL) {
            // fprintf(stderr, "temp: %s\n", temp);
            if (strcmp(temp, "Alt") == 0)
                c = XK_Alt_L;
            else if (strcmp(temp, "Control") == 0)
                c = XK_Control_L;
            else if (strcmp(temp, "Shift") == 0)
                c = XK_Shift_L;
            else
                c = XStringToKeysym(temp);

            if (c == 0) {
                qWarning() << "Unknown key:" << temp;
            }

            switch (c) {
                case XK_Shift_L:
                case XK_Shift_R:
                    shift |= ShiftMask;
                    break;
                case XK_Control_L:
                case XK_Control_R:
                    shift |= ControlMask;
                    break;
                case XK_Caps_Lock:
                case XK_Shift_Lock:
                    shift |= LockMask;
                    break;
                case XK_Meta_L:
                case XK_Meta_R:
                case XK_Alt_L:
                case XK_Alt_R:
                    shift |= Mod1Mask;
                    break;
                case XK_Super_L:
                case XK_Super_R:
                case XK_Hyper_L:
                case XK_Hyper_R:
                    break;
                default:
                    keysym = c;
            }
            // fprintf(stderr, "keysym: 0x%x, shift: %d\n", keysym, shift);
            temp = strtok(NULL, "+");
        }
        /* keysym = strtoul(argv[ii], NULL, 0); */

        if (keyname[0] == 0) {
            qWarning() << "You must specify a keyname";
        } else {
            // now do the work:
            d->SendKeyPressedEvent(keysym, shift);
        }
    } else {
        qWarning() << "You can't send a key to a window you've not identified";
    }
}
