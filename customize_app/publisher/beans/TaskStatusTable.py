import uuid

from sqlalchemy import Boolean
from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import ForeignKey
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy.orm import relationship
from beans.BaseBean import BaseBean, Base
from dao.BaseDao import query, querySql


class TaskStatusInfoField(BaseBean,Base):
    __tablename__ = 's_taskstatus_info'
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTtime = Column("create_time", DateTime)
    contentType = Column("content_type", Integer)
    taskJobId = Column("task_job_id", String(50))
    taskStatus = Column("task_status", String(50))
    def __init__(self, id=None, delFlag=0, createTtime="",
                 contentType=None,taskJobId=None, taskStatus=None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag = delFlag
        self.createTtime = createTtime
        self.contentType = contentType
        self.taskJobId = taskJobId
        self.taskStatus = taskStatus
