#include "UiManager.h"

#include <QScreen>

namespace minesweeper {

//public
UiManager::UiManager(QObject *parent)
    : QObject(parent)
    , translator_(new Translator())
    , gameHandler_(new GameHandler())
    , engine_(new QQmlApplicationEngine(this))
{
    qmlRegister();

    initTranslator();

    loadUi();
}

//private
void UiManager::qmlRegister()
{
    engine_->rootContext()->setContextProperty("UiManager", this);
    engine_->rootContext()->setContextProperty("Translator", translator_.data());
    engine_->rootContext()->setContextProperty("GameHandler", gameHandler_.data());
}

void UiManager::initTranslator()
{
    //Connect retranslating UI
    connect(translator_.data(), &Translator::languageChanged, this, [=]() {
        engine_->retranslate();
    });

    translator_->initTranslation();
}

void UiManager::loadUi()
{
    const QUrl mainQmlUrl{QStringLiteral("qrc:/qml/main/Minesweeper.qml")};
    engine_->load(mainQmlUrl);
}

} // namespace minesweeper
