#include "HiScore.h"


HiScore::HiScore(QObject *parent) :
	    QObject(parent)
{
	settings = new QSettings("mikeasoft", "Seagull Strike");
}


Q_INVOKABLE int HiScore::getScore() {
	int hiscore = 0;
	if (settings->contains("Scores/hiscore")) {
		hiscore = settings->value("Scores/hiscore").toInt();
	}
	return hiscore;
}


Q_INVOKABLE void HiScore::saveScore(int score) {
	settings->setValue("Scores/hiscore", score);
}
