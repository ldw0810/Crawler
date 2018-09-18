# coding=utf-8
import json
import urllib
import urllib2
import cookielib

from poster.encode import multipart_encode
from poster.streaminghttp import register_openers


# proxy_handler = urllib2.ProxyHandler({'http': '60.163.90.194:10708'})
# opener = urllib2.build_opener(proxy_handler)
# r = opener.open('http://travel.qunar.com/p-cs300085-chengdu-jiudian')
# print(r.read())
from beans.UrlTable import UrlStatus

if True:
    body_value = {"noticesubtype": "11", "xzqh": "ALL", "title": "null"}
    register_openers()
    datagen, re_headers=multipart_encode(body_value)
    req = urllib2.Request("http://sd.gsxt.gov.cn/pub/notice/?ad_check=1",datagen, re_headers)
    resp = urllib2.urlopen(req)#body_value
    print resp.read()