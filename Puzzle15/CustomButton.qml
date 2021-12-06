import QtQuick 2.0
import QtQuick.Controls 2.15

Button {
    property alias customText: txt.text
    height: 50

    Text {
        id: txt
        color: "orange"
        font.pointSize: 20
        font.bold: true
        font.family: "Arial"
        anchors.centerIn: parent
    }

    background: Rectangle {
        color: "navy"
        radius: 10
        border.width: 5
        border.color: "orange"
    }
}
