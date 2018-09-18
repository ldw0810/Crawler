# coding=utf-8
import uuid
from datetime import datetime
from sqlalchemy import Boolean
from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import ForeignKey
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import func
from sqlalchemy import select
from sqlalchemy import text
from sqlalchemy.orm import aliased, relationship, backref
from sqlalchemy.orm import deferred, column_property
from sqlalchemy.orm import object_session

from beans.BaseBean import Base
from beans.BaseBean import BaseBean


class TaskJobHistoryType():
    BATCH = "1"
    SINGLE = "0"
    SEARCHTASKTYPE = "2"
    DEPTH = "3"  # 设置深度值进行全网爬取


class TaskStatus():
    WAITING = 0
    RUNNING = 1
    STOP = 2
    FAIL = 3
    SUCCESS = 4
    PAUSE = 5


class ProxyType():
    NONE = "0"
    STATIC = "1"
    DYNAMIC_FOR_USER = "2"
    DYNAMIC_FOR_URL = "3"


TaskType = TaskJobHistoryType


class TaskJobHistory(BaseBean, Base):
    __tablename__ = "task_job_history"
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    type = Column("type", String(120))
    status = Column("status", String(8))
    userId = Column("user_id", String(50))
    taskJobId = Column("task_job_id", String(50))

    def __init__(self, id=None, delFlag=False, createTime=None, type=None, status=None, userId=None, taskJobId=None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag = delFlag
        self.createTime = createTime if createTime != None else datetime.now()
        self.type = type
        self.status = status
        self.userId = userId
        self.taskJobId = taskJobId


class TaskJobCrawlerHistory(BaseBean, Base):
    __tablename__ = "task_job_crawler_history"
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    taskJobHistoryId = Column("task_job_history_id", String(50))
    jobTemplateId = Column("job_template_id", String(50))
    url = Column("url", String(1024))

    def __init__(self, id=None, delFlag=False, createTime=None, taskJobHistoryId=None, jobTemplateId=None, url=None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag = delFlag
        self.createTime = createTime if createTime != None else datetime.now()
        self.taskJobHistoryId = taskJobHistoryId
        self.jobTemplateId = jobTemplateId
        self.url = url


class ContentType(BaseBean, Base):
    __tablename__ = 'content_type'
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    name = Column("name", String(255))
    parentId = Column("parent_id", String(50))

    def __init__(self, id=None, delFlag=False, createTime=datetime.now(), name=None, parentId=-1):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag = delFlag
        self.createTime = createTime
        self.name = name
        self.parentId = parentId


class StaticProxyInfo(BaseBean, Base):
    __tablename__ = "static_proxy_info"
    id = Column("id", String(50), primary_key=True)
    host = Column("host", String(50))
    port = Column("port", String(8))
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    proxyInfoId = Column("proxy_info_id", String(50))

    def __init__(self, id=None, host=None, port=None, delFlag=False, createTime=datetime.now(), proxyInfoId=None):
        self.id = self.id if self.id != None else uuid.uuid1()
        self.host = host
        self.port = port
        self.delFlag = delFlag
        self.createTime = createTime
        self.proxyInfoId = proxyInfoId


class ProxyInfo(BaseBean, Base):
    __tablename__ = 'proxy_info'
    id = Column("id", String(50), primary_key=True)
    hostName = Column("host_name", String(255))
    port = Column("port", String(8))
    delFlag = Column("del_flag", Boolean)
    taskJobId = Column("task_job_id", String(255))
    createTime = Column("create_time", DateTime)
    userName = Column("user_name", String(255))
    password = Column("password", String(255))
    authUrl = Column("auth_url", String(255))
    fileId = Column("file_id", String(255))
    type = Column("type", String(255))

    def __init__(self, id=None, hostName=None, port=None, delFlag=False, taskJobId=None,
                 createTime=datetime.now(), userName=None, password=None, authUrl=None,
                 fileId=None,
                 type=ProxyType.STATIC):
        self.id = self.id if self.id != None else uuid.uuid1()
        self.hostName = hostName
        self.port = port
        self.delFlag = delFlag
        self.taskJobId = taskJobId
        self.createTime = createTime
        self.userName = userName
        self.password = password
        self.authUrl = authUrl
        self.type = type
        self.fileId = fileId


class TaskJobDetail(BaseBean):
    def __init__(self, dbSourse, taskJob, childList, parent, timerJob, jobTemplate, jobTemplateList, taskReFieldList,
                 childrenList):
        self.dbSourse = dbSourse
        self.timerJob = timerJob
        self.brotherList = childList
        self.taskJob = taskJob
        self.parent = parent
        self.jobTemplate = jobTemplate
        self.jobTemplateList = jobTemplateList
        self.taskReFieldList = taskReFieldList
        self.childrenList = childrenList


class SimulationRequestParams(BaseBean, Base):
    __tablename__ = 'simulation_header_params'
    id = Column("id", String(50), primary_key=True)
    paramName = Column("param_name", String(255))
    paramValue = Column("param_value", String(1024))
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    type = Column("type", String(10))
    taskJobId = Column("task_job_id", String(50))

    def __init__(self, id=None, paramName=None, paramValue=None, delFlag=False, createTime=None, type="2",
                 taskJobId=None):
        self.id = id if id != None else uuid.uuid1()
        self.paramName = paramName
        self.paramValue = paramValue
        self.delDlag = delFlag
        self.createTime = createTime
        self.type = type
        self.taskJobId = taskJobId


class TaskJobCount(BaseBean, Base):
    __tablename__ = 'task_job'
    id = Column("id", String(50), primary_key=True)
    parentId = Column("parent_id", String(50))
    delFlag = Column("del_flag", Boolean)

    def __init__(self, id, parentId, delFlag):
        self.id = id
        self.parentId = parentId
        self.delFlag = delFlag


taskJobCount = aliased(TaskJobCount, name='task_job_count')


class TaskJob(BaseBean, Base):
    __tablename__ = 'task_job'
    __table_args__ = {"extend_existing": True}
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    name = Column("name", String(255))
    url = Column("url", String(255))
    type = Column("type", Integer)
    status = Column("status", Integer)
    tableName = Column("table_name", String(255))
    jobTemplateId = Column("job_template_id", String(255))
    parentId = Column("parent_id", String(50))
    createUserId = Column("create_user_id", String(50))
    grapPeriod = Column("grap_period", Integer)
    grapInterval = Column("grap_interval", Integer)
    pageLimit = Column("page_limit", Integer)
    pageOffset = Column("page_offset", Integer)
    proxyType = Column("proxy_type", String(50))
    encodeTypeId = Column("encode_type_id", String(50))
    proxyId = Column("proxy_id", String(50))
    databaseId = Column("database_id", String(50))
    taskJobTimerId = Column("task_job_timer_id", String(50))
    lastExecuteTime = Column("last_execute_time", DateTime)
    contentTypeId = Column("content_type_id", String(50), ForeignKey("content_type.id"))  #
    executeStatus = Column("execute_status", String(5))
    contentType = relationship("ContentType")
    keyWord = Column("key_word", String(255))
    depthLimit = Column("depth_limit", Integer, default=0)  # 深度爬取时的深度设置
    key = "id"
    childrenNum = column_property(
        select([func.count(taskJobCount.id)]). \
            where(taskJobCount.parentId == id). \
            correlate_except(taskJobCount)
    )
    curUrlDepth = 1  # 当前url的深度值（在全网深度爬取的时候才会用到）
    parentUrl = None  # 深度爬取时，用来标记父url

    def __init__(self, id=None, delFlag=None, createTime=None, name=None,
                 url=None, type=None, createUserId=None, status=None, jobTemplateId=None, tableName=None,
                 parentId=None, proxyId=None,
                 grapPeriod=None, grapInterval=None, pageLimit=None, proxyType=None, encodeTypeId=None,
                 databaseId=None, lastExecuteTime=None, ext={}, taskJobTimerId=None,
                 contentTypeId=None, executeStatus=None, page_offset=1, keyWord=None, depthLimit=None, curUrlDepth=1):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag = delFlag if delFlag != None else 0
        self.createTime = createTime if createTime != None else datetime.now()
        self.name = name
        self.url = url
        self.type = type
        self.createUserId = createUserId
        self.status = status
        self.jobTemplateId = jobTemplateId
        self.tableName = tableName
        self.parentId = parentId
        self.grapPeriod = grapPeriod
        self.grapInterval = grapInterval
        self.pageLimit = pageLimit
        self.proxyType = proxyType
        self.encodeTypeId = encodeTypeId
        self.databaseId = databaseId
        self.lastExecuteTime = lastExecuteTime
        self.ext = ext
        self.taskJobTimerId = taskJobTimerId
        self.proxyId = proxyId
        self.contentTypeId = contentTypeId
        self.executeStatus = executeStatus
        self.countFlag = None
        self.pageOffset = page_offset
        self.keyWord = keyWord
        self.depthLimit = depthLimit
        self.curUrlDepth = curUrlDepth


totalSelect = select([func.count(TaskJob.id), ]).group_by(TaskJob.parentId)


class EncodeType(BaseBean, Base):
    __tablename__ = 'encode_type'
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    encodeName = Column("encode_name", String(255))
    taskJobId = Column("task_job_id", String(255))
    encodeValue = Column("encode_value", Integer)

    def __init__(self, id=None, delFlag=None, createTime=None, encodeName=None, taskJobId=None, encodeValue=None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag = delFlag
        self.createTime = createTime
        self.encodeName = encodeName
        self.taskJobId = taskJobId
        self.encodeValue = encodeValue


class TaskJobParam(BaseBean, Base):
    __tablename__ = 'task_job_param'
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    paramNameEn = Column("param_name_en", String(255))
    paramNameCn = Column("param_name_cn", String(255))
    paramValue = Column("param_value", String(255))
    paramCondition = Column("param_condition", Integer)
    nextParamValue = Column("next_param_value", String(255))
    createTime = Column("create_time", DateTime)
    type = Column("type", String(5))
    createUserId = Column("create_user_id", String(255))
    taskJobId = Column("task_job_id", String(255))

    def __init__(self, id=None, delFlag=False, paramNameEn=None, paramNameCn=None, paramValue=None,
                 paramCondition=None, nextParamValue=None, createTime=None, type=0, createUserId=None, taskJobId=None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag = delFlag
        self.paramNameEn = paramNameEn
        self.paramNameCn = paramNameCn
        self.paramValue = paramValue
        self.paramCondition = paramCondition
        self.nextParamValue = nextParamValue
        self.createTime = createTime
        self.type = type
        self.createUserId = createUserId
        self.taskJobId = taskJobId


class DbSource(BaseBean, Base):
    __tablename__ = 'db_source'
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    username = Column("username", String(255))
    password = Column("password", String(255))
    dbname = Column("dbname", String(255))
    port = Column("port", Integer)
    url = Column("url", String(255))
    # oracle,mysql,sqlserver,kafka,hdfs
    type = Column("type", Integer)
    charset = Column("charset", Integer)
    host = Column("host", String(50))
    topic = Column("topic", String(50))

    def __init__(self, id=None, delFlag=None, createTime=datetime.now(), username=None, port=None,
                 password=None, dbname=None, type=None, charset=None, host=None, topic=None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag = delFlag
        self.createTime = createTime
        self.username = username
        self.password = password
        self.dbname = dbname
        self.type = type
        self.charset = charset
        self.host = host
        self.topic = topic
        self.port = port


class TaskJobReTemplate(BaseBean, Base):
    __tablename__ = "task_job_re_template"
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    jobTemplateId = Column("job_template_id", String(50))
    taskJobId = Column("task_job_id", DateTime)
    createUserId = Column("create_user_id", DateTime)
    fieldIds = Column("field_ids", DateTime)

    def __init__(self, id=None, fieldIds=None, delFlag=False, createTime=None, jobTemplateId=None, taskJobId=None,
                 createUserId=None):
        self.id = id if id != None else uuid.uuid1()
        self.createTime = createTime if createTime != None else datetime.now()
        self.jobTemplateId = jobTemplateId
        self.taskJobId = taskJobId
        self.createUserId = createUserId
        self.fieldIds = fieldIds


class TaskJobTimer(BaseBean, Base):
    __tablename__ = 'task_job_timer'
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTime = Column("create_time", DateTime)
    startTime = Column("start_time", DateTime)
    hour = Column("hour", Integer)
    minute = Column("minute", Integer)
    weekDay = Column("week_day", String(255))
    monthDay = Column("month_day", String(255))
    yearMonth = Column("year_month", String(255))
    endTime = Column("end_time", Integer)
    repeatTime = Column("repeat_time", Integer)

    def __init__(self, id=None, delFlag=None, createTime=datetime.now(), hour=None, startTime=None, monthDay=None,
                 minute=None, weekDay=None, yearMonth=None, endTime=None, repeatTime=None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag = delFlag
        self.monthDay = monthDay
        self.createTime = createTime
        self.hour = hour
        self.weekDay = weekDay
        self.minute = minute
        self.yearMonth = yearMonth
        self.endTime = endTime
        self.repeatTime = repeatTime
        self.startTime = startTime


# class TestAAA():
#     def __init__(self):
#         print "asd"
if __name__ == "__main__":
    print select([text("count(1)")]).select_from(text("task_job")).group_by(text("task_job.parent_id"))
