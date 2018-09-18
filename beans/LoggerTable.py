#coding=utf-8
#Created by xutao on 2017-04-28.
import uuid

from sqlalchemy import Boolean
from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import String
from beans.BaseBean import BaseBean, Base

class LogInfo(BaseBean,Base):
    __tablename__ = 'log_info'
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag",Boolean)
    createTime = Column("create_time", DateTime)
    userId = Column("user_id", String(255))
    objectId = Column("object_id", String(1024))
    type = Column("type", String(10))
    content = Column("content", String(2048))
    taskJobHistoryId = Column("task_job_history_id", String(50))
    jobTemplateId = Column("job_template_id", String(50))
    url = Column("url", String(50))
    status = Column("status", String(10))
    def __init__(self,id=None,userId=None,status=None,objectId=None,delFlag=False,createTime=None,type="-1",content=None,taskJobHistoryId=None,
                 jobTemplateId=None,url=None):
        self.id = id if id != None else uuid.uuid1()
        self.delDlag=delFlag
        self.createTime=createTime
        self.type=type
        self.userId=userId
        self.objectId=objectId
        self.content=content
        self.url=url
        self.taskJobHistoryId=taskJobHistoryId
        self.jobTemplateId=jobTemplateId
        self.status=status