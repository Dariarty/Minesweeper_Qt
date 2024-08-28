#include "UiManager.h"

namespace minesweeper {

UiManager::UiManager(QObject *parent)
    : QObject(parent)
    , engine_(new QQmlApplicationEngine())
{
    qmlRegister();
    loadUi();
}

void UiManager::qmlRegister()
{
    engine_->rootContext()->setContextProperty("UiManager", this);
}

void UiManager::loadUi()
{
    const QUrl mainQmlUrl{QStringLiteral("qrc:/qml/main/Minesweeper.qml")};
    engine_->load(mainQmlUrl);
}

} // namespace minesweeper
