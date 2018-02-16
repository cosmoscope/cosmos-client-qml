from PyQt5.QtCore import Qt
from PyQt5.QtCore import QAbstractListModel, QVariant, QModelIndex, pyqtProperty

from .hub import Hub, Message
from .items import TabItem


class DataItemModel(QAbstractListModel):
    def __init__(self, *args, **kwargs):
        super(DataItemModel, self).__init__(*args, **kwargs)

        from .items import DataItem
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


class PlotTabModel(QAbstractListModel):
    def __init__(self, *args, **kwargs):
        super(PlotTabModel, self).__init__(*args, **kwargs)

        self._tabs = [
            TabItem(DataItemModel(), "Tab 1"),
            TabItem(DataItemModel(), "Tab 2")
        ]

    def roleNames(self):
        return {
            Qt.UserRole + 1: b'tab'
        }

    def rowCount(self, parent=QModelIndex()):
        return len(self._tabs)

    @pyqtProperty(TabItem)
    def data(self, index, role):
        if index.isValid():
            return self._tabs[index.row()]
