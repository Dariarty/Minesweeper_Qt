import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Dialog {
    id: appInfoDialog
    title: qsTr("About app")

    //Position dialog at root window center
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    Label{
        text: qsTr("Minesweeper game") + "\n\n" +
                   qsTr("Designed by Artem Darmogray") + "\n\n" +
                   qsTr("Available from:") + "\n" +
                   "github.com/Dariarty/Minesweeper_Qt"
    }

    standardButtons: Dialog.Ok

    Material.accent: "black"
}
