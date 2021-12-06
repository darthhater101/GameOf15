#pragma once

#include <cmath>
#include <algorithm>

#include <QDebug>
#include <QAbstractListModel>
#include <QList>


class NumbersModel : public QAbstractListModel
{
    Q_OBJECT
private:
    QList<int> numbers;
    int zeroCellIndex;

public:
    explicit NumbersModel(QObject *parent = 0);
    ~NumbersModel();

    virtual int rowCount(const QModelIndex& parent) const;
    virtual QVariant data(const QModelIndex& index, int role) const;

    Q_INVOKABLE void shuffle();
    Q_INVOKABLE void swapWithZero(int index);
    Q_INVOKABLE bool isSolvable();
    Q_INVOKABLE bool isOrdered();
};
