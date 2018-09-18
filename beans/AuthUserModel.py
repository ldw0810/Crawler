# -*- coding:utf-8 -*-
from sqlalchemy import Column,Integer,String
from sqlalchemy import create_engine,ForeignKey,Column,Integer,String,Text,DateTime,\
    and_,or_,SmallInteger,Float,DECIMAL,desc,asc,Table,join,event,VARCHAR,Boolean,SMALLINT
from sqlalchemy.orm import relationship,backref,sessionmaker,scoped_session,aliased,mapper
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import MetaData
from sqlalchemy.ext.hybrid import hybrid_property,hybrid_method
from sqlalchemy.orm.collections import attribute_mapped_collection
import datetime
import uuid
# engine = create_engine('mysql+mysqldb://root:root@10.128.100.132/demo?charset=utf8',echo = True,pool_recycle=7200)
# Base = declarative_base()
from beans.BaseBean import Base, BaseBean
from dao import baseEngine

DBSession = sessionmaker(bind=baseEngine)
# db = scoped_session(sessionmaker(autocommit=False, autoflush=False, bind=engine))
# Base.query = DBSession.query_property()


class AuthUser(BaseBean,Base):

    __tablename__ = 'Auth_user'
    id = Column('ID',VARCHAR(50), primary_key=True, default=lambda key: uuid.uuid4(), nullable=False)  # 用户ID
    password = Column('PASSWORD',VARCHAR(50), nullable=False)  # 密码
    username = Column('USER_NAME',VARCHAR(20), nullable=False)  # 用户中文名称
    loginname = Column('Login_Name',VARCHAR(20), nullable=False)  # 登陆账号
    email = Column('EMAIL',VARCHAR(250), nullable=True)  # 邮箱
    phone = Column('PHONE',VARCHAR(50), nullable=True)  # 手机号
    delflag = Column('DEF_FLAG',Boolean, nullable=False)  # 删除标志
    status = Column('STATUS',SMALLINT, nullable=False)  # 状态
    parentid = Column('PARENT_ID',VARCHAR(50), nullable=False)  # 父用户id
    type = Column('TYPE',SMALLINT, nullable=False)  # 类型
    groupid = Column('GROUP_ID',VARCHAR(50), nullable=False)  # 用户所属组id
    createtime = Column('CREATE_TIME',DateTime, nullable=False)  # 创建时间
    modifytime = Column('MODIFY_TIMES',DateTime, nullable=False)  # 更新时间


class AuthUserSession(Base):

    __tablename__ = 'Auth_user_session'
    id = Column('ID',String(50), primary_key=True, default=lambda key: uuid.uuid4(), nullable=False)  # 系统内部唯一标识
    sessionid = Column('SESSION_ID',String(50), nullable=False)  # 会话id
    createtime = Column('CREATE_TIME',DateTime, nullable=False)
    expiretime = Column('EXPIRE_TIME',DateTime, nullable=False)
    userid = Column('USER_ID',String(50), nullable=False)  # 用户id
    delflag = Column('DEF_FLAG', Boolean, nullable=False)  # 删除标志
    # authuser =  relationship('AuthUser', backref= backref('Auth_User_Session'), lazy='dynamic', uselist=False)

    def __init__(self, sessionid, createtime, exipiretime, userid, delflag):
        self.sessionid = sessionid
        self.expiretime = exipiretime
        self.createtime = createtime
        self.userid = userid
        self.delflag = delflag

# if __name__ == '__main__':
#     Base.metadata.create_all(engine)

