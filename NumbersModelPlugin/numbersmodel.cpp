#include "numbersmodel.h"

#include <cmath>
#include <algorithm>
#include <iostream>

Cell::Cell(int val) : value(val)
{

}

bool Cell::isNull() const
{
    return !value;
}

NumbersModel::NumbersModel(QObject *parent) : QAbstractListModel(parent)
{
    numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0};

    do
    {
        shuffle();
    } while(!isSolvable());
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
        return numbers[row].value;
    }

    return QVariant();
}

void NumbersModel::shuffle()
{
    for(int i = 0; i < numbers.size(); i++)
    {
        int randIndex = i + (rand() % (numbers.size() - i));
        std::swap(numbers[i], numbers[randIndex]);
    }

    emit dataChanged(createIndex(0, 0), createIndex(15, 0));
}

void NumbersModel::swapWithZero(int idx)
{
    int zeroCellIndex = 0;

    for(int i = 0; i < numbers.size(); i++)
    {
        if(numbers[i].isNull())
        {
            zeroCellIndex = i;
        }
    }

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
    }
}

bool NumbersModel::isSolvable()
{
    int zeroCellRow = 4;
    int N = 0;
    for(int i = 0; i < numbers.size() - 1; i++)
    {
        if(numbers[i].isNull())
        {
            zeroCellRow = std::floor(i / 4) + 1;
        }
        for(int j = i + 1; j < numbers.size(); j++)
        {
            if(numbers[i].value > numbers[j].value && !numbers[i].isNull() && !numbers[j].isNull())
            {
                N++;
            }
        }
    }

    return !((N + zeroCellRow) & 1);
}

bool NumbersModel::isOrdered()
{
    if(!numbers[0].isNull())
    {
        return std::is_sorted(numbers.begin(), numbers.end() - 1, [](const Cell& left, const Cell& right){
            return left.value < right.value;
        });
    }
    return false;
}
