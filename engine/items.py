# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html
import re
import uuid
import scrapy

categoriesPattern = re.compile(r"[0-9]+(-[0-9]+)+")


class GuizhoudemoItem(scrapy.Item):
    pass


class ScrapBaseItem(scrapy.Item):
    data = scrapy.Field()
    jobTemplateFieldList = scrapy.Field()
    jobTemplate = scrapy.Field()
    taskJob = scrapy.Field()
    globalParamsValues = scrapy.Field()
    jobTemplateParamList = scrapy.Field()
    taskJobId = scrapy.Field()
    taskJobParamList = scrapy.Field()
    taskJobHistroy = scrapy.Field()
    # fields=scrapy.field()
    pass


class TemplateItem(scrapy.Item):
    data = scrapy.Field()
    jobTemplateFieldList = scrapy.Field()
    jobTemplate = scrapy.Field()
    globalParamsValues = scrapy.Field()
    jobTemplateParamList = scrapy.Field()
    taskJobHistroy = scrapy.Field()
    searchTaskJob = scrapy.Field()
    taskJob = scrapy.Field()
    url = scrapy.Field()


class JdCategoriesItem(scrapy.Item):
    id = scrapy.Field()
    name = scrapy.Field()
    url = scrapy.Field()
    next_url = scrapy.Field()
    taskJobId = scrapy.Field()
    categories = scrapy.Field()


class HtmlItem(scrapy.Item):
    url = scrapy.Field()
    html = scrapy.Field()
    subUrls = scrapy.Field()
    # taskJob = scrapy.Field()
    # taskJobHistory = scrapy.Field()
    curUrlDepth = scrapy.Field()  # 当前爬取的url的深度值
