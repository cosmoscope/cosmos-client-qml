import logging
logging.basicConfig(level=logging.INFO)

import os
import sys
import numpy as np

from PyQt5.QtCore import QUrl
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtQuick import QQuickView
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import qmlRegisterType

from .client import launch

from .hub import HubProxy
from .components.data_items import DataItemModel, DataItem
from .components.plot_tabs import TabItemModel


def start(server_ip=None, client_ip=None):
    # Start the server connections
    launch(server_ip=server_ip,
           client_ip=client_ip)

    # Start the application
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine(parent=app)

    rc = engine.rootContext()

    hub_proxy = HubProxy()
    tab_item_model = TabItemModel()

    rc.setContextProperty('hubProxy', hub_proxy)
    rc.setContextProperty('plotTabModel', tab_item_model)

    engine.load(QUrl(
        os.path.abspath(os.path.join(os.path.dirname(__file__),
                                     "qml/main.qml"))))

    sys.exit(app.exec_())
