import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes

Rectangle {
    id: header
    height: parent.height - cellPixelSize * 0.25
    width: parent.width - cellPixelSize * 0.25
    anchors.margins: cellPixelSize * 0.125
    anchors.centerIn: parent

    FontLoader{
        id: seg7Font
        source: "qrc:/resources/fonts/seg7.ttf"
    }

    Text{
        id: flagCountText
        color: "#484c54"
        text: ""
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

    //Restart button
    MouseArea{
        id: restartButton
        anchors.centerIn: parent
        height: parent.height * 0.8
        width:  parent.height * 0.8

        onClicked: {
            GameHandler.initNewGame()
        }

        Rectangle{
            id: restartButtonRect
            anchors.fill: parent
            color: "grey"

            //Restart button shadow
            Shape {
                visible: !restartButton.containsPress
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                  ShapePath {
                      strokeWidth: 0.1
                      strokeColor: "#f0f0f0"
                      fillColor: "#f0f0f0"
                      startX: 0; startY: restartButtonRect.height
                      PathLine { x: restartButtonRect.width; y: 0 }
                      PathLine { x: 0; y: 0 }
                      PathLine { x: 0; y: restartButtonRect.height }
                  }
            }

            //Restart button content rect
            Rectangle{
                id: restrtButtonContent

                anchors.fill: parent
                anchors.leftMargin: cellPixelSize / 6
                anchors.topMargin: cellPixelSize / 6
                anchors.rightMargin: restartButton.containsPress ?
                                         cellPixelSize / 12 : cellPixelSize / 6
                anchors.bottomMargin: restartButton.containsPress ?
                                          cellPixelSize / 12 : cellPixelSize / 6
                color: "lightgrey"
            }
        }
    }

    Text{
        id: timerText
        anchors.margins: cellPixelSize * 0.2
        color: "#484c54"
        text: ""
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
