# coding=utf-8
# Created by wyy on 2017-05-07.

import datetime
from apscheduler.schedulers.background import BackgroundScheduler

sche = BackgroundScheduler()


class TaskJobScheduler(object):
    def __init__(self, taskJobId):
        self.taskJobId = taskJobId

    """
        FIELD_NAMES = ('year', 'month', 'day', 'week', 'day_of_week', 'hour', 'minute', 'second')
        week ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
        options = ['1st', '2nd', '3rd', '4th', '5th', 'last']
        START_TIME=2013-09-21 22:16:00
        MONTH_DAY='4-5,7-8'
        day_of_week='mon-fri' 'last fri'

    """

    def addTask(self, taskJobTimer):
        if self.get_job(taskJobTimer.id):
            self.delTaskTimer(taskJobTimer.id)

        weekdStr = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
        weekdInt = ['1', '2', '3', '4', '5', '6', '7']
        weeks = dict(zip(weekdInt, weekdStr))
        week = []
        if taskJobTimer.weekDay:
            ws = taskJobTimer.weekDay.split(',')
            for i in range(len(ws)):
                ws[i] = weeks[ws[i]]
            week = (',').join(ws)
        if taskJobTimer.repeatTime == 0:
            param = {}
            if taskJobTimer.startTime:
                param.update(start_date=str(taskJobTimer.startTime))
                pass
            if taskJobTimer.endTime:
                param.update(end_date=str(taskJobTimer.endTime))
                pass
            if taskJobTimer.yearMonth:
                param.update(month=str(taskJobTimer.yearMonth))
                pass
            if week:
                param.update(day_of_week=str(week))
                pass
            if taskJobTimer.monthDay:
                param.update(day=str(taskJobTimer.monthDay))
                pass
            if taskJobTimer.hour:
                param.update(hour=str(taskJobTimer.hour))
                pass
            if taskJobTimer.minute:
                param.update(minute=str(taskJobTimer.minute))
                pass
            sche.add_job(self.startCrawler, 'cron', id=taskJobTimer.id,
                         **param)
        else:
            sche.add_job(self.startCrawler, 'date',
                         run_date=datetime.datetime(int(datetime.datetime.now().strftime('%Y')),
                                                    int(datetime.datetime.now().strftime('%m')),
                                                    int(datetime.datetime.now().strftime('%d')),
                                                    int(taskJobTimer.hour),
                                                    int(taskJobTimer.minute)), id=taskJobTimer.id)
        if not sche.running:
            sche.start()

    def stopTaskTimer(self, taskJobTimerid):
        sche.pause_job(taskJobTimerid)
        pass

    def resumTaskTimer(self, taskJobTimerid):
        sche.resume_job(taskJobTimerid)
        pass

    def delTaskTimer(self, taskJobTimerid):
        sche.remove_job(taskJobTimerid)
        pass

    def updateTaskTimer(self, taskJobTimer):
        pass

    def startCrawler(self):
        startCrawlerByTaskJobId(self.taskJobId)
        print "kaishizhixin"
        pass

    def time_differ(self, date1='12:55'):
        date1 = datetime.datetime.strptime(date1, "%H:%M")
        date2 = datetime.datetime.strptime(time.strftime("%H:%M"), "%H:%M")
        if (date1 > date2):
            return (date1 - date2).seconds
        return 0

    def get_job(self, taskJobTimerid):
        b = sche.get_job(taskJobTimerid)
        return b


def hello1():
    print "hello1"


def hello():
    print "hello"
    if sche.get_job("1"):
        sche.remove_job("1")
        param = {}
        param.update(start_date="2017-08-25")
        param.update(hour="15")
        param.update(minute="58")
        sche.add_job(hello1, 'cron', id="1", **param)
        print sche.running


if __name__ == "__main__":
    import time

    param = {}
    param.update(start_date="2017-08-25")
    param.update(hour="15")
    param.update(minute="57")
    sche.add_job(hello, 'cron', id="1", **param)
    if not sche.running:
        sche.start()
    time.sleep(1000000)
