# -*- coding:utf-8 -*-
from utils.RequestUtils import loadParams
from utils.ResponseUtils import parseResponse
from web import app
from customize_app.publisher import WebSocket
from utils.JsonUtils import stringify
from customize_app.publisher.dao import TortTotalDao

@app.route("/getTortTotal",methods=["GET","POST"])
def getTortTotal():
    params = loadParams()
    id = params.get("id")
    data=TortTotalDao.queryTortTotal(66)
    json = stringify(data).encode("utf8")
    print json
    # WebSocket.sendMessage("{'action': 'getTortTotal', 'data': " + json + ", 'returnCode': '0', 'returnMsg': 'SUCCESS'}")
    return parseResponse(0, {'data':data})

