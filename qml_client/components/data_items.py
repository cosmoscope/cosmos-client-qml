import numpy as np
from PyQt5.QtCore import (QAbstractListModel, QModelIndex, QObject, Qt,
                          QVariant, pyqtProperty, pyqtSignal, pyqtSlot)
from PyQt5.QtQml import QQmlListProperty

from ..hub import Hub, Message
from .plot_data import PlotDataModel


class DataItem(QObject):
    nameChanged = pyqtSignal()
    dataChanged = pyqtSignal()
    colorChanged = pyqtSignal()
    visibilityChanged = pyqtSignal()

    def __init__(self, name, color, data=None, *args, **kwargs):
        super(DataItem, self).__init__(*args, **kwargs)

        self._data = data or [[x[0], x[1]] for x in zip(np.arange(10), np.random.sample(10))]
        self._color = color
        self._name = name
        self._visible = True

    @pyqtProperty(str, notify=nameChanged)
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value

    @pyqtProperty(list, notify=dataChanged)
    def data(self):
        return self._data

    @pyqtSlot(int, result=float)
    def x(self, index):
        return list(np.array(self.data)[:, 0])[index]

    @pyqtSlot(int, result=float)
    def y(self, index):
        return list(np.array(self.data)[:, 1])[index]

    @data.setter
    def data(self, value):
        self._data = value

    @pyqtProperty(str, notify=colorChanged)
    def color(self):
        return self._color

    @color.setter
    def color(self, value):
        self._color = value

    @pyqtProperty(bool, notify=visibilityChanged)
    def visible(self):
        return self._visible

    @visible.setter
    def visible(self, value):
        self._visible = value


class DataItemModel(QAbstractListModel):
    ItemRole = Qt.UserRole + 1

    def __init__(self, *args, **kwargs):
        super(DataItemModel, self).__init__(*args, **kwargs)

        self._items = [
            DataItem(name="My data {}".format(np.random.randint(0, 100)), color="cyan", parent=self),# model=PlotDataModel()),
            DataItem(name="My data {}".format(np.random.randint(0, 100)), color="blue", parent=self)#model=PlotDataModel())
        ]

        # The data model needs to listen for add data events
        self._hub = Hub()
        # self._hub.subscribe(AddDataMessage, self.add_data, self)
        # self._hub.subscribe(AddPlotDataMessage, self.add_data, self)

    def roleNames(self):
        return {
            self.ItemRole: b'item'
        }

    def rowCount(self, parent=QModelIndex()):
        return len(self._items)

    @pyqtSlot(int, result=DataItem)
    def at(self, index):
        return self._items[index]

    def data(self, index, role):
        if role == self.ItemRole:
            return self._items[index.row()]

        return QVariant()

    def insertRow(self, row, parent=QModelIndex()):
        self.beginInsertRows(parent, row, row + 1)
        self._items.insert(row, DataItem(name="New data item", color="black"))
        self.endInsertRows()

    def insertRows(self, row, count, parent=QModelIndex()):
        self.beginInsertRows(parent, row, row + count - 1)
        for i in count:
            self._items.insert(row + i, DataItem(name="New data item", color="black"))
        self.endInsertRows()

    @pyqtSlot(int)
    def removeRow(self, p_int, parent=QModelIndex(), *args, **kwargs):
        self.beginRemoveRows(parent, p_int, p_int)
        self._items.pop(p_int)
        self.endRemoveRows()

        return True

    def removeRows(self, p_int, p_int_1, parent=QModelIndex(), *args, **kwargs):
        self.beginRemoveRows(parent, p_int, p_int_1)
        del self._items[p_int:p_int_1 + 1]
        self.endRemoveRows()

        return True

    def setData(self, index, value, *args, **kwargs):
        # if not index.isValid():
        #     return False

        if not 0 <= index.row() < self.rowCount():
            self._items.append(value)
        else:
            self._items[index.row()] = value

        return True
