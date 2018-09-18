#coding=utf-8
#Created by xutao on 2017-05-05.
from beans.TaskTable import ContentType
from dao.BaseDao import Session, with_session


def getContentList(parentId,page=None):
    queryParams=[]
    if parentId!=-1 and parentId!=None and parentId!="":
        queryParams.append(ContentType.parentId==parentId)
    queryParams.append(ContentType.delFlag==False)
    contentList=apply(Session.query(ContentType).filter,queryParams)
    if page!=None:
        contentList=contentList.offset(page.offset).limit(page.limit).all()
    return contentList;
@with_session
def delContentType(id):
    Session.query(ContentType).filter(ContentType.id==id).update({ContentType.delFlag:True});
    return True
@with_session
def addContentType(contentType):
    return Session.add(contentType);
