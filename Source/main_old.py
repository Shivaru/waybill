from PyQt5 import QtWidgets
import Window

def main():
    # cars_data = ['car','driver']
    # dat1 = dict.fromkeys(cars_data)
    app = QtWidgets.QApplication(sys.argv)  # Новый экземпляр QApplication
    window = Window.App()  # Создаём объект класса ExampleApp
    window.show()  # Показываем окно
    app.exec_()  # и запускаем приложение


if __name__ == '__main__':  # Если мы запускаем файл напрямую, а не импортируем
    main()  # то запускаем функцию main()

# TODO Нужно запихать способ обновления программы при внесении правок,
#  можно прописать в ней проверку изменений на гитхаб и автоматическую перезапись экзешника
