# Norns QML Shield

![norns-qml-shield logo](src/icons/128-apps-norns-qml-shield.png)

A small tool which creates something that vaguely resembles a control box for
a Norns synthesizer. It currently expects norns to be instaleld into the
```/home/we``` directory, and that two scripts called ```fates-start.sh``` and
```fates-end.sh``` respectively can be found in that directory alongside norns.

## Requirements

* CMake 3.13 or later
* ECM version 5.52 or later
* Qt 5.11 or later
* Kirigami 2.7 or later (which also translates roughly to the version found in
  KDE Frameworks 5.54)7

## Running

To launch it, usually you would tap the Norns button on the zynthbox main page,
but if you wish to launch it manually, you can run it like so, commonly as
root:

```$ startx norns-qml-shield```

which will start up an X session with the application as the root application,
so that when you quit the application, X is also shut down.
