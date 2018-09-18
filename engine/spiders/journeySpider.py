# -*- coding: utf-8 -*-
import logging
import scrapy


class JourneyspiderSpider(scrapy.Spider):
    name = "journeySpider"
    custom_settings = {
        "DOWNLOADER_MIDDLEWARES": {
            'engine.middlewares.VerifycodeMiddleware': 543,
        }
    }
    # allowed_domains = ["a.com"]
    jouneryInfo = [
        # 查找类型:id, class_name, link_text, partial_link_text, css_selector, name, tag_name, xpath
        dict(
            homepage="http://118.112.180.43:82/scst/login.action",  # 首页地址
            username="D510100D20002",
            username_input=("id", "username"),  # 用户名input框的查找类型和名称
            password="123456",
            password_input=("id", "password"),  # 密码input框的查找类型和名称
            verifycode_is_show=1,  # 是否有验证码
            verifycode_input=("id", "captcha"),  # 验证码input框的查找类型和名称
            verifycode_img=("id", "captchaImage"),  # 验证码图片的查找类型和名称
            verifycode_refresh=("id", "captchaImage"),  # 验证码刷新按钮的查找类型和名称
            verifycode_result_type=0,  # 验证码的返回值类型, 0-纯字母 1-纯数字 2-字母+数字
            login_button=("class_name", "login-btn"),  # 登录按钮的查找类型和名称
            login_success_div=("class_name", "home_btn_box")  # 判断登录成功的DIV
        ),
        # dict(
        #     homepage="http://goldweek.scta.gov.cn/",  # 首页地址
        #     username="",
        #     username_input=("id", "username"),  # 用户名input框的查找类型和名称
        #     password="",
        #     password_input=("id", "password"),  # 密码input框的查找类型和名称
        #     verifycode_is_show=1,  # 是否有验证码
        #     verifycode_input=("id", "captcha"),  # 验证码input框的查找类型和名称
        #     verifycode_img=("id", "captchaImage"),  # 验证码图片的查找类型和名称
        #     verifycode_refresh=("id", "captchaImage"),  # 验证码刷新按钮的查找类型和名称
        #     verifycode_result_type=0,  # 验证码的返回值类型, 0-纯字母 1-纯数字 2-字母+数字
        #     login_button=("class_name", "login-btn"),  # 登录按钮的查找类型和名称
        #     login_success_div=("id", "")  # 判断登录成功的DIV
        # ),
        dict(
            homepage="http://lycs.cnta.gov.cn",  # 首页地址
            username="510100",
            username_input=("id", "LogonName"),  # 用户名input框的查找类型和名称
            password="654321",
            password_input=("id", "Password"),  # 密码input框的查找类型和名称
            verifycode_is_show=1,  # 是否有验证码
            verifycode_input=("id", "validationCode"),  # 验证码input框的查找类型和名称
            verifycode_img=("id", "codeImg"),  # 验证码图片的查找类型和名称
            verifycode_refresh=("class_name", "refresh"),  # 验证码刷新按钮的查找类型和名称
            verifycode_result_type=2,  # 验证码的返回值类型, 0-纯字母 1-纯数字 2-字母+数字
            login_button=("class_name", "submit"),  # 登录按钮的查找类型和名称
            login_success_div=("id", "uid")  # 判断登录成功的DIV
        ),
        dict(
            homepage="http://holiday.cnta.gov.cn/holiday/web/index/login.jsp",  # 首页地址
            username="chengdu",
            username_input=("id", "j_username"),  # 用户名input框的查找类型和名称
            password="cdlyj",
            password_input=("id", "j_password"),  # 密码input框的查找类型和名称
            verifycode_is_show=0,  # 是否有验证码
            login_button=("id", "btnEnter"),  # 登录按钮的查找类型和名称
            login_success_div=("tag_name", "a")  # 判断登录成功的DIV
        ),
        dict(
            homepage="http://jq.cnta.gov.cn/login",  # 首页地址
            username="510100",
            username_input=("id", "login"),  # 用户名input框的查找类型和名称
            password="181848",
            password_input=("id", "password"),  # 密码input框的查找类型和名称
            verifycode_is_show=0,  # 是否有验证码
            login_button=("id", "auto"),  # 登录按钮的查找类型和名称
            login_success_div=("class_name", "menu_nav")  # 判断登录成功的DIV
        ),
    ]
    start_urls = [jouneryInfo[i]["homepage"] for i in range(len(jouneryInfo))]

    def __init__(self):
        pass

    def parse(self, response):
        html_content = response.body
        print html_content
