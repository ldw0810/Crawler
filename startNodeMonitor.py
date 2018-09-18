# coding=utf-8
import ConfigParser
import logging
import threading
import time
import uuid

import MySQLdb.cursors
from DBUtils.PooledDB import PooledDB
from kazoo.client import KazooClient, KazooState

SPIDER_SERVER_NODE = '/spiderServer'
REDIS_SERVER_NODE = '/redisServer'
conf = ConfigParser.ConfigParser()
conf.read('config.ini')
zookeeper_hosts = conf.get("ZOOKEEPER","ZOOKEEPER_HOSTS")
mysql_host = conf.get("MYSQL","MYSQL_HOST")
mysql_user = conf.get("MYSQL","MYSQL_USERNAME")
mysql_pass = conf.get("MYSQL","MYSQL_PASSWD")
mysql_db = conf.get("MYSQL","MYSQL_DBNAME")

pool = PooledDB(MySQLdb,5,host=mysql_host,user=mysql_user,passwd=mysql_pass,db=mysql_db,port=3306)

mutex = threading.Lock()

def execute_sql(sql,type=0):
    """
    
    :param sql: 
    :param type: 0执行查询语句，1表示执行更新语句
    :return: 
    """
    conn = pool.connection()
    cur = conn.cursor()
    try:
        result = cur.execute(sql)
        if type ==1:
            conn.commit()
        else:
            result = cur.fetchall()
        return result
    except Exception,e:
        conn.rollback()
        logging.error(str(e))
        return -1
    finally:
        cur.close()
        conn.close()

def start_node_monitor():
    zk = KazooClient(hosts=zookeeper_hosts)

    @zk.add_listener
    def zookeeper_listener(state):
        if state == KazooState.LOST:
            logging.info("zookeeper connect status:LOST")
            # Register somewhere that the session was lost
        elif state == KazooState.SUSPENDED:
            # Handle being disconnected from Zookeeper
            logging.info("zookeeper connect status:SUSPENDED")
        elif state == KazooState.CONNECTED:
            logging.info("zookeeper connect status:CONNECTED")
        else:
            logging.info(str(state))

    @zk.ChildrenWatch(SPIDER_SERVER_NODE)
    def spider_watch(children):
        """
        监听"/spiderServer"节点下的信息,以此来判断分布式环境中可用的spider节点
        （往"/spiderServer"节点下添加或删除子节点都会促发该方法）
        :param children: 子节点名称集合（list）如：['10.128.100.201','10.128.100.202']
        :return:
        """
        logging.info("spider_watch Children are now: %s" % children)
        update_node_info('spider', children)

    @zk.ChildrenWatch(REDIS_SERVER_NODE)
    def redis_watch(children):
        """
        监听"/redisServer"节点下的信息,以此来判断分布式环境中可用的redis节点
        （往"/redisServer"节点下添加或删除子节点都会促发该方法）
        :param children: 子节点名称集合（list）如：['10.128.100.201','10.128.100.202']
        :return:
        """
        logging.info("redis_watch Children are now: %s" % children)
        print threading.currentThread().getName()
        update_node_info('redis', children)

    def update_node_info(name, nodeInfos):
        try:
            if mutex.acquire():
                if len(nodeInfos) > 0:
                    update_sql = None
                    if len(nodeInfos) == 1:
                        # 刷新可用的节点信息
                        update_sql = "update node_monitor n set n.node_status=1 where n.`name`='%s' and n.node_ip='%s'" % (
                            name, nodeInfos[0])
                        execute_sql(update_sql,1)
                        # 刷新不可用的节点信息
                        update_sql = "update node_monitor n set n.node_status=0 where n.`name`='%s' and n.node_ip!='%s'" % (
                            name, nodeInfos[0])
                        execute_sql(update_sql,1)
                    else:
                        _in_sql = str(tuple(nodeInfos)).replace('u', '')
                        # 刷新可用的节点信息
                        update_sql = "update node_monitor n set n.node_status=1 where n.`name`='%s' and n.node_ip in %s" % (
                            name, _in_sql)
                        execute_sql(update_sql,1)
                        # 刷新不可用的节点信息
                        update_sql = "update node_monitor n set n.node_status=0 where n.`name`='%s' and n.node_ip not in %s" % (
                            name, _in_sql)
                        execute_sql(update_sql,1)

                    for ip in nodeInfos:
                        node_set = execute_sql("select * from node_monitor where name='%s' and node_ip='%s'" % (name, ip))
                        if len(node_set)==0:
                            id = unicode(uuid.uuid1()).replace('-', '')
                            add_sql = "INSERT INTO `node_monitor` (`id`, `name`, `node_ip`, `node_status`) VALUES ('%s', '%s', '%s', '1')" %(id,name,ip)
                            execute_sql(add_sql,1)
                    pass
                else:
                    update_sql = "update node_monitor n set n.node_status=0 where n.`name`='%s'" % name
                    execute_sql(update_sql,1)
            pass
        except Exception, e:
            logging.exception(e)
        finally:
            mutex.release()

    zk.start()
    while True:
        time.sleep(1.5)

if __name__ == "__main__":
    start_node_monitor()
