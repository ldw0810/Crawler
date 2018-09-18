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

class TotalReInfoField(BaseBean,Base):
    __tablename__ = 's_total_info'
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTtime = Column("create_time", DateTime)
    periodType = Column("period_type", Integer)
    timeDis = Column("time_dis", String(512))
    contentType = Column("content_type", Integer)
    tortCnt = Column("tort_cnt", Integer)
    def __init__(self, id=None, delFlag=0, createTtime="",
                 periodType=None, timeDis=None, contentType=None, tortCnt = None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag = delFlag
        self.createTtime = createTtime
        self.periodType = periodType
        self.timeDis = timeDis
        self.contentType = contentType
        self.tortCnt = tortCnt

class TortReInfoField(BaseBean,Base):
    __tablename__ = 's_tort_info'
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTtime = Column("create_time", DateTime)
    contentType = Column("content_type", Integer)
    totalCnt = Column("total_cnt", Integer)
    def __init__(self, id=None, delFlag=0, createTtime="",
                  contentType=None, totalCnt = None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag = delFlag
        self.createTtime = createTtime
        self.contentType = contentType
        self.totalCnt = totalCnt