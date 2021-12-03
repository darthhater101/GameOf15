import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import NumbersModelInterface 1.0

Window {
    width: 700
    height: width
    visible: true
    title: qsTr("Puzzle 15")

    VictoryPopup {
        id: victoryPopup
    }

    Button {
        id: shuffleButton
        text: "Shuffle"
        onClicked: numbersModel.shuffle()
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
        model: NumbersModel2 { id: numbersModel }
        delegate: Cell {
            width: view.cellWidth
            height: view.cellHeight
            visible: !(model.display === 0)
            enabled: !victoryPopup.opened
            onClicked: {
                numbersModel.swapWithZero(index)
                if(numbersModel.isOrdered()) {
                    //victoryPopup.open()
                }
            }
        }
    }

    Component.onCompleted: {
//        do {
//            numbersModel.shuffle();
//        } while(numbersModel.isSolvable());
    }
}
