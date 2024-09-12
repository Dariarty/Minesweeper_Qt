#ifndef GAMEHANDLER_H
#define GAMEHANDLER_H

#include <QObject>
#include <QTimer>
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
    Q_INVOKABLE void initNewGame(const qint8 &cellsCountWidth,
                                 const qint8 &cellsCountHeight,
                                 const qint32 &minesCount);

    //Process clicking a cell
    Q_INVOKABLE void clickCell(const qint16 &cellIndex);

signals:
    void newGameStarted(qint8 cellsCountWidth, qint8 cellsCountHeight, qint32 minesCount);

    void cellOpened(qint16 cellIndex, qint8 cellState);

    void gameLost(qint16 losingIndex);

    void timerTick();

    void gameWon();

private:
    //Game Parameters
    qint8 cellsCountWidth_;
    qint8 cellsCountHeight_;
    qint32 minesCount_;

    /// game field cell values:
    ///     -1 : a cell containing a bomb
    /// 0 to 8 : empty cell with a corresponding number
    ///      9 : already revealed cell
    QVector<qint8> field_;

    //Game is in progress
    bool gameActive_;

    //generate new field
    void generateField(const qint16 &startingCellIndex);

    //Reveal a cell
    void revealCell(const qint16 &cellIndex);

    //get adjacent cell indexes
    QVector<qint16> adjacentCells(const qint16 &cellIndex);

    //timer for game time
    QScopedPointer<QTimer> timer_;
};

} // namespace minesweeper

#endif // GAMEHANDLER_H
