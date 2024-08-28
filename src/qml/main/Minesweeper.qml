import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Imagine 2.12

import "../areas"

ApplicationWindow{
    id: root

    property int rootHeight: 480
    property int rootWidth: 640

    height: rootHeight
    minimumHeight: rootHeight
    maximumHeight: rootHeight
    width: rootWidth
    minimumWidth: rootWidth
    maximumWidth: rootWidth

    visible: true

    background: Rectangle{
        anchors.fill: parent
        color: "grey"
    }

    title: "Minesweeper"

    menuBar: MinesweeperMenuBar { }

}
