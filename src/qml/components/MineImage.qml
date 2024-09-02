import QtQuick 2.15

Image{
    anchors.fill: parent
    source: {
        if(cellPixelSize > 64) return "qrc:/resources/icons/mine256px.png"
        else if(cellPixelSize > 32) return "qrc:/resources/icons/mine128px.png"
        else if(cellPixelSize > 16) return "qrc:/resources/icons/mine64px.png"
        else if(cellPixelSize > 8) return "qrc:/resources/icons/mine32px.png"
        else return "qrc:/resources/icons/mine16px.png"
    }
}
