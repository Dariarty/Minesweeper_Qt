import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12

import "../components"

Menu{
    id: scaleMenu
    title: qsTr("Cells scale")

    contentWidth: 205
    topPadding: 0
    bottomPadding: 0

    //Model to store cells scale options
    ListModel{
        id: cellScaleModel

        ListElement{ name: qsTr("Tiny"); cellScale: 15 }
        ListElement{ name: qsTr("Very Small"); cellScale: 20 }
        ListElement{ name: qsTr("Small"); cellScale: 25}
        ListElement{ name: qsTr("Medium"); cellScale: 30; defaultScale: true }
        ListElement{ name: qsTr("Large"); cellScale: 35 }
        ListElement{ name: qsTr("Very Large"); cellScale: 40 }
        ListElement{ name: qsTr("Huge"); cellScale: 50 }
        ListElement{ name: qsTr("Gigantic"); cellScale: 70 }
    }

    //Cells scale button group
    ButtonGroup{
        id: cellScaleButtonGroup
    }

    //Instantiator to dynamically load menu items from model
    Instantiator{
        id: cellScaleInstantiator
        model: cellScaleModel
        delegate: CheckableMenuItem {
            text: name + " | " + cellScale + "x" + cellScale

            ButtonGroup.group: cellScaleButtonGroup

            onTriggered: {
                console.log("Set CellPixelSize From Menu: " + cellScale + "\n")
                root.cellPixelSize = cellScale
            }

            checked: defaultScale

            Component.onCompleted: {
                if(defaultScale) triggered()
            }

        }

        onObjectAdded: (index, object) => scaleMenu.insertItem(index, object)
        onObjectRemoved: (index, object) => scaleMenu.removeItem(object)
    }

    //Grey line separator
    MenuSeparator{
        topPadding: 0
        bottomPadding: 0

        contentItem: Rectangle {
            implicitHeight: 1
            color: "grey"
        }
    }

    //Add new custom cell scale
    Action{
        text: qsTr("Custom cell scale...")

        enabled: false
    }
}
