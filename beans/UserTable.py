# coding=utf-8
import uuid

from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import BOOLEAN
from sqlalchemy import ForeignKey
from sqlalchemy import func
from sqlalchemy.orm import relationship
from beans.BaseBean import BaseBean, Base


class User(BaseBean, Base):
    __tablename__ = 'auth_user'
    id = Column('ID', String(50), primary_key=True, default=lambda: unicode(uuid.uuid1()).replace('-', ''))
    password = Column('PASSWORD', String(50))
    userName = Column('USER_NAME', String(20))
    loginName = Column('LOGIN_NAME', String(20))
    email = Column('EMAIL', String(250))
    phone = Column('PHONE', String(20))
    delFlag = Column('DEL_FLAG', Integer, default=0)
    status = Column('STATUS', Integer, default=0)
    parentId = Column('PARENT_ID', String(50), default='-1')
    type = Column('TYPE', Integer, default=0)
    # group = relationship('Group')
    # groupId = Column('GROUP_ID', String(50),ForeignKey('group.id'))
    groupId = Column('GROUP_ID', String(50))
    createTime = Column('CREATE_TIME', DateTime, default=func.now())
    modefyTime = Column('MODEFY_TIME', DateTime, default=func.now())

class Group(BaseBean,Base):
    __tablename__= 'Auth_group'
    id = Column('ID', String(50), primary_key=True, default=lambda: unicode(uuid.uuid1()).replace('-', ''))
    name = Column('NAME', String(250))
    delFlag = Column('DEL_FLAG', BOOLEAN, default=False)
    type = Column('TYPE',Integer)
    code = Column('CODE',String(10))

class Permission(BaseBean,Base):
    __tablename__= 'Auth_permission'
    id = Column('ID', String(50), primary_key=True, default=lambda: unicode(uuid.uuid1()).replace('-', ''))
    name = Column('NAME', String(50))
    code = Column('CODE', String(10))
    content = Column('CONTENT',String(1000))
    delFlag = Column('DEL_FLAG', BOOLEAN, default=False)
    type = Column('TYPE',Integer)

class Group_re_permission(BaseBean,Base):
    __tablename__ = 'Auth_group_re_permission'
    id = Column('ID', String(50), primary_key=True, default=lambda: unicode(uuid.uuid1()).replace('-', ''))
    delFlag = Column('DEL_FLAG', BOOLEAN, default=False)
    # group = relationship('Group')
    # groupId = Column('GROUP_ID', String(50), ForeignKey('group.id'))
    # permission = relationship('Permission')
    # permission_id = Column('PERMISSION_ID', String(50),ForeignKey('permission.id'))
    groupId = Column('GROUP_ID', String(50))
    permissionId = Column('PERMISSION_ID', String(50))