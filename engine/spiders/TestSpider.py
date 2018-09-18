# coding=utf-8
import re
import uuid
import scrapy

class TestSpider(scrapy.Spider):
    name = "TestSpider"
    start_urls = [
        'https://book.jd.com/booksort.html'
    ]

    def parse(self, response):
       pass
