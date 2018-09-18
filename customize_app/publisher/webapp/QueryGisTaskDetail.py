#coding=utf-8
from sqlalchemy import text

from customize_app.publisher import WebSocket
from customize_app.publisher.beans.GisTable import GisInfoField, GisInfoDetailField
from customize_app.publisher.dao.QueryGisTaskDetailDao import queryGisDetailOne, queryGisDetailAll, queryGisDetailBigOne
from dao import BaseDao
from utils.JsonUtils import stringify
from utils.RequestUtils import loadParams
from utils.ResponseUtils import parseResponse
from web import app
from utils import RandomUtil
# app = Flask(__name__)
@app.route("/queryGisDetailSmallByTaskJobId", methods=['POST', 'GET'])
def queryGisDetailByTaskJobId():
    params = loadParams()
    taskJobId = params["taskJobId"]
    if taskJobId:
        data = queryGisDetailOne(taskJobId);
    else:
        data = queryGisDetailAll();
    # 制造动态假数据begin
    if data:
        for result in data:
            d = result[0]
            if isinstance(d,GisInfoField):
                if d.detailCnt:
                    d.detailCnt+= RandomUtil.random(0,50)
                    d.provinceCnt += RandomUtil.random(0,50)
                    d.overseasCnt += RandomUtil.random(0,50)
    # 制造动态假数据end
    json = stringify(data).encode("utf8")
    # WebSocket.sendMessage("{'action':'queryGisDetailByTaskJobId','data':" + json + ",'returnCode':'0','returnMsg':'SUCCESS'}")
    return parseResponse(0, {"data": data})

@app.route("/queryGisDetailBigByDetailKv", methods=['POST', 'GET'])
def queryGisDetailByDetailKv():
    params = loadParams()
    taskJobId = params["taskJobId"]
    # data = BaseDao.query(GisInfoDetailField, text('task_job_id="'+taskJobId+'"'))
    data = queryGisDetailBigOne(taskJobId);
    json = stringify(data).encode("utf8")
    # WebSocket.sendMessage("{'action':'queryGisDetailBigByDetailKv','data':" + json + ",'returnCode':'0','returnMsg':'SUCCESS'}")
    return parseResponse(0, {"data": data})

# @app.route("/ceshi", methods=['POST', 'GET'])
# def ceshi():
#     params = loadParams()
#     taskJobId = params["taskJobId"]
#     data = queryGisDetailOne(taskJobId);
#     json = stringify(data).encode("utf8")
#     WebSocket.sendMessage("{'action':'queryGisDetailByTaskJobId','data':'" + json + "','returnCode':'0','returnMsg':'SUCCESS'}")
#     return parseResponse(0, {"data": data})
# if __name__ == '__main__':
#     app.run()