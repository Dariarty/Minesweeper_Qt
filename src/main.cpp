#include <QApplication>
#include <QGuiApplication>
#include <QIcon>

#include "UiManager.h"

int main(int argc, char *argv[])
{
    int exitCode = -101;

    QApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/resources/icons/greyMine256px.png"));

    minesweeper::UiManager uiManager;

    exitCode = app.exec();
    return exitCode;
}
