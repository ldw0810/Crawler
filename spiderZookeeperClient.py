# coding=utf-8
# Created by yupengcheng on 2017-08-02.
import logging
import socket
import os
import time
from kazoo.client import KazooClient, KazooState
from kazoo.exceptions import NodeExistsException
from Settings import KEYMAP
from utils import ConfigUtils

zookeeper_hosts = ConfigUtils.getZookeeperHosts(KEYMAP.ZOOKEEPER_HOSTS)
SPIDER_SERVER_NODE = '/spiderServer'


def get_ip():
    try:
        csock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        csock.connect(('8.8.8.8', 80))
        (addr, port) = csock.getsockname()
        csock.close()
        return addr
    except socket.error:
        return "127.0.0.1"


def add_node_to_zookeeper():
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

    zk.start()
    # 创建“/spiderServer”永久节点，后面每个有效的redis节点，或动态添加redis节点后，都会在
    # “/spiderServer”节点下创建对应的redis服务节点（如：/spiderServer/128.0.0.203），服务节点名称已redis服务所在的机器的ip地址命名
    if zk.exists(SPIDER_SERVER_NODE):
        pass
    else:
        try:
            zk.create(SPIDER_SERVER_NODE)
        except Exception,e:
            if isinstance(e,NodeExistsException):
                pass
            else:
                logging.exception(str(e))
    ip = get_ip()
    node_path = '%s/%s' % (SPIDER_SERVER_NODE, ip+"_"+str(os.getpid()))
    zk.create(node_path, value=ip+"_"+str(os.getpid()), ephemeral=True)


if __name__ == "__main__":
    add_node_to_zookeeper()