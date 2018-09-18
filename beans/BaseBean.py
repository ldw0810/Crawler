# -*- coding: utf-8 -*-
import inspect
import json
from types import NoneType
from sqlalchemy.ext.declarative import declarative_base
Base = declarative_base();
class BaseBean():
    # ext={}
    """

    """
    # def __repr__(self):
    #     result = {}
    #     # result = result + self.__class__.__name__ + "\r\n"
    #     for i, j in vars(self).items():
    #         if type(i) == NoneType or str(i) == None or str(j) == None or str(i).startswith("__") or str(i).startswith("_"):
    #             continue
    #         result[i]=str(j).decode('utf-8')
    #     return str(json.dumps(result))