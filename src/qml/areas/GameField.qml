import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Imagine 2.12
import QtQuick.Shapes

Rectangle {
    id: fieldRootItem

    color: "lightgrey"

    Connections{
        target: GameHandler

        function onNewGameStarted(cellsCountWidth, cellsCountHeight){
            fieldModel.clear()
            for(var i = 0; i < cellsCountWidth * cellsCountHeight; i++){
                fieldModel.append({})
            }
        }
    }

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

        delegate: MouseArea{
            height: cellPixelSize
            width: cellPixelSize

            Rectangle {
                color: "#f0f0f0"
                anchors.fill: parent

                Shape {
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                      ShapePath {
                          strokeWidth: 0.1
                          strokeColor: "grey"
                          fillColor: "grey"
                          startX: 0; startY: cellPixelSize
                          PathLine { x: cellPixelSize; y: 0 }
                          PathLine { x: cellPixelSize; y: cellPixelSize }
                          PathLine { x: 0; y: cellPixelSize }
                      }
                  }

                Rectangle{
                    anchors.fill: parent
                    anchors.margins: cellPixelSize / 8
                    color: "lightgrey"
                }
            }

            onClicked: console.log("clicked cell: " + index)
        }

    }


}
