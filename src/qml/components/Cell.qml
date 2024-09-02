import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes

MouseArea{
    id: cell
    height: cellPixelSize
    width: cellPixelSize

    readonly property bool flagged: !opened && cellImage.active

    acceptedButtons: Qt.LeftButton | Qt.RightButton

    enabled: !opened

    property bool opened: ( cell.pressedButtons & Qt.LeftButton ) && !flagged

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
        }
    }

    onClicked: (mouse) => {
        //Place/remove flag on right mouse click if cell not opened
        if(mouse.button === Qt.RightButton && !cell.opened){
            if(cell.flagged){
                cellImage.unLoad()
            }
            else{
                cellImage.loadFlagImage()
            }
        }

        //Reveal cell
        if(mouse.button === Qt.LeftButton && !cell.flagged && !cell.opened){
            console.log("requested revealing cell: " + index)
        }

    }

}
