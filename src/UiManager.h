#ifndef UIMANAGER_H
#define UIMANAGER_H

#include <QQmlApplicationEngine>
#include <QQmlContext>

namespace minesweeper {

class UiManager : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(UiManager)

public:
    UiManager(QObject *parent = NULL);
    ~UiManager() = default;

private:
    void qmlRegister();
    void loadUi();

    QQmlApplicationEngine *engine_;
};

} // namespace minesweeper

#endif // UIMANAGER_H
