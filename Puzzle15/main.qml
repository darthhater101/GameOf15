import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import NumbersModelPlugin 1.0

Window {
    id: root
    width: 700
    height: width
    visible: true
    title: qsTr("Puzzle 15")
    color: "#400080"

    VictoryPopup {
        id: victoryPopup
    }

    CustomButton {
        id: shuffleButton
        customText: "Shuffle"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 200
        anchors.right: parent.right
        anchors.rightMargin: 200
        onClicked: numbersModel.shuffle()
    }

    Board {
        id: view
        anchors.top: parent.top
        anchors.topMargin: 25
        anchors.bottom: shuffleButton.top
        anchors.bottomMargin: 25
        anchors.right: parent.right
        anchors.rightMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 25
        model: NumbersModel { id: numbersModel }
        delegate: Cell {
            width: view.cellWidth
            height: view.cellHeight
            visible: !(model.display === 0)
            enabled: !victoryPopup.opened
            onClicked: {
                numbersModel.swapWithZero(index)
                if(numbersModel.isOrdered()) {
                    victoryPopup.open()
                }
            }
        }
    }
}
