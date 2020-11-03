from wialon import Wialon, WialonError
from datetime import datetime
import pytz

# TODO Create automated taked token
#TOKEN = '7fae21d313423abf843b5259df4b4a81F53AD32A14F160198AB5051A885522C082D667CB'
TOKEN = '7fae21d313423abf843b5259df4b4a81FE06A8959018953B11D6E9950A3D445A389EDABC'

#http://hosting.wialon.com/login.html?lang=ru&wialon_sdk_url=https%3A%2F%2Fhst-api.wialon.com&access_token=7fae21d313423abf843b5259df4b4a81FE06A8959018953B11D6E9950A3D445A389EDABC&user_name=20315&svc_error=0

# TODO Add func list drivers
# TODO Add func add drivers to server
# TODO Add func remove drivers to server

############# params constant
params_get_cars = {
    "spec": {
        "itemsType": "avl_unit",
        "propName": "sys_name",
        "propValueMask": "*",
        "sortType": "sys_name"
    },
    "force": 1,
    "flags": "0x00000001",
    "from": 0,
    "to": 0
}

params_get_drivers = {
    "spec": {
        "itemsType": "avl_resource",
        "propName": "drivers",
        "propValueMask": "*",
        "sortType": "drivers"
    },
    "force": 1,
    "flags": "0x00000001",
    "from": 0,
    "to": 0
}


### ЗАПРОСЫ к Wialon

# Поиск обьекта
def search_items(wialon, params):
    report_params = params
    units = wialon.core_search_items(**report_params)
    return units


# Очистка отчета
def cleanup_result(wialon):
    units = wialon.report_cleanup_result()
    return units


# Запрос отчета
def exec_report(wialon, params):
    report_params = params
    units = wialon.report_exec_report(**report_params)

    # get_result_rows_params = {
    #     "tableIndex": 1,
    #     "indexFrom": 0,
    #     "indexTo": 10
    # }
    # get_result_subrows_params = {
    #              "tableIndex": 0,
    #              "rowIndex": 0
    # }

    # units_rows = wialon.report_get_result_rows(**get_result_rows_params)
    # units_subrows = wialon.report_get_result_subrows(**get_result_subrows_params)

    select_result_stops = {
         "tableIndex": 0,
         "config": {
                "type": "range",
                "data": {
                        "from": 0,
                        "to": 20,
                        "level": 1
             }
         }
     }

    select_result_trips = {
        "tableIndex": 1,
        "config": {
            "type": "range",
            "data": {
                "from": 0,
                "to": 20,
                "level": 1
            }
        }
    }

    select_result_stays = {
         "tableIndex": 2,
         "config": {
                "type": "range",
                "data": {
                        "from": 0,
                        "to": 20,
                        "level": 1
             }
         }
     }




    units_stops = wialon.report_select_result_rows(**select_result_stops)
    units_trips = wialon.report_select_result_rows(**select_result_trips)
    units_stays = wialon.report_select_result_rows(**select_result_stays)

    #print("Units ", units)
    #print("Stops ", units_stops)
    #print("Trips ", units_trips)
    #print("Stays ", units_stays)

    return units, units_stops, units_trips, units_stays


# Статус отчета
def get_report_status(wialon):
    units = wialon.get_report_status()
    return units


# Get items in cars func
def get_cars():
    wialon = Wialon()

    try:
        login = wialon.token_login(token=TOKEN)
    except WialonError as e:
        print("Error while login:", e)
        return

    wialon.sid = login['eid']

    try:
        founded = search_items(wialon, params_get_cars)
        # print(founded['items'][1])
        # for i in founded['items']:
        #     array.append(i['nm'])
        # return array
        return founded
    except WialonError as e:
        print("Error while execturing report:", e)

    # logout is necessary, for preventing error with a lot of session from one ip
    try:
        wialon.core_logout()
    except WialonError as e:
        print("Error while logout")


# Запрос водителей
def get_drivers():
    wialon = Wialon()
    array = []

    try:
        login = wialon.token_login(token=TOKEN)
    except WialonError as e:
        print("Error while login:", e)
        return

    wialon.sid = login['eid']

    try:
        founded = search_items(wialon, params_get_drivers)
        #print(founded['items'])
        # for i in founded['items']:
        #     array.append(i['nm'])
        # return array
        return founded
    except WialonError as e:
        print("Error while execturing report:", e)

    # logout is necessary, for preventing error with a lot of session from one ip
    try:
        wialon.core_logout()
    except WialonError as e:
        print("Error while logout")


######################### CREATE REPORT ################################

# Результирующие функции


# Func create convert time to unixformat
def time_convert_save(dateparam,ft):
    if ft == 0:
        dateparam = dateparam + " 00:00:01"
    elif ft == 1:
        dateparam = dateparam + " 23:59:59"
    date = datetime.strptime(dateparam, '%d-%m-%Y %H:%M:%S')
    return int(date.timestamp())

def time_convert(dateparam,ft):
    if ft == 0:
        dateparam = dateparam + " 00:00:01"
    elif ft == 1:
        dateparam = dateparam + " 23:59:59"
    date = datetime.strptime(dateparam, '%d-%m-%Y %H:%M:%S').replace(tzinfo=pytz.utc)
    return int(date.timestamp())

def time_conver_tolocal(dttm):
    local_tz = pytz.timezone('Europe/Moscow')
    outtime = datetime.strptime(dttm, '%Y-%m-%d %H:%M:%S').replace(tzinfo=pytz.utc).astimezone(local_tz)
    return outtime




# Получение Id отчета
def get_id_report():
    wialon = Wialon()
    array = []

    params_getid_report = {
        "spec": {
            "itemsType": "avl_resource",
            "propName": "reporttemplates",
            "propValueMask": "*",
            "sortType": "reporttemplates"
        },
        "force": 1,
        "flags": "0x00002001",
        "from": 0,
        "to": 0
    }

    try:
        login = wialon.token_login(token=TOKEN)
    except WialonError as e:
        print("Error while login:", e)
        return

    wialon.sid = login['eid']

    try:
        founded = search_items(wialon, params_getid_report)
        #        print(founded['items'][0]['rep']['1']['n'])
        for i in founded['items']:
            # print(i['nm'])
            id1 = (i['id'])
            id2 = (i['rep']['1']['id'])
            namereport = (i['rep']['1']['n'])
        return namereport, id1, id2

    except WialonError as e:
        print("Error while execturing report:", e)

    # logout is necessary, for preventing error with a lot of session from one ip
    try:
        wialon.core_logout()
    except WialonError as e:
        print("Error while logout")


# For invoke 1 count
ids = get_id_report()


# Создание параметров для запроса отчета
def params_get_report(carid, dtfrom, dtto):
    datefrom = time_convert(dtfrom,0)
    dateto = time_convert(dtto,1)
    #print(datefrom)
    #print(dateto)
    #print(carid)
    repuserid = ids[1]
    repid = ids[2]
    report_params = {
        'reportResourceId': repuserid,
        'reportTemplateId': repid,
        'reportObjectId': carid,
        'reportObjectSecId': 0,
        'reportTemplate': None,
        'interval': {
            # from - unix timestamp
            'from': datefrom,
            # to - unix timestamp
            'to': dateto,
            'flags': 0
        }
    }
    return report_params


# Запрос отчета
def get_data_cars(carid, dtfrom, dtto):
    wialon = Wialon()
    array = []
    params = params_get_report(carid, dtfrom, dtto)
    # print(params)
    try:
        login = wialon.token_login(token=TOKEN)
    except WialonError as e:
        print("Error while login:", e)
        return

    wialon.sid = login['eid']

    try:
        founded = exec_report(wialon, params)
        return founded

    except WialonError as e:
        print("Error while execturing report:", e)

    # logout is necessary, for preventing error with a lot of session from one ip
    try:
        wialon.core_logout()
    except WialonError as e:
        print("Error while logout")


# Выполнение кастомной команды
def start_command():
    wialon = Wialon()
    try:
        login = wialon.token_login(token=TOKEN)
    except WialonError as e:
        print("Error while login:", e)
        return

    wialon.sid = login['eid']

    try:
        # founded = cleanup_result(wialon)
        founded = wialon.report_get_report_status()
        return founded

    except WialonError as e:
        print("Error while execturing report:", e)

    # logout is necessary, for preventing error with a lot of session from one ip
    try:
        wialon.core_logout()
    except WialonError as e:
        print("Error while logout")

# Logon
def logon_session():
    wialon = Wialon()
    try:
        login = wialon.token_login(token=TOKEN)
    except WialonError as e:
        print("Error while login:", e)
        return

    wialon.sid = login['eid']

    try:
        # founded = cleanup_result(wialon)
        founded = wialon.report_get_report_status()
        return founded

    except WialonError as e:
        print("Error while execturing report:", e)

    # logout is necessary, for preventing error with a lot of session from one ip
    try:
        wialon.core_logout()
    except WialonError as e:
        print("Error while logout")



# Start Command

# Logout




#########################################################################



"""
Нужно
лист 1
 
дата путевого листа
Организация и месторосположени + телефон
Марка авто
ГосНомер
Водитель ФИО
Удостоверение водителя
Регистрационный номер
Прицеп номер
число | месяц | показание спидометра км | время выезда
число | месяц | показание спидометра км | время возвращения

в чьем распоряжении | где погрузил | где разгрузил

лист 2
пункты погрузки разгрузки киллометраж

"""