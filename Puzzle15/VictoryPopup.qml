import QtQuick 2.15
import QtQuick.Controls 2.15

Popup {
    id: root
    width: 300
    height: 125

    anchors.centerIn: parent
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

    signal mainClosed
    signal restarted

    background: Rectangle {
        color: "navy"
        border.color: "orange"
        border.width: 2
        radius: 10
    }

    Text {
        id: winText
        font.pointSize: 20
        font.bold: true
        font.family: "Arial"
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        color: "orange"
        text: "You win!"
    }

    CustomButton {
        id: restartButton
        anchors.top: winText.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: 5
        customText: "Restart"
        onClicked: {
            root.restarted()
            close()
        }
    }

    CustomButton {
        id: closeButton
        anchors.top: winText.bottom
        anchors.topMargin: 10
        anchors.left: parent.horizontalCenter
        anchors.right: parent.right
        anchors.leftMargin: 5
        customText: "Close"
        onClicked: root.mainClosed()
    }
}
