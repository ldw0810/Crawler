#coding=utf-8
import logging
import exceptions

import sqlalchemy
from sqlalchemy import exc
from sqlalchemy import func
from sqlalchemy import text
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm.attributes import InstrumentedAttribute
from beans.TaskTable import TaskJob
from dao import baseEngine

Session_class = sessionmaker(bind=baseEngine)
# Session = Session_class()
# class SessionClass:
#     def getSession(self):
#         return (lambda :Session_class())();
#     def setSession(self):
#         return None
#     SessionProperty=property(getSession,setSession)
Session=(lambda :Session_class())()
def refresh():
    return;
    global Session
    try:
        Session.expunge_all()
        Session.commit()
        Session.close()
        Session=Session_class()
    except Exception,e:
        Session.rollback()
        logging.error("refresh",e)
def with_session(fn):
   i = 0
   def go(*args, **kw):
        global Session
        try:
           ret = fn(*args, **kw)
           Session.commit()
           return ret
        except Exception,e:
           logging.exception(e)
           Session.rollback()
           logging.error("e:"+str(e))
           # raise
   return go
ALL=1
FIRST=0
class Page:
    offset=0
    limit=10
    def __init__(self,pageNo=1,pageSize=10):
        self.offset=(int(pageNo)-1)*int(pageSize)
        self.limit = int(pageSize)

def query(clazz,param=None,type=None,offset=0,limit=10):
    object =  Session.query(clazz)
    if(param!=None):
        object = object.filter(param)
    if type==ALL:
        return object.all()
    elif type==FIRST:
        return object.first()
    object=object.offset(offset).limit(limit).all()
    Session.flush()
    Session.commit()
    # Session.close()
    return object
@with_session
def getPageResult(page=Page(1,10),userId=None,paramMap=None,orderBy=None,parentId=None,clzz=None,join=None):
    queryParam=[]
    queryParam.append(clzz[0].delFlag == False)
    queryParam=initialQueryParam(paramMap or {},clzz[0],queryParam)
    resultList = apply(Session.query, tuple(clzz))
    resultList=apply(resultList.filter,tuple(queryParam))
    if orderBy!=None:
        orderBy=text('%s.create_time desc'%(clzz[0].__tablename__))
    if join != None:
        resultList = apply(resultList.join, tuple(join))
    if page!=None:
        resultList=resultList.order_by(orderBy).offset(page.offset).limit(page.limit)
    resultList=resultList.all()
    result=apply(Session.query,tuple(clzz))
    if join!=None:
        result=apply(result.join,tuple(join))
    count=apply(result.filter,tuple(queryParam)).count()
    return {"resultList":resultList,"count":count}
@with_session
def queryData(clazz):
    object =  Session.query(clazz)
    Session.flush()
    Session.commit()
    # Session.close()
    return object
@with_session
def update(update):
    return object.update(update)
@with_session
def add(obj):
    result=Session.add(obj)
    Session.flush()
    Session.commit()
    return result
@with_session
def execute(sql):
    try:
        result = Session.execute(text(sql))#.fetchall()#.offset(0).limit(10)
        Session.flush()
        Session.commit()
    except Exception ,e:
        Session.rollback()
        logging.error('querySql:%s:error:%s' % (sql, e))
        return []
    # finally:
    #     Session.close()
    return result
@with_session
def querySql(sql):
    try:
        result = Session.execute(text(sql)).fetchall()#.offset(0).limit(10)
        Session.flush()
        Session.commit()
    except Exception ,e:
        logging.error('querySql:%s:error:%s'%(sql,e))
        Session.rollback()
        return []
    # finally:
    #     Session.close()
    return result
@with_session
def count(obj,param=None):
    object= Session.query(func.count('id')).select_from(obj).filter(param).scalar()
    # Session.close()
    return object
def like(name):
    return name
def exp(name):
    if name.find("like")!=-1:
        return {"field":eval(name),"isLike":True}
    else:
        return name
def initialQueryParam(data,clzz,queryParam,flag=False):
    for key in data.keys():
        # keyDict=exp(key)
        # isLike=False
        value=data.get(key)
        # if type(keyDict) == dict:
        #     key = keyDict.get("field")
        #     isLike = keyDict.get("isLike") or False
        #如果是-1则表示查询全部，参数忽略
        if str(value)=="-1":
            continue
        if hasattr(clzz, key):
            attr = getattr(clzz, key)
            if value == None and not flag:
                continue
            if isinstance(attr, InstrumentedAttribute):
                if type(value)==dict:
                    print getattr(attr,value.get("condition"))
                    queryParam.append(apply(getattr(attr,value.get("condition")),tuple([value.get("value")])))
                else:
                    queryParam.append(attr == value)
                # if hasattr(attr, "primary_key") and attr.primary_key == True:
                # if isLike:
                #     queryParam.append(attr.like("%"+value+"%"))
                # else:
                #     queryParam.append(attr == value)
                # else:
                #     updateParam[attr] = value
    return queryParam
#flag表示没有设置字段的话则不处理
def updateByPrimary(object,clzz,flag=False):
    data = clzz.__dict__
    updateParam={}
    queryParam=[]
    for key in data.keys():
        if hasattr(clzz,key):
            attr=getattr(clzz, key)
            value=getattr(object,key)
            if value==None and not flag:
                continue
            if isinstance(attr,InstrumentedAttribute):
                if hasattr(attr,"primary_key") and attr.primary_key==True:
                    queryParam.append(attr==value)
                else:
                    updateParam[attr]=value
    result= apply(Session.query(clzz).filter,tuple(queryParam)).update(updateParam)
    Session.commit()
    return result
@with_session
def updateByPrimaryNotNull(object,clzz):
    return updateByPrimary(object,clzz,True)

if __name__=="__main__":
    try:
        1 / 0
    except Exception,e:
        print type(e)==exceptions.ZeroDivisionError
    print

