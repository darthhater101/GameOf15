import QtQuick 2.0

GridView {
    cellWidth: width / 4
    cellHeight: height / 4
    interactive: false
    property int zeroCellIndex: 15

    Transition {
        id: animation
        NumberAnimation {
            properties: "x, y"; duration: 400;
        }
    }

    move: animation
    displaced: animation
}
