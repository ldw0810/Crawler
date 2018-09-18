#coding=utf-8
#Created by xutao on 2017-04-27.
from beans.TemplateTable import JobTemplate


def copyToNewInstances(originData,clzz):
    data=dir(originData)
    # print data
    newObject=clzz()
    for key in data:
        if key.startswith("_"):
            continue
        value=getattr(originData, key)
        setattr(newObject,key,value)
    return newObject


# print copyToNewInstances(JobTemplate(),JobTemplate)