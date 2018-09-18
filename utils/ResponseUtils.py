#coding=utf-8
from flask import make_response, app
from message import ErrorMessage
from utils import ConfigUtils
from utils.JsonUtils import stringify

def parseResponseJson(errorCode,dict=None):
    reponseMsg = {}
    reponseMsg["returnCode"] = errorCode
    reponseMsg["returnMsg"] = ErrorMessage[errorCode]
    if dict:
        for d in dict:
            reponseMsg[d] = dict[d]
    return reponseMsg
def parseResponse(errorCode,dict=None,flag=False):
    result=stringify(parseResponseJson(errorCode,dict))
    if flag:
        return result
    rsp = make_response(result)
    allowCrossOrigin=eval(ConfigUtils.getWebPorperties("ALLOW_CROSS_ORIGIN"))
    if allowCrossOrigin:
        rsp.headers['Access-Control-Allow-Origin'] = '*'
    rsp.mimetype = 'application/json;charset=utf-8'
    return rsp
class InvalidAPIUsage(Exception):
    status_code = 400
    def __init__(self, message, status_code=None, payload=None):
        Exception.__init__(self)
        self.message = message
        if status_code is not None:
            self.status_code = status_code
        self.payload = payload

    def to_dict(self):
        rv = dict(self.payload or ())
        rv['message'] = self.message
        return rv