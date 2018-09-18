# coding:utf-8
from scrapy import Selector
from  SeleniumSpider import SeleniumSpider


class ChildVideoSpider(SeleniumSpider):
    name = 'childspl'
    # allowed_domains = ['movie.douban.com']
    # start_urls = ['http://image.baidu.com/search/index?tn=baiduimage&ct=201326592&lm=-1&cl=2&ie=gbk&word=%CD%BC%C6%AC&fr=ala&ala=1&alatpl=others&pos=0'
    #               ]
    sturls = [
        'http://image.baidu.com/search/index?tn=baiduimage&ct=201326592&lm=-1&cl=2&ie=gbk&word=%CD%BC%C6%AC&fr=ala&ala=1&alatpl=others&pos=0'
                  ]
    def __init__(self,namess="child",age='10'):
        self.url = self.sturls[0]
        self.namess = namess
        self.age = age
        self.sm_type = {"type": "scroll", "option": {
                "scroll_count": "4",
                "scroll_step": "2000",
                "sleeptime":'1'
            }}
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
