#coding=utf-8
#Created by xutao on 2017-05-06.
class CacheFactory():
    _instance=None
    cacheMap={}
    # def __new__(cls, *args, **kwargs):
    #     if CacheFactory.__instance is None:
    #         CacheFactory.__instance = object.__new__(cls, *args, **kwargs)
    #         CacheFactory.__instance.cacheMap={}
    #     return CacheFactory.__instance
    @staticmethod
    def cache(glo,key,value):
        if CacheFactory.cacheMap.get(glo)==None:
            CacheFactory.cacheMap[glo]={}
        CacheFactory.cacheMap[glo][key]=value

    @staticmethod
    def get(glo,key):
        if(CacheFactory.cacheMap==None):
            CacheFactory.cacheMap={}
        if(CacheFactory.cacheMap.get(glo)==None):
            CacheFactory.cacheMap[glo]={}
        return CacheFactory.cacheMap.get(glo).get(key)

    @staticmethod
    def clear(glo=None,key=None):
        if glo==None:
            CacheFactory.cacheMap={}
        else:
            if CacheFactory.cacheMap.get(glo)!=None:
                CacheFactory.cacheMap.get(glo).pop(key)


