function shuffle() {
    var random = (min, max) => {
        return Math.floor(Math.random() * (max - min)) + min;
    }

    for(var i = 0; i < numbersModel.count; i++) {
        var randIndex = random(i, numbersModel.count);
        var buff = numbersModel.get(i).number;
        numbersModel.get(i).number = numbersModel.get(randIndex).number;
        numbersModel.get(randIndex).number = buff;
        if(numbersModel.get(i).number === 0) {
            view.zeroCellIndex = i;
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
    do {
        shuffle();
    } while (!isSolvable())
}
