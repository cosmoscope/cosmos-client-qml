from PyQt5.QtCore import QObject, pyqtProperty, pyqtSignal

from .models import DataItemModel


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