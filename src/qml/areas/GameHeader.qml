import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes

import "../components"

Rectangle {
    id: header

    function reEnableElements(){
        if(Math.max(minesCounter.width, timer.width) * 2
                + resetButton.width + 0.8 * cellPixelSize <= header.width){
            minesCounter.visible = true
            resetButton.visible = true
            timer.visible = true
        }
        else{
            resetButton.visible = false

            if(minesCounter.width + timer.width + 0.6 * cellPixelSize <= header.width){
                minesCounter.visible = true
                timer.visible = true
            }
            else{
                timer.visible = false
                minesCounter.visible = minesCounter.width + 0.4 * cellPixelSize <= header.width ?
                            true : false
            }
        }
    }

    anchors.margins: cellPixelSize * 0.125
    anchors.centerIn: parent
    height: parent.height - cellPixelSize * 0.25
    width: parent.width - cellPixelSize * 0.25
    color: "lightgrey"

    onWidthChanged: reEnableElements()

    FontLoader{
        id: dseg7Font
        source: "qrc:/resources/fonts/DSEG7Classic-Bold.ttf"
    }

    MinesCounter{
        id: minesCounter
    }

    ResetButton{
        id: resetButton
    }

    GameTimer{
        id: timer
    }

}
