# coding=utf-8
import ConfigParser
import os

import Settings

KEYMAP=Settings.KEYMAP
getPorperties=Settings.getPorperties
getDesPorperties=Settings.getDesPorperties
getRedisPorperties=Settings.getRedisPorperties
getSpiderPorperties=Settings.getSpiderPorperties
getMysqlPorperties=Settings.getMysqlPorperties
getWebPorperties=Settings.getWebPorperties
getItems=Settings.getItems
getHdfsHost = Settings.getHDFSHost
getZookeeperHosts = Settings.getZookeeperHosts
if __name__=="__main__":
    print getZookeeperHosts(Settings.KEYMAP.ZOOKEEPER_HOSTS)