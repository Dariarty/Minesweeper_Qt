import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Imagine 2.12
import QtQuick.Shapes

import "../areas"

ApplicationWindow{
    id: root

    property int rootHeight: 480
    property int rootWidth: 360

    height: rootHeight
    minimumHeight: rootHeight
    maximumHeight: rootHeight
    width: rootWidth
    minimumWidth: rootWidth
    maximumWidth: rootWidth

    visible: true

    background: Rectangle{
        anchors.fill: parent
        color: "#bec3cf"
    }

    title: "Minesweeper"

    menuBar: MinesweeperMenuBar { }

}

// Field cell template

// Button{
//     height: 40
//     width: 40

//     background: Rectangle {
//         color: "#f0f0f0"
//         anchors.fill: parent

//         Shape {
//             width: parent.width
//             height: parent.height
//             anchors.centerIn: parent
//               ShapePath {
//                   strokeWidth: 1
//                   strokeColor: "grey"
//                   fillColor: "grey"
//                   startX: 0; startY: 40
//                   PathLine { x: 40; y: 0 }
//                   PathLine { x: 40; y: 40 }
//                   PathLine { x: 0; y: 40 }
//               }
//           }

//         Rectangle{
//             anchors.fill: parent
//             anchors.margins: 5
//             color: "lightgrey"
//         }
//     }

// }
