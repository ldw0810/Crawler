#coding=utf-8
import BaseHTTPServer
import sys
import threading

from flask import Flask

from service import ProcessShare
from utils import ConfigUtils
from utils import LicenseUtils

reload(sys)
sys.setdefaultencoding('utf-8')
app = Flask(__name__)
import TaskApp
import UserController
import UserloginApi
import HtmlApp
import ContentTypeApp
import LogApp
initApp=ConfigUtils.getWebPorperties("INITAPPS")
appList=ConfigUtils.getWebPorperties("APPLIST")
initAppList=initApp.split(",")
appLists=appList.split(",")
for initA in initAppList:
    if initA==None or initA=="":
        continue
    exec("import %s"%(initA))
    eval(initA).init()
for appInfo in appLists:
    if appInfo==None or appInfo=="":
        continue
    exec("import %s"%(appInfo))
# @app.before_request
# def before_request(exception=None):
#     print "asd"
# class LicenseRequest(BaseHTTPServer.BaseHTTPRequestHandler):
#     def parse_request(self):
#         super(self).parse_request()


def start(host="127.0.0.1",port=5000):
    if not LicenseUtils.check_licence(LicenseUtils.get_mac_address()):
        return
    # thread = threading.Thread(target=ProcessShare.run, args=())
    # thread.start()
    #去除,threaded=True，因为在全局变量下，,threaded=True这个会导致lost connect
    app.run(host=host,port=port,debug=False)

# if __name__ == "__main__":
#     print {}.get("asd")