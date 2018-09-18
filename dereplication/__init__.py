#coding=utf-8
#Created by xutao on 2017-04-21.
#去重redis数据
import redis

from utils import ConfigUtils
from utils.ConfigUtils import KEYMAP

dereplicationRedisConfig=ConfigUtils.getItems(KEYMAP.DEREPLICATION)
dereHost=dereplicationRedisConfig.get(KEYMAP.REDIS_HOST)
derePort=dereplicationRedisConfig.get(KEYMAP.REDIS_PORT)
dereNamespace=dereplicationRedisConfig.get(KEYMAP.REDIS_NAMESPACE)
derePrefrex=dereplicationRedisConfig.get(KEYMAP.REDIS_PREFIX)

#去重redis连接池
derePool = redis.ConnectionPool(host=dereHost, port=int(derePort))
dereRedis = redis.Redis(connection_pool=derePool)

def lpush(key,value):
    return dereRedis.lpush(key,value)
def hset(namespace,key,value):
    return dereRedis.hset(namespace,key,value)
def hget(namespace,key):
    return dereRedis.hget(namespace,key)
def hsetUrl(key,value):
    return dereRedis.hset(dereNamespace,key,value)
def hgetUrl(key):
    return dereRedis.hget(dereNamespace,key)