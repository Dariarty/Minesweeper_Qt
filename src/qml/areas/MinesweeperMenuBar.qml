import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12

MenuBar {

      Menu {
        title: qsTr("Game")

        Menu {
          title: qsTr("Change difficulty")

          MenuItem {
            text: "Beginner "
          }

          MenuItem {
            text: "Intermediate "
          }

          MenuItem {
            text: "Expert "
          }

        }

        MenuItem {
          text: "Start a new game"
        }
        MenuItem {
          text: "Exit app"
        }
      }

      Menu {
        title: "Settings"

        Menu {
          title: "Language"

          MenuItem {
            text: "English "
          }

          MenuItem {
            text: "Русский "
          }

        }

      }

      Menu {
        title: "Help"

        MenuItem {
          text: "Game Rules"
        }

        MenuItem {
          text: "About application"
        }

      }

    }
