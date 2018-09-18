#coding=utf-8
#Created by xutao on 2017-04-21.
import json

from utils import DesUtils


def push(ID,URL,IP,PORT,Version,RefreshTime,domain):
    data={
        "ID":ID,
        "URL":URL,
        "IP":IP,
        "PORT":PORT,
        "Version":Version,
        "RefreshTime":RefreshTime,
        "domain":domain
    }
    return DesUtils.encrypt(json.dumps(data));
if __name__=="__main__":
    id=push("http:www.baidu.comhttp:www.baidu.comhttp:www.baidu.comhttp:www.baidu.comhttp:www.baidu.com","123","123","123","123","123","123")
    print id
    # print DesUtils.decrypt(id)