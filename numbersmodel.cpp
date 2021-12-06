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

        if(beginMoveRows(QModelIndex(), min, min, QModelIndex(), max + 1))
        {
            numbers.move(min, max);
            endMoveRows();
        }
        if(beginMoveRows(QModelIndex(), max - 1, max - 1, QModelIndex(), min))
        {
            numbers.move(max - 1, min);
            endMoveRows();
        }

        zeroCellIndex = idx;
    }
}

bool NumbersModel::isSolvable()
{
    int zeroCellRow = 4;
    int N = 0;
    for(int i = 0; i < numbers.size() - 1; i++)
    {
        if(numbers[i] == 0)
        {
            zeroCellRow = std::floor(i / 4) + 1;
        }
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
    return std::is_sorted(numbers.begin(), numbers.end() - 1);
}
