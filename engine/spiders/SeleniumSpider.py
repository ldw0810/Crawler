# coding:utf-8

from scrapy.spiders import Spider
import scrapy


class SeleniumSpider(Spider):
    name = 'spl'
    custom_settings = {
        "DOWNLOADER_MIDDLEWARES": {
            'scrapy.contrib.spidermiddleware.offsite.OffsiteMiddleware': None,
            'engine.middlewares.SeleniumMiddleware': 543,
        }
    }

    def __init__(self, namess='', sm_type={}, url=""):
        self.url = url
        self.namess = namess
        self.sm_type = sm_type

    def start_requests(self):
        return [scrapy.FormRequest(self.url,
                                   callback=self.parse)]

    def make_requests_from_url(self, url):
        return None

    def parse(self, response):
        print "fater parse"
        return None

    def parseAg(self):
        print "parseAg--", self.namess, self.age
