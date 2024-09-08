import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Dialog {
    id: scaleDialog

    title: qsTr("Select cell size")
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

    //Emit signal to add new scale option
    onAccepted: {
        var acceptedScale = scaleSpinBox.value

        if(acceptedScale < 12) acceptedScale = 12
        if(acceptedScale > 120) acceptedScale = 120

        root.scaleOptionAdded(acceptedScale)
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
        from: 12
        to: 120
    }

}
