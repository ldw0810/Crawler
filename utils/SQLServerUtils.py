# coding=utf-8
import pymssql
import traceback
from uuid import uuid1
from utils.MysqlUtils import MyEncoder
from DBUtils.PooledDB import PooledDB
from dao import BaseDao
from dao.TaskJobDao import loadTaskById
from dao.TemplateDao import queryFieldByTaskJobId
from engine import settings
from beans.TaskTable import TaskJob
from beans.TemplateTable import JobTemplateField
from datetime import datetime
from dao import TemplateDao,TaskJobDao
import logging
import json
import MySQLdb
import time
args = (5, 5, 10, 10, True, 0, None)


class sqlserver(object):
    def __init__(self,cur_database_param):
        # super(SQLServerUtils, self).__init__()
        # self.quert_db_info = super(SQLServerUtils,self).getDBConfig()
        # conn_args = {
        #     'host': "%s" % self.quert_db_info['host'],
        #     'port': "%s" % self.quert_db_info['port'],
        #     'database': "%s" % self.quert_db_info['dbname'],
        #     'charset': "utf8",
        #     'user': "%s" % self.quert_db_info['username'],
        #     'password': "%s" % self.quert_db_info['password']
        # }
        conn_args = {
            'host': "%s" % cur_database_param['host'],
            'database': "%s" % cur_database_param['dbname'],
            'charset': "utf8",
            'user': "%s" %cur_database_param['username'],
            'password': "%s" % cur_database_param['password']
        }
        self._pool = PooledDB(pymssql, *args, **conn_args)
        # self.conn =  self._get_connect()
        # self.cursor = self.conn.cursor()
        pass

    def _get_connect(self):
        return self._pool.connection()

    def execQuery(self, sql):
        """
        执行查询语句
        :param sql: sql语句
        :return: 返回的是一个包含tuple的list，list的元素是记录行，tuple的元素是每行记录的字段
        """
        try:
            connect = self._get_connect()
            self.cursor = connect.cursor()
            self.cursor.execute(sql)
            resultList = self.cursor.fetchall()
        except Exception,e:
            logging.error("oracle,execute,"+str(e))
            traceback.print_exc()
        finally:
            if self.cursor:
                self.cursor.close()
            if connect:
                connect.close()
        return resultList

    def insert(self, table, column_dict,paramMap=None):
        # keys = ','.join(column_dict.keys())
        # values = ','.join(column_dict.values())
        # ins_sql = 'INSERT INTO %(tablename)s (%(keys)s) VALUES (%(values)s)'
        # return ins_sql
        # BaseDao.execute(ins_sql % locals(),column_dict)
        # pass
        keys = []
        createTime = time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
        for v in range(len(column_dict.keys())):
            keys.append("" + column_dict.keys()[v] + "")
        vals = list(column_dict.values())
        valueslist = []
        for v in range(len(vals)):
            valueslist.append("'" + MySQLdb.escape_string(vals[v]) + "'")
        # valueslist.append("'"+str(uuid.uuid1())+"'")
        valueslist.append("0")
        valueslist.append("'" + createTime + "'")
        keys.append("task_job_del_flag")
        keys.append("task_job_create_time")
        # keys.append("`parent_id`")
        task_job_id_sequenceValue = paramMap.get("task_job_id_sequence") if paramMap != None else None
        if task_job_id_sequenceValue != None:
            valueslist.append("'" + str(task_job_id_sequenceValue) + "'")
            keys.append("task_job_id_sequence")
        values = ','.join(valueslist)
        keys = ','.join(keys)
        ins_sql = 'INSERT  INTO %(table)s (%(keys)s) VALUES (%(values)s)'
        return ins_sql % locals()

    def insert_sql(self,tablename, jobid,item):
        self.insert(tablename, item)

    def execute(self, sqls):
        """
        执行非查询语句
        """
        # conn = self._get_connect()
        # cur = conn.cursor()
        # cur.execute(sql)
        # conn.commit()
        # conn.close()
        connect = self._get_connect()
        self.cursor = connect.cursor()
        try:
            if isinstance(sqls,list):
                for sql in sqls:
                    self.cursor.execute(sql)
            else:
                self.cursor.execute(sqls)
            connect.commit()
        except Exception,e:
            logging.error("sqlserver,execute,"+str(e))
            # self.conn.close()
            # if str(e[0])=="1146":
            raise  Exception()
        finally:
            if self.cursor:
                self.cursor.close()
            if connect:
                connect.close()

    def createTableByTaskJobId(self, taskJobId,tableName=None,jobTemplateFieldList=None):
        """
        创建数据库表
        :param taskJobId: 
        :return: 
        """
        if tableName==None:
            taskJob = TaskJobDao.loadTaskById(taskJobId)

            tableName = taskJob.tableName

        if self.isTableExist(tableName):
            logging.info('isTableExist:%s' % ('TRUE'))
            return
        if jobTemplateFieldList==None or len(jobTemplateFieldList)==0:
            jobTemplateFieldList = TemplateDao.queryJobTemplateFieldByJobTemplateId(taskJobId) #(jobid)
        if (jobTemplateFieldList == None or len(jobTemplateFieldList) == 0):
            return
        fieldList = []
        for jobTemplateField in jobTemplateFieldList:
            dataLength = jobTemplateField.dataLength
            dataType = str(jobTemplateField.dataType) or "varchar"
            fieldNameEn = str(jobTemplateField.fieldNameEn)
            if dataType=='int':
                fieldList.append("%s %s" % (fieldNameEn, dataType))
            elif dataLength != None and dataLength > 0 or (dataLength==None and dataType=="varchar"):
                if dataType!='int':
                    dataLength="1024"
                fieldList.append("%s %s(%s)" % (fieldNameEn, dataType, dataLength))
            else:
                fieldList.append("%s %s" % (fieldNameEn, dataType))
        fieldList.append("id varchar(50) primary key")
        fieldList.append("task_job_create_time datetime")
        fieldList.append("task_job_del_flag int")
        fieldList.append("task_job_id_sequence varchar(50)")
        fieldList.append("parent_id varchar(50)")
        fieldList.append("task_job_url varchar(255)")
        create_table_sql = "create table %s(%s)" % (tableName, ",".join(fieldList))
        self.execute(create_table_sql)

    def query_table_pages(self, tableName, page, pageCount ,parentId=None,taskHistoryId=None):
        """
        查询数据
        :param page: 页码 从1开始
        :param pageCount: 分页大小
        :param tableName: 要查询的表名
        :return:
        """
        query_sql = "select * from (select top %s ROW_NUMBER() OVER(ORDER BY id ASC) AS ROWID,* FROM %s) AS Temp1 where ROWID > %s" % (
            page * pageCount, tableName, (page - 1) * pageCount)
        resultList = self.execQuery(query_sql)
        for result in resultList:
            print result
        pass

    def isTableExist(self, tableName):
        """
        判断数据表是否已近存在
        :param tableName: 
        :return: 
        """
        sql = "SELECT COUNT(*) FROM sys.sysobjects where name = '%s'" % tableName
        resultList = self.execQuery(sql)
        count = resultList[0][0]
        if count > 0:
            return True
        else:
            return False
    def query_count(self,tableName,parentId=None,taskHistoryId=None):
        """
        查询数据量
        :param tableName:
        :param parentId:
        :param taskHistoryId:
        :return:
        """
        parentId=parentId or ""
        taskHistoryId=taskHistoryId or ""
        sql = """
                   select
                   count(*)
                   from %s where if('%s'!='',parent_id='%s',1=1)and if('%s'!='',task_job_id_sequence='%s',1=1)
                   """ % (tableName,parentId,parentId,taskHistoryId,taskHistoryId)
        return self.execQuery(sql)
    def query_collect_index(self,dbname,tablename):
        """
        查询统计监控
        :param dbname:
        :param tablename:
        :return:
        """
        sql = """
                select name,convert(int,row) as row,convert(int,replace(reserved,'KB',''))
                 as reserved,convert(int,replace(data,'KB','')) as data,
                  convert(int,replace(index_size,'KB','')) as index_size,convert(int,replace(unused,'KB',''))
                   as unused from '%s'
            """% (tablename)
        return self.querySql(sql)
    def querySql(self, sql):
        try:
            print sql
            self.execute(sql)
            # self.conn.commit()
            result = self.cursor.fetchall()
        except Exception, e:
            logging.error('querySql:%s:error:%s' % (sql, e))
            return []
        # finally:
        #     conn.close()

        return json.dumps(result, cls=MyEncoder)
    # def query_table_pages(self,tableName, page, pageCount,parentId=None,taskHistoryId=None):
    #     parentId = parentId or ""
    #     taskHistoryId = taskHistoryId or ""
    #     sql=None
    #     if page==0 and pageCount==0:
    #         sql = """
    #             select * from %s where if('%s'!='',parent_id='%s',1=1)and if('%s'!='',task_job_id_sequence='%s',1=1)
    #         """ % (tableName,parentId,parentId,taskHistoryId,taskHistoryId)
    #     else:
    #         st=(page-1)*pageCount
    #         sql = """
    #             select * from %s where if('%s'!='' and '%s'!='-1',parent_id='%s',1=1)and if('%s'!='',task_job_id_sequence='%s',1=1) limit %s, %s
    #         """ % (tableName, parentId,parentId,parentId,taskHistoryId,taskHistoryId, st, pageCount)
    #     return self.execQuery(sql)





if __name__ == '__main__':
    # 创建表
    # SQLServerUtils().createTableByTaskJobId('1')
    cur_database_param = {"host":"10.128.100.203",
                          "dbname":"demo",
                          "username":"sa",
                          "password":"123456"
                          }
    sqlserve = sqlserver(cur_database_param)
    jobTemplateFieldList = TemplateDao.queryJobTemplateFieldByJobTemplateId('b78f69bc-4c1a-11e7-ba08-000c299438c6')
    sqlserve.createTableByTaskJobId('lsl0s','kkkkkk00',jobTemplateFieldList)
    # print sqlserver
    import random

    number = random.randint(10, 100)
    d = {"pagecount": "116", "id": str(number), "task_job_id_sequence": 'e57f7640-6d1d-11e7-bc2b-38c986148389'}
    sql = sqlserve.insert('kkkkkk',d)
    sqlserve.execute(sql)
    # 插入数据
    # taskJob = TaskJob()
    # taskJob.tableName='taskJob_20170414000000'
    #
    # jobTemplateFieldList = []
    # jobTemplateField1 = JobTemplateField()
    # jobTemplateField1.fieldNameEn='url'
    # jobTemplateField2 = JobTemplateField()
    # jobTemplateField2.fieldNameEn='name'
    #
    # jobTemplateFieldList.append(jobTemplateField1)
    # jobTemplateFieldList.append(jobTemplateField2)
    #
    # dataList = []
    # for i in range(100):
    #     name = 'name_%s' % i
    #     url = 'url_%s' % i
    #     data = {'name':name,'url':url}
    #     dataList.append(data)
    # inter_sql = generatorSql(taskJob,jobTemplateFieldList,dataList)
    # SQLServerUtils().execNonQuery(inter_sql)

    # 分页查询
    # SQLServerUtils().query(1, 5, 'taskJob_20170414000000')

    # 判断表是否存在
    # print SQLServerUtils().isTableExist('taskJob_20170414000000')
    pass