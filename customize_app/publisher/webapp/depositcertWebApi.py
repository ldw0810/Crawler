# -*- coding: utf-8 -*-
import logging

from customize_app.publisher.dao import SearchTaskDao
from dao import TaskJobDao
from dao.TaskJobDao import TaskJobExecuteStatus
from utils.RequestUtils import loadParams
from customize_app.publisher.depositcert import depositcert
from utils.ResponseUtils import parseResponse
from flask import Flask
from customize_app.publisher import WebSocket
from utils.JsonUtils import stringify
from web import app
import time
@app.route("/saveCert",methods=["GET","POST"])
def saveCert():
    params = loadParams()
    content = params.get("content")
    phone = params.get("phone")
    name = params.get("name")
    id = params.get("id")
    result = depositcert.deposit_cert(content,name,phone)
    json={}
    try:
        json = stringify(result).encode("utf8")
    except Exception,e:
        logging.error(str(e))
    finally:
        WebSocket.sendMessage(
            "{'action': 'saveCert', 'data': " + json + ", 'returnCode': '0', 'returnMsg': 'SUCCESS'}")
    if result:
        SearchTaskDao.updateSearckTask(name,6)
        SearchTaskDao.updateSearckTaskExecute(name,1)
        return parseResponse(0)
    else:
        return parseResponse(-1)

@app.route("/queryCerts", methods=["GET", "POST"])
def queryCerts():
    params = loadParams()
    phone = params.get("phone")
    email = params.get("email")
    out_id = params.get("out_id")
    result = depositcert.query_certs(phone,email,out_id)
    if result['code']==0:
        files = result['files']
        for file in files:
            long_time = file['save_time']
            timeArray = time.localtime(long_time / float(1000))
            otherStyleTime = time.strftime("%Y-%m-%d %H:%M:%S", timeArray)
            file['save_time'] = otherStyleTime
        json = stringify(result['files']).encode("utf8")
        WebSocket.sendMessage("{'action': 'queryCerts', 'data': " + json + ", 'returnCode': '0', 'returnMsg': 'SUCCESS'}")
        return parseResponse(0, {"result": result['files']})
    else:
        return parseResponse(-1)

@app.route("/getDownLoadCertUrl", methods=["GET", "POST"])
def getDownLoadCertUrl():
    params = loadParams()
    phone = params.get("phone")
    email = params.get("email")
    out_id = params.get("out_id")
    file_id = params.get("file_id")
    downLoadUrl = depositcert.get_download_cert_url(file_id,phone,email,out_id)
    json = stringify(downLoadUrl).encode("utf8")
    WebSocket.sendMessage("{'action': 'getDownLoadCertUrl', 'data': " + json + ", 'returnCode': '0', 'returnMsg': 'SUCCESS'}")
    return parseResponse(0, {"downLoadUrl": downLoadUrl})

if __name__=="__main__":
    app.run()