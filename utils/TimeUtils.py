# -*- coding:utf-8 -*-
import time
from datetime import timedelta
import datetime
import calendar
import httplib
import os
from datetime import date
import logging
from calendar import monthrange

def get_now_time():
    # now = datetime.datetime.now()
    webtimeStr = get_webservertime('www.baidu.com')
    webtime = datetime.datetime.strptime(webtimeStr, '%Y-%m-%d %H:%M:%S')
    thisyear = int(webtime.year)
    thismon  = int(webtime.month)
    thisday  = int(webtime.day)
    thishour = int(webtime.hour)
    thisminute = int(webtime.minute)
    thissecond = int(webtime.second)
    return thisyear, thismon, thisday, thishour, thisminute, thissecond


def get_year_and_month(n=0):
   """
    get the year, month, days from today befor or after n months
   """
   now = datetime.datetime.now()
   thisyear, thismon, thisday, thishour, thisminute, thissecond = get_now_time()
   totalmon = thismon + n
   if (n >= 0):
       if (totalmon <= 12):
           days = str(get_days_of_month(thisyear, totalmon))
           totalmon = add_zero(totalmon)
           return (thisyear, totalmon, days, thishour, thisminute, thissecond, thisday)
       else:
           i = totalmon / 12
           j = totalmon % 12
           if (j == 0):
               i -= 1
               j = 12
           thisyear += i
           days = str(get_days_of_month(thisyear, j))
           j = add_zero(j)
           return (str(thisyear), str(j), days, thishour, thisminute, thissecond, thisday)
   else:
       if ((totalmon > 0) and (totalmon < 12)):
           days = str(get_days_of_month(thisyear, totalmon))
           totalmon = add_zero(totalmon)
           return (thisyear, totalmon, days, thishour, thisminute, thissecond, thisday)
       else:
           i = totalmon / 12
           j = totalmon % 12
           if (j == 0):
               i -= 1
               j = 12
           thisyear += i
           days = str(get_days_of_month(thisyear, j))
           j = add_zero(j)
           return (str(thisyear), str(j), days, thishour, thisminute, thissecond, thisday)


def get_days_of_month(year, mon):
    return calendar.monthrange(year, mon)[1]


def add_zero(n):
    """
    add 0 before 0-9
    return 01-09
    """
    nabs = abs(int(n))
    if(nabs<10):
        return "0"+str(nabs)
    else:
        return nabs

#
def get_today_months(n=0):
    year,mon,d, hour, minute,second, day = get_year_and_month(n)
    arr = (year,mon,d, hour, minute,second, day)
    if(int(day)<int(d)):
        arr = (year,mon,day, hour, minute,second)
    return "-".join("%s" %i for i in arr)


#获取当前时间之后的几个月string
def format_today_months(n=0):
    today = get_today_months(n)
    date_time = datetime.datetime.strptime(today, '%Y-%m-%d-%H-%M-%S')
    showtime = date_time.strftime('%Y-%m-%d %H:%M:%S')
    return showtime


#获取服务端时间
def get_webservertime(host):
    try:
        conn=httplib.HTTPConnection(host)
        conn.request("GET", "/")
        r=conn.getresponse()
        #r.getheaders() #获取所有的http头
        ts=  r.getheader('date') #获取http头date部分
        # print '============================'
        # print ts
        # print '============================'
        #将GMT时间转换成北京时间
        ltime= time.strptime(ts[5:25], "%d %b %Y %H:%M:%S")
        #print(ltime)
        ttime=time.localtime(time.mktime(ltime)+8*60*60)
        #print(ttime)
        # dat="date %u-%02u-%02u"%(ttime.tm_year,ttime.tm_mon,ttime.tm_mday)
        # tm="time %02u:%02u:%02u"%(ttime.tm_hour,ttime.tm_min,ttime.tm_sec)
        currenttime="%u-%02u-%02u %02u:%02u:%02u"%(ttime.tm_year,ttime.tm_mon,ttime.tm_mday,ttime.tm_hour,ttime.tm_min,ttime.tm_sec)
        # os.system(dat)
        # os.system(tm)
        return currenttime
    except Exception,e:
        logging.error( 'get webservertime failure:%s' % e.message)
        return False


def get_time_beforeNow(n,format='%Y-%m-%d'):
    now_time = datetime.datetime.now()
    yes_time = now_time + datetime.timedelta(days=-n)
    yes_time_nyr = yes_time.strftime(format)
    return yes_time_nyr

#间隔时间列表
def dateRange(start, end, step=1, format="%Y-%m-%d"):
    fmt = '%Y-%m-%d'
    bgn = int(time.mktime(time.strptime(start, fmt)))
    end = int(time.mktime(time.strptime(end, fmt)))
    return [time.strftime(fmt, time.localtime(i)) for i in range(bgn, end + 1, 3600 * 24)]


#获取当前月份之前的6个月份列表
def dateMounthRange():
    timeList = []
    for i in range(6):
        curretMounth = get_today_months(-i)
        date_time = datetime.datetime.strptime(curretMounth, '%Y-%m-%d-%H-%M-%S')
        showtime = date_time.strftime('%Y-%m')
        timeList.append(showtime)
    return timeList

#获取当前月份共有多少天
def getDaysForMounth(year,mounth):
    days = monthrange(year,mounth)
    return days