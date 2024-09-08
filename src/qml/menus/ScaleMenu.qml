import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12

import "../components"
import "../dialogs"

Menu{
    id: scaleMenu

    //Default number of scale options
    property int defaultNumberOfOptions

    title: qsTr("Cells scale")
    contentWidth: UiManager.isWebAssembly ? 300 : 205
    topPadding: 0
    bottomPadding: 0
    Component.onCompleted: defaultNumberOfOptions = cellScaleModel.count

    //Model to store cells scale options
    ListModel{
        id: cellScaleModel

        ListElement{ name: qsTr("Tiny"); cellScale: 15; chosen: false }
        ListElement{ name: qsTr("Very Small"); cellScale: 20; chosen: false}
        ListElement{ name: qsTr("Small"); cellScale: 25; chosen: false}
        ListElement{ name: qsTr("Medium"); cellScale: 30; chosen: true }
        ListElement{ name: qsTr("Large"); cellScale: 35; chosen: false }
        ListElement{ name: qsTr("Very Large"); cellScale: 40; chosen: false }
        ListElement{ name: qsTr("Huge"); cellScale: 50; chosen: false }
        ListElement{ name: qsTr("Gigantic"); cellScale: 70; chosen: false }
    }

    //Add new custom scale option
    Connections{
        target: root

        function onScaleOptionAdded(newCellSize){
            //If Custom Scale option already exists, delete it
            if(cellScaleModel.count > defaultNumberOfOptions)
                cellScaleModel.remove(cellScaleModel.count - 1, 1)

            //Add new custom scale option
            cellScaleModel.append({name: qsTr("Custom"), cellScale: newCellSize, chosen: true})
        }
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
            checked: chosen
            Component.onCompleted: if(chosen) triggered()
            onTriggered: {
                chosen = true
                root.cellPixelSize = cellScale
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
        id: customCellScaleAction

        text: qsTr("Custom cell scale...")
        onTriggered: scaleDialog.open()
    }

}
