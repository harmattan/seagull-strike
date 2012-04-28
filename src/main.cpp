#include <QApplication>
#include <QDeclarativeContext>
#include <QDeclarativeView>
#include <QSettings>

#include "HiScore.h"

int main(int argc, char *argv[])
{
	QApplication app(argc, argv);
	QSettings settings("mikeasoft", "Seagull Strike");
	QDeclarativeView view;
	HiScore hiscore;
	view.rootContext()->setContextProperty("hiscore", &hiscore);
	view.setSource(QUrl::fromLocalFile(DATADIR "/seagullstrike/seagullstrike.qml"));
//	view.setSource(QUrl::fromLocalFile("seagullstrike.qml"));

	view.showFullScreen();
	return app.exec();
}
