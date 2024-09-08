import QtQuick 2.15
import QtQuick.Shapes

Rectangle{
    id: timerRect

    color: "grey"
    anchors.rightMargin: cellPixelSize * 0.2
    anchors.topMargin: cellPixelSize * 0.2
    anchors.bottomMargin: cellPixelSize * 0.2
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: timerText.width
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
            startX: 0; startY: timerRect.height
            PathLine { x: cellPixelSize / 16 ; y: timerRect.height - cellPixelSize  / 16 }
            PathLine { x: timerRect.width - cellPixelSize  / 16; y: cellPixelSize  / 16 }
            PathLine { x: timerRect.width; y: 0 }
            PathLine { x: timerRect.width; y: timerRect.height }
            PathLine { x: 0; y: timerRect.height }
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
            anchors.right: parent.right
            anchors.centerIn: parent
            font.family: dseg7Font.name
            verticalAlignment: Qt.AlignVCenter
            font.pixelSize: cellPixelSize * 1.25
            font.weight: Font.ExtraBold
            opacity: 0.3
            text: '8'.repeat(timerText.text.length)
            color: "red"
        }

        Text{
            id: timerText

            color: "red"
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.centerIn: parent
            font.family: dseg7Font.name
            verticalAlignment: Qt.AlignVCenter
            font.pixelSize: cellPixelSize * 1.3
            font.weight: Font.ExtraBold

            Connections{
                target: GameHandler

                function onNewGameStarted(){
                    timerText.text = "0"
                }

                function onTimerTick(){
                    timerText.text = Number(timerText.text) + 1
                }

            }

        }

    }

}
