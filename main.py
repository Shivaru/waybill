from PyQt5 import QtWidgets
import Window
import traceback
import sys
import updater


def log_uncaught_exceptions(ex_cls, ex, tb):
    text = '{}: {}:\n'.format(ex_cls.__name__, ex)

    text += ''.join(traceback.format_tb(tb))

    print(text)
    QtWidgets.QMessageBox.critical(None, 'Error', text)

    sys.exit()


sys.excepthook = log_uncaught_exceptions


def main():
    app = QtWidgets.QApplication(sys.argv)  # Новый экземпляр QApplication

    # updatewindow = updater.App()
    # updatewindow.show()
    # updater.update()
    # app = QtWidgets.QApplication(sys.argv)  # Новый экземпляр QApplication
    window = Window.App()  # Создаём объект класса ExampleApp
    window.show()  # Показываем окно
    sys.exit(app.exec_())  # и запускаем приложение


if __name__ == '__main__':  # Если мы запускаем файл напрямую, а не импортируем
    main()  # то запускаем функцию main()

# TODO Нужно запихать способ обновления программы при внесении правок,
#  можно прописать в ней проверку изменений на гитхаб и автоматическую перезапись экзешника
# python -m PyQt5.uic.pyuic -x .\update.ui -o update.py

# TODO Прописать стандартные пути с файлами в юзерс док предварительно скопировав шаблоны
# TODO Написать способ обновления файлов через гитхаб
