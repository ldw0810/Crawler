#coding=utf-8
#Created by xutao on 2017-05-08.
import sys
import threading

from customize_app.publisher import WebSocket as websocket
from utils import ConfigUtils

reload(sys)
sys.setdefaultencoding('utf-8')

ip=ConfigUtils.getPorperties(ConfigUtils.KEYMAP.WEBSOCKET,ConfigUtils.KEYMAP.WEBSOCKET_IP)
port=ConfigUtils.getPorperties(ConfigUtils.KEYMAP.WEBSOCKET,ConfigUtils.KEYMAP.WEBSOCKET_PORT)
def init():
    t=threading.Thread(target=websocket.start,args=(ip,int(port)))
    # t.start()