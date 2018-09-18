# coding=utf-8
from hashlib import md5

import redis

from utils import ConfigUtils
from utils.ConfigUtils import KEYMAP
#普通redis数据
redisConfig=ConfigUtils.getItems(KEYMAP.URL_STATUS_REDIS)
port=redisConfig.get(KEYMAP.REDIS_PORT)
host=redisConfig.get(KEYMAP.REDIS_HOST)
namespace=redisConfig.get(KEYMAP.REDIS_NAMESPACE)
prefix=redisConfig.get(KEYMAP.REDIS_PREFIX)


#普通redis连接池
pool = redis.ConnectionPool(host=host, port=int(port))
r = redis.Redis(connection_pool=pool)

def llen(key):
    return r.llen(key)
def keys():
    return r.keys()
def lpush(key,value):
    return r.lpush(key,value)
def hset(namespace,key,value):
    return r.hset(namespace,key,value)
def hget(namespace,key):
    return r.hget(namespace,key)
def hkeys(namespace):
    return r.hkeys(namespace)
def hsetUrlRedisStatus(key,value):
    return r.hset(namespace,key,value)
def hgetUrlRedisStatus(key):
    return r.hget(namespace,key)


class SimpleHash(object):
    def __init__(self, cap, seed):
        self.cap = cap
        self.seed = seed

    def hash(self, value):
        ret = 0
        for i in range(len(value)):
            ret += self.seed * ret + ord(value[i])
        return (self.cap - 1) & ret


class BloomFilter(object):
    def __init__(self,db=0, blockNum=2,key="url_have_crawled"):
        """
        :param db: witch db in Redis
        :param blockNum: one blockNum for about 90,000,000; if you have more strings for filtering, increase it.
        :param key: the key's name in Redis
        """
        # self.server = redis.Redis(host=host, port=port, db=db)
        self.bit_size = 1 << 31  # Redis的String类型最大容量为512M，现使用256M
        self.seeds = [5, 7, 11, 13, 31, 37, 61]
        self.blockNum = blockNum
        self.key=key
        self.hashfunc = []
        for seed in self.seeds:
            self.hashfunc.append(SimpleHash(self.bit_size, seed))

    def isContains(self,id,str_input):
        if not str_input:
            return False
        m5 = md5()
        m5.update(str_input)
        str_input = m5.hexdigest()
        ret = True
        name = id+"_"+self.key #+ str(int(str_input[0:2], 16) % self.blockNum)
        for f in self.hashfunc:
            loc = f.hash(str_input)
            ret = ret & r.getbit(name, loc)
        return ret

    def insert(self,id,str_input):
        m5 = md5()
        m5.update(str_input)
        str_input = m5.hexdigest()
        name = id+"_"+self.key #+ str(int(str_input[0:2], 16) % self.blockNum)
        for f in self.hashfunc:
            loc = f.hash(str_input)
            r.setbit(name, loc, 1)
    def delete(self,id):
        name = id+"_"+self.key #+ str(int(str_input[0:2], 16) % self.blockNum)
        r.delete(name)
if __name__=="__main__":
    """ 第一次运行时会显示 not exists!，之后再运行会显示 exists! """
    bf = BloomFilter()
    # if bf.isContains("123",'55http://www.baidu.com'):  # 判断字符串是否存在
    #     print 'exists!'
    # else:
    #     print 'not exists!'
    #     bf.insert("123",'55http://www.baidu.com')
    bf.delete("98dabacf-5c75-11e7-a462-00232490c701")
