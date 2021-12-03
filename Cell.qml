import QtQuick 2.0

Item {
    id: item
    signal clicked
    Rectangle {
        width: parent.width - 10
        height: parent.height - 10
        radius: 10
        anchors.centerIn: parent
        color: "red"

        Text {
            anchors.centerIn: parent
            text: model.display
            font.pointSize: 30
            font.family: "Arial"
        }

        MouseArea {
            id: area
            anchors.fill: parent
            onClicked: item.clicked()
        }
    }
}
