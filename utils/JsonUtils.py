#coding=utf-8
import inspect
import json
import pickle
from datetime import datetime
from uuid import UUID

import logging

from pydispatch.robustapply import function
from sqlalchemy.ext.declarative import DeclarativeMeta

from beans.BaseBean import BaseBean


def new_alchemy_encoder():
    _visited_objs = []

    class AlchemyEncoder(json.JSONEncoder):
        def default(self, obj):
            if inspect.isfunction(obj) or inspect.ismethod(obj):
                return None
            if type(obj)==UUID:
                return str(obj)
            if isinstance(obj, datetime):
                return obj.__str__()
            if isinstance(obj, BaseBean):
                fields = {}
                for field in [x for x in dir(obj) if not x.startswith('_') and x != 'metadata']:
                    data=None
                    try:
                        data = getattr(obj,field)
                    except Exception,e:
                        logging.error("jsonUtils,error:%s:%s"%(field,str(e)))
                    # if type(data)==function:
                    if data==None:
                        continue
                    try:
                        if isinstance(data, datetime):
                            data = data.strftime('%Y-%m-%d %H:%M:%S')
                        # json.dumps(data)  # this will fail on non-encodable values, like other classes
                        if isinstance(data, BaseBean) or type(data)==dict:
                            try:
                                if type(data)==dict:
                                    fields[field]=data
                                else:
                                    fields[field] = AlchemyEncoder().default(data)
                            except Exception,e:
                                logging.error("jsonUtils,error:%s"%(str(e)))
                        else:
                            if hasattr(data, "encode"):
                                fields[field] = data  # .encode("utf8")
                            else:
                                fields[field]=data
                    except TypeError:
                        fields[field] = None
                return fields

            return json.JSONEncoder.default(self, obj)

    return AlchemyEncoder
def parseJsonToClass(dict,Clazz):
    data = Clazz()
    for key in dict:
        if hasattr(data, key):
            setattr(data, key, dict[key])
    return data


def parseClassToDict(obj):
    pr = {}
    for name in dir(obj):
        value = getattr(obj, name)
        if not name.startswith('_') and not name.startswith("metadata") and not callable(value):
            pr[name] = value
    return pr


def stringify(data):
    return json.dumps(data, cls=new_alchemy_encoder(), sort_keys=True, indent=4,encoding='utf-8',ensure_ascii=False)