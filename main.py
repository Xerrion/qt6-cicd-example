import sys

from PySide6.QtCore import Qt

from PySide6.QtWidgets import QApplication, QMainWindow, QLabel

class MainWindow(QMainWindow):
    def __init__(self) -> None:
        super().__init__()

        self.setWindowTitle("Hello World")
        self.hello_label = QLabel("Hello World", self)


app = QApplication(sys.argv)
window = MainWindow()
window.show()
sys.exit(app.exec())
