#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QSharedPointer>

#include "UiManager.h"

int main(int argc, char *argv[])
{
    int exitCode = -111;

    QCoreApplication::setApplicationName("Minesweeper");

    QGuiApplication app(argc, argv);

    minesweeper::UiManager uiManager;

    exitCode = app.exec();

    return exitCode;
}
