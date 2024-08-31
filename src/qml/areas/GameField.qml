import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Controls.Imagine 2.12
import QtQuick.Shapes

Rectangle {
    width: parent.width

    color: "lightgrey"

    Button{
        height: cellPixelSize
        width: cellPixelSize

        background: Rectangle {
            color: "#f0f0f0"
            anchors.fill: parent

            Shape {
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                layer.samples: 8
                  ShapePath {
                      strokeWidth: 0.1
                      strokeColor: "grey"
                      fillColor: "grey"
                      startX: 0; startY: cellPixelSize
                      PathLine { x: cellPixelSize; y: 0 }
                      PathLine { x: cellPixelSize; y: cellPixelSize }
                      PathLine { x: 0; y: cellPixelSize }
                  }
              }

            Rectangle{
                anchors.fill: parent
                anchors.margins: cellPixelSize / 8
                color: "lightgrey"
            }
        }
    }
}
