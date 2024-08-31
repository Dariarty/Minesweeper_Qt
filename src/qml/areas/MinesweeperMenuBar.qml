import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12

import "../components"

MenuBar{

    background: Rectangle {
            implicitWidth: 40
            implicitHeight: 40
            color: "white"

            Rectangle {
                color: "grey"
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
            }
    }

    ButtonGroup{
        id: difficultyButtonGroup
    }

    ButtonGroup{
        id: languageButtonGroup
    }

    ButtonGroup{
        id: cellScaleButtonGroup
    }

    ListModel{
        id: difficultyModesModel

        ListElement{
            name: qsTr("Beginner")
            fieldWidth: 9
            fieldHeight: 9
            mines: 10
            defaultMode: true
        }

        ListElement{
            name: qsTr("Intermediate")
            fieldWidth: 16
            fieldHeight: 16
            mines: 40
        }

        ListElement{
            name: qsTr("Expert")
            fieldWidth: 30
            fieldHeight: 16
            mines: 99
        }
    }

    ListModel{
        id: languagesModel

        ListElement{
            name: "English"
            lang: "en_US"
        }

        ListElement{
            name: "Русский"
            lang: "ru_RU"
        }
    }

    ListModel{
        id: cellScaleModel

        ListElement{
            name: qsTr("Tiny")
            cellScale: 24
        }

        ListElement{
            name: qsTr("Small")
            cellScale: 30
        }

        ListElement{
            name: qsTr("Medium")
            cellScale: 35
            defaultScale: true
        }

        ListElement{
            name: qsTr("Large")
            cellScale: 40
        }

        ListElement{
            name: qsTr("Extra Large")
            cellScale: 50
        }

        ListElement{
            name: qsTr("Gigantic")
            cellScale: 70
        }
    }

    Menu{
        title: qsTr("Game")

        topPadding: 0
        bottomPadding: 0

        Menu{
            id: difficultyMenu
            title: qsTr("Change difficulty")

            topPadding: 0
            bottomPadding: 0

            Instantiator{
                id: difficultyModeInstantiator
                model: difficultyModesModel
                delegate: CheckableMenuItem {
                    text: name

                    ButtonGroup.group: difficultyButtonGroup

                    onTriggered: {
                        GameHandler.initNewGame(fieldWidth, fieldHeight, mines)
                    }

                    checked: defaultMode

                    Component.onCompleted: {
                        if(defaultMode) triggered()
                    }
                }

                onObjectAdded: (index, object) => difficultyMenu.insertItem(index, object)
                onObjectRemoved: (index, object) => difficultyMenu.removeItem(object)
            }

            MenuSeparator{
                topPadding: 0
                bottomPadding: 0

                contentItem: Rectangle {
                    implicitHeight: 1
                    color: "grey"
                }
            }

            Action{
                text: qsTr("New custom rules...")
                enabled: false
            }
        }

        MenuItem {
          text: qsTr("Start a new game")
          onTriggered: GameHandler.initNewGame()
        }

        MenuItem {
          text: qsTr("Exit app")
          onTriggered: Qt.quit()
        }

    }

    Menu{
        title: qsTr("Settings")

        topPadding: 0
        bottomPadding: 0

        Menu{
            id: scaleMenu
            title: qsTr("Cells scale")

            topPadding: 0
            bottomPadding: 0

            Instantiator{
                id: cellScaleInstantiator
                model: cellScaleModel
                delegate: CheckableMenuItem {
                    text: name + " | " + cellScale + "x" + cellScale

                    ButtonGroup.group: cellScaleButtonGroup

                    onTriggered: root.cellPixelSize = cellScale

                    checked: defaultScale

                }

                onObjectAdded: (index, object) => scaleMenu.insertItem(index, object)
                onObjectRemoved: (index, object) => scaleMenu.removeItem(object)
            }

            MenuSeparator{
                topPadding: 0
                bottomPadding: 0

                contentItem: Rectangle {
                    implicitHeight: 1
                    color: "grey"
                }
            }

            Action{
                text: qsTr("Custom cell scale...")
                enabled: false
            }
        }

        Menu {
            id: languageMenu
            title: qsTr("Language")

            topPadding: 0
            bottomPadding: 0

            Instantiator{
                id: languagesInstantiator
                model: languagesModel
                delegate: CheckableMenuItem {
                    text: name

                    ButtonGroup.group: languageButtonGroup

                    onTriggered: Translator.setLanguage(lang)

                    Component.onCompleted: {
                        if(Translator.language===lang) checked = true
                    }

                }

                onObjectAdded: (index, object) => languageMenu.insertItem(index, object)
                onObjectRemoved: (index, object) => languageMenu.removeItem(object)
            }
        }
    }

    Menu {
        title: qsTr("Help")

        topPadding: 0
        bottomPadding: 0

        MenuItem {
          text: qsTr("Game Rules")
          enabled: false
        }

        MenuItem {
          text: qsTr("About application")
          enabled: false
        }

    }
}
