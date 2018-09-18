#!/usr/bin/env python
# -*- coding: utf-8 -*-
from pyhdfs import HdfsClient
import logging
import time
import sys
from dao import TaskJobDao
class hdfs(object):
    #默认50070端口
    def __init__(self,cur_database_param):
        # super(HdfsClients, self).__init__()
        # self.quert_db_info = super(HdfsClients, self).getDBConfig()
        # self.hdfsHost=self.quert_db_info["host"]
        hdfsHost = cur_database_param['url']
        path = cur_database_param['dbname']
        self.hdfs = HdfsClient(hosts='{hdfs_host}'.format(
            hdfs_host=hdfsHost
        ))
        self.host=hdfsHost
        self.path=path

    def append(self,path, data):
        self.hdfs.append(path, data)
        pass

    def concat(self,target,sources):
        self.concat(target,sources)

    # self, taskJobId,tableName=None,jobTemplateFieldList=None
    def createTableByTaskJobId(self,taskJobId,tableName=None,jobTemplateFieldList=None,data=None):
        if tableName == None:
            taskJob = TaskJobDao.loadTaskById(taskJobId)
            tableName = taskJob.tableName
        path = self.path+'/'+tableName
        self.hdfs.create(path,data,replication=2)

    def hmkdirs(self,path):
        self.hdfs.mkdirs(path)


    def open(self,path):
        return self.hdfs.open(path=path)

    def delete(self,path):
        self.hdfs.delete(path=path)

    def listdir(self,rule):
        f = self.hdfs.listdir(rule)
        return f

    def insert(self,jobid,tablename, column_dict,paramMap=None):
        if tablename == None:
            taskJob = TaskJobDao.loadTaskById(jobid)
            tablename = taskJob.tableName
        path = self.path + '/' + tablename
        createTime = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
        task_job_id_sequenceValue = paramMap.get("task_job_id_sequence") if paramMap != None else None
        if task_job_id_sequenceValue != None:
            column_dict.update({"task_job_id_sequence": str(task_job_id_sequenceValue)})
        column_dict.update({"task_job_del_flag": "False", "task_job_create_time": createTime})
        # self.append(path, column_dict)
        if self.isTableExist(tablename):
            self.append(path, column_dict)
        else:
            self.createTableByTaskJobId(jobid,tablename, column_dict)
        # return column_dict

    def isTableExist(self,tablename):
        path = self.path + '/' + tablename
        exist = self.hdfs.exists(path)
        return exist

    def save_to_hdfs(self,jobid,path,data):
        if self.isTableExist(path):
            self.append(path,data)
        else:
            self.createTableByTaskJobId(jobid,path,data)

    def save_to_hdfs2(self,path,data):
        if self.hdfs.exists(path):
            self.hdfs.append(path,data)
        else:
            self.hdfs.create(path,data,replication=2)
    def execute(self, sqls="append",path=None,data=None):
        try:
            if isinstance(sqls,list) and len(sqls) > 0:
                for sql in sqls:
                    # method = eval(sql)
                    method = getattr(self,sql)
                    method(path,data)
            else:
                # method = eval(sqls)
                method = getattr(self, sqls)
                method(path,data)
        except Exception,e:
            logging.error("hdfs,execute,"+str(e))
            raise  Exception()

def main():
    path = "/depthSpider/cache/zhangshan3666"
    tablepath = '/root/mdc/chengduhuaqu_list'
    rootpath = '/root/mdc'
    dic = {
        "url": "172.21.14.46",
        "dbname":path
    }
    path1 = "/depthSpider/cache/zhangshan3666/table1"
    fs = hdfs(dic)
    data = {"data":'123'}
    # fs.createTableByTaskJobId('0000','table1')
    # print fs.exists(path)
    # fs.execute('append')
    fs.append(path1, data)
    # fs.save_to_hdfs("/depthSpider/cache/zhangshan3666/table","\n123")
    print fs.listdir(rootpath)
    with fs.open(tablepath) as f:
        print f.read()
if __name__=="__main__":
    main()