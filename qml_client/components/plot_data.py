import numpy as np
from PyQt5.QtCore import (QAbstractTableModel, QModelIndex, QObject, Qt,
                          QVariant, pyqtProperty, pyqtSignal, pyqtSlot)

from ..hub import Hub, Message


class PlotDataModel(QAbstractTableModel):
    # DataRole = Qt.UserRole + 1

    def __init__(self, *args, **kwargs):
        super(PlotDataModel, self).__init__(*args, **kwargs)

        self._data = list(zip(np.arange(10), np.random.sample(10)))

        # The data model needs to listen for add data events
        self._hub = Hub()
        # self._hub.subscribe(AddDataMessage, self.add_data, self)
        # self._hub.subscribe(AddPlotDataMessage, self.add_data, self)

    # def roleNames(self):
    #     return {
    #         self.DataRole: b'data'
    #     }

    def rowCount(self, parent=None, *args, **kwargs):
        return len(self._data)

    def columnCount(self, parent=None, *args, **kwargs):
        return 2

    def data(self, index, role=None):
        print("Trying...", index.row(), index.column(), self._data[index.row()][index.column()], role)
        return self._data[index.row()][index.column()]
        # if role == self.DataRole:
        #     return self._data[index.row()]
        if role == Qt.DisplayRole:
            return self._data[index.row()][index.column()]
        elif role == Qt.EditRole:
            return self._data[index.row()][index.column()]

        return QVariant()

    # def insertRow(self, p_int, parent=None, *args, **kwargs):
    #     self.beginInsertRows(parent, p_int, p_int + 1)
    #     self._data.insert(p_int, 0)
    #     self.endInsertRows()

    # def insertRows(self, p_int, p_int_1, parent=None, *args, **kwargs):
    #     self.beginInsertRows(parent, p_int, p_int + p_int_1 - 1)
    #     for i in p_int_1:
    #         self._data.insert(p_int + i, 0)
    #     self.endInsertRows()

    # @pyqtSlot(int)
    # def removeRow(self, p_int, parent=QModelIndex(), *args, **kwargs):
    #     self.beginRemoveRows(parent, p_int, p_int)
    #     self._data.pop(p_int)
    #     self.endRemoveRows()

    #     return True

    # def removeRows(self, p_int, p_int_1, parent=QModelIndex(), *args, **kwargs):
    #     self.beginRemoveRows(parent, p_int, p_int_1)
    #     del self._data[p_int:p_int_1 + 1]
    #     self.endRemoveRows()

        # return True

    # def setData(self, index, value, *args, **kwargs):
    #     # if not index.isValid():
    #     #     return False

    #     if not 0 <= index.row() < self.rowCount():
    #         self._data.append(value)
    #     else:
    #         self._data[index.row()] = value

    #     return True
