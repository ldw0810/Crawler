# coding=utf-8
import base64
import traceback
import uuid

from TimeUtils import *

path = os.path.dirname(os.path.abspath(__file__))
licenseFilePath = os.path.dirname(path)
TIME_FORMAT = '%Y-%m-%d %H:%M:%S'
LICESE_FILE_NAME = "license.lic"
LICESE_FILE_PATH = licenseFilePath + "/" + LICESE_FILE_NAME
logging.info("LICESE_FILE_PATH:%s" % (LICESE_FILE_PATH))


def check_is_exist(path):
    return os.path.exists(path)


def check_licence(mac):
    return True
    """
    检查授权是否通过
    :param mac: 
    :return: True 通过，False 不通过
    """
    if check_is_exist(LICESE_FILE_PATH):
        try:
            license_file = open(LICESE_FILE_PATH, mode="r")
            data = base64.decodestring(license_file.read())
            logging.info(data)
            list = data.split("||")
            flag = False
            for value in list:
                if value.strip() == mac:
                    flag = True
                    break
            if flag:
                license_time = list[len(list) - 1]
                long_expir_time=None
                webservertime=None
                try:
                    time.sleep(0.5)
                    long_expir_time = time.mktime(time.strptime(license_time.strip(), TIME_FORMAT))
                    webservertime = None;# get_webservertime("www.baidu.com")
                except Exception,e:
                    # long_expir_time=time.time()
                    logging.error(e)
                if webservertime:
                    long_cur_time = time.mktime(time.strptime(webservertime, TIME_FORMAT))
                else:
                    long_cur_time = time.time()
                if long_expir_time > long_cur_time:
                    return True
            logging.error("license is not valid %s" % (data))
            return False
        except Exception, e:
            traceback.print_exc(e)
            logging.error("exception：%s" % (e))
            return False
        finally:
            license_file.close()
    else:
        logging.error("license.lic is not exist")
        return False


def get_mac_address():
    return "111111"
    mac = uuid.UUID(int=uuid.getnode()).hex[-12:]
    macAddr = "-".join([mac[e:e + 2] for e in range(0, 11, 2)])
    logging.info("macAddr:%s" % (macAddr))
    return macAddr


if __name__ == "__main__":
    # print get_mac_address()
    # make_license_file(3,"00-50-56-81-14-B6")
    # d = "AA BB CC DD EE||2017-04-25 12:00:00"
    # d= d.encode("hex")
    # d = base64.encodestring(d)
    # d= base64.decodestring(d)
    # d = d.decode("hex")
    # print d 1495503403.42 1495503413.0
    pass
