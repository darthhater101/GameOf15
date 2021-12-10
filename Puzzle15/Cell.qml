import QtQuick 2.0

Item {
    id: root
    signal clicked
    Rectangle {
        width: parent.width - 10
        height: parent.height - 10
        radius: 10
        anchors.centerIn: parent
        color: "navy"
        border.color: "orange"
        border.width: 5

        Text {
            anchors.centerIn: parent
            text: model.display
            font.pointSize: 30
            color: "orange"
            font.family: "Arial"
            font.bold: true
        }

        MouseArea {
            id: area
            anchors.fill: parent
            onClicked: root.clicked()
        }
    }
}
