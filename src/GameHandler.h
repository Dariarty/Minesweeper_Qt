#ifndef GAMEHANDLER_H
#define GAMEHANDLER_H

#include <QObject>

namespace minesweeper {

class GameHandler : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(GameHandler)

public:
    GameHandler(QObject *parent = NULL);
    ~GameHandler() = default;

    Q_INVOKABLE void initNewGame();
    Q_INVOKABLE void initNewGame(quint8 cellsCountWidth,
                                 quint8 cellsCountHeight,
                                 quint32 minesCount);

signals:
    void newGameStarted(quint8 cellsCountWidth, quint8 cellsCountHeight, quint32 minesCount);

private:
    //Game Parameters
    quint8 cellsCountWidth_;
    quint8 cellsCountHeight_;
    quint32 minesCount_;
};

} // namespace minesweeper

#endif // GAMEHANDLER_H
