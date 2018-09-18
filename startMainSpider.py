# coding=utf-8
import logging
from scrapy.crawler import CrawlerRunner
from scrapy.utils.project import get_project_settings
from twisted.internet import reactor

from Settings import LoggerLevel
from engine.spiders.SpidersList import MainRedisSpider
from engine.spiders.TemplateSpidersList import TemplateRedisSpider
from utils.LogUtils import LoggingFormatter,LoggingHandle
import spiderZookeeperClient

def startSpider(spider=MainRedisSpider):
    # logging.basicConfig(level=LoggerLevel,
    #                     format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s')
    formater = LoggingFormatter(filename='startMainSpider')
    handle = LoggingHandle()
    handle.setLevel(LoggerLevel)
    handle.setFormatter(formater)
    logging.getLogger('').addHandler(handle)
    try:
        spiderZookeeperClient.add_node_to_zookeeper()
    except Exception,e:
        logging.exception(str(e))
    runner = CrawlerRunner(get_project_settings())

    d = runner.crawl(spider)
    d.addBoth(lambda _: reactor.stop())
    reactor.run()
if __name__=="__main__":
    startSpider(TemplateRedisSpider)
# reactor.listenTCP
# configure_logging({'LOG_FORMAT': '%(levelname)s: %(message)s'})
# runner = CrawlerRunner(get_project_settings())
# d = runner.crawl(RedisSpider)
# d.addBoth(lambda _: reactor.stop())
# reactor.run()