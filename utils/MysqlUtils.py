#coding=utf-8
import uuid

from sqlalchemy import func

from dao import BaseDao
from dao import TaskJobDao
from dao import TemplateDao
from dao.BaseDao import with_session
from dao.TemplateDao import queryFieldByTaskJobId
import MySQLdb
import MySQLdb.cursors
import logging
from utils.JsonUtils import stringify
ALL=1
FIRST=0
class mysql(object):
    def __init__(self,cur_database_param):
      
        self.db_config = {
            'host': "%s" % cur_database_param['host'],
            'port': "%s" % cur_database_param['port'],
            'db': "%s" % cur_database_param['dbname'],
            'charset': "utf8",
            'user': "%s" % cur_database_param['username'],
            'password': "%s" % cur_database_param['password']
        }
        self.conn = MySQLdb.connect(self.db_config['host'],
                                       self.db_config['user'],
                                       self.db_config['password'] or "",
                                       self.db_config['db'] or "",
                                       charset="utf8", use_unicode=True)
        self.cursor = self.conn.cursor()

    # def execute_sql(self, sql):
    #     try:
    #         result = self.cursor.execute(sql)  # .fetchall()#.offset(0).limit(10)
    #         self.conn.commit()
    #     except Exception, e:
    #         logging.error('execute_sql:%s:error:%s' % (sql, e))
    #         self.conn.rollback()
    #         return 0
    #     # finally:
    #     #     Session.close()
    #     return result

    def query(self,sql):
        try:
            self.execute_sql(sql)
            result = self.cursor.fetchall()
            self.conn.commit()
        except Exception, e:
            result=0
        return result
    def queryTableTitle(self,tablename,database_name=None):
        sql = """
        select column_name, column_comment
        from Information_schema.columns
        where table_Name = '%s'and table_schema='%s'
        """ %(tablename,database_name)
        return self.querySql(sql)

    def insert(self,tablename,column_dict,paramMap=None):
        keys=[]
        for v in range(len(column_dict.keys())):
            keys.append("`"+column_dict.keys()[v]+"`")
        vals=list(column_dict.values())
        valueslist=[]
        for v in range(len(vals)):
            valueslist.append("'"+MySQLdb.escape_string(vals[v])+"'")
        # valueslist.append("'"+str(uuid.uuid1())+"'")
        valueslist.append("False")
        valueslist.append("now()")
        keys.append("`task_job_del_flag`")
        keys.append("`task_job_create_time`")
        # keys.append("`parent_id`")
        task_job_id_sequenceValue=paramMap.get("task_job_id_sequence") if paramMap!=None else None
        if task_job_id_sequenceValue!=None:
            valueslist.append("'"+str(task_job_id_sequenceValue)+"'")
            keys.append("`task_job_id_sequence`")
        values = ','.join(valueslist)
        keys=','.join(keys)
        ins_sql = 'INSERT ignore INTO %(tablename)s (%(keys)s) VALUES (%(values)s)'
        return ins_sql% locals();
        # return BaseDao.execute()#(ins_sql % locals())

    def insert_sql(self,tablename,jobid,item):
        # self.createTableByTaskJobId(jobid)
        return self.insert(tablename,item)

    def isTableExist(self,tablename):
        sql = """
            SHOW TABLES LIKE '%s'
        """ % tablename
        rs =BaseDao.execute(sql)
        if(rs.rowcount == 1):
            return True
        else:
            return False

    @with_session
    def createTableByTaskJobId(self,jobid,tableName=None,jobTemplateFieldList=None):
        """
                创建数据库表
                :param taskJobId:
                :return:
                """
        if tableName==None:
            taskJob = TaskJobDao.loadTaskById(jobid)

            tableName = taskJob.tableName

        # if self.isTableExist(tableName):
        #     logging.info('isTableExist:%s' % ('TRUE'))
        #     return
        if jobTemplateFieldList==None or len(jobTemplateFieldList)==0:
            jobTemplateFieldList = TemplateDao.queryJobTemplateFieldByJobTemplateId(jobid) #(jobid)
        if (jobTemplateFieldList == None or len(jobTemplateFieldList) == 0):
            return
        fieldList = []
        for jobTemplateField in jobTemplateFieldList:
            dataLength = jobTemplateField.dataLength
            dataType = jobTemplateField.dataType or "varchar"
            fieldNameEn = jobTemplateField.fieldNameEn
            if dataType=='int':
                fieldList.append("`%s` %s" % (fieldNameEn, dataType))
            elif dataLength != None and dataLength > 0 or (dataLength==None and dataType=="varchar"):
                if dataType!='int':
                    dataLength="1024"
                fieldList.append("`%s` %s(%s)" % (fieldNameEn, dataType, dataLength))
            else:
                fieldList.append("`%s` %s" % (fieldNameEn, dataType))
        fieldList.append("id varchar(50) primary key")
        fieldList.append("task_job_create_time datetime")
        fieldList.append("task_job_del_flag tinyint")
        fieldList.append("task_job_id_sequence varchar(50)")
        fieldList.append("parent_id varchar(50)")
        fieldList.append("task_job_url varchar(1024)")
        create_table_sql = "create table %s(%s)" % (tableName, ",".join(fieldList))
        self.cursor.execute(create_table_sql)
        #增加查询字段的索引来提高效率
        self.cursor.execute("alter table `%s` add index index_name(`parent_id`,`task_job_id_sequence`)"%(tableName))
    def query_count(self,tableName,parentId=None,taskHistoryId=None):
        parentId=parentId or ""
        taskHistoryId=taskHistoryId or ""
        sql = """
                   select
                   count(*)
                   from %s where if('%s'!='',parent_id='%s',1=1)and if('%s'!='',task_job_id_sequence='%s',1=1)
                   """ % (tableName,parentId,parentId,taskHistoryId,taskHistoryId)
        return self.querySql(sql)
    def query_table_pages(self,tableName, page, pageCount,parentId=None,taskHistoryId=None):
        parentId = parentId or ""
        taskHistoryId = taskHistoryId or ""
        sql=None
        if page==0 and pageCount==0:
            sql = """
                select * from %s where if('%s'!='',parent_id='%s',1=1)and if('%s'!='',task_job_id_sequence='%s',1=1)
            """ % (tableName,parentId,parentId,taskHistoryId,taskHistoryId)
        else:
            st=(page-1)*pageCount
            sql = """
                select * from %s where if('%s'!='' and '%s'!='-1',parent_id='%s',1=1)and if('%s'!='',task_job_id_sequence='%s',1=1) limit %s, %s
            """ % (tableName, parentId,parentId,parentId,taskHistoryId,taskHistoryId, st, pageCount)
        return self.querySql(sql)

    def query_collect_index(self,dbname,tablename):
        sql = """
                SELECT DATA_LENGTH,INDEX_LENGTH
                FROM INFORMATION_SCHEMA.TABLES 
                WHERE table_schema =  '%s' and table_name = '%s' 
            """% ( dbname,tablename)
        return self.querySql(sql)

    def execute(self,sqls):
        try:
            if isinstance(sqls,list):
                for sql in sqls:
                    self.cursor.execute(sql)
            else:
                self.cursor.execute(sqls);
            self.conn.commit()
        except Exception,e:
            logging.error("mysql,execute,"+str(e))
            if str(e[0])=="1146":
                raise  Exception()
    def querySql(self,sql):
        try:
            print sql
            self.cursor.execute(sql)
            # self.conn.commit()
            result=self.cursor.fetchall()
        except Exception, e:
            logging.error('querySql:%s:error:%s' % (sql, e))
            return []
        # finally:
        #     conn.close()

        return json.dumps(result, cls=MyEncoder)

    def count(self,obj, param=None):
        object = self.conn.query(func.count('id')).select_from(obj).filter(param).scalar()
        return object

import json
from datetime import date, datetime
class MyEncoder(json.JSONEncoder):
  def default(self, obj):
      # if isinstance(obj, datetime.datetime):
      #     return int(mktime(obj.timetuple()))
      if isinstance(obj, datetime):
          return obj.strftime('%Y-%m-%d %H:%M:%S')
      elif isinstance(obj, date):
          return obj.strftime('%Y-%m-%d')
      else:
          return json.JSONEncoder.default(self, obj)
