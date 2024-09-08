import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Dialog {
    id: gameModeDialog

    title: qsTr("New custom rules")
    parent: Overlay.overlay
    anchors.centerIn: parent
    implicitWidth: 350
    implicitHeight: 300
    Material.accent: "black"
    standardButtons: Dialog.Save | Dialog.Cancel
    focus: true

    //set default values on opened
    onVisibleChanged: {
        if(visible){
            widthSpinBox.value = 16
            heightSpinBox.value = 16
            minesSpinBox.value = 40
        }
    }

    //Emit signal to add new difficulty option
    onAccepted: {
        var acceptedWidth = widthSpinBox.value
        var acceptedHeight = heightSpinBox.value
        var acceptedMinesCount = minesSpinBox.value

        if(acceptedWidth > 99) acceptedWidth = 99
        else if(acceptedWidth < 2) acceptedWidth = 2

        if(acceptedHeight > 99) acceptedHeight = 99
        else if(acceptedHeight < 2) acceptedHeight = 2

        if(acceptedMinesCount < 1) acceptedMinesCount = 1
        else if(acceptedMinesCount >= acceptedWidth * acceptedHeight)
            acceptedMinesCount = acceptedWidth * acceptedHeight - 1

        root.difficultyOptionAdded(acceptedWidth, acceptedHeight, acceptedMinesCount)
    }

    contentItem: Rectangle{
        id: contentRect

        color: "transparent"

        //Selection of field width
        Rectangle{
            id: fieldWidthArea

            anchors.left: contentRect.left
            anchors.top: contentRect.top
            implicitWidth: contentRect.width / 2
            implicitHeight: contentRect.height / 2
            color: "transparent"

            Rectangle{
                id: fieldWidthLabelArea

                anchors.top: parent.top
                anchors.left: parent.left
                implicitWidth: parent.width
                implicitHeight: parent.height / 2
                color: "transparent"

                Text{
                    text: qsTr("Field width")
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    anchors.fill: parent
                    anchors.margins: 10
                    font.pointSize: 40
                }
            }

            //SpinBox to choose field width
            SpinBox{
                id: widthSpinBox

                anchors.top: fieldWidthLabelArea.bottom
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                implicitWidth: parent.width - 10
                Material.accent: Material.Grey
                editable: true

                //Field Constraints are from 2x2 to 99x99
                from: 2
                to: 99
            }

        }

        //Selection of field height
        Rectangle{
            id: fieldHeightArea

            anchors.right: contentRect.right
            anchors.top: contentRect.top
            implicitWidth: contentRect.width / 2
            implicitHeight: contentRect.height / 2
            color: "transparent"

            Rectangle{
                id: fieldHeightLabelArea

                anchors.top: parent.top
                anchors.left: parent.left
                implicitWidth: parent.width
                implicitHeight: parent.height / 2
                color: "transparent"

                Text{
                    text: qsTr("Field height")
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    anchors.fill: parent
                    anchors.margins: 10
                    font.pointSize: 40
                }
            }

            //SpinBox to choose field height
            SpinBox{
                id: heightSpinBox

                anchors.top: fieldHeightLabelArea.bottom
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                implicitWidth: parent.width - 10
                Material.accent: Material.Grey
                editable: true

                //field contraints are from 2x2 to 99x99
                from: 2
                to: 99
            }
        }

        //Selection of mines number
        Rectangle{
            id: minesArea

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            implicitWidth: parent.width
            implicitHeight: parent.height / 2
            color: "transparent"

            Rectangle{
                id: minesLabelArea

                anchors.top: parent.top
                anchors.left: parent.left
                implicitWidth: parent.width
                implicitHeight: parent.height / 2
                color: "transparent"

                Text{
                    text: qsTr("Number of mines")
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    anchors.fill: parent
                    anchors.margins: 10
                    font.pointSize: 40
                }
            }

            //SpinBox to choose number of mines in a field
            SpinBox{
                id: minesSpinBox

                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                implicitWidth: parent.width * 0.6
                implicitHeight: parent.height / 2
                Material.accent: Material.Grey
                editable: true

                //Constraints: from 1 to number of cells in a field - 1
                from: 1
                to: widthSpinBox.value * heightSpinBox.value - 1
            }

        }

    }

}
