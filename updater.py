import requests
import sys  # sys нужен для передачи argv в QApplication
from PyQt5 import QtWidgets
import update  # Это наш конвертированный файл дизайна
import os


def update():
        urls = ['https://raw.github.com/Shivaru/waybill/master/README.md',
                'https://raw.github.com/Shivaru/waybill/master/design.py',
                'https://raw.github.com/Shivaru/waybill/master/Excel.py',
                'https://raw.github.com/Shivaru/waybill/master/GetDataWialon.py',
                'https://raw.github.com/Shivaru/waybill/master/Window.py',
                # 'https://raw.github.com/Shivaru/waybill/master/GA4-C.xls',
                # 'https://raw.github.com/Shivaru/waybill/master/LA.xls',
                'https://raw.github.com/Shivaru/waybill/master/updater.py',
                'https://raw.github.com/Shivaru/waybill/master/main.py',
                'https://raw.github.com/Shivaru/waybill/master/version.txt']

        r = requests.get(urls[-1])
        versgit = r.text

        path = os.getcwd()
        verspath = path + "\\version.txt"
        versfile = open(verspath,'r')
        version = (versfile.read())

        print(versgit, version)

        if versgit == version:
                print("Versii sovpadaut")
                return "Обновлений нет"
        else:
                print("Versii nesovpadaut")
                for link in urls:
                        lcnt = requests.get(link)
                        name = link.split("/")
                        print(name[-1])
                        # with open(name, "wb") as code:
                        #      code.write(r.content)
                return "Программа обновлена"