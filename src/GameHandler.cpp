#include "GameHandler.h"

#include <QDebug>

namespace minesweeper {

GameHandler::GameHandler(QObject *parent)
    : QObject(parent)
{}

void GameHandler::initNewGame()
{
    qDebug() << "Started new game with rules:";
    qDebug() << "Field width:" << cellsCountWidth_;
    qDebug() << "Field height:" << cellsCountHeight_;
    qDebug() << "Mines count:" << minesCount_ << "\n";

    emit newGameStarted(cellsCountWidth_, cellsCountHeight_, minesCount_);
}

void GameHandler::initNewGame(quint8 cellsCountWidth, quint8 cellsCountHeight, quint32 minesCount)
{
    cellsCountWidth_ = cellsCountWidth;
    cellsCountHeight_ = cellsCountHeight;
    minesCount_ = minesCount;

    initNewGame();
}

} // namespace minesweeper
