# -*- coding: utf-8 -*-

import re

from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import Rule
from scrapy.utils.project import get_project_settings

from beans.UrlTable import UrlStatus
from dao import TaskJobDao
from dao import UrlDao
from engine.items import HtmlItem
from engine.spiders.RedisCallbackSpider import RedisCallbackSpider
from utils import ConfigUtils
from utils import RedisUtils
from utils.ConfigUtils import KEYMAP
import logging


class DepthSpider(RedisCallbackSpider):
    name = ConfigUtils.getSpiderPorperties(KEYMAP.DEPTH_SPIDER_NAME)
    custom_settings = ConfigUtils.getItems(KEYMAP.REDIS)
    custom_settings["ITEM_PIPELINES"] = {'engine.pipelines.CacheHtmlPipeline': 300}
    custom_settings["DOWNLOADER_MIDDLEWARES"] = {'engine.useragent.RotateUserAgentMiddleware': 1}
    # start_urls = ['http://mini.qq.com/']
    custom_settings = dict(custom_settings.items() + ConfigUtils.getItems(KEYMAP.MYSQL).items())
    redis_key = ConfigUtils.getRedisPorperties(KEYMAP.DEPTH_SPIDER_REDIS_KEY)
    id = ""
    allowed_domain = None  # 允许爬取的域名
    rules = [Rule(LinkExtractor(allow=()), callback='parse', follow=True)]
    cur_url_depth = 1  # 当前url的深度值
    depth_limit = 3  # 爬取深度

    def beforeStartUrl(self, dataDict):
        if (dataDict == None):
            return dataDict
        id = dataDict.get("id")
        if id == None:
            return
        status = RedisUtils.hgetUrlRedisStatus(RedisUtils.prefix + id)
        taskJobHistoryId = dataDict.get("taskJobHistoryId")
        if taskJobHistoryId:
            taskJobHistory = TaskJobDao.loadTaskJobHistoryById(taskJobHistoryId)
            if taskJobHistory:
                taskJobId = taskJobHistory.taskJobId
                self.taskJob = TaskJobDao.loadTaskById(taskJobId)
                self.taskJobHistory = taskJobHistory
        url = dataDict["url"] if dataDict.has_key("url") else "http://www.baidu.com"
        self.url = url
        if self.allowed_domain is None:
            self.allowed_domain = self.get_first_domain(self.get_domain(url))
        self.cur_url_depth = dataDict.get("curUrlDepth")
        self.depth_limit = dataDict.get("depthLimit") if dataDict.has_key("depthLimit") else 3
        return url;

    def get_domain(self, url):
        """
        获取url中的域名
        :param url: 
        :return: 
        """
        pattern = r'(?<=//).*?(?=/)'
        result = re.findall(pattern, url)
        if result and len(result) > 0:
            return result[0]
        else:
            pattern = r'(?<=//).*'
            result = re.findall(pattern, url)
            if result and len(result) > 0:
                return result[0]
            else:
                return None

    def get_first_domain(self, domain):
        """获取域名中的一级域名,比如www.baidu.com中的baidu.com"""
        pattern = r'(?<=\.).*'
        result = re.findall(pattern, domain)
        if result and len(result) > 0:
            return result[0]

    def parse(self, response):
        if response.body:
            urlListStatusId = response.meta["urlListStatusId"]
            if urlListStatusId:
                UrlDao.updateUrlStatus(urlListStatusId, UrlStatus.SUCCESS)
            htmlItem = HtmlItem()
            htmlItem["url"] = response.url
            htmlItem["html"] = response.body
            subUrls = []
            URLgroup = LinkExtractor(allow=()).extract_links(response)
            if (self.cur_url_depth < self.depth_limit and self.depth_limit != 0) or self.depth_limit == 0:
                for URL in URLgroup:
                    if self.is_domain_allowed(URL.url):
                        subUrls.append(URL.url)
            htmlItem["subUrls"] = subUrls
            # htmlItem["taskJob"]=self.taskJob
            # htmlItem["taskJobHistory"] = self.taskJobHistory
            htmlItem["curUrlDepth"] = self.cur_url_depth
            return htmlItem

    def is_domain_allowed(self, url):
        """
        判断当前url是否属于允许爬取的域名范围内
        :param url: 
        :return: 
        """
        logging.info("allowed_domain : " + self.allowed_domain)
        logging.info("url : " + url)
        if self.allowed_domain:
            cur_url_domain = self.get_domain(url)
            if cur_url_domain and self.allowed_domain in cur_url_domain:
                return True
            else:
                return False
        else:
            return True
