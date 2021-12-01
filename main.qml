import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    width: 600
    height: width
    visible: true
    title: qsTr("Puzzle 15")

    Popup {
        id: victoryPopup
        width: 200
        height: 150

        anchors.centerIn: parent

        Text {
            id: winText
            anchors.centerIn: parent
            text: "You win!"
        }

        Button {
            id: restartButton
            anchors.top: winText.bottom
            anchors.left: parent.left
            text: "Restart"
            onClicked: {
                reset();
                victoryPopup.visible = false
            }
        }

        Button {
            id: closeButton
            anchors.top: winText.bottom
            anchors.left: restartButton.right
            text: "Close"
            onClicked: {
                close();
            }
        }

        onOpened: view.interactive = false
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    }

    ListModel {
        id: numbersModel

        ListElement { number: 1 }
        ListElement { number: 2 }
        ListElement { number: 3 }
        ListElement { number: 4 }
        ListElement { number: 5 }
        ListElement { number: 6 }
        ListElement { number: 7 }
        ListElement { number: 8 }
        ListElement { number: 9 }
        ListElement { number: 10 }
        ListElement { number: 11 }
        ListElement { number: 12 }
        ListElement { number: 13 }
        ListElement { number: 14 }
        ListElement { number: 15 }
        ListElement { number: 0 }
    }

    GridView {
        id: view
        anchors.fill: parent
        model: numbersModel
        cellWidth: parent.width / 4
        cellHeight: parent.height / 4
        property int zeroCellIndex: 15
        interactive: false
        enabled: !victoryPopup.opened
        delegate: cellDelegate

        move: Transition {
            id: anim
            NumberAnimation {
                properties: "x, y"; duration: 400;
            }
        }

    }

    function shuffle() {
        var random = (min, max) => {
            return Math.floor(Math.random() * (max - min)) + min;
        }

        for(var i = 0; i < numbersModel.count - 1; i++) {
            var randIndex = random(i, numbersModel.count);
            numbersModel.move(i, randIndex, 1)
            //swap(i, randIndex)
        }
        for(i = 0; i < numbersModel.count; i++) {
            if(numbersModel.get(i).number === 0) {
                view.zeroCellIndex = i;
                break;
            }
        }
    }

    function swap(i, j = view.zeroCellIndex) {

        if((Math.abs(i - j) == 1 && Math.floor(i / 4) == Math.floor(j / 4))
                || Math.abs(i - j) == 4)
        {

            var min = Math.min(i, j);
            var max = Math.max(i, j);
            numbersModel.move(min, max, 1)
            numbersModel.move(max - 1, min, 1)
            view.zeroCellIndex = i;
        }
    }

    function isSolvable() {
        var zeroCellRow = 0;
        for(var i = 0; i < numbersModel.count; i++) {
            if(numbersModel.get(i).number === 0) {
                zeroCellRow = Math.floor(i / 4) + 1;
                break;
            }
        }

        var N = 0;
        for(i = 0; i < numbersModel.count - 1; i++) {
            for(var j = i + 1; j < numbersModel.count; j++) {
                var iNumber = numbersModel.get(i).number;
                var jNumber = numbersModel.get(j).number;
                if(iNumber > jNumber && jNumber && iNumber) {
                    N++;
                }
            }
        }
        return !((N + zeroCellRow) & 1)
    }

    function isOrdered() {
        for(var i = 0; i < numbersModel.count - 2; i++) {
            if(numbersModel.get(i).number > numbersModel.get(i + 1).number) {
                return false;
            }
        }
        return true;
    }

    function reset() {
        shuffle();
        while(!isSolvable()) {
            shuffle();
        }
    }

    Component {
        id: cellDelegate

        Item {
            visible: !(model.number === 0)
            width: view.cellWidth
            height: view.cellHeight

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
                    anchors.fill: parent
                    onClicked: {
                        swap(index)
                        if(isOrdered()) {
                            victoryPopup.open()
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        anim.enabled = false;
        reset();
        anim.enabled = true;
    }
}
