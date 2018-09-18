# -*- coding:utf-8 -*-
# http://scrapy-chs.readthedocs.io/zh_CN/0.24/topics/item-pipeline.html
import engine.settings
# import cx_Oracle
from DBUtils.PooledDB import PooledDB
import MySQLdb
from dao import BaseDao
from dao import TaskJobDao
from datetime import datetime
from dao.TemplateDao import queryFieldByTaskJobId
# from DBClient import DbClient
from engine import settings
import uuid
import os
import logging
import json
from utils.MysqlUtils import MyEncoder
from dao import TemplateDao
import time
# mdc/mdc123@172.21.14.66:1526/sdpdb
# mdc/mdc123@10.128.100.111:1522/orcl
os.environ['NLS_LANG'] = 'SIMPLIFIED CHINESE_CHINA.UTF8'

class oracle(object):
    __pool = None  # 连接池对象
    def __init__(self,cur_database_param):
        # super(OracleManager, self).__init__()
        # self.quert_db_info = super(OracleManager,self).getDBConfig("1")
        # db_info = {
        #     'host': "%s" % self.quert_db_info['host'],
        #     'port': "%s" % self.quert_db_info['port'],
        #     'sid': "%s" % self.quert_db_info['dbname'],
        #     'charset': "utf8",
        #     'user': "%s" % self.quert_db_info['username'],
        #     'password': "%s" % self.quert_db_info['password']
        # }
        self.db_info = {
                'host': "%s" % cur_database_param['host'],
                'port': "%s" % cur_database_param['port'],
                'sid': "%s" % cur_database_param['dbname'],
                'charset': "utf8",
                'user': "%s" % cur_database_param['username'],
                'password': "%s" % cur_database_param['password']
            }

        self.conn = oracle.__getConn(self.db_info)
        self.cursor = self.conn.cursor()

    @staticmethod
    def __getConn(db_info):
        # 静态方法,从连接池中取出连接
        if oracle.__pool is None:
            __pool = PooledDB(cx_Oracle,
                              user=db_info['user'],
                              password=db_info['password'],
                              dsn="%s:%s/%s" % (db_info['host'], db_info['port'], db_info['sid']),
                              mincached=20,
                              maxcached=5000,
                              )
        return __pool.connection()

    # 查询表的所有列
    def columns(self, table):
        sql = ["select lower(column_name)column_name \
                from user_tab_columns where table_name=upper('%(table)s')"]
        rows = self.query(''.join(sql) % locals())
        col_list = [k["column_name"] for k in rows]
        return col_list

    # 根据表创建参数字典
    def create_params(self, table, args={}):
        col_list = self.columns(table)
        params = {}
        for k in col_list:
            if args.has_key(k):
                params[k] = args[k]
        return params

    # 判断table是否存在
    def isTableExist(self, table):
        sql = ["select count(*)cnt FROM user_tables "]
        sql.append(" WHERE table_name = upper('%(table)s')")
        str = "".join(sql) % locals()
        rows = self.query(str)
        if rows[0]["cnt"]== 0:
            return False
        else:
            return True

    # 分页查询(可增加筛选参数)，参数一：sql语句，参数二：参数字典{'字段1'：'值1','字段2':'值2'}，参数三：页码，参数四：分页大小
    def query_pages(self, sql, args={}, page=1, page_size=30):
        _args, count_args = args, args
        page = int(page)
        # print "page:%s" %(page,)
        # 下一页
        next_page = page_size * page
        # 当前页
        cur_page = page_size * (page - 1)
        if page == 1 or cur_page < 0:
            cur_page = 0
            next_page = page_size
        sql = """SELECT * FROM(
                SELECT ROWNUM RN,T.* FROM(""" + sql + """)T
                WHERE ROWNUM<:next_page
                )WHERE RN >=:cur_page """

        count_sql = """
                SELECT COUNT(1)CNT FROM (""" + sql + """)"""
        _args["cur_page"] = cur_page
        _args["next_page"] = next_page
        rows = self.query(sql, _args)
        countrows = self.query(count_sql, count_args)
        return rows, countrows[0]['cnt']

    # 插入数据:insert ;Oracle的参数名必须使用:代替,如 userid = :userid
    def insert(self, table, column_dict,paramMap=None):
        # column_dict = self.create_params(table, column_dict)
        # keys = ','.join(column_dict.keys())
        # values = column_dict.values()
        # # placeholder = ','.join(['%s' % (v) for v in values])
        # placeholder = ','.join(values)
        # ins_sql = 'INSERT INTO %(table)s (%(keys)s) VALUES (%(placeholder)s)'
        # sql = ins_sql % locals()
        # return sql

        keys = []
        createTime = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
        for v in range(len(column_dict.keys())):
            keys.append("" + column_dict.keys()[v] + "")
        vals = list(column_dict.values())
        valueslist = []
        for v in range(len(vals)):
            valueslist.append("'" + MySQLdb.escape_string(vals[v]) + "'")
        # valueslist.append("'"+str(uuid.uuid1())+"'")
        valueslist.append("0")
        valueslist.append("sysdate")
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

    # 批量插入数据库，参数一：表名，参数二：['字段1','字段2',...],参数二：[('值1','值2',...),('值1','值2',...)]
    def multi_insert(self, table, columns=[], values=()):
        keys = ','.join(columns)
        placeholder = ','.join([':%s' % (v) for v in columns])
        ins_sql = 'INSERT INTO %(table)s (%(keys)s) VALUES(%(placeholder)s)'
        return self.cursor.executemany(ins_sql % locals(), values)

    # 更新，参数一：表名，参数二用于set 字段1=值1，字段2=值2...格式：{'字段1':'值1','字段2':'值2'},
    # 参数三：用于where条件，如 where 字段3=值3 and 字段4=值4，格式{'字段3':'值3','字段4':'值4'}
    def update(self, table, column_dict={}, cond_dict={}):
        column_dict = self.create_params(table, column_dict)
        cond_dict = self.create_params(table, cond_dict)
        set_stmt = ','.join(['%s=:%s' % (k, k) for k in column_dict.keys()])
        cond_stmt = ' and '.join(['%s=:%s' % (k, k) for k in cond_dict.keys()])
        upd_sql = 'UPDATE %(table)s set %(set_stmt)s where %(cond_stmt)s'
        args = dict(column_dict, **cond_dict)  # 合并成1个
        return self.execute(upd_sql % locals(), args)

    # 删除，参数一：表名，#参数二：用于where条件，如 where 字段3=值3 and 字段4=值4，格式{'字段3':'值3','字段4':'值4'}
    def delete(self, table, cond_dict):
        cond_dict = self.create_params(table, cond_dict)
        cond_stmt = ' and '.join(['%s=:%s' % (k, k) for k in cond_dict.keys()])
        del_sql = 'DELETE FROM %(table)s where %(cond_stmt)s'
        return self.execute(del_sql % locals(), cond_dict)

    # 根据jobId查询taskjob获取表名
    def createTableByTaskJobId(self, taskJobId,tableName=None,jobTemplateFieldList=None):
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
        fieldList.append("task_job_create_time date")
        fieldList.append("task_job_del_flag int")
        fieldList.append("task_job_id_sequence varchar(50)")
        fieldList.append("parent_id varchar(50)")
        fieldList.append("task_job_url varchar(255)")
        create_table_sql = "create table %s(%s)" % (tableName, ",".join(fieldList))
        # create_table_sql = "create table DEMO1(name varchar(50))"
        self.execute(create_table_sql)
       # 增加查询字段的索引来提高效率
       #  self.cursor.execute(
       #      "alter table '%s' add index index_name('parent_id','task_job_id_sequence')" % (tableName))

    # 执行sql
    def execute(self, sqls,args = {}):
        try:
            if isinstance(sqls,list):
                for sql in sqls:
                    self.cursor.execute(sql,args)
            else:
                self.cursor.execute(sqls)
            self.conn.commit()
        except Exception,e:
            logging.error("oracle,execute,"+str(e))
            # self.close()
            # if str(e[0])=="1146":
            raise  Exception()

    def insert_sql(self,tablename , jobid , item):
        # self.createTableByTaskJobId(jobid)
        return self.insert(tablename,item)
    # 批量执行
    def executemany(self, sql, args):
        try:
            return self.cursor.executemany(sql, args)
        except Exception, e:
            self.close()
            raise e

    # def creat_oracle_table(self, name):
    #     crete_table = 'create table %s (name varchar(20),jobid INT)' % name
    #     self.cursor.execute(crete_table)

    # 执行sql，参数一：sql语句，参数二：参数字典{'字段1'：'值1','字段2':'值2'}
    def query(self, sql, args={}):
        self.execute(sql)
        return self.get_rows()

        # 提取数据，参数一提取的记录数，参数二，是否以字典方式提取。为true时返回：{'字段1':'值1','字段2':'值2'}

    def get_rows(self, size=None, is_dict=True):
        if size is None:
            rows = self.cursor.fetchall()
        else:
            rows = self.cursor.fetchmany(size)
        if rows is None:
            rows = []
        if is_dict:
            dict_rows = []
            dict_keys = [r[0].lower() for r in self.cursor.description]
            for row in rows:
                dict_rows.append(dict(zip(dict_keys, row)))
            rows = dict_rows
        return rows

    # 获取记录数
    def get_rows_num(self):
        return self.cursor.rowcount

    # 提交
    def commit(self):
        self.conn.commit()

    # 回滚
    def rollback(self):
        self.conn.rollback();

    # 销毁
    def __del__(self):
        self.close()

    # 关闭连接
    def close(self):
        self.commit()
        self.cursor.close()
        self.conn.close()

    #分页查询整个表
    def query_table_pages(self,tablename,page=1, page_size=10,parentId=None,taskHistoryId=None):
        page = int(page)
        # print "page:%s" %(page,)
        # 下一页
        next_page = page_size * page
        # 当前页
        cur_page = page_size * (page - 1)
        if page == 1 or cur_page < 0:
            cur_page = 0
            next_page = page_size
        newsql = """
        SELECT * FROM(
                SELECT ROWNUM RN,T.* FROM %s T
                WHERE ROWNUM<%s
                )WHERE RN >=%s
        """ % (tablename,next_page,cur_page)
        rows = self.query(newsql)
        return rows

    def query_count(self,tableName,parentId=None,taskHistoryId=None):
        parentId=parentId or ""
        taskHistoryId=taskHistoryId or ""
        sql = """
                   select
                   count(*)
                   from %s where if('%s'!='',parent_id='%s',1=1)and if('%s'!='',task_job_id_sequence='%s',1=1)
                   """ % (tableName,parentId,parentId,taskHistoryId,taskHistoryId)
        return self.querySql(sql)

    def query_collect_index(self,dbname,tablename):
        sql = """
                select segment_name,bytes from dba_segments where segment_name = '%s'
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
if __name__ == '__main__':
    cur_database_param = {'host':'10.128.100.111',
                'port': '1522',
                'dbname': 'orcl',
                'charset': "utf8",
                'username': 'mdc',
                'password':'mdc123'}
    oracle = oracle(cur_database_param)
    # exist = oracle.isTableExist('table')
    # print exist
    field = ['pageCount varchar(1024)']
    # jobTemplateFieldList = TemplateDao.queryJobTemplateFieldByJobTemplateId('b78f69bc-4c1a-11e7-ba08-000c299438c6')
    # create = oracle.createTableByTaskJobId('1', 'de1m12',jobTemplateFieldList)
    print oracle
    import random
    number = random.randint(10,100)
    d = {"pagecount":"116","id":str(number),"task_job_id_sequence":'e57f7640-6d1d-11e7-bc2b-38c986148389'}
    insert = oracle.insert('de1m12',d)

    oracle.execute(insert)
    page = oracle.query_table_pages('de1m12')
    print page
    # list = oracle.columns('DEMO')
    # existTable = oracle.oracle_table_isexist('DEMO')
    # sql = "select *  from DEMO a where id = '10'"
    # sql.append(" WHERE table_name = DEMO")
    # rows = oracle.query("".join(sql) % locals())
    # rows1 = oracle.query("select *  from DEMO a where id='20'")
    # oracle.insert('DEMO', {'id': '1060'})
    # pages1 = oracle.query_table_pages('DEMO',2,6)
    # pages = oracle.query_pages("select *  from DEMO  where id=:id",{"id":"1060"} , 1, 6)
    # task = oracle.create_oracle_table('1')
    # oracle.update('DEMO', {'testname':'mdc123'},{'id': '1060'})
    # oracle.delete('DEMO', {'id': '60'})
    # print task
    pass