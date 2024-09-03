import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: header
    height: parent.height - cellPixelSize * 0.25
    width: parent.width - cellPixelSize * 0.25
    anchors.margins: cellPixelSize * 0.125
    anchors.centerIn: parent

    onWidthChanged: {
        console.log(width)
        console.log(header.width)
    }

    FontLoader{
        id: seg7Font
        source: "qrc:/resources/fonts/seg7.ttf"
    }

    Text{
        id: flagCountText
        color: "#484c54"
        text: "54321"
        anchors.leftMargin: cellPixelSize * 0.15
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        font.family: seg7Font.name
        verticalAlignment: Qt.AlignVCenter
        font.pixelSize: cellPixelSize * 1.5
        font.weight: Font.ExtraBold
        visible: width < header.width
    }

    Text{
        id: timerText
        anchors.margins: cellPixelSize * 0.2
        color: "#484c54"
        text: "67890"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        font.family: seg7Font.name
        font.pixelSize: cellPixelSize * 1.5
        font.weight: Font.ExtraBold
        visible: width < header.width
    }

    color: "lightgrey"
}
