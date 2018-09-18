# coding=utf-8
import json
import re
from scrapy import Selector
from scrapy_redis.spiders import RedisCrawlSpider

from engine.spiders.RedisCallbackSpider import RedisCallbackSpider
from utils import ConfigUtils
from beans.TemplateTable import JobTemplateField
from dao.BaseDao import query


class RedisSpider(RedisCallbackSpider):
    name = 'RedisSpider'
    custom_settings = ConfigUtils.getItems("REDIS")
    redis_key = 'redisSpider:startId'
    def beforeStartUrl(self,data):
        if(data==None):
            return data;
        dict=json.loads(data)
        return dict["url"] if dict.has_key("url") else "http://www.baidu.com"
    def parse(self, response):
        items=[]
        hxs = Selector(response)
        jobTemplateFieldList = query(JobTemplateField,type=1)
        for jobTemplateField in jobTemplateFieldList:
            fieldNameEn=jobTemplateField.fieldNameEn
            fieldValue=jobTemplateField.fieldValue
            node = hxs.xpath(fieldValue).extract()
            split=jobTemplateField.split if jobTemplateField.split!=None else ""
            value=split.join(node)
            value=value if value!=None else ""
            regExp=jobTemplateField.regExp
            if regExp!=None and regExp != "":
                pattern = re.compile(regExp);
                matches = pattern.search(value.encode("utf8"))
                if matches != None and len(matches.groups()) > 0:
                    value = regExp.join(matches.groups())
                elif len(matches.groups())==0 and matches!=None:
                    value=matches.group()
            items[fieldNameEn]=value
        self.log('A response from %s just arrived!' % response.url)
        return items
if __name__=="__main__":
    textHtml=u"""
                              出版社：
                    人民邮电出版社

    ISBN：9787115413581
    版次：1
    商品编码：11895364
    包装：平装
    开本：16开
    出版时间：2016-03-01
    用纸：纯质纸
    页数：503
    字数：660000
    正文语种：中文
                            """
    pattern = re.compile("出版社：[\s]+[^\s]*");
    # print textHtml
    matches = pattern.search(textHtml.encode("utf8"))
    if matches:
        print len(matches.groups())
