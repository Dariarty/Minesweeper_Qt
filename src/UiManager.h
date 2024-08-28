#ifndef UIMANAGER_H
#define UIMANAGER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQuickView>
#include <QtQml>

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
