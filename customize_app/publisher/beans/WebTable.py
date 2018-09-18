#coding=utf-8
#Created by xutao on 2017-05-09.
import uuid
from datetime import datetime

from sqlalchemy import Boolean
from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import String
from sqlalchemy.dialects.mysql import DOUBLE

from beans.BaseBean import Base
from beans.BaseBean import BaseBean
class JobStatus():
    WAIT_RUNNING=0
    RUNNING=1
    SUCCESS=2
    FAIL=3
    STOP=4
    PERSONAL_CONFIRM=5
    SAVE=6
SearchTaskType="SearchTaskType"
#流程表
class TaskFlow(BaseBean,Base):
    __tablename__="p_task_flow"
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    taskJobId = Column("task_job_id", String(50))
    status = Column("status", String(5))
    flowName = Column("flow_name", String(50))
    parentId = Column("parent_id", String(50))
    # 流程状态
    # 0：待运行
    # 1：正在运行
    # 2：成功
    # 3:失败
    def __init__(self,id=None,delFlag=False,createTime=None,taskJobId=None,status=None,flowName=None,parentId=None):
        self.id=id
        self.delFlag=delFlag
        self.createTime=createTime
        self.taskJobId=taskJobId
        self.status=status
        self.flowName=flowName
        self.parentId=parentId
class WhiteAndBlackList(BaseBean,Base):
    __tablename__ = "p_white_and_black_list"
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    ip = Column("ip", String(50))
    port = Column("port", String(8))
    type = Column("type", String(50))
    hostName = Column("host_name", String(50))
    objectId = Column("object_id", String(1042))
    objectType = Column("object_type", String(50))
    def __init__(self,id=None,delFlag=False,
                 createTime=None,ip=None,port=None,type=None,hostName=None,
                 objectId=None,objectType=None):
        self.id=id
        self.delFlag=delFlag
        self.createTime=createTime
        self.ip=ip
        self.port=port
        self.type=type
        self.hostName=hostName
        self.objectId=objectId
        self.objectType=objectType
class FieldWeight(BaseBean,Base):
    __tablename__="p_field_weight"
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    fieldNameEn = Column("field_name_en", String(512))
    fieldNameCn = Column("field_name_cn", String(512))
    type = Column("type", String(8))
    weight = Column("weight", DOUBLE)
    def __init__(self,id=None,delFlag=False,createTime=None,fieldNameEn=None,fieldNameCn=None,type=None,weight=None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag=delFlag
        self.createTime=createTime
        self.fieldNameEn=fieldNameEn
        self.fieldNameCn=fieldNameCn
        self.type=type
        self.weight=weight

# class Area(BaseBean,Base):
#     __tablename__="p_area"
#     id = Column("id", String(50), primary_key=True)
#     delFlag = Column("del_flag", Boolean)
#     createTime = Column("create_time", DateTime)
#     province = Column("province", String(8))
#     city = Column("city", String(8))
#     country = Column("country", String(8))
#     lat = Column("lat", DOUBLE)
#     lng = Column("lng", DOUBLE)
#     code = Column("code", String(8))
#     def __init__(self,id=None,delFlag=False,createTime=None,province=None,city=None,country=None,lat=None,lng=None,code=None):
#         self.id=id
#         self.delFlag=delFlag
#         self.createTime=createTime
#         self.province=province
#         self.city=city
#         self.country=country
#         self.lat=lat
#         self.lng=lng
#         self.code=code

class IpStorage(BaseBean,Base):
    __tablename__="p_ip_storage"
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    hostName = Column("host_name", String(1024))
    ip = Column("ip", String(50))
    port = Column("port", String(8))
    areaId = Column("area_id", String(50))
    def __init__(self,id=None,delFlag=False,createTime=None,hostName=None,ip=None,port=None,areaId=None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag=delFlag
        self.createTime=createTime
        self.hostName=hostName
        self.ip=ip
        self.port=port
        self.areaId=areaId
class SaveEvidence(BaseBean,Base):
    __tablename__ = "p_save_evidence"
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    status = Column("status", String(1024))
    url = Column("url", String(50))
    port = Column("key", String(100))
    def __init__(self,id=None,delFlag=False,createTime=None,status=None,url=None,port=None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag=delFlag
        self.createTime=createTime
        self.status=status
        self.url=url
        self.port=port
class BaseInfo(BaseBean,Base):
    __tablename__ = "p_base_info"
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    type = Column("type", String(1024))
    url = Column("url", String(1024))
    match_degree = Column("match_degree", String(10))
    field_id = Column("field_id", String(512))
    field_value = Column("field_value", String(512))
    field_flag = Column("field_flag", String(5))
    task_job_id = Column("task_job_id", String(50))
    def __init__(self,id=None,defFlag=False,createTime=None,type=None,url=None,match_degree=None,
                 field_id=None,field_value=None,field_flag=None,task_job_id=None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag=defFlag
        self.createTime=createTime
        self.type=type
        self.url=url
        self.match_degree=match_degree
        self.field_id=field_id
        self.field_value=field_value
        self.task_job_id=task_job_id
        self.field_flag=field_flag
# class ContentInfo(BaseBean,Base):
#     __tablename__ = "p_content_info"
#     id = Column("id", String(50), primary_key=True)
#     delFlag = Column("del_flag", Boolean)
#     createTime = Column("create_time", DateTime)
#     type = Column("type", String(1024))
#     url = Column("url", String(1024))
#     match_degree = Column("match_degree", String(10))
#     field_id = Column("field_id", String(512))
#     field_value = Column("field_value", String(512))
#     task_job_id = Column("task_job_id", String(50))
class SearchTaskJob(BaseBean,Base):
    __tablename__="p_search_task_job"
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    name = Column("name", String(255))
    key = Column("key", String(255))
    status = Column("status", String(255))
    executeStatus = Column("execute_status", String(255))
    type = Column("type", String(255))
    createUserId = Column("create_user_id", String(50))
    childIds = Column("child_ids", String(1024))
    def __init__(self,id=None,delFlag=False,createTime=datetime.now(),name=None,key=None,status=None,executeStatus=0,type=None,createUserId=None,childIds=None):
        self.id=id if id!=None else uuid.uuid1()
        self.delFlag=delFlag
        self.createTime=createTime
        self.name=name
        self.key=key
        self.status=status
        self.executeStatus=executeStatus
        self.type=type
        self.createUserId=createUserId
        self.childIds=childIds