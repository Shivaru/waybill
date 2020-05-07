import sys  # sys нужен для передачи argv в QApplication
from PyQt5 import QtWidgets
import design  # Это наш конвертированный файл дизайна
import os
import GetDataWialon
import datetime
import Excel


# TODO Fix autosize window

class App(QtWidgets.QMainWindow, design.Ui_Dialog):
    def __init__(self):
        # Это здесь нужно для доступа к переменным, методам
        # и т.д. в файле design.py
        super().__init__()
        self.setupUi(self)  # Это нужно для инициализации нашего дизайна
        self.pB_accept.clicked.connect(self.browse_folder)
        self.pB_download.clicked.connect(self.out_to_list)
        self.listWidget.itemDoubleClicked.connect(self.put_selected)
        self.pB_print.clicked.connect(self.out_to_excel)

    def browse_folder(self):
        self.listWidget.clear()  # На случай, если в списке уже есть элементы
        directory = QtWidgets.QFileDialog.getExistingDirectory(self, "Выберите папку")
        # открыть диалог выбора директории и установить значение переменной
        # равной пути к выбранной директории

        if directory:  # не продолжать выполнение, если пользователь не выбрал директорию
            for file_name in os.listdir(directory):  # для каждого файла в директории
                self.listWidget.addItem(file_name)  # добавить файл в listWidget


    cars = 0
    drivers = 0

    def out_to_list(self):
        self.listWidget.clear()
        date = self.dateTo.dateTime().toString('dd-MM-yyyy')

        # TODO дату передать в метод гет карс
        # TODO сюда приплести значение галочки если галоча такая то дата такая
        global cars, drivers
        cars = GetDataWialon.get_cars()
        drivers = GetDataWialon.get_drivers()
        # for item in cars :
        #     self.listWidget.addItem(item)
        for i in cars['items']:
            self.listWidget.addItem(i['nm'])

    def put_selected(self):
        items = self.listWidget.selectedItems()
        str1 = items[0].text()
        self.label_4.setText(str1)
        self.label_4.adjustSize()

    data = 0

    def out_to_excel(self):
        datefrom = self.dateFrom.dateTime().toString('dd-MM-yyyy')
        dateto = self.dateTo.dateTime().toString('dd-MM-yyyy')
        print(datefrom, dateto)
        items = self.listWidget.selectedItems()
        caridname = items[0].text()
        for i in cars['items']:
            name = i['nm']
            if name == caridname:
                carid = i['id']
                print(name, " FOUNDED ", caridname, carid)
                car = str(carid)
                print(car)
            else:
                carid = 0
        global data
        data = GetDataWialon.get_data_cars(car,datefrom,dateto)
        try:
            Excel.add_date_tofile(data)
        except TypeError as e:
            #print("НЕТ ДАННЫХ НА ТЕКУЩУЮ ДАТУ", e)
            errormes = "Нет данных по машине на выбранные даты " + datefrom + " " + dateto
            QtWidgets.QMessageBox.critical(self, "Ошибка ", errormes, QtWidgets.QMessageBox.Ok)
            #return
        except FileNotFoundError as e:
            errormes = "Файл для открытия ненайден "
            QtWidgets.QMessageBox.critical(self, "Ошибка ", errormes, QtWidgets.QMessageBox.Ok)
        #Excel.save_file(data)


        ############ Заполнение эксель файла

        ############ Запуск эксель файла


