#coding=utf-8
# author mdc by 2017-07-05
import pymongo
from pymongo import MongoClient
from dao import BaseDao
from dao import TaskJobDao
from dao import TemplateDao
from dao.BaseDao import with_session
import time
import random
import MySQLdb
from pymongo.cursor import Cursor

class mongodb(object):
    # def __init__(self, host='localhost', port=27017, database='Test',
    #              max_pool_size=10, timeout=10):
    #     self.host = host
    #     self.port = port
    #     self.max_pool_size = max_pool_size
    #     self.timeout = timeout
    #     self.database = database
    #     client = MongoClient(self.host, self.port, maxPoolSize=self.max_pool_size,
    #     connectTimeoutMS = 60 * 60 * self.timeout)
    #
    #     self.db = client[self.database]
    def __init__(self,cur_database_param):
        self.host = cur_database_param['host']
        self.port = int(cur_database_param['port'])
        self.database = cur_database_param['dbname']
        self.username = cur_database_param['username']
        self.password = cur_database_param['password']
        client = MongoClient(self.host, self.port)
        self.db = client[self.database]

    def insert(self,jobid,tablename,column_dict,paramMap=None):
        if tablename == None:
            taskJob = TaskJobDao.loadTaskById(jobid)
            tablename = taskJob.tableName
        keys = []
        for v in range(len(column_dict.keys())):
            keys.append(" " + column_dict.keys()[v] + " ")
        vals = list(column_dict.values())
        valueslist = []
        for v in range(len(vals)):
            valueslist.append(" " + MySQLdb.escape_string(vals[v]) + " ")
        # valueslist.append("'"+str(uuid.uuid1())+"'")
        createTime = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
        valueslist.append("False")
        valueslist.append(createTime)
        keys.append("task_job_del_flag")
        keys.append("task_job_create_time")
        # keys.append("`parent_id`")
        task_job_id_sequenceValue = paramMap.get("task_job_id_sequence") if paramMap != None else None
        if task_job_id_sequenceValue != None:
            valueslist.append("" + str(task_job_id_sequenceValue) + "")
            keys.append("task_job_id_sequence")
        fielddic = dict(zip(keys,valueslist))
        collection = self.db[tablename]
        collection.insert(fielddic)

    def isTableExist(self,tablename):
        """
        因为mongodb在插入过程中 如果collection不存在 则会自动创建 故返回True
        :param tablename:
        :return:
        """
        return True
        # collections = self.db.collection_names()
        # for collection in collections:
        #     if tablename == collection:
        #         return True
        # return False

    def createTableByTaskJobId(self, jobid, tableName=None, jobTemplateFieldList=None):
        """
                创建collection
                :param taskJobId:
                :return:
                """
        if tableName == None:
            taskJob = TaskJobDao.loadTaskById(jobid)

            tableName = taskJob.tableName

        # if self.isTableExist(tableName):
        #     logging.info('isTableExist:%s' % ('TRUE'))
        #     return
        if jobTemplateFieldList == None or len(jobTemplateFieldList) == 0:
            jobTemplateFieldList = TemplateDao.queryJobTemplateFieldByJobTemplateId(jobid)  # (jobid)
        if (jobTemplateFieldList == None or len(jobTemplateFieldList) == 0):
            return
        fieldList = []
        for jobTemplateField in jobTemplateFieldList:
            dataLength = jobTemplateField.dataLength
            dataType = jobTemplateField.dataType or "varchar"
            fieldNameEn = jobTemplateField.fieldNameEn
            if dataType == 'int':
                fieldList.append("`%s` %s" % (fieldNameEn, dataType))
            elif dataLength != None and dataLength > 0 or (dataLength == None and dataType == "varchar"):
                if dataType != 'int':
                    dataLength = "1024"
                fieldList.append("`%s` %s(%s)" % (fieldNameEn, dataType, dataLength))
            else:
                fieldList.append("`%s` %s" % (fieldNameEn, dataType))
        fieldList.append("id ")
        fieldList.append("task_job_create_time")
        fieldList.append("task_job_del_flag ")
        fieldList.append("task_job_id_sequence")
        fieldList.append("parent_id ")
        fieldList.append("task_job_url ")
        fielddic = {}
        collection = self.db[tableName]
        for index,item in enumerate(fieldList):
            if item == 'task_job_create_time':
                fielddic[item] = time.strftime('%Y-%m-%d %H:%M:%S')
            else:
                fielddic[item] = ''
        collection.insert(fielddic)

    def query_count(self, tableName, parentId=None, taskHistoryId=None):
        """
        查询collection 文档数据量
        :param tableName:
        :param parentId:
        :param taskHistoryId:
        :return:
        """
        collection = self.db[tableName]

        return collection.find().count()

    def query_table_pages(self, tableName, page, pageCount, parentId=None, taskHistoryId=None):
        """
        mongodb 分页查询
        :param tableName:
        :param page:
        :param pageCount:
        :param parentId:
        :param taskHistoryId:
        :return:
        """
        collection = self.db[tableName]
        offset = (page-1)*pageCount
        pageData = collection.find().skip(offset).limit(pageCount)
        datalist = list(pageData)
        return datalist

    def query_collect_index(self, dbname, tablename):
        """
        获取collection信息数据:dict
        key:totalIndexSize   collection中索引数据大小
            storageSize      为collection分配的空间大小，包括未使用的空间
            totalSize        collection中索引+data所占空间
        :param dbname:
        :param tablename:
        :return:
        """
        collection = self.db[tablename]
        collectionInfo =  self.db.command("collstats",tablename)
        metadata = collectionInfo['totalSize']
        return collectionInfo #collection 信息字典


if __name__ == '__main__':
    mongo = mongodb()
    randomnumber = random.uniform(0, 100)
    paramdic = {'paratentid':str(randomnumber-1),'random':str(randomnumber),'author':'mdc'}
    # table = mongo.insert('task_job',paramdic)
    # count = mongo.query_count('task_job')
    count1 = mongo.query_count('task_job','mdc')
    pages = mongo.query_table_pages('task_job',2,10)
    list = list(pages)
    # mongo.createTableByTaskJobId('06ea221f-5ad9-11e7-ae90-002324925c6d')
    # print count1,list
    collection_data = mongo.query_collect_index('Test','task_job')
    print count1