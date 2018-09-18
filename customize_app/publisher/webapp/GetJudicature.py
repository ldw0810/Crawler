# -*- coding:utf-8 -*-
from utils.RequestUtils import loadParams
from utils.ResponseUtils import parseResponse
from web import app
from customize_app.publisher import WebSocket
from utils.JsonUtils import stringify
from customize_app.publisher.dao import JudicatureDao
@app.route('/getJudicature',methods=["GET","POST"])
def getJudicature():
    params = loadParams()
    id = params.get("id")
    data=JudicatureDao.quertJudicature(id)
    json = stringify(data).encode("utf8")
    # WebSocket.sendMessage("{'action': 'getJudicature', 'data': " + json + ", 'returnCode': '0', 'returnMsg': 'SUCCESS'}")
    return parseResponse(0, {"data": data})

