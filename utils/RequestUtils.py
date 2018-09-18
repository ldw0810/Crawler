#coding=utf-8
import json
import os
from flask import request
from werkzeug.utils import secure_filename
from beans.SeriesEntity import JobTemplateSerialize
from utils import ConfigUtils
from utils.ConfigUtils import KEYMAP
from utils.ResponseUtils import InvalidAPIUsage
from sqlalchemy.orm.attributes import InstrumentedAttribute
import urllib2
import logging
ALLOWED_EXTENSIONS=ConfigUtils.getPorperties(KEYMAP.UPLOAD,KEYMAP.ALLOW_FILES)
UPLOAD_FOLDER=ConfigUtils.getPorperties(KEYMAP.UPLOAD,KEYMAP.UPLOAD_FOLDER)
def loadParams():
    params={}
    try:
        if(request.method=="POST"):
            data = urllib2.unquote(str(request.data))#避免中文参数乱码
            params=json.loads(data)
        else:
            return request.args
    except Exception,e:
        # logging.error('requst %s error --reason: %s' % (request.url,e.message))
        InvalidAPIUsage(e.message,400)
    if not isinstance(params,dict):
        return {}
    return params
def allowed_file(filename):

    return '.' in filename and \
           filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS.split(",")
def parseFile():
    jobTemplateSerialize=None
    if request.method == 'POST':
        file = request.files['file']
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(UPLOAD_FOLDER, filename))
            content=open(os.path.join(UPLOAD_FOLDER, filename)).read()
            if content:
                jobTemplateSerialize=JobTemplateSerialize.deSerialize(content)
    return jobTemplateSerialize
def parseProxyFile():
    content=None
    if request.method == 'POST':
        file = request.files['file']
        if file and allowed_file(file.filename):

            filename = secure_filename(file.filename)
            file.save(os.path.join(UPLOAD_FOLDER, filename))
            content=open(os.path.join(UPLOAD_FOLDER, filename)).read()
    ipList=str(content).split("\n") or []

    return ipList
def parseResToClass(ParamObject,params=None):
    paramObject = ParamObject()
    if params==None:
        params=loadParams()
    for key in params:
        if hasattr(paramObject, key):
            setattr(paramObject, key, params[key])
    cls = ParamObject
    data = cls.__dict__
    for key in data.keys():
        if hasattr(cls,key):
            attr=getattr(cls, key)
            if isinstance(attr,InstrumentedAttribute):
                if hasattr(attr, "type") and str(attr.type)=="BOOLEAN":
                    value = getattr(paramObject, key)
                    if value == None:
                        continue
                    if "1"==str(value) or str(value)=="true" or str(value)=="True":
                        setattr(paramObject, key, 1)
                    else:
                        setattr(paramObject, key, 0)
    return paramObject
if __name__=="__main__":
    print os.path.join(UPLOAD_FOLDER, "1123")