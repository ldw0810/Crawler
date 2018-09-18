#coding=utf-8
#Created by xutao on 2017-04-28.
# coding:utf-8
from scrapy import Selector
from  SeleniumSpider import SeleniumSpider


class BaiduSpider(SeleniumSpider):
    name = 'baidu'
    # allowed_domains = ['movie.douban.com']
    # start_urls = ['http://image.baidu.com/search/index?tn=baiduimage&ct=201326592&lm=-1&cl=2&ie=gbk&word=%CD%BC%C6%AC&fr=ala&ala=1&alatpl=others&pos=0'
    #               ]
    sturls = [
        'https://index.baidu.com/?tpl=demand&word=%B3%C9%B6%BC+%C2%C3%D3%CE'
                  ]
    def __init__(self,namess="child",age='10'):
        self.url = self.sturls[0]
        self.namess = namess
        self.age = age
        self.sm_type = {"type": "login",
                            "option":{"user": {"element": "input[id='TANGRAM_12__userName']", "value": "cyssxt@163.com"},
                            "password": {"element": "input[id='TANGRAM_12__password']", "value": "cyssxt19901231"},
                            "sleeptime": '2',#等待时间
                            "submit": {"element": "input[id='TANGRAM_12__submit']"}}
                        }
    def parse(self, response):
        print "child parse"
        hxs = Selector(response)
        divs = hxs.xpath("//div[@class='pageNum0']").extract()
        print divs
        try:
            with open("testDDDs4.txt", 'w') as f:
                f.write(str(response.body))
                f.close()
        except TypeError:
            print u'页码写入失败'
