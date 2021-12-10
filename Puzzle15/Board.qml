import QtQuick 2.0

GridView {
    cellWidth: width / 4
    cellHeight: height / 4
    interactive: false
    move: animation
    displaced: animation

    Transition {
        id: animation
        NumberAnimation {
            properties: "x, y"; duration: 400;
        }
    }
}
