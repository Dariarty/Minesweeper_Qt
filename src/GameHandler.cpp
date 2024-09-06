#include "GameHandler.h"

#include <QDebug>

#include <algorithm>
#include <chrono>
#include <random>

namespace minesweeper {

//public
GameHandler::GameHandler(QObject *parent)
    : QObject(parent)
    , gameActive_(false)
{}

void GameHandler::initNewGame()
{
    //clear field and release memory
    field_.clear();
    field_.squeeze();

    //Write game active state
    gameActive_ = true;

    //signal for gui
    emit newGameStarted(cellsCountWidth_, cellsCountHeight_, minesCount_);

    //Debug new game values
    qDebug() << "Started new game with rules:";
    qDebug() << "Field width:" << cellsCountWidth_;
    qDebug() << "Field height:" << cellsCountHeight_;
    qDebug() << "Mines count:" << minesCount_ << "\n";
}

void GameHandler::initNewGame(quint8 cellsCountWidth, quint8 cellsCountHeight, quint32 minesCount)
{
    //write new values
    cellsCountWidth_ = cellsCountWidth;
    cellsCountHeight_ = cellsCountHeight;
    minesCount_ = minesCount;

    initNewGame();
}

void GameHandler::revealCell(quint16 cellIndex)
{
    if (!gameActive_)
        return;

    qDebug() << "Played requested revealing cell: " + QString::number(cellIndex);

    //If field is empty, this must be a new game
    if (field_.empty()) {
        generateField(cellIndex);
    }

    //Check for game loss
    if (field_[cellIndex] == -1) {
        //Write game as inactive because lost
        gameActive_ = false;

        for (int i = 0; i < field_.count(); i++) {
            if (field_[i] == -1)
                emit cellOpened(i, -1);
        }
        emit gameLost(cellIndex);

        return;
    }

    //open cell in gui
    emit cellOpened(cellIndex, field_[cellIndex]);

    //check if empty cell and recursively open adjacent cells
    //9 indicates that cell is already opened
    if (field_[cellIndex]) {
        field_[cellIndex] = 9;
    } else {
        //cell is empty
        field_[cellIndex] = 9;
        //open adjacent cells
        for (auto adjacentCell : adjacentCells(cellIndex)) {
            if (field_[adjacentCell] != 9) {
                revealCell(adjacentCell);
            }
        }
    }

    //check for game won
    for (int i = 0; i < field_.count(); i++) {
        if (field_[i] == -1 || field_[i] == 9)
            continue;

        return;
    }

    //Game is Won
    gameActive_ = false;
    qDebug() << "Game Victory!";
    emit gameWon();
}

//private
void GameHandler::generateField(quint16 startingCellIndex)
{
    //Create list for getting mines indexes in a field
    QList<quint16> minesList;
    minesList.resize(cellsCountHeight_ * cellsCountWidth_ - 1);
    for (int i = 0; i < minesList.count(); i++) {
        minesList[i] = i;

        //adjust for not getting starting cell
        if (i >= startingCellIndex)
            ++minesList[i];
    }

    // obtain a time-based seed:
    unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();

    //shuffle indices of cells with mines
    std::shuffle(minesList.begin(), minesList.end(), std::default_random_engine(seed));

    //resize field
    field_.resize(cellsCountHeight_ * cellsCountWidth_);

    // write mines into field
    for (QList<quint16>::iterator i = minesList.begin(); i - minesList.begin() < minesCount_; i++) {
        field_[*i] = -1;
    }

    //fill field with number values
    for (int i = 0; i < field_.count(); i++) {
        //skip mines
        if (field_[i] == -1)
            continue;

        //check adjacent cells for mines
        for (auto adjacentCellIndex : adjacentCells(i)) {
            if (field_[adjacentCellIndex] == -1)
                field_[i]++;
        }
    }

    qDebug() << "Field generation complete";
}

QList<quint16> GameHandler::adjacentCells(quint16 cellIndex)
{
    //cells at left border
    if (cellIndex % cellsCountWidth_ == 0) {
        QList<quint16> adjacentCells;

        adjacentCells.append(cellIndex + 1);
        //add top adjacent cells except top left corner cell
        if (cellIndex != 0) {
            adjacentCells.append(cellIndex - cellsCountWidth_);
            adjacentCells.append(cellIndex - cellsCountWidth_ + 1);
        }
        //add bottom adjacent cells except bottom left corner cell
        if ((cellIndex / cellsCountWidth_ + 1) < cellsCountHeight_) {
            adjacentCells.append(cellIndex + cellsCountWidth_);
            adjacentCells.append(cellIndex + cellsCountWidth_ + 1);
        }

        return adjacentCells;
    }

    //cells at right border
    if ((cellIndex + 1) % cellsCountWidth_ == 0) {
        QList<quint16> adjacentCells;

        adjacentCells.append(cellIndex - 1);
        //add top adjacent cells except top right corner cell
        if (cellIndex >= cellsCountWidth_) {
            adjacentCells.append(cellIndex - cellsCountWidth_);
            adjacentCells.append(cellIndex - cellsCountWidth_ - 1);
        }
        //add bottom adjacent cells except bottom right corner
        if (cellIndex != cellsCountHeight_ * cellsCountWidth_ - 1) {
            adjacentCells.append(cellIndex + cellsCountWidth_);
            adjacentCells.append(cellIndex + cellsCountWidth_ - 1);
        }

        return adjacentCells;
    }

    //cells at top border
    if (cellIndex < cellsCountWidth_) {
        return QList<quint16>{static_cast<unsigned short>(cellIndex - 1),
                              static_cast<unsigned short>(cellIndex + 1),
                              static_cast<unsigned short>(cellIndex + cellsCountWidth_ - 1),
                              static_cast<unsigned short>(cellIndex + cellsCountWidth_),
                              static_cast<unsigned short>(cellIndex + cellsCountWidth_ + 1)};
    }

    //cells at bottom border
    if (cellIndex + cellsCountWidth_ >= cellsCountHeight_ * cellsCountWidth_) {
        return QList<quint16>{static_cast<unsigned short>(cellIndex - 1),
                              static_cast<unsigned short>(cellIndex + 1),
                              static_cast<unsigned short>(cellIndex - cellsCountWidth_ - 1),
                              static_cast<unsigned short>(cellIndex - cellsCountWidth_),
                              static_cast<unsigned short>(cellIndex - cellsCountWidth_ + 1)};
    }

    //non-border cells
    return QList<quint16>{static_cast<unsigned short>(cellIndex - 1),
                          static_cast<unsigned short>(cellIndex + 1),
                          static_cast<unsigned short>(cellIndex - cellsCountWidth_ - 1),
                          static_cast<unsigned short>(cellIndex - cellsCountWidth_),
                          static_cast<unsigned short>(cellIndex - cellsCountWidth_ + 1),
                          static_cast<unsigned short>(cellIndex + cellsCountWidth_ - 1),
                          static_cast<unsigned short>(cellIndex + cellsCountWidth_),
                          static_cast<unsigned short>(cellIndex + cellsCountWidth_ + 1)};
}

} // namespace minesweeper
