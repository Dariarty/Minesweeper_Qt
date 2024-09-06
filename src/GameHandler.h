#ifndef GAMEHANDLER_H
#define GAMEHANDLER_H

#include <QObject>
#include <QVector>

namespace minesweeper {

class GameHandler : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(GameHandler)

public:
    GameHandler(QObject *parent = NULL);
    ~GameHandler() = default;

    //Start new game
    Q_INVOKABLE void initNewGame();
    Q_INVOKABLE void initNewGame(quint8 cellsCountWidth,
                                 quint8 cellsCountHeight,
                                 quint32 minesCount);

    //Reveal a cell
    Q_INVOKABLE void revealCell(quint16 cellIndex);

signals:
    void newGameStarted(quint8 cellsCountWidth, quint8 cellsCountHeight, quint32 minesCount);

    void cellOpened(quint16 cellIndex, qint8 cellState);

    void gameLost(quint16 losingIndex);

    void gameWon();

private:
    //Game Parameters
    quint8 cellsCountWidth_;
    quint8 cellsCountHeight_;
    quint32 minesCount_;

    /// game field cell values:
    /// -1: a cell containing a bomb
    /// from 0 to 8: empty cell with a corresponding number
    /// 9 - already revealed cell
    QVector<qint8> field_;

    //Game is in progress
    bool gameActive_;

    //generate new field
    void generateField(quint16 startingCellIndex);

    //get list of adjacent cell indexes by cellIndex
    QList<quint16> adjacentCells(quint16 cellIndex);
};

} // namespace minesweeper

#endif // GAMEHANDLER_H
