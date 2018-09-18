#coding=utf-8
#Created by xutao on 2017-05-11.
import logging

from scrapy.crawler import CrawlerRunner
from scrapy.utils.project import get_project_settings
from twisted.internet import reactor

from Settings import LoggerLevel
from engine.spiders.DepthSpider import DepthSpider
def startSpider():
    logging.basicConfig(level=LoggerLevel,
                        format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s')

    runner = CrawlerRunner(get_project_settings())

    d = runner.crawl(DepthSpider)
    d.addBoth(lambda _: reactor.stop())
    reactor.run()
if __name__=="__main__":
    startSpider()