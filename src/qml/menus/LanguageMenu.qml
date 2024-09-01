import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12

import "../components"

Menu{
    id: languageMenu
    title: qsTr("Language")

    topPadding: 0
    bottomPadding: 0

    //Model to store language options
    ListModel{
        id: languagesModel

        ListElement{ name: "English"; lang: "en_US" }
        ListElement{ name: "Русский"; lang: "ru_RU" }
    }

    //Lanugage buttons group
    ButtonGroup{
        id: languageButtonGroup
    }

    //Instantiator to dynamically load menu items from model
    Instantiator{
        id: languagesInstantiator
        model: languagesModel
        delegate: CheckableMenuItem {
            text: name

            ButtonGroup.group: languageButtonGroup

            onTriggered: Translator.setLanguage(lang)

            Component.onCompleted: {
                if(Translator.language===lang) checked = true
            }

        }

        onObjectAdded: (index, object) => languageMenu.insertItem(index, object)
        onObjectRemoved: (index, object) => languageMenu.removeItem(object)
    }
}
