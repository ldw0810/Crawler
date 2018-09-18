# -*- coding: utf-8 -*-
import uuid
from datetime import datetime

from sqlalchemy import Boolean
from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import ForeignKey
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy.orm import relationship
from beans.BaseBean import BaseBean, Base
from dao.BaseDao import query, querySql
#模板字段字段表
from beans.TaskTable import TaskJob

class RequestType():
    DEFALT=0
    GET=1
    POST=2

class DataType():
    JSON="2"
    XPATH="1"
    STR='3'
class JobTemplateType(BaseBean,Base):
    __tablename__="job_template_type"
    id = Column("id",String(50), primary_key=True)
    delFlag = Column("del_flag",Boolean)
    name = Column("name",String(255))
    createTime = Column("create_time",DateTime)
    code = Column("code",String(255))
    def __init__(self,id=None,delFlag=False,name=None,createTime=None,code=None):
        self.id=id if id!=None else ""
        self.delFlag=delFlag
        self.name=name
        self.createTime=createTime if createTime!=None else datetime.now()
        self.code=code
class JobTemplate(BaseBean,Base):
    __tablename__ = 'job_template'
    id = Column("id",String(50), primary_key=True)
    delFlag = Column("del_flag",Boolean)
    flag = Column("flag",Boolean)
    name = Column("name",String(255))
    desc = Column("desc",String(1000))
    createTime = Column("create_time",DateTime)
    createUserId = Column("create_user_id",String(255))
    rootPath = Column("root_path",String(255))
    tableName = Column("base_table_name",String(255))
    url = Column("url",String(255))
    databaseId=Column("database_id",String(50))
    jobTemplateType = Column("job_template_type", String(255),ForeignKey("content_type.id"))
    templateType = relationship('ContentType')
    taskJobId=Column("task_job_id",String(255))
    parentId = Column("parent_id", String(255))
    encodeType = Column("encode_type", String(255))
    objectType = Column("object_type", String(8))
    requestType = Column("request_type", Integer)
    phantomjsFlag = Column("phantomjs_flag", Boolean)
    sleepTime = Column("sleep_time", Integer)
    taskJobHistoryId=None
    extraData=None
    parseType=Column("parse_type",String(255))

    cookie_flag = Column('cookie_flag', Boolean)
    cookie_obtain_url = Column('cookie_obtain_url', String(255))
    cookie_refresh_cycle = Column('cookie_refresh_cycle', Integer)
    userLoginBehaviorId = Column("u_login_behavior_id", String(50), ForeignKey("user_login_behavior.id"))
    userLoginBehavior = relationship('UserLoginBehavior')
    autoLogin = Column('auto_login', Boolean)
    chromeFlag = Column('chrome_flag', Boolean)
    def __init__(self,id=None,delFlag=0,flag=0,name=None,
                 desc=None,createTime=None,createUserId=None,phantomjsFlag=False,
                 rootPath=None,tableName=None,url=None,taskJobId=None,requestType=RequestType.DEFALT,sleepTime=None,
                 databaseId=None,jobTemplateType=None,parentId=None,encodeType=None,objectType=None,parseType=None,
                 cookie=None,cookie_flag=False, cookie_obtain_url=None, cookie_refresh_cycle=-1,autoLogin=None,chromeFlag=False):

        self.id=id if id!=None else uuid.uuid1()
        self.delFlag=delFlag
        self.flag=flag
        self.name=name
        self.createTime=createTime
        self.desc=desc
        self.createUserId=createUserId
        self.rootPath=rootPath
        self.url=url
        self.tableName=tableName
        self.databaseId=databaseId
        self.jobTemplateType=jobTemplateType
        self.parentId=parentId
        self.encodeType=encodeType
        self.objectType=objectType
        self.taskJobId=taskJobId
        self.requestType=requestType
        self.phantomjsFlag=phantomjsFlag
        self.parseType=parseType
        self.sleepTime=sleepTime
        self.extraData={}
        self.autoLogin = autoLogin
        self.chromeFlag = chromeFlag
class JobTemplateParam(BaseBean,Base):
    __tablename__ = 'job_template_param'
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    paramNameEn = Column("param_name_en", String(255))
    paramNameCn = Column("param_name_cn", String(255))
    paramValue = Column("param_value", String(255))
    paramCondition = Column("param_condition", Integer)
    nextParamValue = Column("next_param_value", String(255))
    createTime = Column("create_time", DateTime)
    jobTemplateId = Column("job_template_id", String(50))
    type = Column("type", String(5))
    createUserId = Column("create_user_id", String(255))
    def __init__(self,id=None,delFlag=False,paramNameEn=None,paramNameCn=None,paramValue=None,
                 paramCondition=None,nextParamValue=None,createTime=None,type=0,createUserId=None,jobTemplateId=None):
        self.id=id if id!=None else uuid.uuid1()
        self.delFlag=delFlag
        self.paramNameEn=paramNameEn
        self.paramNameCn=paramNameCn
        self.paramValue=paramValue
        self.paramCondition=paramCondition
        self.nextParamValue=nextParamValue
        self.createTime=createTime
        self.type=type
        self.createUserId=createUserId
        self.jobTemplateId=jobTemplateId
class TaskJobReTemplateParam(BaseBean,Base):
    __tablename__="task_job_re_template_param"
    id = Column("id", String(50), primary_key=True)
    jobTemplateId = Column("job_template_id", String(50))
    jobTemplateParamId = Column("job_template_param_id", String(50))
    taskJobId = Column("task_job_id", String(50))
    createTime = Column("create_time", DateTime)
    createUserId = Column("create_user_id", String(50))
    def __init__(self,id=None,jobTemplateId=None,jobTemplateParamId=None,taskJobId=None,createTime=None,createUserId=None):
        self.id = id if id != None else uuid.uuid1()
        self.jobTemplateId=jobTemplateId
        self.jobTemplateParamId=jobTemplateParamId
        self.taskJobId=taskJobId
        self.createTime=createTime
        self.createUserId=createUserId
class JobTemplateField(BaseBean,Base):
    __tablename__ = 'job_template_field'
    id = Column("id",String(50), primary_key=True)
    delFlag = Column("del_flag",Boolean)
    fieldNameEn = Column("field_name_en",String(255))
    fieldNameCn = Column("field_name_cn",String(255))
    dataType = Column("data_type",String(255))
    dataLength = Column("data_length",Integer)
    createTime = Column("create_time",DateTime)
    createUserId = Column("create_user_id",String(255))
    jobTemplateId = Column("job_template_id",String(255))
    regExp = Column("reg_exp",String(255))
    split = Column("split",String(255))
    fieldValue = Column("field_value",String(255))
    func = Column("func",String(255))
    createTime = Column("create_time", DateTime)
    chooseFlag=None
    def __init__(self,id=None,delFlag=0,fieldNameEn="",fieldNameCn="",
                dataType=None,dataLength=None,createUserId=None,
                 jobTemplateId=None,regExp=None,split=None,fieldValue="",func=None,
                 createTime=None):
        self.id=id if id!=None else uuid.uuid1()
        self.delFlag=delFlag
        self.fieldNameEn=fieldNameEn
        self.fieldNameCn=fieldNameCn
        self.dataType=dataType
        self.dataLength=dataLength
        self.createUserId=createUserId
        self.jobTemplateId=jobTemplateId
        self.regExp=regExp
        self.split=split
        self.fieldValue=fieldValue
        self.func=func
        self.chooseFlag=None
        self.createTime=createTime
class TaskJobReField(BaseBean,Base):
    __tablename__ = 'task_job_re_field'
    id = Column("id",String(50), primary_key=True)
    delFlag = Column("del_flag",Boolean)
    taskJobId = Column("task_job_id",String(255), ForeignKey('task_job.id'))
    jobTemplateFieldId = Column("job_tempalte_field_id",String(255), ForeignKey('job_template_field.id'))
    jobTemplateId = Column("job_template_id",String(255), ForeignKey('job_template.id'))
    createTime = Column("create_time",DateTime)
    # taskJob=relationship(TaskJob,uselist=False)
    # jobTemplateField=relationship(JobTemplateField,uselist=False)
    # jobTemplate=relationship(JobTemplate,uselist=False)
    def __init__(self,id=None,delFlag=0,taskJobId="",J="",
                 jobTemplateId=None,createTime=None,jobTemplateFieldId=None):
        self.id=id if id!=None else uuid.uuid1()
        self.delFlag=delFlag
        self.taskJobId=taskJobId
        self.jobTemplateFieldId=jobTemplateFieldId
        self.jobTemplateId=jobTemplateId
        self.createTime=createTime
        self.taskJob=None
        self.jobTemplateField=None
        self.jobTemplate=None

    def __repr__(self):
        return repr((self.delFlag, self.taskJobId, self.jobTemplateFieldId, self.jobTemplateId, self.createTime, self.taskJob, self.jobTemplateField))

class UserLoginBehavior(BaseBean,Base):
    __tablename__ = 'user_login_behavior'
    id = Column("id", String(50), primary_key=True,default=lambda: unicode(uuid.uuid1()).replace('-', ''))
    userId = Column("user_id", String(255))
    passWord = Column("pass_word", String(255))
    userLabel = Column("user_label", String(255))
    passWordLabel = Column("pass_word_label", String(255))
    vertInputLabel = Column("vert_input_label", String(255))
    vertImageLabel = Column("vert_img_label", String(255))
    loginLabel = Column("login_label", String(255))

class CrawlerDataListener(BaseBean,Base):
    __tablename__ = 'data_listener'
    id = Column("id", String(50), primary_key=True,default=lambda: unicode(uuid.uuid1()).replace('-', ''))
    time = Column("time", String(50))
    count=Column("count", String(255))
    totle=Column("totle", String(255))
    createTime = Column("create_time", DateTime)

if __name__=="__main__":
    print querySql("select * from task_job_re_field where task_job_id=1")