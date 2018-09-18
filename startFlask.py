#coding=utf-8
#Created by xutao on 2017-04-14.
import logging

from Settings import LoggerLevel
from utils import ConfigUtils
from utils.ConfigUtils import KEYMAP
from web import start
from utils.LogUtils import LoggingFormatter,LoggingHandle
if __name__=="__main__":
    # logging.basicConfig(level=LoggerLevel,
    #                     format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s')
    formater = LoggingFormatter(filename='startFlask')
    handle = LoggingHandle()
    handle.setLevel(LoggerLevel)
    handle.setFormatter(formater)
    logging.getLogger('').addHandler(handle)
    start(host=ConfigUtils.getWebPorperties(KEYMAP.HOST),
          port=int(ConfigUtils.getWebPorperties(KEYMAP.PORT)))