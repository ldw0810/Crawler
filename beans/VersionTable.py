#coding=utf-8
#Created by xutao on 2017-08-07.
import uuid

from sqlalchemy import Boolean
from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import String
from beans.BaseBean import BaseBean, Base


class Version(BaseBean, Base):
    __tablename__ = 't_version'
    id = Column('id', String(50), primary_key=True)
    versionCode=Column("version_code",String(255))
    description=Column("description",String(1024))
    releaseNote=Column("release_note",String(1024))
    delFlag=Column("del_flag",Boolean)
    createTime=Column("create_time",DateTime)

    def __init__(self, id=None, delFlag=False, versionCode=None, description=None,releaseNote=None,createTime=None):
        self.id=id if id!=None else uuid.uuid1()
        self.delFlag=delFlag
        self.versionCode=versionCode
        self.description=description
        self.releaseNote=releaseNote
        self.createTime=createTime

