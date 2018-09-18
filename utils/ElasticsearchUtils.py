#coding=utf-8
from elasticsearch import Elasticsearch
# ./bin/elasticsearch -d
import datetime
"""
Elasticsearch与关系型数据库对应关系:
Relational DB -> Databases -> Tables -> Rows -> Columns
Elasticsearch -> Index  -> Types  -> Documents -> Fields
"""
class elasticsearch:
    def __init__(self,hosts):
        host_list = hosts.split(',')
        hosts = []
        dic = {}
        for host in host_list:
            dic["host"] = host
            hosts.append(dic)
        self.es  = Elasticsearch(
            hosts,
            sniff_on_start=True,
            sniff_on_connection_fail=True,
            sniffer_timeout=600,
            http_auth = ('elastic', 'changeme')
        )
        # ES = Elasticsearch(['localhost'], http_auth=('elastic', 'changeme'), port=9200)
        print self.es

    def es_insert(self,index, doc_type, body,id=None):
        """
        ES插入数据
        :param index: 索引类似于sql的database
        :param doc_type:文档类型 类似于sql的Table
        :param body:需要插入的数据
        :return:
        """
        self.es.index(index = index,doc_type=doc_type,body=body,id=id)

    def es_create(self,index, doc_type,id,body):
        """
        创建index
        :param index:
        :param doc_type:
        :param id:
        :param body:
        :return:
        """
        return self.es.create(index=index,doc_type=doc_type,id=id,body=body,ignore = 400)

    def es_isexist(self,index, doc_type, id):
        """
        判断doc是否存在
        :param index:
        :param doc_type:
        :param id:
        :return:
        """
        isexist = self.es.exists(index=index,doc_type=doc_type,id=id)
        return isexist

    def es_delete(self, index, doc_type, id):
        """
        删除
        :param index:
        :param doc_type:
        :param id:
        :return:
        """
        self.es.delete(index=index,doc_type=doc_type,id=id)


    def es_get(self,index, id, doc_type='_all', params=None):
        """
        获取数据 :根据id 获取数据
        :param index:
        :param id:
        :param doc_type:
        :param params:
        :return:
        """
        data = self.es.get(index=index,id=id,doc_type=doc_type)['_source']
        return data
    def es_count(self,index=None, doc_type=None, body=None, params=None):
        """
        统计查询
        :param index:
        :param doc_type:
        :param body:
        :param params:
        :return:
        """
        count = self.es.count(index=index, doc_type=doc_type, body=body)
        return count

    def es_page_search(self,index=None, doc_type=None,page=1,pageCount = 10):
        """
        ES分页查询
        :param index:
        :param doc_type:
        :param page:
        :param pageCount:
        :return:
        """
        offset = (page -1)*pageCount
        body = {
             "query": { "match_all": {}},
             "from": offset,
             "size": pageCount
        }
        hits = self.es.search(index=index, doc_type=doc_type,body=body)['hits']['hits']
        return hits



if __name__ == '__main__':
    str = '127.0.0.1'
    body = {"any": "data1", "timestamp": datetime.datetime.now()}
    es = elasticsearch(str)
    # success = es.es_create('test1','test_type','55',body)
    import random
    number = random.randint(100,1000)
    inser = es.es_insert('test','test_type',body,number)
    # data = es.es_query('test','46')
    data = es.es_get('test',1556)
    exist = es.es_isexist('test','test_type',1556)
    count = es.es_count('test','test_type')
    # es.es_delete('test','test_type',1556)
    hits = es.es_page_search('test','test_type',2,5)
    listS = str.split(',')
    print listS