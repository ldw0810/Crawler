# -*- coding:utf-8 -*-
from beans.UserTable import User, Group, Permission, Group_re_permission
from dao import BaseDao
from dao.BaseDao import add
from utils.ResponseUtils import parseResponse
from sqlalchemy import text
from dao.BaseDao import query
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from ScreenInfoTable import HotInfo,GisInfo,TotalInfo,AginstPornography,HighCharts
import random
from dao import baseEngine
# baseEngine = create_engine('mysql+mysqldb://root:123456@172.21.14.35/guizhou_db?charset=utf8',echo = True,pool_recycle=7200)
Session_class = sessionmaker(bind=baseEngine)
Session = Session_class()


def query_hotInfo_byContentType(contentType):
    hotInfo = Session.query(HotInfo).filter(HotInfo.contenttype == contentType,HotInfo.delflag == 0).all()
    return {'hotInfo':hotInfo}


def query_all_hotInfo():
    hotInfo = Session.query(HotInfo).filter(HotInfo.delflag == 0).all()
    return {'hotInfo': hotInfo}


def query_tortcnt_byTimeDis(timestr):
    # totalInfo = Session.query(TotalInfo).filter(datetime_tostring(TotalInfo.createtime) == time,TotalInfo.delflag == 0).first()
    sql = 'select * from S_total_info where DATE_FORMAT(CREATE_TIME,"%%Y-%%m-%%d") = "%s" AND DEL_FLAG = 0' % timestr
    # sql = "select * from S_total_info where DATE_FORMAT(CREATE_TIME,'%Y-%m-%d') = %s" % timestr
    totalInfo = Session.execute(sql).fetchone()
    if not totalInfo:
        return 0
    else:
        return totalInfo['tort_cnt']


def get_dataPoints_byContentType(contentType):
    gisInfo = Session.query(GisInfo).filter(GisInfo.contenttype == contentType,GisInfo.delflag == 0).all()
    return {'GisInfo':gisInfo}


def get_aginstPornography():
    aginstPornography = Session.query(AginstPornography).filter(AginstPornography.delflag == 0).first()
    randomNumber = randomlist(8)
    aginstPornography.webcnt +=randomNumber[0]
    aginstPornography.imgcnt +=randomNumber[1]
    aginstPornography.video_cnt += randomNumber[2]
    aginstPornography.text_cnt += randomNumber[3]
    aginstPornography.totalcnt = aginstPornography.webcnt + aginstPornography.imgcnt + \
                                 aginstPornography.video_cnt + aginstPornography.text_cnt
    aginstPornography.saved_cnt += randomNumber[4]
    aginstPornography.antiVice_cnt += randomNumber[5]
    aginstPornography.surveillance_cnt += randomNumber[6]
    Session.commit()
    return {'AginstPornography':aginstPornography}


def query_torcnt_inCharts(timeStr):
    sql = 'select * from S_highcharts_info where DATE_FORMAT(CREATE_TIME,"%%Y-%%m-%%d") = "%s" AND DEL_FLAG = 0' % timeStr
    # sql = "select * from S_total_info where DATE_FORMAT(CREATE_TIME,'%Y-%m-%d') = %s" % timestr
    totalInfo = Session.execute(sql).fetchone()
    if not totalInfo:
        return 0
    else:
        # return {'contentType':totalInfo['CONTENT_TYPE'],'totalcnt':totalInfo['TOTAL_CNT']}
        return totalInfo['TOTAL_CNT']
def query_allContent_inCharts():
    hights = Session.query(HighCharts).filter(HighCharts.delflag == 0).all()
    return hights

def datetime_tostring(dt):
    return dt.strftime('%Y-%m-%d')

def randomlist(n):
    randomList = []
    for i in range(1,n+1):
        randomN = random.randint(1,50)
        randomList.append(randomN)
    return randomList