from PyQt5.QtCore import Qt
from PyQt5.QtCore import (QObject, pyqtProperty, pyqtSignal,
                          QAbstractListModel, QVariant, QModelIndex,
                          pyqtProperty, pyqtSlot)

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
        elif role == self.TabRole:
            return self._tabs[index.row()]

        return QVariant()

    @pyqtSlot(int)
    def removeRow(self, p_int, parent=QModelIndex(), *args, **kwargs):
        self.beginRemoveRows(parent, p_int, p_int)
        self._tabs.pop(p_int)
        self.endRemoveRows()
        
        return True

    def setData(self, index, value, *args, **kwargs):
        if not index.isValid():
            return False

        if not 0 <= index.row() < self.rowCount():
            self._tabs.append(value)
        else:
            self._tabs[index.row()] = value

        return True
