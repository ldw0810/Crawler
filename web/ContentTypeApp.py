#coding=utf-8
#Created by xutao on 2017-05-05.
from dao import ContentTypeDao
from dao import VersionDao
from dao.BaseDao import Page
from utils import RequestUtils
from utils import ResponseUtils
from web import app


@app.route("/getContentTypeList",methods=["post"])
def getContentTypeList():
    params=RequestUtils.loadParams()
    parentId=params.get("parentId")
    result=ContentTypeDao.getContentList(parentId,Page())
    return ResponseUtils.parseResponse(0,{"result":result})

@app.route("/loadVersionList",methods=["post"])
def loadVersionList():
    params = RequestUtils.loadParams()
    result = VersionDao.loadVersionList();
    return ResponseUtils.parseResponse(0, {"result": result})