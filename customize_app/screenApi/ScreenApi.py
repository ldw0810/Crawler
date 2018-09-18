# -*- coding:utf-8 -*-
from utils.RequestUtils import loadParams
from utils.ResponseUtils import parseResponse
from web import app
from ScreenInfoDao import query_hotInfo_byContentType,query_tortcnt_byTimeDis,\
    get_dataPoints_byContentType,get_aginstPornography,query_all_hotInfo,\
    query_allContent_inCharts,query_torcnt_inCharts
from flask import jsonify
from utils.TimeUtils import get_time_beforeNow,dateRange,dateMounthRange,getDaysForMounth
from customize_app.publisher import WebSocket
import json
from flask import request
import datetime
from utils.JsonUtils import stringify
# from flask import Flask
#
# app = Flask(__name__)

@app.route('/totalNumberTrend',methods=['POST','GET'])
def totalNumberTrend():
    """
     总检测数量趋势
    """
    params = loadParams()
    beginTime = get_time_beforeNow(0)
    endTime   = get_time_beforeNow(6)
    timelist  = dateRange(endTime,beginTime)
    array = []
    for i in range(len(timelist)):
        currentTime = timelist[i]
        hotTrend = query_tortcnt_byTimeDis(currentTime)
        dic = {'time':currentTime,'tortcnt':hotTrend}
        array.append(dic)
    # dic = dict(zip(timelist,array))
    dic = {'time_torcnt':array}
    websocketMessage('totalNumberTrend',dic)
    return parseResponse(0,{'time_torcnt':array})


@app.route('/hotContent',methods=['POST','GET'])
def hotContent():
    """
    热门内容
    :return:
    """
    params = loadParams()
    # if params.has_key('timeDis') == False:
    #     return parseResponse(-1, {'message': 'please check your params'})
    if not params or params.has_key('contentType') == False:
        content_type = 0  # 不传 默认类型为0:总量
        hotInfo = query_all_hotInfo()
    else:
        content_type = params['contentType']
        hotInfo = query_hotInfo_byContentType(content_type)
        print hotInfo
    websocketMessage('dataPoints',hotInfo)
    return parseResponse(0, hotInfo)


@app.route('/dataPoints',methods=['POST','GET'])
def dataPoints():
    """
    数据点接口
    :return:
    """
    params = loadParams()
    if not params or params.has_key('contentType') == False:
        content_type = 0  # 不传 默认类型为0:总量
        gisInfo = get_dataPoints_byContentType(content_type)
    else:
        content_type = params['contentType']
        gisInfo = get_dataPoints_byContentType(content_type)
    websocketMessage('dataPoints',gisInfo)
    return parseResponse(0,gisInfo)


@app.route('/againstPornography',methods=['POST','GET'])
def againstPornography():
    """
    扫黄打非接口
    :return:
    """
    aginstPornography = get_aginstPornography()
    if not aginstPornography:
        return parseResponse(0,{'message':'no data'})
    websocketMessage('againstPornography',aginstPornography)
    return parseResponse(0,aginstPornography)


@app.route('/hotMapData',methods=['POST','GET'])
def hotMapData():
    """
    热地图数据接口
    :return:
    """
    dateList = []
    mounths = dateMounthRange()
    for i in range(len(mounths)):
        year_mounth = mounths[i]
        year = str(year_mounth).split('-')[0]
        mounth  = str(year_mounth).split('-')[1]
        days = getDaysForMounth(int(year),int(mounth))
        for j in range(1,days[1]+1):
            if j < 10:
                day = '0%s' %j
                dateTime ='-'.join([year_mounth,day])
                current_data = query_torcnt_inCharts(dateTime)
                dic = {'time': dateTime, 'currentDayData': current_data}
                dateList.append(dic)
            else:
                dateTime = '-'.join([year_mounth,str(j)])
                current_data = query_torcnt_inCharts(dateTime)
                dic = {'time': dateTime, 'currentDayData': current_data}
                dateList.append(dic)
    allContent = query_allContent_inCharts()
    listData = sort_by_attr(allContent,'totalcnt')
    websocketMessage('hotMapData',listData)
    return parseResponse(0,{'datalist':listData})

# 根据对象的属性把对象进行排序
def sort_by_attr(seq,attr):
    intermed=[(getattr(x,attr),i,x) for i,x in enumerate(seq)]
    intermed.sort()
    return [x[-1] for x in intermed]

def websocketMessage(method,data):
    json = stringify(data).encode("utf8")
    message = "{'action':'%s','data':%s,returnCode':'0','returnMsg':'SUCCESS'}" % (method,json)
    WebSocket.sendMessage(
        message)

if __name__ == '__main__':
    app.run(host='10.128.100.204',port='8080')