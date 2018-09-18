# coding=utf-8
import uuid
from datetime import datetime

from sqlalchemy import Boolean
from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import func
from beans.BaseBean import BaseBean, Base


class UrlStatus():
    WAITING = 0
    RUNNING = 1
    STOP = 2
    FAIL = 3
    SUCCESS = 4
    PAUSE = 5


class UrlClazz(BaseBean, Base):
    __tablename__ = 'url_list_status'
    id = Column(String(50), primary_key=True, default=lambda: unicode(uuid.uuid1()).replace('-', ''))
    url = Column(String(1024))
    parentUrl = Column(String(1024))
    jobTemplateId = Column(String(50), default='-1')
    jobTemplateParentId = Column(String(50), default='-1')
    status = Column(Integer, default=0)
    taskJobId = Column(String(50))
    taskJobHistoryId = Column(String(50))
    createTime = Column(DateTime, default=func.now())
    desc = Column(String(2048))
    delFlag = Column(Boolean)

    def __init__(self, id=None, url=None, parentUrl="-1", jobTemplateId="-1", jobTemplateParentId="-1",
                 status=UrlStatus.WAITING, taskJobId=None, taskJobHistoryId=None, desc=None, delFlag=False):
        self.id = id or unicode(uuid.uuid1()).replace('-', '')
        self.url = url or ""
        self.parentUrl = parentUrl or "-1"
        self.jobTemplateId = jobTemplateId or "-1"
        self.jobTemplateParentId = jobTemplateParentId or "-1"
        self.status = status or 0
        self.taskJobId = taskJobId
        self.taskJobHistoryId = taskJobHistoryId
        self.createTime = datetime.now()
        self.desc = desc
        self.delFlag = delFlag

        # def __repr__(self):
        #     tempDict = {
        #         "url": self.url,
        #         "status": self.status,
        #         "desc": self.desc,
        #         "jobTemplateId": self.jobTemplateId,
        #         "jobTemplateParentId": self.jobTemplateParentId
        #     }
        #     return str(tempDict)
