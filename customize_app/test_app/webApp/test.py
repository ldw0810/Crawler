#coding=utf-8
#Created by xutao on 2017-06-27.
import urllib2

request=urllib2.Request("https://openapi.daocloud.io/v1/build-flows")
request.add_header("Authorization","5wg73yxjp7q0w2doojscaw2y0g8uz1cp55xp6629")
response=urllib2.urlopen(request)
print response.read()
