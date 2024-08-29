#include "UiManager.h"

namespace minesweeper {

UiManager::UiManager(QObject *parent)
    : QObject(parent)
    , translator_(new Translator())
    , engine_(new QQmlApplicationEngine(this))
{
    qmlRegister();

    initTranslator();

    loadUi();
}

void UiManager::qmlRegister()
{
    engine_->rootContext()->setContextProperty("UiManager", this);
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
