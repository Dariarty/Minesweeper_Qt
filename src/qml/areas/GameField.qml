import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Imagine 2.12
import QtQuick.Shapes
import QtQml.Models

import "../components"

Rectangle {
    id: fieldRootItem

    FontLoader{
        id: bungeeFont
        source: "qrc:/resources/fonts/Bungee-Regular.ttf"
    }

    color: "lightgrey"

    ListModel{
        id: fieldModel
    }

    GridView{
        id: fieldGridView
        anchors.fill: parent

        interactive: false

        model: fieldModel

        cellHeight: cellPixelSize
        cellWidth: cellPixelSize

        delegate: Cell{
            id: cell
            cellState: elementState
        }

    }

    Connections{
        target: GameHandler

        function onNewGameStarted(cellsCountWidth, cellsCountHeight){
            fieldModel.clear()
            for(var i = 0; i < cellsCountWidth * cellsCountHeight; i++){
                fieldModel.append({elementState: 9})
            }
        }

        function onCellOpened(cellIndex, cellState) {
            fieldModel.get(cellIndex).elementState = cellState
        }

    }

}
