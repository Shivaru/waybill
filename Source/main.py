from PyQt5 import QtWidgets
import Window
import traceback
import sys


def log_uncaught_exceptions(ex_cls, ex, tb):
    text = '{}: {}:\n'.format(ex_cls.__name__, ex)
    text += ''.join(traceback.format_tb(tb))
    print(text)
    QtWidgets.QMessageBox.critical(None, 'Error', text)
    sys.exit()


sys.excepthook = log_uncaught_exceptions


def main():
    app = QtWidgets.QApplication(sys.argv)  # Новый экземпляр QApplication
    window = Window.App()  # Создаём объект класса ExampleApp
    window.show()  # Показываем окно
    sys.exit(app.exec_())  # и запускаем приложение


if __name__ == '__main__':  # Если мы запускаем файл напрямую, а не импортируем
    main()  # то запускаем функцию main()
