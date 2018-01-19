from PyQt5.QtCore import Qt
from PyQt5.QtCore import QAbstractListModel, QVariant, QModelIndex

from .hub import Hub, AddDataMessage, NewPlotMessage, AddPlotDataMessage


class BaseListModel(QAbstractListModel):
    def __init__(self, *args, **kwargs):
        super(BaseListModel, self).__init__(*args, **kwargs)

        self._items = []

    def appendRow(self, item, parent=QModelIndex(), first=None, last=1):
        self.beginInsertRows(parent, first or self.rowCount(), last)

        self._items.append(item)

        self.endInsertRows()

    def removeRow(self, p_int, parent=QModelIndex(), *args, **kwargs):
        self.beginRemoveRows(parent, p_int, p_int)

        self._items.pop(p_int)

        self.endRemoveRows()

    def removeRows(self, p_int, p_int_1, parent=QModelIndex(), *args, **kwargs):
        self.beginRemoveRows(parent, p_int, p_int_1)

        del self._items[p_int:p_int_1 + 1]

        self.endRemoveRows()

    def rowCount(self, parent=QModelIndex(), *args, **kwargs):
        return len(self._items)

    def setData(self, index, value, *args, **kwargs):
        if not index.isValid():
            return False

        if not 0 <= index.row() < self.rowCount():
            self._items.append(value)
        else:
            self._items[index.row()] = value

        return True

    def data(self, index, role=Qt.DisplayRole):
        if not index.isValid() or not 0 <= index.row() < self.rowCount():
            return QVariant()

        row = index.row()

        return self._items[row][str(self.roleNames()[role], 'utf-8')]


class TabListModel(BaseListModel):
    def __init__(self, *args, **kwargs):
        super(TabListModel, self).__init__(*args, **kwargs)

        # The data model needs to listen for add data events
        self._hub = Hub()

    def roleNames(self):
        return {
            Qt.UserRole + 1: b'name',
            Qt.UserRole + 2: b'value',
            Qt.UserRole + 4: b'style'
        }

    def add_data(self, data, row=None, parent=QModelIndex()):
        self.beginInsertRows(parent, row or self.rowCount(), 1)

        data_list_model = DataListModel()
        data_list_model.add_data(data)

        self._items.append(data_list_model)

        self.endInsertRows()


class DataListModel(BaseListModel):
    def __init__(self, *args, **kwargs):
        super(DataListModel, self).__init__(*args, **kwargs)

        # The data model needs to listen for add data events
        self._hub = Hub()
        self._hub.subscribe(AddDataMessage, self.add_data, self)
        self._hub.subscribe(AddPlotDataMessage, self.add_data, self)

    def roleNames(self):
        return {
            Qt.UserRole + 1: b'name',
            Qt.UserRole + 2: b'value',
            Qt.UserRole + 3: b'units',
            Qt.UserRole + 4: b'style'
        }

    def add_data(self, data, row=None, parent=QModelIndex()):
        self.beginInsertRows(parent, row or self.rowCount(), 1)

        self._items.append(data)

        self.endInsertRows()
