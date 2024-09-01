import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12

import "../components"

Menu{
    id: difficultyMenu
    title: qsTr("Change difficulty")

    topPadding: 0
    bottomPadding: 0

    //Model with difficulty modes
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
            defaultMode: true
        }

        ListElement{
            name: qsTr("Expert")
            fieldWidth: 30
            fieldHeight: 16
            mines: 99
        }
    }

    //Button Group of difficulty modes
    ButtonGroup{
        id: difficultyButtonGroup
    }

    //Instantiator to dynamically load menu item from model
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

    //Grey line separator
    MenuSeparator{
        topPadding: 0
        bottomPadding: 0

        contentItem: Rectangle {
            implicitHeight: 1
            color: "grey"
        }
    }

    //Add new custom gamemode
    Action{
        text: qsTr("New custom rules...")
        enabled: false
    }
}
