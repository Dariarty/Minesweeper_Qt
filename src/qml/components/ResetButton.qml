import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes

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
        Shape{
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
            id: restartButtonContent

            anchors.fill: parent
            anchors.leftMargin: cellPixelSize / 6
            anchors.topMargin: cellPixelSize / 6
            anchors.rightMargin: restartButton.containsPress ?
                                     cellPixelSize / 12 : cellPixelSize / 6
            anchors.bottomMargin: restartButton.containsPress ?
                                      cellPixelSize / 12 : cellPixelSize / 6
            color: "lightgrey"

            Image{
                id: faceImage
                state: "normal"
                antialiasing: true
                sourceSize.width: faceImage.width * 3
                sourceSize.height: faceImage.height * 3
                width: restartButtonRect.width * 0.66
                height: restartButtonRect.height * 0.66
                anchors.centerIn: parent
                source: {
                    switch(state){
                        case "normal": return "qrc:/resources/icons/face.png"
                        case "pressed": return "qrc:/resources/icons/surprised.png"
                        case "victory": return "qrc:/resources/icons/cool.png"
                        case "defeat": return "qrc:/resources/icons/dead.png"
                    }
                }

                //Update face on field pressed
                Connections{
                    target: root

                    function onFieldPressChanged(fieldPressed){
                        if(faceImage.state==="normal" && fieldPressed){
                            faceImage.state="pressed"
                        }
                        else if(faceImage.state==="pressed" && !fieldPressed){
                            faceImage.state="normal"
                        }
                    }
                }

                //Update face on game start and end
                Connections{
                    target: GameHandler

                    function onGameLost(){
                        faceImage.state = "defeat"
                    }

                    function onGameWon(){
                        faceImage.state = "victory"
                    }

                    function onNewGameStarted(){
                        faceImage.state = "normal"
                    }
                }
            }
        }
    }
}
