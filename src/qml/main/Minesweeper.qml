import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Imagine 2.12
import QtQuick.Shapes

import "../areas"

ApplicationWindow{
    id: root
    visible: true
    title: qsTr("Minesweeper")

    //Size of single field cell in pixels
    property real cellPixelSize: 30

    //Count of cells in width and height
    property int fieldCellsCountWidth
    property int fieldCellsCountHeight

    //Disable height resize
    minimumHeight: (fieldCellsCountHeight + 3.25) * cellPixelSize
                   + topMenu.contentItem.height
    maximumHeight: (fieldCellsCountHeight + 3.25) * cellPixelSize
                   + topMenu.contentItem.height
    height: (fieldCellsCountHeight + 3.25) * cellPixelSize
            + topMenu.contentItem.height

    //Disable width resize
    minimumWidth: (fieldCellsCountWidth + 0.75) * cellPixelSize
    maximumWidth: (fieldCellsCountWidth + 0.75) * cellPixelSize
    width: (fieldCellsCountWidth + 0.75) * cellPixelSize

    Connections{
        target: GameHandler

        function onNewGameStarted(cellsCountWidth, cellsCountHeight){
            //If size of game field changed, remember new values and
            if(cellsCountWidth !== fieldCellsCountWidth
                    || cellsCountHeight !==fieldCellsCountHeight){
                fieldCellsCountWidth = cellsCountWidth
                fieldCellsCountHeight = cellsCountHeight

                //Check if window out of bounds
                centerWindowIfOutOfBounds()
            }
        }
    }

    //If window is out of screen after field resize, center window
    function centerWindowIfOutOfBounds(){
        if((root.x + root.width > screen.width
                || root.y + root.height > screen.height
                || root.x < 0
                || root.y < 0)
                && root.width <= screen.width && root.height <= screen.height){
            root.x =
                    screen.width / 2 -
                    (fieldCellsCountWidth + 0.75) * cellPixelSize / 2
            root.y =
                    screen.height / 2 -
                    ((fieldCellsCountHeight + 3.25) * cellPixelSize
                     + topMenu.contentItem.height) / 2
        }
    }

    background: Rectangle{
        anchors.fill: parent
        color: "#bec3cf"
    }

    menuBar: MinesweeperMenuBar {
        id: topMenu
    }

    //Game Header
    Rectangle  {
        id: headerRect

        anchors{
            top: topMenu.bottom
            topMargin: cellPixelSize * 0.25
            rightMargin: cellPixelSize * 0.25
            leftMargin: cellPixelSize * 0.25
            horizontalCenter: parent.horizontalCenter
        }

        height: cellPixelSize * 2.25
        width: parent.width - cellPixelSize * 0.5

        color: "grey"

        Shape{
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            layer.enabled: true
            layer.samples: 8

            ShapePath {
                strokeWidth: 0.1
                strokeColor: "#f0f0f0"
                fillColor: "#f0f0f0"
                startX: 0; startY: headerRect.height
                PathLine { x: cellPixelSize * 0.125 ; y: headerRect.height - cellPixelSize * 0.125 }
                PathLine { x: headerRect.width - cellPixelSize * 0.125; y: cellPixelSize * 0.125 }
                PathLine { x: headerRect.width; y: 0 }
                PathLine { x: headerRect.width; y: headerRect.height }
                PathLine { x: 0; y: headerRect.height }
            }
        }

        GameHeader{
            id: gameHeader
            height: parent.height - cellPixelSize * 0.25
            width: parent.width - cellPixelSize * 0.25
            anchors.margins: cellPixelSize * 0.125
            anchors.centerIn: parent
        }
    }

    //Game Field
    Rectangle{
        id: fieldRect

        width: (fieldCellsCountWidth + 0.25) * cellPixelSize
        height: (fieldCellsCountHeight + 0.25) * cellPixelSize

        anchors{
            bottom: parent.bottom
            left: root.left
            right: root.right
            margins: cellPixelSize * 0.25
            horizontalCenter: parent.horizontalCenter
        }

        color: "grey"

        Shape{
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            layer.enabled: true
            layer.samples: 8

            ShapePath {
                strokeWidth: 0.1
                strokeColor: "#f0f0f0"
                fillColor: "#f0f0f0"
                startX: 0; startY: fieldRect.height
                PathLine { x: cellPixelSize * 0.125 ; y: fieldRect.height - cellPixelSize * 0.125 }
                PathLine { x: fieldRect.width - cellPixelSize * 0.125; y: cellPixelSize * 0.125 }
                PathLine { x: fieldRect.width; y: 0 }
                PathLine { x: fieldRect.width; y: fieldRect.height }
                PathLine { x: 0; y: fieldRect.height }
            }
        }

        GameField{
            id: gameField
            height: parent.height - cellPixelSize * 0.25
            width: parent.width - cellPixelSize * 0.25
            anchors.centerIn: parent
            anchors.margins: cellPixelSize * 0.125
        }
    }
}
