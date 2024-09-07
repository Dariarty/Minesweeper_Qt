#include "GameHandler.h"

#include <algorithm>
#include <chrono>
#include <random>

#include <QDebug>
#include <QElapsedTimer>

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
}

void GameHandler::initNewGame(const quint8 &cellsCountWidth,
                              const quint8 &cellsCountHeight,
                              const quint32 &minesCount)
{
    //write new values
    cellsCountWidth_ = cellsCountWidth;
    cellsCountHeight_ = cellsCountHeight;
    minesCount_ = minesCount;

    initNewGame();
}

void GameHandler::clickCell(const quint16 &cellIndex)
{
    if (!gameActive_)
        return;

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

    //reveal this cell
    revealCell(cellIndex);

    //check for game victory
    for (int i = 0; i < field_.count(); i++) {
        //Skip mines and revealed cells
        if (field_[i] == -1 || field_[i] == 9) {
            continue;
        }

        //Return if there are still closed cells
        return;
    }

    //Game is Won
    gameActive_ = false;
    emit gameWon();
}

//private
void GameHandler::generateField(const quint16 &startingCellIndex)
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
}

void GameHandler::revealCell(const quint16 &cellIndex)
{
    //open cell in gui
    emit cellOpened(cellIndex, field_[cellIndex]);

    //check if empty cell and recursively open adjacent cells
    //9 indicates that cell is already opened
    if (field_[cellIndex]) {
        field_[cellIndex] = 9;
    } else {
        //cell is empty
        field_[cellIndex] = 9;
        //reveal adjacent cells
        for (auto adjacentCell : adjacentCells(cellIndex)) {
            if (field_[adjacentCell] != 9) {
                revealCell(adjacentCell);
            }
        }
    }
}

QVector<quint16> GameHandler::adjacentCells(const quint16 &cellIndex)
{
    QVector<quint16> adjacentCells;

    //Reserve space for 8 adjacent cells
    adjacentCells.reserve(8);

    //cells at left border
    if (cellIndex % cellsCountWidth_ == 0) {
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

    //add top row of adjacent cells except for cells at top border
    if (cellIndex >= cellsCountWidth_) {
        adjacentCells.append(cellIndex - cellsCountWidth_ - 1);
        adjacentCells.append(cellIndex - cellsCountWidth_);
        adjacentCells.append(cellIndex - cellsCountWidth_ + 1);
    }

    //add bottom row of adjacent cells except for cells at bottom border
    if (cellIndex + cellsCountWidth_ < cellsCountHeight_ * cellsCountWidth_) {
        adjacentCells.append(cellIndex + cellsCountWidth_ - 1);
        adjacentCells.append(cellIndex + cellsCountWidth_);
        adjacentCells.append(cellIndex + cellsCountWidth_ + 1);
    }

    //add next and previous cell in the same row
    adjacentCells.append(cellIndex - 1);
    adjacentCells.append(cellIndex + 1);

    return adjacentCells;
}

} // namespace minesweeper
