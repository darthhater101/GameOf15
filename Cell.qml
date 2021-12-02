import QtQuick 2.0

Item {
    id: item
    signal clicked
    Rectangle {
        width: parent.width - 10
        height: parent.height - 10
        anchors.centerIn: parent
        color: "red"

        Text {
            anchors.centerIn: parent
            text: model.number
        }

        MouseArea {
            id: area
            anchors.fill: parent
            onClicked: item.clicked()
        }
    }
}
