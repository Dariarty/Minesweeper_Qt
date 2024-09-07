import QtQuick 2.15

Text{
    id: timerText
    anchors.margins: cellPixelSize * 0.2
    color: "#484c54"
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    font.family: seg7Font.name
    font.pixelSize: cellPixelSize * 1.5
    font.weight: Font.ExtraBold
    visible: width < header.width

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
