#include "numbersmodel.h"

NumbersModel::NumbersModel(QObject *parent) : QAbstractListModel(parent)
{
    numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0};
    zeroCellIndex = 15;
}

NumbersModel::~NumbersModel()
{

}

int NumbersModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return numbers.count();
}

QVariant NumbersModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();

    if(row < 0 || row >= numbers.count())
    {
        return QVariant();
    }

    switch (role)
    {
    case Qt::DisplayRole:
        return numbers[row];
    }

    return QVariant();
}

void NumbersModel::shuffle()
{
    for(int i = 0; i < numbers.size(); i++)
    {
        int randIndex = i + (rand() % (numbers.size() - i));
        int buff = numbers[i];
        numbers[i] = numbers[randIndex];
        numbers[randIndex] = buff;
        if(numbers[i] == 0)
        {
            zeroCellIndex = i;
        }
    }

    emit dataChanged(createIndex(0, 0), createIndex(15, 0));
}

void NumbersModel::swapWithZero(int idx)
{
    if((std::abs(idx - zeroCellIndex) == 1 && std::floor(idx / 4) == std::floor(zeroCellIndex / 4))
            || std::abs(idx - zeroCellIndex) == 4)
    {
        int min = std::min(idx, zeroCellIndex);
        int max = std::max(idx, zeroCellIndex);

        if(beginMoveRows(QModelIndex(), max, max, QModelIndex(), min))
        {
            numbers.move(max, min);
            endMoveRows();
        }
        if(beginMoveRows(QModelIndex(), min + 1, min + 1, QModelIndex(), max))
        {
            numbers.move(min + 1, max);
            endMoveRows();
        }

        zeroCellIndex = idx;

        emit dataChanged(createIndex(min, 0), createIndex(max, 0));
    }
}

bool NumbersModel::isSolvable()
{
    int zeroCellRow = 0;
    for(int i = 0; i < numbers.size(); i++)
    {
        if(numbers[i] == 0)
        {
            zeroCellRow = std::floor(i / 4) + 1;
            break;
        }
    }

    int N = 0;
    for(int i = 0; i < numbers.size() - 1; i++)
    {
        for(int j = i + 1; j < numbers.size(); j++)
        {
            if(numbers[i] > numbers[j] && numbers[i] && numbers[j])
            {
                N++;
            }
        }
    }

    return !((N + zeroCellRow) & 1);
}

bool NumbersModel::isOrdered()
{
    for(int i = 0; i < numbers.size() - 2; i++)
    {
        if(numbers[i] > numbers[i + 1])
        {
            return false;
        }
    }
    return true;
}
