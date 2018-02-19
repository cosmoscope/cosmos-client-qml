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
