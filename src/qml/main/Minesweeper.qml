import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Imagine 2.12
import QtQuick.Shapes

import "../areas"
import "../dialogs"

ApplicationWindow{
    id: root
    visible: true
    title: qsTr("Minesweeper")

    //Size of single field cell in pixels
    property real cellPixelSize

    //Count of cells in width and height
    property int fieldCellsCountWidth
    property int fieldCellsCountHeight

    //When cell pixel size changes, center window if out of bounds
    onCellPixelSizeChanged: {
        centerWindowIfOutOfBounds()
    }

    //When entering windowed mode, resize window into reference size and check if window will be out of bounds
    onVisibilityChanged: (visibility) => {

        if(visibility === Window.Windowed){
            minimumHeight = windowedHeight
            height = windowedHeight
            minimumWidth = windowedWidth
            width = windowedWidth
            centerWindowIfOutOfBounds()
        }
    }

    //height of game content with MenuBar
    property int referenceGameHeight: {
        (fieldCellsCountHeight + 3.5) * cellPixelSize + topMenu.contentItem.height
    }
    //width of game content
    property int referenceGameWidth: {
        (fieldCellsCountWidth + 1) * cellPixelSize
    }

    //Height of window in windowed mode
    //Adjusted for not fitting into available screen space
    //Adjusted for too little window
    property int windowedHeight: {
        Math.max(Math.min(referenceGameHeight,
                          screen.desktopAvailableHeight - UiManager.titleBarSize),
                 400)
    }
    //Width of window in windowed mode
    //Adjusted for not fitting into available screen space
    //Adjusted for too little window
    property int windowedWidth: {
        Math.max(Math.min(referenceGameWidth,
                          screen.desktopAvailableWidth),
                 400)
    }

    //If windowed height changed, update window height value if in windowed mode
    onWindowedHeightChanged: {
        if(visibility === Window.Windowed){
            minimumHeight = windowedHeight
            height = windowedHeight
        }
    }

    //If windowed width changed, ipdate window width value if in windowed mode
    onWindowedWidthChanged: {
        if(visibility === Window.Windowed){
            minimumWidth = windowedWidth
            width = windowedWidth
        }
    }

    Connections{
        target: GameHandler

        function onNewGameStarted(cellsCountWidth, cellsCountHeight){
            //If size of game field changed, remember new values
            if(cellsCountWidth !== fieldCellsCountWidth
                    || cellsCountHeight !==fieldCellsCountHeight){
                fieldCellsCountWidth = cellsCountWidth
                fieldCellsCountHeight = cellsCountHeight
            }

            //Center window when new game starts, if out of bounds
            centerWindowIfOutOfBounds()
        }
    }

    //If window is out of screen after field resize, center window
    function centerWindowIfOutOfBounds(){
        if(root.visibility == Window.Windowed && (root.x + root.width > screen.desktopAvailableWidth
                || root.y - UiManager.titleBarSize +
            Math.min((fieldCellsCountHeight + 3.25) * cellPixelSize +
                     topMenu.contentItem.height, screen.desktopAvailableHeight
                     - UiManager.titleBarSize) > screen.desktopAvailableHeight - UiManager.titleBarSize
                || root.x < 0
                || root.y < 0)){
            root.x =
                    screen.width / 2 - root.width / 2
            root.y =
                    (screen.desktopAvailableHeight + UiManager.titleBarSize ) / 2 -
                    Math.min((fieldCellsCountHeight + 3.25) * cellPixelSize +
                    topMenu.contentItem.height, screen.desktopAvailableHeight
                    - UiManager.titleBarSize) / 2
        }
    }

    background: Rectangle{
        anchors.fill: parent
        color: "#d0d5db"
    }

    menuBar: MainMenuBar {
        id: topMenu
    }

    Flickable{
        id: flick

        height: parent.height
        anchors.top: topMenu.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: cellPixelSize * 0.125

        interactive: flick.contentHeight > flick.height || flick.contentWidth > flick.width
        flickableDirection: {
            if(flick.contentHeight > flick.height && flick.contentWidth > flick.width)
                Flickable.HorizontalAndVerticalFlick
            else if (flick.contentHeight > flick.height) Flickable.VerticalFlick
                else Flickable.HorizontalFlick
        }
        boundsBehavior: Flickable.DragAndOvershootBounds
        contentHeight: flickContentWrapper.height
        contentWidth: flickContentWrapper.width

        Rectangle{
            id: flickContentWrapper
            width: Math.max(referenceGameWidth, flick.width)
            height: Math.max(referenceGameHeight - topMenu.contentItem.height, flick.height)
            color: "transparent"

            //Game Padding Rectangle
            Rectangle{
                id: paddingRectangle

                anchors.top: headerRect.top
                anchors.left: headerRect.left
                anchors.right: headerRect.right
                anchors.bottom: fieldRect.bottom
                anchors.margins: -border.width - cellPixelSize / 4
                color: "grey"
                border.color: "grey"
                border.width: cellPixelSize / 8

                //White Shadow
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
                        startX: 0; startY: paddingRectangle.height
                        PathLine { x: cellPixelSize / 8; y: paddingRectangle.height - cellPixelSize / 8 }
                        PathLine { x: paddingRectangle.width - cellPixelSize / 8 ; y: cellPixelSize / 8 }
                        PathLine { x: paddingRectangle.width ; y: 0 }
                        PathLine { x: 0 ; y: 0 }
                    }
                }

                //Background Rectangle
                Rectangle{
                    id: fieldRectangleBackground
                    anchors.fill: paddingRectangle
                    anchors.margins: cellPixelSize / 8
                    color: "lightgrey"
                }
            }

            //Game Header
            Rectangle {
                id: headerRect

                anchors{
                    top: parent.top
                    topMargin: cellPixelSize * 0.25
                               + (flickContentWrapper.height - (referenceGameHeight - topMenu.contentItem.height)) / 2
                    rightMargin: cellPixelSize * 0.25
                    leftMargin: cellPixelSize * 0.25
                    horizontalCenter: parent.horizontalCenter
                }

                height: cellPixelSize * 2.25
                width: (fieldCellsCountWidth + 0.25) * cellPixelSize

                color: "grey"

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
                        startX: 0; startY: headerRect.height
                        PathLine { x: cellPixelSize * 0.125 ; y: headerRect.height - cellPixelSize * 0.125 }
                        PathLine { x: headerRect.width - cellPixelSize * 0.125; y: cellPixelSize * 0.125 }
                        PathLine { x: headerRect.width; y: 0 }
                        PathLine { x: headerRect.width; y: headerRect.height }
                        PathLine { x: 0; y: headerRect.height }
                    }
                }

                GameHeader{
                    id: gameHeader
                }
            }

            //Game Field
            Rectangle{
                id: fieldRect

                width: (fieldCellsCountWidth + 0.25) * cellPixelSize
                height: (fieldCellsCountHeight + 0.25) * cellPixelSize

                anchors{
                    top: headerRect.bottom
                    left: root.left
                    right: root.right
                    margins: cellPixelSize * 0.25
                    horizontalCenter: parent.horizontalCenter
                }

                color: "grey"

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
                        startX: 0; startY: fieldRect.height
                        PathLine { x: cellPixelSize * 0.125 ; y: fieldRect.height - cellPixelSize * 0.125 }
                        PathLine { x: fieldRect.width - cellPixelSize * 0.125; y: cellPixelSize * 0.125 }
                        PathLine { x: fieldRect.width; y: 0 }
                        PathLine { x: fieldRect.width; y: fieldRect.height }
                        PathLine { x: 0; y: fieldRect.height }
                    }
                }

                GameField{
                    id: gameField
                    height: parent.height - cellPixelSize * 0.25
                    width: parent.width - cellPixelSize * 0.25
                    anchors.centerIn: parent
                    anchors.margins: cellPixelSize * 0.125
                }
            }

        }
    }

    signal scaleOptionAdded(int newCellSize)

    //Dialog to choose cell scale
    ScaleDialog{
        id: scaleDialog
    }

    signal difficultyOptionAdded(int cellsCountWidth, int cellsCountHeight, int minesCount)

    //Dialog to choose difficulty
    GameModeDialog{
        id: gameModeDialog
    }

    //About app Dialog
    AboutAppDialog{
        id: aboutAppDialog
    }

    //Game Rules Dialog
    GameRulesDialog{
        id: gameRulesDialog
    }
}
