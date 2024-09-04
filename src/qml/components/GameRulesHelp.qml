import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Universal

ScrollView{
    id: gameRulesRect
    width: parent.width - scrollBar.width
    height: parent.height
    Universal.accent: Universal.Steel
    ScrollBar.horizontal: ScrollBar{
        policy: ScrollBar.AlwaysOff
    }
    ScrollBar.vertical: ScrollBar{
        id: scrollBar
        anchors.left: gameRulesRect.right
        height: parent.height
    }

    TextArea{
        enabled: false
        background: Rectangle{
            color: "transparent"
        }

        color: "black"
        text: qsTr("Minesweeper is a classic puzzle game where the objective is" +
                   "to clear a grid without detonating any hidden mines") + "\n\n" +
              qsTr("The game board consists of a grid of squares, " +
                   "some of which contain mines") + "\n\n" +
              qsTr("Numbers indicate how many mines are adjacent to that cell") + "\n\n" +
              qsTr("Gameplay:") + "\n" +
              qsTr("Use LEFT MOUSE CLICK on any cell to reveal it") + "\n" +
              qsTr("Use RIGHT CLICK to mark a cell you suspect contains a mine") + "\n\n" +
              qsTr("When you open a square that contains a mine, you lose") + "\n\n" +
              qsTr("When you open a square that does not touch any mines, it will be empty " +
                   "and the adjacent squares will automatically open in all directions until" +
                   " reaching squares that contain numbers.") + "\n\n" +
              qsTr("Use numbers to deduce mines location. A number indicates how many mines " +
                   "are adjacent to that square.") + "\n\n" +
              qsTr("Winning:") + "\n" +
              qsTr("The game is won by revealing all non-mine squares, " +
                   "leaving only the mines covered or flagged correctly") + "\n\n" +
              qsTr("Losing:") + "\n" +
              qsTr("The game ends immediately if you click on a square with a mine") + "\n\n" +
              qsTr("Game modes:") + "\n" +
              qsTr("Beginner: 9x9 field, 10 mines") + "\n" +
              qsTr("Intermediate: 16x16 field, 40 mines") + "\n" +
              qsTr("Expert: 30x16 field, 99 mines") + "\n" +
              qsTr("Custom: fields from 5x5 to 100x100 are supported, " +
                   "with number of mines from 1 to number of cells in a field minus one")

        wrapMode: Text.WordWrap
    }
}
