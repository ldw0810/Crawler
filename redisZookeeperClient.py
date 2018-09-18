# coding=utf-8
# Created by yupengcheng on 2017-08-02.
import ConfigParser
import socket
import time

import redis
from kazoo.client import KazooClient, KazooState

conf = ConfigParser.ConfigParser()
conf.read('config.ini')
zookeeper_hosts = conf.get("ZOOKEEPER","ZOOKEEPER_HOSTS")
zk = KazooClient(hosts=zookeeper_hosts)
REDIS_SERVER_NODE = '/redisServer'

@zk.add_listener
def zookeeper_listener(state):
    if state == KazooState.LOST:
        print "LOST"
        # Register somewhere that the session was lost
        pass
    elif state == KazooState.SUSPENDED:
        # Handle being disconnected from Zookeeper
        print "SUSPENDED"
        pass
    elif state == KazooState.CONNECTED:
        print "CONNECTED"
        pass
    else:
        print state
        pass


def get_ip():
    try:
        csock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        csock.connect(('8.8.8.8', 80))
        (addr, port) = csock.getsockname()
        csock.close()
        return addr
    except socket.error:
        return "127.0.0.1"


if __name__ == "__main__":
    zk.start()
    # 创建“/redisServer”永久节点，后面每个有效的redis节点，或动态添加redis节点后，都会在
    # “/redisServer”节点下创建对应的redis服务节点（如：/redisServer/128.0.0.203），服务节点名称已redis服务所在的机器的ip地址命名
    if zk.exists(REDIS_SERVER_NODE):
        pass
    else:
        zk.create(REDIS_SERVER_NODE)
    redis_ip = get_ip()
    node_path = '%s/%s' % (REDIS_SERVER_NODE,redis_ip)
    pool = redis.ConnectionPool(host='localhost', port=6379)
    r = redis.Redis(connection_pool=pool)
    while True:
        try:
            if r.ping() and not zk.exists(node_path):
                # 如果redis服务可以ping通并且不存在临时节点“/redisServer/该redis节点的ip”,那么就创建该临时节点
                zk.create(node_path, value=redis_ip, ephemeral=True)
        except Exception, e:
            # 如果redis服务无法ping通，说明，redis服务无效了，此时删除该redis对应的节点信息
            if zk.exists(node_path):
                zk.delete(node_path)
        time.sleep(3)
    pass
