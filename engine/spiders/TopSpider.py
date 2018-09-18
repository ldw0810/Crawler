# coding=utf-8
import re
import uuid
import scrapy
from scrapy.selector import  Selector
from engine.items import JdCategoriesItem
categoriesPattern = re.compile(r"[0-9]+(-[0-9]+)+")

class TopSpider(scrapy.Spider):
    name = 'TopSpider'
    # allowed_domains = ['example.com']
    custom_settings={
        "ITEM_PIPELINES":{
        'GuizhouDemo.pipelines.MysqlSavePipeline': 300}
    }
    # ITEM_PIPELINES = {
    #    # 'GuizhouDemo.pipelines.GuizhoudemoPipeline': 300,
    # }
    start_urls = [
        "https://book.jd.com/booksort.html"
    ]
    # def __init__(self,taskJob=None):
    #     # pass
    #     if taskJob==None:
    #         return
    #     self.taskJob=taskJob
    #     data=self.taskJob.__dict__
    #     self.start_urls.append(data["url"])
    # def make_requests_from_url(self,url):
    #     pass
    # def parse_start_url(self, response):
    #     return []

    def parse(self, response):
        # scrapy.Request("http://www.baidu.com")
        hxs = Selector(response)
        divs = hxs.xpath("//div[@id='booksort']")
        items=[]
        for div in divs:
            aList = div.xpath("div//a")
            for a in aList:
                names = a.xpath("text()").extract()
                url = a.xpath("@href").extract()
                jdCategoriesItem=JdCategoriesItem()
                item = {}
                item["name"]=names[0]
                item["url"]=url[0]
                item["id"]=str(uuid.uuid1())
                matches = categoriesPattern.search(url[0])
                categories=None
                if matches:
                    categories = str(matches.group()).replace("-",",")
                    item["categories"] = str(categories)
                nextUrl="https://list.jd.com/list.html?cat={categories}".replace("{categories}",categories)
                item["next_url"] = str(nextUrl)
                jdCategoriesItem["data"]=item
                items.append(jdCategoriesItem)
        self.log('A response from %s just arrived!' % response.url)
        return items


if __name__=="__main__":
    value='"123-123-123{123123}".replace("{123123}",",")'
    print eval(value)