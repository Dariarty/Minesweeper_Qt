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

    //Default number of scale options
    property int defaultNumberOfOptions

    //Model with difficulty modes
    ListModel{
        id: difficultyModesModel

        ListElement{
            name: qsTr("Beginner")
            fieldWidth: 9
            fieldHeight: 9
            mines: 10
            chosen: false
        }

        ListElement{
            name: qsTr("Intermediate")
            fieldWidth: 16
            fieldHeight: 16
            mines: 40
            chosen: true
        }

        ListElement{
            name: qsTr("Expert")
            fieldWidth: 30
            fieldHeight: 16
            mines: 99
            chosen: false
        }
    }

    Component.onCompleted: defaultNumberOfOptions = difficultyModesModel.count

    //Add new custom gameMode option
    Connections{
        target: root

        function onDifficultyOptionAdded(cellsCountWidth, cellsCountHeight, minesCount){
            //If more than 3 custom gamemodes, delete last added
            if(difficultyModesModel.count > defaultNumberOfOptions + 2)
                difficultyModesModel.remove(defaultNumberOfOptions, 1)

            //Add new custom gamemode
            difficultyModesModel.append({
                name:
                    cellsCountWidth.toString() + "x" + cellsCountHeight.toString() + " | " +
                    qsTr("Mines: ") + minesCount.toString(),
                fieldWidth: cellsCountWidth,
                fieldHeight: cellsCountHeight,
                mines: minesCount,
                chosen: true
            })
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

                chosen = true
            }

            checked: chosen

            Component.onCompleted: {
                if(chosen) triggered()
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

        onTriggered: gameModeDialog.open()
    }
}
