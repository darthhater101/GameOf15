import QtQuick 2.15
import QtQuick.Controls 2.15

Popup {
    width: 300
    height: 125

    anchors.centerIn: parent

    Text {
        id: winText
        font.pointSize: 14
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        text: "You win!"
    }

    Button {
        id: restartButton
        anchors.top: winText.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: 5
        text: "Restart"
        onClicked: {
            do {
              numbersModel.shuffle();
            } while(numbersModel.isSolvable());

            victoryPopup.visible = false
        }
    }

    Button {
        id: closeButton
        anchors.top: winText.bottom
        anchors.topMargin: 10
        anchors.left: parent.horizontalCenter
        anchors.right: parent.right
        anchors.leftMargin: 5
        text: "Close"
        onClicked: {
            close();
        }
    }

    onOpened: view.interactive = false
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
}
