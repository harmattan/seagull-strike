TEMPLATE = app
QT += declarative
CONFIG += meegotouch
TARGET = "seagullstrike"
DEPENDPATH += .
INCLUDEPATH += .

# Input
HEADERS += HiScore.h
SOURCES += main.cpp HiScore.cpp
#FORMS#

  unix {
    #VARIABLES
    isEmpty(PREFIX) {
        PREFIX = /usr
  }
BINDIR = $$PREFIX/bin
DATADIR =$$PREFIX/share

DEFINES += DATADIR=\\\"$$DATADIR\\\" PKGDATADIR=\\\"$$PKGDATADIR\\\"

#MAKE INSTALL

INSTALLS += target qmlgui desktop service images iconsvg

  target.path =$$BINDIR

  qmlgui.path = $$DATADIR/seagullstrike
  qmlgui.files += *.qml

  images.path = $$DATADIR/seagullstrike
  images.files += *.png
  images.files += *.jpg
  images.files += *.gif
  images.files += *.svg

  desktop.path = $$DATADIR/applications
  desktop.files += $${TARGET}.desktop

  service.path = $$DATADIR/dbus-1/services/
  service.files += com.meego.$${TARGET}.service

  iconsvg.path = $$DATADIR/icons/hicolor/scalable/apps
  iconsvg.files += $${TARGET}.svg
}
