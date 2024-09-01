import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Dialog {
        id: gameModeDialog
        title: qsTr("New custom rules")

        implicitWidth: 300
        implicitHeight: 300

        //Position dialog at root window center
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

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
        onAccepted: root.difficultyOptionAdded(
                        widthSpinBox.value,
                        heightSpinBox.value,
                        minesSpinBox.value)

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

                    //Field Constraints are from 5x5 to 50x50
                    from: 5
                    to: 50

                    //default value
                    value: 16
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

                    //field contraints are from 5x5 to 50x50
                    from: 5
                    to: 50

                    //default value
                    value: 16
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
                    value: 16

                    //Constraints: from 1 to number of cells in a field - 1
                    from: 1
                    to: widthSpinBox.value * heightSpinBox.value - 1
                }

            }

        }

}
