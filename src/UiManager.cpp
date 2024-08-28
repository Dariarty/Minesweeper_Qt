#include "UiManager.h"

namespace minesweeper {

UiManager::UiManager(QObject *parent)
    : QObject(parent)
    , view_(new QQuickView())
{
    qmlRegister();

    loadUi();
}

void UiManager::qmlRegister()
{
    view_->engine()->rootContext()->setContextProperty("UiManager", this); 
}

void UiManager::loadUi()
{
    view_->setResizeMode(QQuickView::SizeRootObjectToView);

    view_->setWidth(kDefaultWidth);
    view_->setMinimumWidth(kDefaultWidth);
    view_->setHeight(kDefaultHeight);
    view_->setMinimumHeight(kDefaultHeight);

    view_->setSource(QUrl(kMainQmlName));
    view_->setTitle(kAppTitle);

    view_->show();
}

} // namespace minesweeper
