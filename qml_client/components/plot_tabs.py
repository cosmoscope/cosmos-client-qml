from PyQt5.QtCore import Qt
from PyQt5.QtCore import (QObject, pyqtProperty, pyqtSignal,
                          QAbstractListModel, QVariant, QModelIndex,
                          pyqtProperty)

from ..hub import Hub, Message

from .data_items import DataItemModel


class TabItem(QObject):
    data_item_model_changed = pyqtSignal()
    name_changed = pyqtSignal()

    def __init__(self, data_item_model, name, *args, **kwargs):
        super(TabItem, self).__init__(*args, **kwargs)

        self._name = name
        self._data_item_model = data_item_model

    @pyqtProperty(DataItemModel, notify=data_item_model_changed)
    def data_item_model(self):
        return self._data_item_model

    @data_item_model.setter
    def data_item_model(self, value):
        self._data_item_model = value

    @pyqtProperty(str, notify=name_changed)
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value


class TabItemModel(QAbstractListModel):
    TabRole = Qt.UserRole + 1

    def __init__(self, *args, **kwargs):
        super(TabItemModel, self).__init__(*args, **kwargs)

        self._tabs = [
            TabItem(DataItemModel(), "Tab 1"),
            TabItem(DataItemModel(), "Tab 2"),
            TabItem(DataItemModel(), "Tab 3")
        ]

    def roleNames(self):
        return {
            self.TabRole: b'tab'
        }

    def rowCount(self, parent=QModelIndex()):
        return len(self._tabs)

    def data(self, index, role=Qt.DisplayRole):
        if role == Qt.DisplayRole:
            pass
        return self._tabs[index.row()]
