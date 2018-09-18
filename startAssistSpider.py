# coding=utf-8
from scrapy.crawler import CrawlerRunner
from scrapy.utils.log import configure_logging
from scrapy.utils.project import get_project_settings
from twisted.internet import reactor

from engine.spiders.BaiduSpider import BaiduSpider
from engine.spiders.SpidersList import AssistRedisSpider
# configure_logging({'LOG_FORMAT': '%(levelname)s: %(message)s'})
# runner = CrawlerRunner(get_project_settings())
#
# d = runner.crawl(TopSpider)
# d.addBoth(lambda _: reactor.stop())
# reactor.run()


configure_logging({'LOG_FORMAT': '%(levelname)s: %(message)s'})
runner = CrawlerRunner(get_project_settings())

d = runner.crawl(BaiduSpider)
d.addBoth(lambda _: reactor.stop())
reactor.run()

# configure_logging({'LOG_FORMAT': '%(levelname)s: %(message)s'})
# runner = CrawlerRunner(get_project_settings())
# d = runner.crawl(RedisSpider)
# d.addBoth(lambda _: reactor.stop())
# reactor.run()