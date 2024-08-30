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

    ListModel{
        id: difficultyModesModel

        ListElement{
            name: qsTr("Beginner")
            fieldWidth: 9
            fieldHeight: 9
            mines: 10
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
                    ButtonGroup.group: difficultyButtonGroup
                    onTriggered: {
                        console.log(name)
                    }
                    text: name
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
                onTriggered: console.log("Custom")
            }
        }

        MenuItem {
          text: qsTr("Start a new game")
        }

        MenuItem {
          text: qsTr("Exit app")
        }

    }

    Menu{
        title: qsTr("Settings")

        topPadding: 0
        bottomPadding: 0

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

                    Connections{
                        target: Translator

                        function onLanguageChanged(){
                            if(Translator.language===lang) checked = true
                        }
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
        }

        MenuItem {
          text: qsTr("About application")
        }

    }
}
