# coding=utf-8
# !/usr/bin/env python
import json
import os
import sys

from scrapy.utils.project import get_project_settings

from utils.HdfsUtil import hdfs
# from utils.KafkaUtil import Kafka_producer
# from utils.OracleServerUtils import OracleManager
import dao
from beans.TaskTable import DbSource
from dao.BaseDao import Session
from utils import ConfigUtils
from utils.KafkaUtil import kafka
from utils.JsonUtils import stringify
from utils.SQLServerUtils import sqlserver
from utils.MysqlUtils import mysql
from utils.MongoDBUtils import mongodb
from dao.TemplateDao import childTaskJobByParentId
import uuid
from datetime import datetime
from utils.OracleServerUtils import oracle
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import MySQLdb
import MySQLdb.cursors
import codecs
import logging

class DbClient(object):
    """
    DbClient DB工厂类
    """
    def __init__(self):
        """
        init
        :return:
        """
        self.dbconfig=[]
        self.settings = get_project_settings()
        self.dbparms = dict(
            # MYSQL_HOST="127.0.0.1"
            # MYSQL_DBNAME = "wyy"
            # MYSQL_USER = "root"
            # MYSQL_PASSWORD = "123321"
            host=ConfigUtils.getMysqlPorperties(ConfigUtils.KEYMAP.MYSQL_HOST),
            dbname=ConfigUtils.getMysqlPorperties(ConfigUtils.KEYMAP.MYSQL_DBNAME),
            username=ConfigUtils.getMysqlPorperties(ConfigUtils.KEYMAP.MYSQL_USERNAME),
            password=ConfigUtils.getMysqlPorperties(ConfigUtils.KEYMAP.MYSQL_PASSWD),
            charset='utf8',
            cursorclass=MySQLdb.cursors.DictCursor,
        )
        self.db_type=None

    # self.conn=self.getConnection(type=self.type)

    #ID, DEL_FLAG ,HOST, USERNAME, PASSWORD, DBNAME,TYPE, CHARSET, PATH, CREATE_TIME
    dbmodule=['id','del_flag','host','port','username','password','dbname','type','charset','path','create_time']


    def getDBConfig(self,base_id):
        self.__MasterDbClient(self.dbparms,base_id)
        return dict(zip(self.dbmodule, self.dbconfig[0]))
    def execute(self,sql):
        self.conn.execute(sql)
        # self.conn.commit()
    def __MasterDbClient(self,param,id):
        """
        init Mater DB Client
        """
       
        self.conn = MySQLdb.connect(param['host'],param['username'], param['password'], param['dbname'], charset="utf8", use_unicode=True)
        self.cursor = self.conn.cursor()
        insert_sql = """
            select * from DB_source where id=%s
        """
        self.cursor.execute(insert_sql,id)
        self.dbconfig= self.cursor.fetchall()
        self.conn.commit()

    def createTable(self,id,tableName=None,jobTemplateList=None):
        return self.conn.createTableByTaskJobId(id,tableName,jobTemplateList)

    def isTableExist(self,tablaName):

        return self.conn.isTableExist(tablaName)
    def getConnection(self,base_id):
        # db_config = {
        #     'host': ConfigUtils.getMysqlPorperties(KEYMAP.MYSQL_HOST),
        #     'user': ConfigUtils.getMysqlPorperties(KEYMAP.MYSQL_USERNAME),
        #     'passwd': ConfigUtils.getMysqlPorperties(KEYMAP.MYSQL_PASSWD),
        #     'db': ConfigUtils.getMysqlPorperties(KEYMAP.MYSQL_DBNAME),
        #     'charset': ConfigUtils.getMysqlPorperties(KEYMAP.MYSQL_ENCODE),
        #     'port': ConfigUtils.getMysqlPorperties(KEYMAP.MYSQL_PORT)
        # }
        dbSource=Session.query(DbSource).filter(DbSource.id==base_id).first()
        if dbSource==None:
            host=dao.db_config.get("host")
            dbName=dao.db_config.get("db")
            userName=dao.db_config.get("user")
            passwd=dao.db_config.get("passwd")
            port=dao.db_config.get("port")
            dbSource=DbSource(dbname=dbName,host=host,port=port,type="mysql",password=passwd,username=userName)
        if dbSource==None:
            raise Exception("base_id is not Exist")
            return None
        self.cur_database_param = dbSource.__dict__
        self.db_type = self.cur_database_param["type"]
        db=eval(self.db_type)
        self.conn = db(self.cur_database_param)
        return self.conn


        # elif db_type == 'oracle':
        #     db_info = {
        #         'host': "%s" % self.cur_database_param['host'],
        #         'port': "%s" % self.cur_database_param['port'],
        #         'sid': "%s" % self.cur_database_param['dbname'],
        #         'charset': "utf8",
        #         'user': "%s" % self.cur_database_param['username'],
        #         'password': "%s" % self.cur_database_param['password']
        #     }
        #     self.conn = OracleManager(db_info)
        #     return self.conn
        # elif db_type == 'sqlserver':
        #     conn_args = {
        #         'host': "%s" % self.cur_database_param['host'],
        #         'database': "%s" % self.cur_database_param['dbname'],
        #         'charset': "utf8",
        #         'user': "%s" % self.cur_database_param['username'],
        #         'password': "%s" % self.cur_database_param['password']
        #     }
        #     self.conn = SQLServerUtils(self.cur_database_param)
        #     return self.conn

        # elif db_type == 'kafka':
        #     self.conn=Kafka_producer(self.cur_database_param['host'],self.cur_database_param['port'])
        #     return self.conn
        # elif db_type == 'hdfs':
        #     self.conn = HdfsClients(self.cur_database_param['host']+':'+self.cur_database_param['port'],self.cur_database_param['path'])
        #     return self.conn



