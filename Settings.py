#coding=utf-8
#Created by xutao on 2017-04-20.
#开发 不填表示生产
import ConfigParser
import os
import logging

Profile="_dev"
ProjectName="Crawler"
SettingFileName="config"
SettingFileNameDev="config"

class KEYMAP():
    #主spider的redis键值
    MAIN_SPIDER_REDIS_KEY="MAIN_SPIDER_REDIS_KEY"
    PHANTOMJS="PHANTOMJS"
    CHROME = "CHROME"
    # 辅助spider的redis键值
    ASSIST_SPIDER_REDIS_KEY = "ASSIST_SPIDER_REDIS_KEY"
    # 主spider的名称
    MAIN_SPIDER_NAME = "MAIN_SPIDER_NAME"
    TEMPLATE_SPIDER_NAME = "TEMPLATE_SPIDER_NAME"
    TEMPLATE_SPIDER_NAME_REDIS_KEY = "TEMPLATE_SPIDER_NAME_REDIS_KEY"
    # 深度爬取spider
    DEPTH_SPIDER_NAME = "DEPTH_SPIDER_NAME"
    DEPTH_SPIDER_REDIS_KEY = "DEPTH_SPIDER_REDIS_KEY"
    URL_LIST_SPIDER_REDIS_KEY = "URL_LIST_SPIDER_REDIS_KEY"
    DISTRIBUTED_SPIDER_NODE_LIST="DISTRIBUTED_SPIDER_NODE_LIST"
    DISTRIBUTED_SPIDER_SWITCH="DISTRIBUTED_SPIDER_SWITCH"
    FINISH_SPIDER_REDIS_KEY="FINISH_SPIDER_REDIS_KEY"
    FINISH_SPIDER_NAME="FINISH_SPIDER_NAME"
    #爬取失败spider
    Failure_SPIDER_REDIS_KEY='Failure_SPIDER_REDIS_KEY'
    Failure_SPIDER_NAME='Failure_SPIDER_NAME'
    VIRTUAL_NODE="VIRTUAL_NODE"
    # 副spider的名称
    ASSIST_SPIDER_NAME = "ASSIST_SPIDER_NAME"
    ALLOW_FILES = "ALLOW_FILES"
    UPLOAD_FOLDER = "UPLOAD_FOLDER"
    UPLOAD = "UPLOAD"
    REDIS="REDIS"
    DES="DES"
    URL_STATUS_REDIS="URL_STATUS_REDIS"
    REDIS_HOST="REDIS_HOST"
    REDIS_PORT="REDIS_PORT"
    REDIS_NAMESPACE = "REDIS_NAMESPACE"
    REDIS_PREFIX="REDIS_PREFIX"
    SPIDER="SPIDER"
    MYSQL="MYSQL"
    MYSQL_HOST = 'MYSQL_HOST'
    MYSQL_DBNAME = 'MYSQL_DBNAME'
    MYSQL_USERNAME = 'MYSQL_USERNAME'
    MYSQL_PASSWD = 'MYSQL_PASSWD'
    MYSQL_ENCODE = 'MYSQL_ENCODE'
    MYSQL_PORT = 'MYSQL_PORT'
    WEBAPP = 'WEBAPP'
    HOST = 'HOST'
    PORT = 'PORT'
    DEREPLICATION = 'DEREPLICATION'
    DEREPLICATION = 'DEREPLICATION'
    WEBSOCKET = 'WEBSOCKET'
    WEBSOCKET_IP = 'WEBSOCKET_IP'
    WEBSOCKET_PORT = 'WEBSOCKET_PORT'
    HDFS='HDFS'
    HDFS_MASTER_HOST="HDFS_MASTER_HOST"
    ZOOKEEPER="ZOOKEEPER"
    ZOOKEEPER_HOSTS="ZOOKEEPER_HOSTS"

class ConfigParserCustomer(ConfigParser.ConfigParser):
    def __init__(self,defaults=None):
        ConfigParser.ConfigParser.__init__(self,defaults=None)
    def optionxform(self, optionstr):
        return optionstr
conf = ConfigParserCustomer()
FileName="%s%s.ini"%(SettingFileName,Profile)
path = os.path.dirname(os.path.abspath(__file__))
# path= os.path.abspath(FileName)
conf.read(path+"/"+FileName)
def getPorperties(glo,name,defaultStr=""):
    value=conf.get(glo,name)
    return defaultStr if value==None else value
def getDesPorperties(name,defaultStr=""):
    return getPorperties(KEYMAP.DES,name,defaultStr)
def getRedisPorperties(name,defaultStr=""):
    return getPorperties(KEYMAP.REDIS,name,defaultStr)
def getSpiderPorperties(name,defaultStr=""):
    return getPorperties(KEYMAP.SPIDER,name,defaultStr)
def getMysqlPorperties(name,defaultStr=""):
    return getPorperties(KEYMAP.MYSQL,name,defaultStr)
def getWebPorperties(name,defaultStr=""):
    return getPorperties(KEYMAP.WEBAPP,name,defaultStr)
def getHDFSHost(name,defaultStr=""):
    return getPorperties(KEYMAP.HDFS,name,defaultStr)
def getZookeeperHosts(name,defaultStr=""):
    return getPorperties(KEYMAP.ZOOKEEPER,name,defaultStr)
#获取命名空间下的所有配置
def getItems(glo):
    dictConfig={}
    data = conf.items(glo)
    for d in data:
        dictConfig[d[0]]=d[1]
    return dictConfig
#正常日志级别开关
logLevel = eval("logging.%s"%(getPorperties(KEYMAP.WEBAPP,"logLevel","ERROR")))
LoggerLevel=logLevel
#sqlalchemy日志级别开关
sqllogLevel = eval("logging.%s"%(getPorperties(KEYMAP.WEBAPP,"sqlLogLever","ERROR")))
SqlLoggerLevel=sqllogLevel

maximumData = 1300000
minimunData = 1100000