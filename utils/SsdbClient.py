# coding=utf-8
# !/usr/bin/env python
"""
-------------------------------------------------
   File Name：     SsdbClient.py
   Description :  封装SSDB操作
   Author :       wyy
   date：          2016/12/2
-------------------------------------------------
   Change Activity:
                   2016/12/2:
-------------------------------------------------
"""
import os, sys
from sys import stdin, stdout
from SSDB import SSDB
import hashlib
class SsdbClient(object):
    """
    SSDB client
    """

    def __init__(self, host, port):
        self.__conn = SSDB(host, port)

    def put(self, tablename, key, value):
        self.__conn.request('hset', [tablename, key, value])

    def get(self,tablename,key):
        return self.__conn.request('hget', [tablename, key]).data

    def delete(self,tablename,key):
        return self.__conn.request('hdel',[tablename,('%s' % key)])

    def getAll(self,tablename):
        return self.__conn.request('hgetall', [tablename]).data

    def deleteAll(self):
        return self.__conn.request('flushdb')

if __name__ == '__main__':
    ost = '172.21.14.35'
    port = 8888
    ssdb = SsdbClient(ost, port)
    # dic={'id':'11','cacheid':'112','userid':'112','crawlid':'111','ip':'12.121.21.11','delaytime':'111','flag':'111','date':'111'}
    # ssdb.put('prolist',dic)
    # dix = ssdb.getAll('raw_proxy_queue')

