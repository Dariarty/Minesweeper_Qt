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

    ListModel{
        id: difficultyModesModel

        ListElement{
            name: "Beginner"
        }

        ListElement{
            name: "Intermediate"
        }

        ListElement{
            name: "Expert"
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
                id: customModeInstantiator
                model: difficultyModesModel
                delegate: DifficultyMenuItemDelegate { }

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
          text: "Start a new game"
        }

        MenuItem {
          text: "Exit app"
        }

    }

    Menu{
        title: "Settings"

        topPadding: 0
        bottomPadding: 0

        Menu {
          title: "Language"

          topPadding: 0
          bottomPadding: 0

          MenuItem {
            text: "English "
          }

          MenuItem {
            text: "Русский "
          }

        }
    }

    Menu {
        title: "Help"

        topPadding: 0
        bottomPadding: 0

        MenuItem {
          text: "Game Rules"
        }

        MenuItem {
          text: "About application"
        }

    }
}
