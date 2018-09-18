# -*- coding:utf-8 -*-
import urlparse

from web import  app
from datetime import datetime
from threading import Timer

from flask import make_response
from flask import request
from flask import url_for

from utils.JsonUtils import stringify
from utils.ResponseUtils import parseResponse
from dao.PcInfoDao import PcInfoDao
from flask import Flask


# app = Flask(__name__)
# app.debug = True
pc = PcInfoDao()
@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/getStaticAssetsList/',methods=['POST','GET'])
def getStaticAssetsList():
    query = urlparse.urlparse(request.url).query
    param_dict = dict([(k, v[0]) for k, v in urlparse.parse_qs(query).items()])
    # user_id = param_dict.get("userid")
    # if not user_id:
    #     #检验用户 admin
    #     result =  "error user_id"
    # else :
    assetList = pc.getStaticAssetsList()
    reponseMsg = {}
    reponseMsg["returnCode"] = '0'
    reponseMsg["Msg"] = 'success'
    if assetList:
        for d in assetList:
            reponseMsg[d] = assetList[d]
    result = stringify(reponseMsg)
    rsp = make_response(result)
    rsp.mimetype = 'application/json;charset=utf-8'
    result =  rsp

    return result

@app.route('/getAssetDetail/',methods=['POST','GET'])
def getAssetDetail():
    query = urlparse.urlparse(request.url).query
    param_dict = dict([(k, v[0]) for k, v in urlparse.parse_qs(query).items()])
    asset_id = param_dict.get("assetId")
    if asset_id :
        asset = pc.getAssetDetail(asset_id)
        result = parseResponse(0, asset)
    else:
        result = "error asset_id"
    return result

@app.route('/getDynamicAssetDetail/',methods=['POST','GET'])
def getDynamicAssetDetail():
    query = urlparse.urlparse(request.url).query
    param_dict = dict([(k, v[0]) for k, v in urlparse.parse_qs(query).items()])
    assetId = param_dict.get("assetId")
    beginTime = param_dict.get("beginTime")
    endTime = param_dict.get("endTime")
    if beginTime and endTime:
        # print beginTime,"-----","endTime",endTime
        result = pc.getDynamicAssetDetail(assetId,beginTime,endTime)
    else:
        result = pc.getDynamicAssetDetail(assetId)
    responseResult = parseResponse(0, result)
    return responseResult

@app.route('/assetMgmt/',methods=['POST','GET'])
def assetMgmt():
    result = ''

    return result

@app.route('/getServerLog/',methods=['POST','GET'])
def getServerLog():
    query = urlparse.urlparse(request.url).query
    param_dict = dict([(k, v[0]) for k, v in urlparse.parse_qs(query).items()])
    assetId = param_dict.get("assetId")
    result = pc.getServerLog(assetId)
    responseResult = parseResponse(0, result)
    return responseResult

@app.route('/pcHeartBeat/',methods=['POST','GET'])
def pcHeartBeat():
    query = urlparse.urlparse(request.url).query
    param_dict = dict([(k, v[0]) for k, v in urlparse.parse_qs(query).items()])
    ip = param_dict.get("ip")
    print "***************--",datetime.now(),"***************"
    pc.pcHeartBeatAdd({"ip":ip})
    return "success"

@app.route('/getPcHeartBeat/',methods=['POST','GET'])
def getPcHeartBeat():
    query = urlparse.urlparse(request.url).query
    param_dict = dict([(k, v[0]) for k, v in urlparse.parse_qs(query).items()])
    ip = param_dict.get("ip")

    print "********************",ip,"*****************"
    pclist = pc.getPcHeartBeat({"ip":ip})
    responseResult = parseResponse(0, pclist)
    return responseResult

def start():
    app.run(port=7879,host='0.0.0.0')
    # test = dict([(k,v) for k,v in {"a":"a","b":"b"}.items()])
    # print test

def requireHeartBeat():
    with app.test_request_context():
        url_for('pcHeartBeat', ip='172.21.14.35')


# if __name__ == '__main__':
#     app.run()