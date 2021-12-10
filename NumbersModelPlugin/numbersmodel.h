#pragma once

#include <QAbstractListModel>
#include <QList>

struct Cell
{
    int value;

    Cell(int value);
    bool isNull() const;
};

class NumbersModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit NumbersModel(QObject *parent = 0);
    ~NumbersModel();

    virtual int rowCount(const QModelIndex& parent) const;
    virtual QVariant data(const QModelIndex& index, int role) const;

    Q_INVOKABLE void shuffle();
    Q_INVOKABLE void swapWithZero(int index);
    Q_INVOKABLE bool isOrdered();

private:
    QList<Cell> m_numbers;

    bool isSolvable() const;
};
