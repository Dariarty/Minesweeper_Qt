#include "UiManager.h"

#include <QApplication>
#include <QScreen>
#include <QStyle>

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

int UiManager::titleBarSize() const
{
    return QApplication::style()->pixelMetric(QStyle::PM_TitleBarHeight);
}

bool UiManager::isAndroidDevice() const
{
#ifdef Q_OS_ANDROID
    return true;
#else
    return false;
#endif
}

bool UiManager::isWebAssembly() const
{
#if defined(__EMSCRIPTEN__) || defined(__wasm__) || defined(__wasm32__) || defined(__wasm64__)
    return true;
#else
    return false;
#endif
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
