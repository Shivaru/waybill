import win32com.client
import os
import GetDataWialon


filenamebig = "\GA4-C.xls"
filenamesmall = "\LA.xls"
#path = os.getcwd()
path = "c:\Program Files\waybill"
filepathbig = path+filenamebig
filepathsmall = path+filenamesmall


Excel = win32com.client.Dispatch("Excel.Application")


def open_file(filepath):
    Excel.DisplayAlerts = 0
    return Excel.Workbooks.Open(filepath)


def close_file(exemp):
    # закрываем ее
    exemp.Close()
    # закрываем COM объект
    Excel.Quit()


def save_file(exemp,date,carname):
    # сохраняем рабочую книгу
    fp = path + "\\" + date + "_" + carname + ".xls"
    filepathsave = str(fp)
    #print("Сохраняем файл",filepathsave)
    exemp.SaveAs(filepathsave)


def start_file(date,carname):
    fp = path + "\\" + date + "_" + carname + ".xls"
    filepathopen = str(fp)
    os.startfile(filepathopen)


# TODO Нужно написать инструкции для каждого поля и в конце сохранить и открыть файл для просмотра
# TODO Еще нужно учесть лист на котором производятся изменения


def add_date_tofile(dataset):
    wb = open_file(filepathbig)
    sheet = wb.ActiveSheet
    sheet2 = wb.Worksheets(u'стр2')

    #### Выбор таблиц данных

    reportstats = dataset[0]['reportResult']['stats']
    reportstatsdict = dict(reportstats)
    reportstops = dataset[0]['reportResult']['tables'][0]['total']
    reporttrips = dataset[0]['reportResult']['tables'][1]['total']
    reportstays = dataset[0]['reportResult']['tables'][2]['total']

    stops = dataset[1]
    trips = dataset[3]
    stays = dataset[3]

    #### Выбор переменных для заполнения

    # Дата отчета для имени файла
    #datestats = reportstats[2][1].split(" ")[0]
    #print("DATA OTCHETA ", datestats)

    datestats = reportstatsdict['Начало интервала'].split(" ")[0]
    print("DATA OTCHETA ", datestats)


    # dateputlist
    ### 5,59   5,68   5,90
    dateputlist = datestats.split('-')
    sheet.Cells(5, 59).value = dateputlist[2]
    sheet.Cells(5, 68).value = dateputlist[1]
    sheet.Cells(5, 90).value = dateputlist[0]

    # orgaddr
    ### 6,17
    orgaddr = "ООО ДЭП-53 г.Поворино ул.Народная д.230, тел: 847376-4-21-04 "
    sheet.Cells(6, 17).value = orgaddr

    # Марка авто
    ### 13,17
    # markcar = reportstats[1]
    # markcar = markcar[1].split(" ")
    # print("markaavto", markcar)

    markcar = reportstatsdict['Объект']
    markcar = markcar.split(" ")
    markcar = markcar[4:]
    markcar = ' '.join(markcar)
    print("markaavto", markcar)

    # записываем значение в определенную ячейку
    sheet.Cells(13, 17).value = markcar

    # госномер
    ### 14,28
    #gosnum = reportstats[1]
    #gosnum = gosnum[1].split(" ")
    #gosnum = gosnum[0]
    gosnum = reportstatsdict['Объект']
    gosnum = gosnum.split(" ")
    gosnum = gosnum[:4]
    num = ' '.join(gosnum)
    gosnum = ''.join(gosnum)
    print("Gosnomer", gosnum)
    sheet.Cells(14, 28).value = num

    # driver
    ### 15,9
    # driverud
    ### 17,16
    # driverpas
    ### 20,18  20,49   20,65
    # pricep
    ### 21,44

    # dtday

    # dtmonth

    # kmdo = reportstats[9]
    # print("Probeg", kmdo[1])
    kmdo = reportstatsdict['Пробег'].split(" ")
    print("Probeg", kmdo[0])
    # kmpos

    # Остаток топлива при выезде
    ### 24,128
    # fuelstart = reportstats[4]
    # fuelstart= fuelstart[1].strip(' l')
    fuelstart = reportstatsdict['Нач. уровень'].split(" ")
    print("Fuel na starte", fuelstart[0])
    sheet.Cells(24, 128).value = fuelstart[0]

    # Остаток по возвращению
    ### 24,137
    # fuelend = reportstats[5]
    # fuelend = fuelend[1].strip(' l')
    fuelend = reportstatsdict['Конеч. уровень'].split(" ")
    print("Fuel v konce", fuelend[0])
    sheet.Cells(24, 137).value = fuelend[0]

    # Расход горючего фактически лист 2
    ### 36,9
    # fuelloss = reportstats[6]
    # fuelloss = fuelloss[1].strip(' l')
    fuelloss = reportstatsdict['Потрачено топлива по ДУТ'].split(" ")
    print("Potracheno fuel", fuelloss[0])
    sheet2.Cells(36, 9).value = fuelloss[0]

    # Время в движении лист 2
    ###  36,34

    # Время в простое лист 2
    ### 36,47

    # Пробег км лист 2
    ### 36,113
    # probeg = reportstats[9]
    probeg = reportstatsdict['Пробег'].split(" ")
    sheet2.Cells(36, 113).value = probeg[0]

    # Работа моточасов
    ### 24,179
    # motochas = reportstats[13]
    # motochas = motochas[1]
    motochas = reportstatsdict['Моточасы']
    print("Motochas", motochas)
    sheet.Cells(24, 179).value = motochas

    # Выезд из гаража
    ### 14,117  14,124   14,131   14,138    14,164
    print(reporttrips[2])
    starttripstime = str(GetDataWialon.time_conver_tolocal(reporttrips[2]))
    starttripstime = starttripstime.split(" ")
    starttripsdt = starttripstime[0].split("-")
    starttripstm = starttripstime[1].split("+")[0]
    print("Start trips", starttripstime)
    sheet.Cells(14, 117).value = starttripsdt[2] # число
    sheet.Cells(14, 124).value = starttripsdt[1] # месяц
    #sheet.Cells(14, 124).value = starttripstm  # время фактическое


    # Прибытие в гараж
    ### 15,117  15,124   15,131   15,138    15,164

    temptrips = dataset[3][0]['c']
    endtripstime = temptrips[1] + " " + temptrips[3]['t']

    print(reporttrips[3])
    #endtripstime = str(GetDataWialon.time_conver_tolocal(reporttrips[3]))
    endtripstime = str(GetDataWialon.time_conver_tolocal(endtripstime))
    endtripstime = endtripstime.split(" ")
    endtripsdt = endtripstime[0].split("-")
    endtripstm = endtripstime[1].split("+")[0]
    print("End time trips", endtripstime)
    sheet.Cells(15, 117).value = endtripsdt[2] # число
    sheet.Cells(15, 124).value = endtripsdt[1] # месяц
    #sheet.Cells(15, 124).value = endtripstm  # время фактическое


    # org
    # addrin
    # addrout
    # addrs

    # Пункт разгрузки погрузки лист 2
    ### 7,1 ...
    # punkt
    r=7
    c=1
    cin = [38,48,58]
    cout =  [67,78]

    print(trips)
    #
    # for item in trips:
    #     # Поездки
    #     #punkt = item['c'][7]['t'] прошлое значение
    #     punkt = item['c'][3]['t']
    #     print(punkt)  # Наименование пункта
    #     sheet2.Cells(r, c).value = punkt  # число
    #
    #     # # Прибытие
    #     # dtin = item['c'][1]['t'] прошлое значение
    #     dtin = item['c'][2]['t']
    #     punktin = str(GetDataWialon.time_conver_tolocal(dtin))
    #     punktin = punktin.split(" ")
    #     punktindt = punktin[0].split("-")
    #     punktintm = punktin[1].split(":")
    #     print(punktin)  # Время прибытия
    #     sheet2.Cells(r, cin[0]).value = punktindt[2] # число
    #     sheet2.Cells(r, cin[1]).value = punktintm[0] # часы
    #     sheet2.Cells(r, cin[2]).value = punktintm[1] # минуты
    #
    #     # Убытие
    #     dtout = item['c'][2]['t']
    #     punktout = str(GetDataWialon.time_conver_tolocal(dtout))
    #     punktout = punktout.split(" ")
    #     punktoutdt = punktout[0].split("-")
    #     punktouttm = punktout[1].split(":")
    #     print(punktout)  # Время убытия
    #     sheet2.Cells(r, cout[0]).value = punktouttm[0]  # часы
    #     sheet2.Cells(r, cout[1]).value = punktouttm[1]  # минуты
    #
    #     r = r+1


    item = trips[0]
    # Поездки
    #punkt = item['c'][7]['t'] прошлое значение
    punkt = item['c'][4]['t']
    print(punkt)  # Наименование пункта
    sheet2.Cells(r, c).value = punkt  # число


    # Время прибытия число часов минут
    ### 7,38 7,48 7,58

    # Время убытия часов минут
    ###  7,67 7,78

    # try:
    #     save_file(wb, datestats, gosnum)
    # except WialonError as e:
    #     print("Error while logout")

    save_file(wb,datestats,gosnum)
    close_file(wb)
    start_file(datestats,gosnum)