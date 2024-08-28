#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QSharedPointer>

#include "UiManager.h"

int main(int argc, char *argv[])
{
    int exitCode = -101;

    QCoreApplication::setApplicationName("Minesweeper");

    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/resources/icons/greyMine256px.png"));

    minesweeper::UiManager uiManager;

    exitCode = app.exec();

    return exitCode;
}
