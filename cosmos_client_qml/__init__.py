import logging
logging.basicConfig(level=logging.INFO)

import os
import sys

from PyQt5.QtCore import QUrl
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtQuick import QQuickView
from PyQt5.QtWidgets import QApplication

from .client import launch


def start(server_ip=None, client_ip=None):
    # Start the server connections
    launch(server_ip=server_ip,
           client_ip=client_ip)

    # Start the application
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine(parent=app)

    # Associate the data list model with the engine context so that it can be
    # references from the QML frontend
    from .models import DataListModel, PlotListModel

    data_list_model = DataListModel()
    plot_list_model = PlotListModel()

    engine.rootContext().setContextProperty('dataList', data_list_model)
    engine.rootContext().setContextProperty('plot_list', plot_list_model)
    engine.load(QUrl(
        os.path.abspath(os.path.join(os.path.dirname(__file__),
                                     "qml/main.qml"))))

    sys.exit(app.exec_())
