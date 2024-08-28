#ifndef UIMANAGER_H
#define UIMANAGER_H

#include <QObject>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQuickView>
#include <QtQml>

namespace {
const QString kMainQmlName = "qrc:/qml/main/Minesweeper.qml";
const QString kAppTitle = "Minesweeper";
const int kDefaultWidth = 350;
const int kDefaultHeight = 500;
} // namespace

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

    QQuickView *view_;
};

} // namespace minesweeper

#endif // UIMANAGER_H
