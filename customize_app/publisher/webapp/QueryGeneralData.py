# coding=utf-8
from sqlalchemy import text

from customize_app.publisher import WebSocket
from customize_app.publisher.beans.TotalTable import TotalReInfoField, TortReInfoField
from dao import BaseDao
from dao.BaseDao import Session
from utils.JsonUtils import stringify
from utils.RequestUtils import loadParams
from utils.ResponseUtils import parseResponse
from web import app
from utils import RandomUtil
import datetime,time
from flask import Flask
import math
from Settings import maximumData,minimunData
# app = Flask(__name__)
@app.route("/queryGeneralDateList", methods=['POST', 'GET'])
def queryGeneralDateListByPeriodType():
    params = loadParams()
    periodType = params["periodType"]
    data = Session.query(TotalReInfoField).filter(text('period_type='+periodType+'')).group_by("content_type").all()
    # 制造动态假数据begin
    totalCount = 0
    newData = []
    currentzerotime = currentZeroTime()  # 当前时间的零点时间戳
    currenttick = time.time()  # 当前时间戳
    currentPercent = (currenttick - currentzerotime) / (24 * 60 * 60)  # 当前时间所占一整天的百分比
    bigCount = math.floor(maximumData/(24 * 60 * 60))
    smallCount = math.floor(minimunData/(24 * 60 * 60))
    random = smallCount+(bigCount - smallCount)*currentPercent #生成逐步增加的处于smallcount和bigcount之间的随机数
    currentData = int(random *(currenttick-currentzerotime))  #根据随机数计算得出当前总数据
    if data:
        for d in data:
            if isinstance(d,TotalReInfoField):
                if d.contentType !=0:
                    value = int(addDataByContentType(d.contentType,currentData))
                    d.tortCnt =value
                    if d.contentType !=5:
                        totalCount += d.tortCnt
                    newData.append(d)
                    pass
                else:
                    totalData = d
        totalData.tortCnt=totalCount
        newData.append(totalData)
    # 制造动态假数据end
    json=stringify(newData).encode("utf8")
    # WebSocket.sendMessage("{'action':'queryGeneralDateList','data':"+json+",'returnCode':'0','returnMsg':'SUCCESS'}")
    return parseResponse(0, {"data": newData})

@app.route("/queryTortDate", methods=['POST', 'GET'])
def queryTortDate():
    # params = loadParams()
    # periodType = params["periodType"]
    data = BaseDao.query(TortReInfoField)
    # 制造动态假数据begin
    if data:
        for d in data:
            if isinstance(d,TortReInfoField):
                value = RandomUtil.random(0,50)
                d.totalCnt +=value
    # 制造动态假数据end
    json = stringify(data).encode("utf8")
    # WebSocket.sendMessage( "{'action':'queryTortDate','data':" + json + ",'returnCode':'0','returnMsg':'SUCCESS'}")
    return parseResponse(0, {"data": data})

def addDataByContentType(type,currentData):
    if type == 1:
        return currentData * 0.2
    if type == 2:
        return currentData * 0.11
    if type == 3:
        return currentData * 0.41
    if type == 4:
        return currentData * 0.28
    if type == 5:
        return currentData * 0.2

def currentZeroTime():
    today = datetime.date.today()
    currentTime = time.mktime(today.timetuple())
    return currentTime


# if __name__ == '__main__':
#     app.run()