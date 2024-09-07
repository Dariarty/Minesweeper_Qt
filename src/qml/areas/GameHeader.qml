import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes

import "../components"

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

    //Text with number of unflagged mines
    MinesCounter{
        id: minesCounter
    }

    //Restart button
    ResetButton{
        id: resetButton
    }

    //Game Timer
    GameTimer{
        id: timer
    }

    color: "lightgrey"
}
