import QtQuick 2.15
import QtQuick.Shapes

Rectangle{
    id: minesCounter

    color: "grey"
    anchors.leftMargin: cellPixelSize * 0.2
    anchors.topMargin: cellPixelSize * 0.2
    anchors.bottomMargin: cellPixelSize * 0.2
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: mineCountText.width
    onWidthChanged: parent.reEnableElements()

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
            startX: 0; startY: minesCounter.height
            PathLine { x: cellPixelSize / 16 ; y: minesCounter.height - cellPixelSize  / 16 }
            PathLine { x: minesCounter.width - cellPixelSize  / 16; y: cellPixelSize  / 16 }
            PathLine { x: minesCounter.width; y: 0 }
            PathLine { x: minesCounter.width; y: minesCounter.height }
            PathLine { x: 0; y: minesCounter.height }
        }
    }

    Rectangle{
        id: innerRectangle

        anchors.fill: parent
        color: "black"
        anchors.margins: cellPixelSize / 16

        Text{
            id: shadowText

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.centerIn: parent
            font.family: dseg7Font.name
            verticalAlignment: Qt.AlignVCenter
            font.pixelSize: cellPixelSize * 1.25
            font.weight: Font.ExtraBold
            opacity: 0.3
            text: '8'.repeat(mineCountText.text.length)
            color: "red"
        }

        Text{
            id: mineCountText

            color: "red"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.centerIn: parent
            font.family: dseg7Font.name
            verticalAlignment: Qt.AlignVCenter
            font.pixelSize: cellPixelSize * 1.3
            font.weight: Font.ExtraBold

            Connections{
                target: GameHandler

                function onNewGameStarted(cellsCountWidth, cellsCountHeight, minesCount){
                    mineCountText.text = minesCount
                }
            }

            Connections{
                target: root

                function onFlagUpdated(isAdded){
                    mineCountText.text = isAdded ?
                              Number(mineCountText.text) - 1 :
                              Number(mineCountText.text) + 1
                }

            }

        }

    }

}
