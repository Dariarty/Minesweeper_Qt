import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Dialog {
        id: scaleDialog
        title: qsTr("Select cell size")

        //Position dialog at window center
        parent: Overlay.overlay
        anchors.centerIn: parent

        implicitWidth: 250
        implicitHeight: 200

        Material.accent: "black"

        standardButtons: Dialog.Save | Dialog.Cancel

        focus: true

        //set default value on opened
        onVisibleChanged: {
            if(visible) scaleSpinBox.value = 30
        }

        //spinbox to choose cell size
        contentItem: SpinBox{
            id: scaleSpinBox
            Material.accent: Material.Grey
            focus: scaleDialog.visible
            editable: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            //min and max values
            from: 10
            to: 100
        }

        //Emit signal to add new scale option
        onAccepted: root.scaleOptionAdded(scaleSpinBox.value)

}
