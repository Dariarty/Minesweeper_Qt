import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

import "../components"

Dialog {
    id: gameRulesDialog
    title: qsTr("Game Rules")

    //Position dialog at root window center
    x: parent.width * 0.05
    y: parent.height * 0.05

    implicitWidth: parent.width * 0.9
    implicitHeight: parent.height * 0.9

    contentItem: GameRulesHelp{ }

    standardButtons: Dialog.Ok

    Material.accent: "black"
}
