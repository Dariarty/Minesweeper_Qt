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
                color: "grey"
                width: parent.width
                height: 1
                anchors.bottom: parent.bottom
            }
    }

    //Game Menu
    Menu{
        title: qsTr("Game")

        contentWidth: UiManager.isWebAssembly ? 250 : 200
        topPadding: 0
        bottomPadding: 0

        //Menu to choose difficulty mode
        DifficultyMenu{
            id: difficultyMenu
        }

        MenuItem{
          text: qsTr("Start a new game")
          onTriggered: GameHandler.initNewGame()
        }

        MenuItem{
          text: qsTr("Exit app")
          onTriggered: Qt.quit()
        }

    }

    //Settings Menu
    Menu{
        title: qsTr("Settings")

        contentWidth: UiManager.isWebAssembly ? 250 : 200
        topPadding: 0
        bottomPadding: 0

        //Menu to change scale of cells
        ScaleMenu{
            id: scaleMenu
        }

        //Menu to changle language
        LanguageMenu{
            id: languageMenu
        }
    }

    //Help Menu
    Menu{
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
