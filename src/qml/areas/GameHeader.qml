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

    onWidthChanged: reEnableElements()

    FontLoader{
        id: dseg7Font
        source: "qrc:/resources/fonts/DSEG7Classic-Bold.ttf"
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

    function reEnableElements(){
        console.log(minesCounter.width)
        console.log(resetButton.width)
        console.log(timer.width)
        console.log(header.width)

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

}
