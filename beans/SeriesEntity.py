#coding=utf-8
#Created by xutao on 2017-04-15.
import pickle

import dill as dill

from beans.BaseBean import BaseBean
from beans.TemplateTable import JobTemplate
from utils import DesUtils


class JobTemplateSerialize(BaseBean):
    def __init__(self,jobTemplate,jobTemplateFieldList,jobTemplateParamList):
        self.jobTemplate=jobTemplate
        self.jobTemplateFieldList=jobTemplateFieldList
        self.jobTemplateParamList=jobTemplateParamList
    def serialize(self):
        return DesUtils.encrypt(dill.dumps(self))

    @staticmethod
    def deSerialize(data):
        return dill.loads(DesUtils.decrypt(data))

if __name__=="__main__":
    # a= type(JobTemplateSerialize.deSerialize)
    # print a == pickle.FunctionType
    print JobTemplateSerialize(JobTemplate(),[],[]).serialize()