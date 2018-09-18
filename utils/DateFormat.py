#coding=utf-8
#Created by wyy on 2017-04-15.
import datetime
import time
# import date
#
# now = date(2017, 04, 29)
# tomorrows=now.replace(day = 29)
# print tomorrows
# tomorrow = now.replace(day = 29)
#
# print 'now:', now, ', tomorrow:', tomorrow
# # print 'timetuple():', now.timetuple()
# print 'weekday():', now.weekday()
# print 'isoweekday():', now.isoweekday()
# print 'isocalendar():', now.isocalendar()
# print 'isoformat():', now.isoformat()
#
# print 'date.today():' , date.today()
# print 'date.fromtimestamp():' , date.fromtimestamp(time.time())
# print datetime.now().strftime("%Y-%m-%d %H:%M:%S")



# 每天 18:00
# 每周一 18:00
# 每月1号 18:00
# 每年1月（每天） 18:00
# 每年1月 1号 18:00
# 每年1月 每周一 18:00
def calcDate():
    pass

from apscheduler.schedulers.blocking import BlockingScheduler
def my_job():
    print 'hello world',time.time()
def my_job2():
    print 'hello world2'
def my_job5():
    print 'hello world5'

sched = BlockingScheduler()
# sched.add_job(my_job, 'interval', minutes=1)
# sched.add_job(my_job, 'interval', hours=2)
# sched.add_job(my_job, 'interval', seconds=2)
# sched.add_job(my_job, 'cron', start_date ='2017-05-02', second=3)
# sched.start()


from pymongo import MongoClient
from apscheduler.schedulers.blocking import BlockingScheduler
from apscheduler.jobstores.mongodb import MongoDBJobStore
from apscheduler.jobstores.memory import MemoryJobStore
from apscheduler.executors.pool import ThreadPoolExecutor, ProcessPoolExecutor


# Runs from 2016-09-21 at 21:46 (pm) until ....
# sched.add_job(my_job, 'cron', start_date ='2017-05-02', hour=16, minute=10 )
# sched.start()

# Runs from Monday to Friday at 5:30 (am) until 2016-09-30 00:00:00
# sched.add_job(my_job, 'cron', day_of_week='mon-fri', hour=21, minute=39, end_date='2016-09-30' )
# sched.start()
# sched.add_job(my_job, 'interval', start_date ='2013-09-21 22:16:00', seconds=5,minutes=1 )
# sched.add_job(my_job2, 'interval', start_date ='2013-09-21 22:16:00', seconds=4, end_date='2017-05-03 09:53:00')
# sched.add_job(my_job5, 'interval', seconds=10,weeks=0, days=0, hours=0, minutes=0)

# sched.add_job(my_job5, 'interval',days=0,hours=0,minutes=1)
# abc=datetime(2017, 5, 4, 1, 29, 15)

# sched.add_job(my_job, 'date', run_date=)
# sched.start()
import scrapy_splash

def loopAddJob(startdate='2017-05-03',enddate=None,type=0,time=None,week=1,mouth=1,day=1):
    start_date = startdate
    end_date = enddate
    job_type = type
    sched = BlockingScheduler()
    if(job_type==1):
        #单次执行任务 18:30
        sec=time_differ(time)
        sched.add_job(my_job, 'cron', start_date=start_date,end_date=end_date, second=sec)

    elif(job_type==2):
        #everyday time 每天 18:30
        sched.add_job(my_job, 'interval',day=1, start_date=start_date, end_date=end_date)
    elif (job_type == 3):
        # everyweek time 每周 18:30
        sched.add_job(my_job, 'interval', start_date=start_date, end_date=end_date)
    elif (job_type == 4):
        #atday time 每月
        sched.add_job(my_job, 'interval', start_date=start_date, end_date=end_date)
#coding:utf8
def time_differ(date1='12:55'):
    date1=datetime.datetime.strptime(date1,"%H:%M")
    date2=datetime.datetime.strptime(time.strftime("%H:%M"),"%H:%M")
    if(date1>date2):
        return (date1-date2).seconds
    return 0


# date1 = '15:05'
# differ = time_differ(date1)
# print differ
# print type(differ)


# Schedules job_function to be run on the third Friday
# of June, July, August, November and December at 00:00, 01:00, 02:00 and 03:00


# sched.add_job(my_job, 'cron', month='6-8,11-12', day='3rd fri', hour='0-3')
# Runs from Monday to Friday at 5:30 (am) until 2014-05-30 00:00:00
# sched.add_job(my_job(), 'cron', day_of_week='mon-fri', hour=5, minute=30, end_date='2014-05-30')
# h=1
# sched.add_job(my_job, 'cron', month='5',day_of_week='thu',minute='1',second='1')
# sched.add_job(my_job, 'cron', month=None,day='4-5,7-8',minute='3',second='1')
# sched.start()
print int(datetime.datetime.now().strftime('%Y'))