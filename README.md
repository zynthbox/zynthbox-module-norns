# Norns QML Shield

![norns-qml-shield logo](src/icons/128-apps-norns-qml-shield.png)

A small tool which creates something that vaguely resembles a control box for
a Norns synthesizer. It currently expects norns to be instaleld into the
```/home/we``` directory, and that two scripts called ```fates-start.sh``` and
```fates-end.sh``` respectively can be found in that directory alongside norns.

## Requirements

To build this, you need development packages for the following things:

* CMake 3.13 or later
* ECM version 5.52 or later
* Qt 5.11 or later
* X11
* Kirigami 2.7 or later (which also translates roughly to the version found in
  KDE Frameworks 5.54)
* libxdo

## Running

To launch it, usually you would tap the Norns button on the zynthbox main page,
but if you wish to launch it manually, you can run it like so, commonly as
root:

```$ startx norns-qml-shield```

which will start up an X session with the application as the root application,
so that when you quit the application, X is also shut down.

## Components

The application is basically a test tool for a set of components which allow 
The module is ```org.zynthbox.norns.qmlshield``` and includes several components:

* **Shield** - The main control used for interacting with norns. Instantiate this
  to perform work on the system itself. Pay attention to the various properties
  and signals available on this control, as you will need to set some of them up.
* **PushSlideControl** - a button with a rounded look, which is designed to take 
  both presses as well as reacting to moving the finger up and down. It can also
  adapted to look as though it has ridges
* **Process** - an invisible component which allows for basic process control
  (and which is a wrapper around QProcess)
* **XDoWrapper** - an invisible component which allows for basic control of a
  named window on X11. This is what adds the libxdo requirement.
