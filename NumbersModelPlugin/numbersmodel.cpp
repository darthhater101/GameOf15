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
    m_numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0};
    shuffle();
}

NumbersModel::~NumbersModel()
{

}

int NumbersModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_numbers.count();
}

QVariant NumbersModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();

    if(row < 0 || row >= m_numbers.count())
    {
        return QVariant();
    }

    switch (role)
    {
    case Qt::DisplayRole:
        return m_numbers[row].value;
    }

    return QVariant();
}

void NumbersModel::shuffle()
{
    do
    {
        for(int i = 0; i < m_numbers.size(); i++)
        {
            int randIndex = i + (rand() % (m_numbers.size() - i));
            std::swap(m_numbers[i], m_numbers[randIndex]);
        }
    } while(!isSolvable());

    emit dataChanged(createIndex(0, 0), createIndex(15, 0));
}

void NumbersModel::swapWithZero(int idx)
{
    int zeroCellIndex = 0;

    for(int i = 0; i < m_numbers.size(); i++)
    {
        if(m_numbers[i].isNull())
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
            m_numbers.move(min, max);
            endMoveRows();
        }
        if(beginMoveRows(QModelIndex(), max - 1, max - 1, QModelIndex(), min))
        {
            m_numbers.move(max - 1, min);
            endMoveRows();
        }
    }
}

bool NumbersModel::isSolvable() const
{
    int zeroCellRow = 4;
    int N = 0;
    for(int i = 0; i < m_numbers.size() - 1; i++)
    {
        if(m_numbers[i].isNull())
        {
            zeroCellRow = std::floor(i / 4) + 1;
        }
        for(int j = i + 1; j < m_numbers.size(); j++)
        {
            if(m_numbers[i].value > m_numbers[j].value && !m_numbers[i].isNull() && !m_numbers[j].isNull())
            {
                N++;
            }
        }
    }

    return !((N + zeroCellRow) & 1);
}

bool NumbersModel::isOrdered()
{
    if(!m_numbers[0].isNull())
    {
        return std::is_sorted(m_numbers.begin(), m_numbers.end() - 1, [](const Cell& left, const Cell& right){
            return left.value < right.value;
        });
    }
    return false;
}
