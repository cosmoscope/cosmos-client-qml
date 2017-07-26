import sys
from PyQt5.QtWidgets import QApplication
from PyQt5.QtCore import QUrl
from PyQt5.QtQuick import QQuickView
from PyQt5.QtQml import QQmlApplicationEngine


if __name__ == "__main__":

    app = QApplication(sys.argv)

    # view = QQuickView()
    # view.setSource(QUrl('qml/main.qml'))
    # view.show()

    engine = QQmlApplicationEngine(parent=app)
    engine.load(QUrl('qml/main.qml'))

    sys.exit(app.exec_())