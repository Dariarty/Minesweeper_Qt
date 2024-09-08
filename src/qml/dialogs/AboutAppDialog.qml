import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Dialog {
    id: appInfoDialog

    title: qsTr("About app")
    parent: Overlay.overlay
    anchors.centerIn: parent
    implicitWidth: UiManager.isWebAssembly ? 350 : 250
    implicitHeight: 250
    standardButtons: Dialog.Ok
    Material.accent: "black"

    Label{
        text: {
            qsTr("Minesweeper game") + "\n\n" +
            qsTr("Designed by Artem Darmogray") + "\n\n" +
            qsTr("Available from:") + "\n" + "github.com/Dariarty/Minesweeper_Qt"
        }
    }
}
