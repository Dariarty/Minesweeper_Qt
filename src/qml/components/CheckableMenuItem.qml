import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12

//Checkable Menu Item Component for use in Menus
MenuItem {
    id: menuItem

    implicitWidth: 200
    implicitHeight: 48

    checkable: true

    indicator: Item {
        id: checkableItemIndicator
        implicitWidth: 50
        implicitHeight: 48

        Rectangle {
            id: indicatorRect
            width: 26
            height: 26
            anchors.centerIn: parent
            visible: menuItem.checkable
            border.color: "grey"
            border.width: 2
            radius: 3
            Rectangle {
                width: 14
                height: 14
                anchors.centerIn: parent
                visible: menuItem.checked
                color: "grey"
                radius: 2
            }
        }
    }

    contentItem: Text {
        leftPadding: 35
        text: menuItem.text
        font: menuItem.font
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

}
