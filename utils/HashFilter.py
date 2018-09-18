#!/usr/bin/env python
# -*- coding: utf-8-*-

import hashlib
import csv
import datetime
from collections import Counter



class YHash(object):
    def __init__(self, nodes=None, n_number=5):
        """
        :param nodes:           所有的节点
        :param n_number:        一个节点对应多少个虚拟节点
        :return:
        """
        self._n_number = n_number  # 每一个节点对应多少个虚拟节点，这里默认是3个
        self._node_dict = dict()  # 用于将虚拟节点的hash值与node的对应关系
        self._sort_list = []  # 用于存放所有的虚拟节点的hash值，这里需要保持排序
        if nodes:
            for node in nodes:
                self.add_node(node)

    def add_node(self, node):
        """
        添加node，首先要根据虚拟节点的数目，创建所有的虚拟节点，并将其与对应的node对应起来
        当然还需要将虚拟节点的hash值放到排序的里面
        这里在添加了节点之后，需要保持虚拟节点hash值的顺序
        :param node:
        :return:
        """
        for i in xrange(self._n_number):
            node_str = "%s%s" % (node, i) #虚拟节点地址
            key = self._gen_key(node_str) #虚拟节点 md5 hash
            self._node_dict[key] = node #虚拟节点与真实节点一一对应
            self._sort_list.append(key)
        self._sort_list.sort()

    def remove_node(self, node):
        """
        这里一个节点的退出，需要将这个节点的所有的虚拟节点都删除
        :param node:
        :return:
        """
        for i in xrange(self._n_number):
            node_str = "%s%s" % (node, i)
            key = self._gen_key(node_str)
            del self._node_dict[key]
            self._sort_list.remove(key)

    def get_node(self, key_str):
        """
        返回这个字符串应该对应的node，这里先求出字符串的hash值，然后找到第一个小于等于的虚拟节点，然后返回node
        如果hash值大于所有的节点，那么用第一个虚拟节点
        :param :
        :return:
        """
        if self._sort_list:
            key = self._gen_key(key_str)
            for node_key in self._sort_list:
                if key <= node_key:
                    return self._node_dict[node_key]
            return self._node_dict[self._sort_list[0]]
        else:
            return None

    @staticmethod
    def _gen_key(key_str):
        """
        通过key，返回当前key的hash值，这里采用md5
        :param key:
        :return:
        """
        md5_str = hashlib.md5(key_str).hexdigest()
        return long(md5_str, 16)

# urls=[]
# Realnodes=["127.0.0.1", "192.168.1.1","192.168.5.3","192.152.37.53","192.152.37.55","11.152.37.55","11.152.37.66","12.152.37.66"]
# nodePool=[]
# with open("qq.csv") as f:
#     f_csv=csv.reader(f)
#     print "wyy ____f_csv  ",f_csv
#     headers=next(f_csv)
#     for row in f_csv:
#         urls.append(row[0])
#
#     pass
#
#
# fjs = YHash(Realnodes)
# stime=datetime.datetime.now()
# for url in urls:
#     print 'tempNodeurl  ', url
#     tempNode=fjs.get_node(url)
#
#     print 'tempNode ' ,tempNode
#     nodePool.append(tempNode)
# etime=datetime.datetime.now()
# print "共耗时:" ,(etime-stime).microseconds,"微秒"
# nodeDict=Counter(nodePool)
# for Realnode in Realnodes:
#     print "属于 %s 节点的url个数为 %s" % (Realnode,nodeDict[Realnode])


