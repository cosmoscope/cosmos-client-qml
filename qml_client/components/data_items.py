from PyQt5.QtCore import Qt
from PyQt5.QtCore import (QObject, pyqtProperty, pyqtSignal,
                          QAbstractListModel, QVariant, QModelIndex,
                          pyqtProperty)

from ..hub import Hub, Message


class DataItem(QObject):
    name_changed = pyqtSignal()
    data_changed = pyqtSignal()
    color_changed = pyqtSignal()

    def __init__(self, data, name, color, *args, **kwargs):
        super(DataItem, self).__init__(*args, **kwargs)

        self._data = data
        self._color = color
        self._name = name

    @pyqtProperty(str, notify=name_changed)
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value

    @pyqtProperty(list, notify=data_changed)
    def data(self):
        return self._data

    @data.setter
    def data(self, value):
        self._data = value

    @pyqtProperty(str, notify=color_changed)
    def color(self):
        return self._color

    @color.setter
    def color(self, value):
        self._color = value


class DataItemModel(QAbstractListModel):
    def __init__(self, *args, **kwargs):
        super(DataItemModel, self).__init__(*args, **kwargs)

        import numpy as np

        self._items = [
            DataItem(name="My data 1", color="cyan", data=list(zip(np.arange(10), np.random.sample(10)))),
            DataItem(name="My data 2", color="blue", data=list(zip(np.arange(10), np.random.sample(10))))
        ]

        # Cache a reference to the currently selected item in the model
        self._current_item = self._items[0]

        # The data model needs to listen for add data events
        self._hub = Hub()
        # self._hub.subscribe(AddDataMessage, self.add_data, self)
        # self._hub.subscribe(AddPlotDataMessage, self.add_data, self)

    def roleNames(self):
        return {
            Qt.UserRole + 1: b'item'
        }

    def rowCount(self, parent=QModelIndex()):
        return len(self._items)

    def data(self, index, role):
        if index.isValid():
            return self._items[index.row()]