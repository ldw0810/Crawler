#coding=utf-8
from datetime import datetime
from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import MetaData
from sqlalchemy import String
from sqlalchemy import Table
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, mapper
from sqlalchemy import create_engine
from sqlalchemy.pool import NullPool


class CrawlerMysqlEngine:
    db_config={
        # 'host': '172.21.14.25',
        'host': '10.128.100.132',
        'user': 'root',
        'passwd': 'root',
        'db':'crawler',
        'charset':'utf8'
    }
    engine = create_engine('mysql://%s:%s@%s/%s?charset=%s'%(db_config['user'],
                                                             db_config['passwd'],
                                                             db_config['host'],
                                                             db_config['db'],
                                                             db_config['charset']), echo=True,encoding='utf8', convert_unicode=True,poolclass=NullPool)
Session_class = sessionmaker(bind=CrawlerMysqlEngine.engine)
Session = Session_class()  # 生成session实例，相当于游标
metadata = MetaData()
url_static_config = Table('t_static_pc_info', metadata,
            Column('ip', String(100), primary_key=True),
            Column('memory', String(1024)),
            Column('hostname', String(320)),
            Column('cpuphysicalnum', String(1024)),
            Column('disktotal', String(1024)),
            Column('cpu_total', String(1024)),
            Column('cpu_core_num', String(1024)),
            Column('create_date',DateTime),
            Column('update_date',DateTime)
        )
url_dynamic_config = Table('t_dynamic_pc_info', metadata,
            Column('ip', String(100), primary_key=True),
            Column('create_date',DateTime),
            Column('update_date',DateTime)
        )
class DynamicStorage(object):
    __tableName__ = "t_dynamic_pc_info"
    def __init__(self, ip="",create_date=datetime.now(), update_date=datetime.now()):
        self.ip = ip
        self.create_date = create_date
        self.update_date = update_date
        self.query = Session.query(StaticStorage)
        print "DynamicStorage:__init__"

    def __repr__(self):
        return "<UrlConfig( ip='%s',create_date='%s',update_date='%s')>" % (self.ip, self.create_date, self.update_date)

    def add(self):
        Session.add(self)
        Session.flush()
        Session.commit()

    def queryContent(self, ip):
        return self.query.filter(DynamicStorage.ip == ip).first()

    def delete(self, ip):
        self.query.filter(DynamicStorage.ip == ip).delete()
        Session.commit()

    def update(self, ip, obj):
        self.query.filter(DynamicStorage.ip == ip).update(
            {DynamicStorage.memory: obj["memory"], DynamicStorage.hostname: obj["hostname"],
             DynamicStorage.cpuphysicalnum: obj["cpuphysicalnum"], StaticStorage.disktotal: obj["disktotal"],
             DynamicStorage.cpu_total: obj["cpu_total"], DynamicStorage.cpu_core_num: obj["cpu_core_num"],
             DynamicStorage.update_date: datetime.now()})
        Session.commit()
class StaticStorage(object):
    __tableName__="t_static_pc_info"
    def __init__(self,ip="",memory="",hostname="",cpuphysicalnum="",disktotal="",cpu_total="",cpu_core_num="",create_date=datetime.now(),update_date=datetime.now()):
        self.ip = ip
        self.memory = memory
        self.create_date = create_date
        self.update_date = update_date
        self.hostname = hostname
        self.cpuphysicalnum = cpuphysicalnum
        self.disktotal = disktotal
        self.cpu_total = cpu_total
        self.cpu_core_num = cpu_core_num
        self.query = Session.query(StaticStorage)
        print "Storage:__init__"
    def __repr__(self):
        return "<UrlConfig( ip='%s', memory='%s',create_date='%s',update_date='%s',hostname='%s')>" % ( self.ip, self.memory,self.create_date,self.update_date,self.hostname)
    def add(self):
        Session.add(self)
        Session.flush()
        Session.commit()
    def queryContent(self,ip):
        return self.query.filter(StaticStorage.ip == ip).first()
    def delete(self,ip):
        self.query.filter(StaticStorage.ip == ip).delete()
        Session.commit()
    def update(self,ip,obj):
        self.query.filter(StaticStorage.ip == ip).update({StaticStorage.memory: obj["memory"],StaticStorage.hostname: obj["hostname"],StaticStorage.cpuphysicalnum: obj["cpuphysicalnum"],StaticStorage.disktotal: obj["disktotal"],StaticStorage.cpu_total: obj["cpu_total"],StaticStorage.cpu_core_num: obj["cpu_core_num"],StaticStorage.update_date: datetime.now()})
        Session.commit()

Base = declarative_base()
metadata.create_all(CrawlerMysqlEngine.engine)
mapper(StaticStorage, url_static_config)
mapper(DynamicStorage, url_dynamic_config)
#-----------新增实例------------------
# urlConfig = Storage("173.18.2.101","201M","hqwname1")
# urlConfig.add()
#-----------修改实例------------------
# urlConfig = Storage()
# urlConfig.update("173.18.2.100",{"memory":"300M","hostname":"hqwnametest2"})
#-----------删除实例------------------
# urlConfig = Storage()
# urlConfig.delete("173.18.2.100")
#-----------查看实例------------------
# urlConfig = Storage()
# print urlConfig.queryContent("172.21.14.26")
#------------------test--------------
# dest = {}
# dest.update({"name":"zhangsan"})
# dest.update({"age":"23"})
# print dest["name"]
#------------------from threading import Timer-------
# def helloworld():
#     print "hello world"
#     Timer(3,helloworld).start()
# helloworld()

  # 实例和engine绑定



# urlConfig = Storage("173.18.2.100","200M",datetime.now(),"hqwname")
# urlConfig.add()
# query = Session.query(Storage)
# query.filter(Storage.id == '9298d3a1-145e-11e7-b960-002324925c67').delete()
# print query
# for st in query:
#     print st.ip
# print query.all()
# print query.get("9298d3a1-145e-11e7-b960-002324925c67").ip
# query2 = Session.query(Storage.hostname)
# print query2.all()
# print query2.filter(Storage.id == "9298d3a1-145e-11e7-b960-002324925c67").scalar()
# query.filter(Storage.id == "9298d3a1-145e-11e7-b960-002324925c67").update({Storage.hostname:"tst1"})
# print query.get("9298d3a1-145e-11e7-b960-002324925c67").hostname