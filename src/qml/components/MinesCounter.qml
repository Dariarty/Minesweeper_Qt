import QtQuick 2.15

Text{
    id: mineCountText
    color: "#484c54"
    anchors.leftMargin: cellPixelSize * 0.15
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    font.family: seg7Font.name
    verticalAlignment: Qt.AlignVCenter
    font.pixelSize: cellPixelSize * 1.5
    font.weight: Font.ExtraBold
    visible: width < header.width

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
