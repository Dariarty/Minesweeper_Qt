import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12

import "../menus"

MenuBar{

    //Background styling
    background: Rectangle {
            implicitWidth: 40
            implicitHeight: 40
            color: "white"

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: "grey"
            }
    }

    Menu{
        id: gameMenu

        title: qsTr("Game")
        contentWidth: UiManager.isWebAssembly ? 250 : 200
        topPadding: 0
        bottomPadding: 0

        DifficultyMenu{
            id: difficultyMenu
        }

        MenuItem{
          text: qsTr("Start a new game")
          onTriggered: GameHandler.initNewGame()
        }
    }

    Menu{
        id: settingsMenu

        title: qsTr("Settings")
        contentWidth: UiManager.isWebAssembly ? 250 : 200
        topPadding: 0
        bottomPadding: 0

        ScaleMenu{
            id: scaleMenu
        }

        LanguageMenu{
            id: languageMenu
        }
    }

    Menu{
        id: helpMenu

        title: qsTr("Help")
        contentWidth: UiManager.isWebAssembly ? 250 : 200
        topPadding: 0
        bottomPadding: 0

        MenuItem{
          text: qsTr("Game Rules")
          onClicked: gameRulesDialog.open()
        }

        MenuItem{
          text: qsTr("About application")
          onClicked: aboutAppDialog.open()
        }

    }

}
