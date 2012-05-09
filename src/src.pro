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
        PREFIX = /opt/seagullstrike/
  }
BINDIR = $$PREFIX/bin
DATADIR =$$PREFIX/share

DEFINES += DATADIR=\\\"$$DATADIR\\\" PKGDATADIR=\\\"$$PKGDATADIR\\\"

#MAKE INSTALL

INSTALLS += target qmlgui desktop service images icon

  target.path =$$BINDIR

  qmlgui.path = $$DATADIR/seagullstrike
  qmlgui.files += *.qml

  images.path = $$DATADIR/seagullstrike
  images.files += *.png
  images.files += *.jpg
  images.files += *.gif
  images.files += *.svg

  desktop.path = /usr/share/applications
  desktop.files += $${TARGET}.desktop

  icon.path = /usr/share/icons/hicolor/80x80/apps
  icon.files += $${TARGET}.png
}
