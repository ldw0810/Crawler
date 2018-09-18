#coding=utf-8
import uuid
from datetime import datetime

from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import ForeignKey
from sqlalchemy import MetaData
from sqlalchemy import String,BOOLEAN
from sqlalchemy import Table
from sqlalchemy import create_engine
from sqlalchemy import text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, mapper
from sqlalchemy.pool import NullPool

from beans.BaseBean import BaseBean, Base
db_config={
        'host': 'localhost',
        'user': 'root',
        'passwd': '123456',
        'db':'hqwtest',
        'charset':'utf8'
    }
engine = create_engine('mysql://%s:%s@%s/%s?charset=%s'%(db_config['user'],
                                                             db_config['passwd'],
                                                             db_config['host'],
                                                             db_config['db'],
                                                             db_config['charset']), echo=True,encoding='utf8', convert_unicode=True,poolclass=NullPool)

Session_class = sessionmaker(bind=engine)
Session = Session_class()
metadata = MetaData()


class PcWorkStatus():
    WAITING = 0
    RUNNING = 1
    STOP = 2
    FAIL = 3
    SUCCESS = 4
    PAUSE = 5


# url_static_config = Table('t_static_pc_info', metadata,
#             Column('ASSETID', String(50), primary_key=True),
#             Column('IP', String(50)),
#             Column('MEMORY', String(50)),
#             Column('HOSTNAME', String(320)),
#             Column('CPUPHYSICALNUM', String(1024)),
#             Column('DISKTOTAL', String(1024)),
#             Column('CPU_TOTAL', String(50)),
#             Column('CPU_CORE_NUM', String(50)),
#             Column('DEPLOYMENT', String(10)),
#             Column('STATUS', String(10)),
#             Column('CREATE_DATE',DateTime),
#             Column('UPDATE_DATE',DateTime),
#             Column('LOG_URL',String(1024)),
#         )
# url_dynamic_config = Table('t_dynamic_pc_info', metadata,
#             Column('ID', String(50), primary_key=True),
#             Column('ASSETID', String(50), ForeignKey('t_static_pc_info.ASSETID')),
#             Column('IP', String(50)),
#             Column('MEMORY', String(50)),
#             Column('CPU', String(50)),
#             Column('IO', String(50)),
#             Column('ONLINE_TIME', String(50)),
#             Column('LOADAVG', String(50)),
#             Column('CREATE_DATE',DateTime),
#         )
# url_pc_deployment = Table('t_pc_deployment', metadata,
#             Column('ID', String(50), primary_key=True),
#             Column('IP', String(50)),
#             Column('DEPLOYMENT', String(10)),
#         )
# url_pc_heartbeat = Table('t_heartbeat_pc', metadata,
#             Column('ID', String(50), primary_key=True),
#             Column('IP', String(50)),
#             Column('CREATE_DATE', DateTime),
#         )
# Base = declarative_base()
# metadata.create_all(engine)

#PC静态接口表 可以修改表
class StaticStorage(BaseBean, Base):
    __tablename__="t_static_pc_info"
    assetId = Column('ASSETID', String(50),  primary_key=True, default=lambda: unicode(uuid.uuid1()).replace('-', ''))
    ip = Column('IP', String(50))
    memory = Column('MEMORY', String(50))
    hostname = Column('HOSTNAME', String(320))
    cpuphysicalnum = Column('CPUPHYSICALNUM', String(1024))
    disktotal = Column('DISKTOTAL', String(1024))
    cpu_total = Column('CPU_TOTAL', String(50))
    cpu_core_num = Column('CPU_CORE_NUM', String(50))
    deployment = Column('DEPLOYMENT', String(10))
    status = Column('STATUS', String(10))
    create_date = Column('CREATE_DATE',DateTime,default=datetime.now())
    update_date = Column('UPDATE_DATE',DateTime)
    log_url = Column('LOG_URL',String(1024))


#PC动态接口表 只能添加表
class DynamicStorage(BaseBean, Base):
    __tablename__ = "t_dynamic_pc_info"
    id = Column('ID', String(50),  primary_key=True, default=lambda: unicode(uuid.uuid1()).replace('-', ''))
    assetId = Column('ASSETID', String(50),ForeignKey('t_static_pc_info.ASSETID'))
    ip = Column('IP', String(50))
    memory = Column('MEMORY', String(50))
    cpu = Column('CPU', String(50))
    io = Column('IO', String(50))
    online_time = Column('ONLINE_TIME', String(50))
    loadavg = Column('LOADAVG', String(50))
    create_date = Column('CREATE_DATE', DateTime,default=datetime.now())
    hostname = Column('hostname', String(320))
    net_width = Column('net_width', String(50))
    status = Column('STATUS', BOOLEAN)

class PcDeployment(BaseBean, Base):
    __tablename__ = "t_pc_deployment"
    id = Column('ID', String(50), primary_key=True, default=lambda: unicode(uuid.uuid1()).replace('-', ''))
    ip = Column('IP', String(50))
    deployment = Column('DEPLOYMENT', String(10))

class PcHeartBeat(BaseBean, Base):
    __tablename__ = "t_heartbeat_pc"
    id = Column('ID', String(50), primary_key=True, default=lambda: unicode(uuid.uuid1()).replace('-', ''))
    ip = Column('IP', String(50))
    create_date = Column('CREATE_DATE',  DateTime,default=text('NOW()'))

# mapper(PcHeartBeat, url_pc_heartbeat)
if __name__ == "__main__":
    print "123"



