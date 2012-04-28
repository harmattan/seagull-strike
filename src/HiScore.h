#ifndef HISCORE_H
#define HISCORE_H

#include <QObject>
#include <QSettings>

class HiScore : public QObject
{
	Q_OBJECT

	public:
		explicit HiScore(QObject *parent = 0);
		Q_INVOKABLE int getScore();
		Q_INVOKABLE void saveScore(int score);

	private:
		QSettings *settings;
};

#endif
