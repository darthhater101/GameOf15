import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "gameLogic.js" as Logic

Window {
    width: 700
    height: width
    visible: true
    title: qsTr("Puzzle 15")

    Popup {
        id: victoryPopup
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
                Logic.reset();
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

    Button {
        id: shuffleButton
        text: "Shuffle"
        onClicked: Logic.shuffle()
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Board {
        id: view
        anchors.top: shuffleButton.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        model: NumbersModel{ id: numbersModel }
        delegate: Cell {
            width: view.cellWidth
            height: view.cellHeight
            visible: !(model.number === 0)
            enabled: !victoryPopup.opened
            onClicked: {
                Logic.swap(index)
                if(Logic.isOrdered()) {
                    victoryPopup.open()
                }
            }
        }
    }

    Component.onCompleted: {
        Logic.reset();
    }
}
