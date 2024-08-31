#ifndef UIMANAGER_H
#define UIMANAGER_H

#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSharedPointer>

#include "GameHandler.h"
#include "Translator.h"

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
    void initTranslator();
    void loadUi();

    QSharedPointer<Translator> translator_;
    QSharedPointer<GameHandler> gameHandler_;

    QQmlApplicationEngine *engine_;
};

} // namespace minesweeper

#endif // UIMANAGER_H
