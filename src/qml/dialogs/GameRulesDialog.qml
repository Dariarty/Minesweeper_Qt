import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

import "../components"

Dialog {
    id: gameRulesDialog

    title: qsTr("Game Rules")
    parent: Overlay.overlay
    anchors.centerIn: parent
    implicitWidth: Math.min(parent.width * 0.9, 700)
    implicitHeight: Math.min(parent.height * 0.9, 800)
    standardButtons: Dialog.Ok
    Material.accent: "black"
    contentItem: GameRulesHelp{ }
}
