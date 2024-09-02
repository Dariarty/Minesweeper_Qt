import QtQuick 2.15

Image{
    anchors.fill: parent
    source: {
        if(cellPixelSize > 64) return "qrc:/resources/icons/flag256px.png"
        else if(cellPixelSize > 32) return "qrc:/resources/icons/flag128px.png"
        else if(cellPixelSize > 16) return "qrc:/resources/icons/flag64px.png"
        else if(cellPixelSize > 8) return "qrc:/resources/icons/flag32px.png"
        else return "qrc:/resources/icons/flag16px.png"
    }
}
