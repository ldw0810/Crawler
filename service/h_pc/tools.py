# encoding: utf-8
import time
import psutil
from datetime import datetime
class Time_Tool (object):
    def caltime(self,date1, date2):
        date1 = time.strptime(date1, "%Y-%m-%d %H:%M:%S")
        date2 = time.strptime(date2, "%Y-%m-%d %H:%M:%S")
        date1 = datetime(date1[0], date1[1], date1[2], date1[3], date1[4], date1[5])
        date2 = datetime(date2[0], date2[1], date2[2], date2[3], date2[4], date2[5])
        return date2 - date1
    def formatTime(self,time):
        return  datetime.fromtimestamp(time).strftime("%Y-%m-%d %H:%M:%S")
#-------------------实例--------------------------
timetool = Time_Tool()
time1 = timetool.formatTime(psutil.boot_time())
time2 = timetool.formatTime(time.time())
print str(timetool.caltime(time1,time2))