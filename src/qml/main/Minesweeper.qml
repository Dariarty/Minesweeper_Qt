import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12

import "../areas"

ApplicationWindow{
    id: root

    width: 640
    height: 480
    visible: true

    title: "Minesweeper"
    color: "lightGrey"

    menuBar: MinesweeperMenuBar { }

}
