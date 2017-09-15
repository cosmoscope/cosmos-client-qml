from PyQt5.QtCore import Qt
from PyQt5.QtCore import QAbstractListModel, QVariant, QModelIndex

from .hub import Hub, AddDataMessage

import qtawesome as qta


class DataListModel(QAbstractListModel):
    def __init__(self, *args, **kwargs):
        super(DataListModel, self).__init__(*args, **kwargs)

        self._data = [
            {'name': "Test Object 1"},
            {'name': "Test Object 2"},
            {'name': "Test Object 3"},
            {'name': "Test Object 4"},
            {'name': "Test Object 5"},
            {'name': "Test Object 6"}
        ]

        # The data model needs to listen for add data events
        self._hub = Hub()
        self._hub.subscribe(AddDataMessage, self.add_data, self)

    def add_data(self, data, row=None, parent=QModelIndex()):
        self.beginInsertRows(parent, row or self.rowCount(), 1)

        self._data.append(data)

        self.endInsertRows()

    def removeRow(self, p_int, parent=QModelIndex(), *args, **kwargs):
        self.beginRemoveRows(parent, p_int, p_int)

        self._data.pop(p_int)

        self.endRemoveRows()

    def removeRows(self, p_int, p_int_1, parent=QModelIndex(), *args, **kwargs):
        self.beginRemoveRows(parent, p_int, p_int_1)

        del self._data[p_int:p_int_1 + 1]

        self.endRemoveRows()

    def rowCount(self, parent=QModelIndex(), *args, **kwargs):
        return len(self._data)

    def data(self, index, role=Qt.DisplayRole):
        if not index.isValid() or not 0 <= index.row() < self.rowCount():
            return QVariant()

        row = index.row()

        if role == Qt.DisplayRole:
            return str(self._data[row]['name'])
        elif role == Qt.UserRole:
            return self._data[row]
        elif role == Qt.DecorationRole:
            icon = qta.icon('fa.circle',
                            active='fa.circle-o',
                            color='blue',
                            color_active='orange')
            return icon

        return QVariant()

    def setData(self, index, value, *args, **kwargs):
        if not index.isValid():
            return False

        if not 0 <= index.row() < self.rowCount():
            self._data.append(value)
        else:
            self._data[index.row()] = value

        return True



class PlotListModel(QAbstractListModel):
    def __init__(self, *args, **kwargs):
        super(PlotListModel, self).__init__(*args, **kwargs)

        self._plots = [
            {'name': "Test Object 1"},
            {'name': "Test Object 2"},
            {'name': "Test Object 3"},
            {'name': "Test Object 4"},
            {'name': "Test Object 5"},
            {'name': "Test Object 6"}
        ]

        # The data model needs to listen for add data events
        self._hub = Hub()
        # self._hub.subscribe(AddDataMessage, self.add_data, self)

    def add_data(self, data, row=None, parent=QModelIndex()):
        self.beginInsertRows(parent, row or self.rowCount(), 1)

        self._plots.append(data)

        self.endInsertRows()

    def removeRow(self, p_int, parent=QModelIndex(), *args, **kwargs):
        self.beginRemoveRows(parent, p_int, p_int)

        self._plots.pop(p_int)

        self.endRemoveRows()

    def removeRows(self, p_int, p_int_1, parent=QModelIndex(), *args, **kwargs):
        self.beginRemoveRows(parent, p_int, p_int_1)

        del self._plots[p_int:p_int_1 + 1]

        self.endRemoveRows()

    def rowCount(self, parent=QModelIndex(), *args, **kwargs):
        return len(self._plots)

    def data(self, index, role=Qt.DisplayRole):
        if not index.isValid() or not 0 <= index.row() < self.rowCount():
            return QVariant()

        row = index.row()

        if role == Qt.DisplayRole:
            return str(self._plots[row]['name'])
        elif role == Qt.UserRole:
            return self._plots[row]

        return QVariant()

    def setData(self, index, value, *args, **kwargs):
        if not index.isValid():
            return False

        if not 0 <= index.row() < self.rowCount():
            self._plots.append(value)
        else:
            self._plots[index.row()] = value

        return True