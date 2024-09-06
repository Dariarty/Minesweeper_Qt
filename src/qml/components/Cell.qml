import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes
import QtQml.Models

MouseArea{
    id: cell
    height: cellPixelSize
    width: cellPixelSize

    readonly property bool flagged: cellImage.active

    property bool containsMine: false

    property bool isHeld: false

    property bool opened: ( cell.pressedButtons & Qt.LeftButton ) && !flagged && !isHeld

    acceptedButtons: Qt.LeftButton | Qt.RightButton

    //    - 1 : mine
    // 0 to 8 : number
    //      9 : default
    property int cellState: 9

    enabled: !opened

    Connections{
        target: GameHandler

        function onGameWon(){
            cell.enabled = false
            if(!opened && !flagged) toggleFlag()
        }

        function onGameLost(losingIndex){
            cell.enabled = false
            if(index===losingIndex){
                cellContentRect.color = "red"
            }

            if(containsMine && !cell.flagged){
                opened = true
                cellImage.loadMineImage()
            }

            else if(!containsMine && cell.flagged){
                opened = true
                cellImage.loadMineImage()
                crossImage.visible = true
            }
        }
    }

    onCellStateChanged: {
        //open cell
        if(cellState >= 0) opened = true

        //if flagged, remove flag
        if(flagged && cellState >= 0) cellImage.unLoad()

        if(cellState >= 0){
            //cell is a number
            cellText.text = cellState
            cellText.visible = true
        }
        else{
            containsMine = true
        }
    }

    Rectangle {
        id: cellRect
        color: "grey"
        anchors.fill: parent

        Shape {
            visible: !cell.opened
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
              ShapePath {
                  strokeWidth: 0.1
                  strokeColor: "#f0f0f0"
                  fillColor: "#f0f0f0"
                  startX: 0; startY: cellPixelSize
                  PathLine { x: cellPixelSize; y: 0 }
                  PathLine { x: 0; y: 0 }
                  PathLine { x: 0; y: cellPixelSize }
              }
        }

        Rectangle{
            id: cellContentRect

            anchors.fill: parent
            anchors.leftMargin: cell.opened ? cellPixelSize / 16 : cellPixelSize / 8
            anchors.topMargin: cell.opened ? cellPixelSize / 16 : cellPixelSize / 8
            anchors.rightMargin: cell.opened ? 0 : cellPixelSize / 8
            anchors.bottomMargin: cell.opened ? 0 : cellPixelSize / 8

            color: "lightgrey"

            Text{
                id: cellText
                font.family: bungeeFont.name
                anchors.fill: parent
                visible: false
                color: {
                    switch(text){
                    case "1": return "#0000ff"
                    case "2": return "#008000"
                    case "3": return "#ff0000"
                    case "4": return "#000080"
                    case "5": return "#800000"
                    case "6": return "#008080"
                    case "7": return "#000000"
                    case "8": return "#808080"
                    default: return "transparent"
                    }
                }

                font.pointSize: cellPixelSize * 0.7
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            Loader{
                id: cellImage
                active: false
                anchors.fill: parent
                anchors.margins: cellPixelSize / 16

                function unLoad(){
                    source = ""
                    active = false
                }

                function loadMineImage(){
                    source = "qrc:/qml/components/MineImage.qml"
                    active = true
                }

                function loadFlagImage(){
                    source = "qrc:/qml/components/FlagImage.qml"
                    active = true
                }
            }

            //Cross icon to mark uncorrectly guessed mines at loss
            Image{
                id: crossImage
                source: "qrc:/resources/icons/cross.png"
                anchors.fill: parent
                visible: false
                anchors.margins: cellPixelSize / 16
            }
        }
    }

    //Toggle flag on cell held
    onPressAndHold: {
        isHeld = true
        toggleFlag()
    }

    onReleased: isHeld = false

    onClicked: (mouse) => {
        //Toggle flag on right mouse click if cell not opened
        if(mouse.button === Qt.RightButton && !cell.opened){
            toggleFlag()
        }

        //Reveal cell if not opened
        if(mouse.button === Qt.LeftButton && !cell.flagged && !cell.opened){
            GameHandler.revealCell(index)
        }

    }

    //Place/remove flag from cell
    function toggleFlag(){
        if(cell.flagged){
            cellImage.unLoad()
        }
        else{
            cellImage.loadFlagImage()
        }
    }

}
