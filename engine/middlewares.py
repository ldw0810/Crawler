# -*-coding:utf-8-*-
import base64
import logging
import logging as logger
import os
import random
import re
import thread
import time
import urllib2
import threading
from PIL import Image
from poster.encode import multipart_encode
from poster.streaminghttp import register_openers
from scrapy.http import HtmlResponse
from selenium import webdriver
from selenium.common.exceptions import TimeoutException, NoSuchElementException
from selenium.webdriver.common.by import By
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.common.proxy import ProxyType as Type
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait

from beans.TaskTable import ProxyType, TaskStatus
from beans.TemplateTable import RequestType
from beans.UrlTable import UrlStatus
from cache.Factory import CacheFactory
from dao import ProxyDao
from dao import TaskJobDao
from dao import UrlDao
from utils import ConfigUtils
from utils import VerifycodeUtils
from utils.ConfigUtils import getPorperties, KEYMAP
from utils.RedisUtils import llen
from utils.SsdbClient import SsdbClient
import signal

mutex = threading.Lock()


class ProxyMiddleware(object):
    def __init__(self):
        logging.info('*****************ProxyMiddleware init******************')
    def process_request(self, request, spider):
        # jobTemplate = spider.jobTemplate
        jobTemplateList = CacheFactory.get("job_template_by_url", request.url)
        if jobTemplateList != None and len(jobTemplateList) > 0:
            jobTemplate = jobTemplateList[0]
        else:
            jobTemplate = spider.jobTemplate
        if jobTemplate and jobTemplate.phantomjsFlag:
            return
        if not hasattr(spider, "taskJob"):
            logging.warning('spider not has taskjob attr')
            return
        taskJob = spider.taskJob
        proxy_user_pass = None
        if taskJob and taskJob.proxyId:
            if taskJob.proxyType:
                data = ProxyDao.contentDetail(taskJob.proxyId)
                proxyInfo = data['result']['proxy']
                staticProxyList = data['result']['staticProxyList']
                if data:
                    proxy_type = taskJob.proxyType
                    if proxy_type == ProxyType.DYNAMIC_FOR_URL:
                        if jobTemplate:
                            time.sleep(jobTemplate.sleepTime)
                        else:
                            time.sleep(3)
                        authUrl = proxyInfo.authUrl
                        proxyList = getProxyList(authUrl)
                        if len(proxyList) > 0:
                            proxy = "http://%s" % random.choice(proxyList)
                        else:
                            return
                    elif proxy_type == ProxyType.DYNAMIC_FOR_USER:
                        proxy = "http://%s:%s" % (proxyInfo.hostName, proxyInfo.port)
                        proxy_user_pass = "%s:%s" % (proxyInfo.userName, proxyInfo.password)
                    elif proxy_type == ProxyType.STATIC:
                        staticProxy = random.choice(staticProxyList)
                        proxy = "http://%s:%s" % (staticProxy.host, staticProxy.port)
                    else:
                        return
                    request.meta['proxy'] = proxy
                    if proxy_user_pass:
                        encoded_user_pass = base64.encodestring(proxy_user_pass)
                        request.headers['Proxy-Authorization'] = 'Basic ' + encoded_user_pass

    def process_exception(self, request, exception, spider):
        urlListStatusId = request.meta.get("urlListStatusId")
        if urlListStatusId:
            UrlDao.updateUrlStatus(urlListStatusId, UrlStatus.FAIL, repr(exception))
        if llen(ConfigUtils.getRedisPorperties(
                KEYMAP.MAIN_SPIDER_REDIS_KEY)) == 0 and spider.taskJob.status != TaskStatus.SUCCESS:
            TaskJobDao.updateTaskJobStatus(spider.taskJob.id, TaskStatus.SUCCESS)
            UrlDao.updateUrlStatusListByTaskJobHistoryId(spider.jobTemplate.taskJobHistoryId, status=UrlStatus.STOP,
                                                         desc="The task is over and no longer crawls on this URL")
        logger.info("process_exception ProxyMiddleware")
        return None


def getProxyList(authUrl):
    response = None
    try:
        logger.info("getProxyList")
        response = urllib2.urlopen(authUrl)
        proxy = response.read()
        proxyList = []
        proxyList.append(proxy.strip('\n'))
        try:
            response and response.close()
        except Exception, e:
            logger.exception("getProxyList11111" + str(e))
        return proxyList
    except Exception, e:
        try:
            response and response.close()
        except Exception, e:
            logger.exception("getProxyList11111" + str(e))
        logger.exception("getProxyList")
        return []


class PostMiddleware(object):
    def __init__(self):
        logging.debug("PostMiddleware,__init__")

    def process_request(self, request, spider):
        logging.debug("PostMiddleware")
        jobTemplateList = CacheFactory.get("job_template_by_url", request.url)
        if jobTemplateList != None and len(jobTemplateList) > 0:
            jobTemplate = jobTemplateList.pop()
        else:
            jobTemplate = spider.jobTemplate
        url = jobTemplate.url
        requestType = jobTemplate.requestType
        logging.info('')
        if requestType == str(RequestType.POST):
            body_value = {}
            for key in jobTemplate.extraData:
                if key == 'dataParentId' or key == 'id' or key == 'key' or key == 'task_job_id_sequence':
                    continue
                else:
                    body_value[key] = jobTemplate.extraData[key]
            register_openers()
            datagen, re_headers = multipart_encode(body_value)
            req = urllib2.Request(url, datagen, re_headers)
            resp = urllib2.urlopen(req)  # body_value
            content = resp.read()
            htmlResponse = HtmlResponse(url, body=content, encoding='utf-8', request=request)
            return htmlResponse
        else:
            return


class EnginMiddleware(object):
    pass


class SeleniumMiddleware(object):
    def __init__(self):
        logger.info("SeleniumMiddleware---start -- driver")
        self.driver = webdriver.PhantomJS(
            executable_path='D:\\python\\pachong\\phantomjs-2.1.1-windows\\bin\\phantomjs.exe')  # 指定浏览器
        # webdriver.Ie()
        # webdriver.Chrome()

    scroll = {"type": "scroll", "option": {
        "scroll_count": "1",
        "scroll_step": "2000"
    }
              }
    click = {"type": "scroll", "option": {
        "scroll_count": "1",
        "scroll_step": "2000"
    }
             }

    def process_request(self, request, spider):
        logger.info("process_request ------ start")

        print request.url, "*************---********", spider.sm_type
        sm_type = spider.sm_type

        if spider.name == "baidu":
            self.driver.set_window_size(1000, 10000)  # 尽量将窗口设置大一些，以应对某些网站使用懒加载
            self.driver.get(request.url)
            time.sleep(5)
            # js1 = "var q=document.documentElement.scrollTop=3000"
            # driver.execute_script(js1)  # 模仿用户操作，下拉滚动条
            if sm_type['type'] == 'scroll':
                self.scrollOption(sm_type)
            if sm_type['type'] == 'login':
                self.loginOption(sm_type)
            body = self.driver.page_source
            logging.info("PhantomJS is visiting " + request.url)
            htmlResponse = HtmlResponse(self.driver.current_url, body=body, encoding='utf-8', request=request)
            self.driver.close()
            self.driver.quit()
            return htmlResponse
        else:
            return

    # scroll = {"type": "scroll", "option": {
    #     "scroll_count": "1",
    #     "scroll_step
    # ": "2000",
    #     "sleeptime":'1'
    #   }
    # }
    def scrollOption(self, option={}):
        count = int(option['option'].has_key('scroll_count') and option['option']['scroll_count'] or 1)
        sleeptime = int(option['option'].has_key('sleeptime') and option['option']['sleeptime'] or 2)
        logger.info("scrollOption-----%s------%s", count, sleeptime)
        while (not count == 0):
            count = count - 1
            # js = "window.scrollTo(0,document.body.scrollHeight-" + str(1 * 1 * 100) + ")"
            js = "window.scrollTo(0,document.body.scrollHeight)"
            logger.info("scrollOption---executejs-----%s", js)
            self.driver.execute_script(js)
            time.sleep(sleeptime)

    # self.sm_type = {"type": "login", "option": {
    #     "user": {"element": "", "value": "zhangsan"},
    #     "password": {"element": "", "value": "123456"},
    #     "sleeptime": '2',#等待时间
    #     "submit": {"element": ""},
    #     "getLoginPage":{"element":""},
    #
    # }}
    def loginOption(self, option={}):
        params = option.get("option") or {}
        user = params.get("user") or {}
        password = params.get("password") or {}
        submit = params.get("submit") or {}
        sleeptime = int(params.get('sleeptime') or 2)
        getLoginPage = option['option'].has_key('getLoginPage') and option['option']['getLoginPage'] or None
        logger.info("loginOption-----user:-%s-----password:-%s-----submit:-%s", user['value'], password['value'],
                    submit['element'])
        if getLoginPage:
            try:
                WebDriverWait(self.driver, sleeptime).until(
                    EC.presence_of_element_located((By.CSS_SELECTOR, "#weibo_top_public div.gn_search_v2"))
                )
            except TimeoutException:
                print u'加载页面失败'
            self.driver.get_screenshot_as_file('test.png')
            try:
                element = self.driver.find_element_by_css_selector(
                    ".gn_login a[node-type='loginBtn']")
                # element = self.driver.find_element_by_css_selector("#weibo_top_public div.gn_search_v2")
                print u'成功找到了元素'
                # keyword = "dddd".decode('utf-8', 'ignore')
                # print u'输入关键字', keyword
                # for word in keyword:
                #     print word
                #     element.send_keys(word)
                # element.send_keys(Keys.ENTER)
                element.click()
                # print next
            except NoSuchElementException:
                print u'no find gn_login'
            time.sleep(sleeptime)
            self.driver.get_screenshot_as_file('test1.png')
        try:
            # userE = self.driver.find_element_by_css_selector(
            #     "div[node-type='login_frame'] > div input[node-type='username']")  # sureelenment css选择器#content b.ui-page-num > a.ui-page-next
            # passwordE = self.driver.find_element_by_css_selector(
            #     "div[node-type='login_frame'] > div[node-type='password_box'] input")
            # submitE = self.driver.find_element_by_css_selector(
            #     ".item_btn > a")
            userE = self.driver.find_element_by_css_selector(user.get("element"))
            passwordE = self.driver.find_element_by_css_selector(password.get("element"))
            submitE = self.driver.find_element_by_css_selector(submit.get("element"))
            userE.send_keys(user.get("value"))
            passwordE.send_keys(password.get("value"))
            submitE.click()
            print u'submit success'
        except NoSuchElementException:
            logging.error('no find gn_login1')
            # print u'no find gn_login1'
        time.sleep(sleeptime)
        try:
            next2 = self.driver.find_element_by_css_selector(
                "#layer_14921603834051 > .layer_mini_info")  # sureelenment css选择器#content b.ui-page-num > a.ui-page-next
        except NoSuchElementException:
            logging.error('no find gn_login2')
            # print u'no find gn_login2'
        time.sleep(8)
        self.driver.get_screenshot_as_file('test2.png')


class CacheHtmlDownloaderMiddleware(object):
    def __init__(self):
        self.host = getPorperties('SSDB', 'SSDB_HOST')
        self.port = getPorperties('SSDB', 'SSDB_PORT')
        self.cache_name = getPorperties('SSDB', 'CACHE_NAME')
        try:
            self.ssdb = SsdbClient(self.host, int(self.port))
        except Exception, e:
            logger.ERROR("CacheHtmlDownloaderMiddleware:%s" % (e))

    def process_request(self, request, spider):
        pass
        # assertt= self.ssdb.get(self.cache_name, request.url)
        # if(assertt):
        #     return assertt

    def process_response(self, request, response, spider):
        if (response.status == 200 and self.ssdb != None):
            self.ssdb.put(self.cache_name, response.url, response.body)
        return response


class VerifycodeMiddleware(object):
    def __init__(self):
        self.verifyCode = ""
        self.verifyCodeLength = 4
        self.driver = ""

    def getElement(self, element_tuple):
        if isinstance(element_tuple, tuple) and getattr(self.driver, "find_element_by_" + element_tuple[0]):
            return getattr(self.driver, "find_element_by_" + element_tuple[0])(element_tuple[1])
        return ""

    def process_request(self, request, spider):
        # 需要下载chromedriver, 并将其放到PhantomJS的安装路径里，并添加该路径的环境变量
        logging.info("SeleniumMiddleware**************************start---driver")
        self.verifyCode = ""
        # self.driver = webdriver.PhantomJS()
        self.driver = webdriver.Chrome()
        self.driver.get(request.url)
        user_action = True
        while user_action:
            start_index = -1
            for i in range(len(spider.jouneryInfo)):
                if request.url == spider.jouneryInfo[i]["homepage"]:
                    start_index = i
                    break
            screenshot_url = os.path.dirname(os.path.dirname(os.path.abspath(__file__))) + r"\images\screenshot_" + str(
                start_index) + ".jpg"
            username_input = self.getElement(spider.jouneryInfo[start_index]["username_input"])
            password_input = self.getElement(spider.jouneryInfo[start_index]["password_input"])
            verifyCode_input = ""
            submit_button = ""
            username = spider.jouneryInfo[start_index]["username"]
            password = spider.jouneryInfo[start_index]["password"]
            submit_button = self.getElement(spider.jouneryInfo[start_index]["login_button"])
            # 判断是否有验证码
            isShowVerifycode = spider.jouneryInfo[start_index]["verifycode_is_show"]
            if isShowVerifycode:
                verifyCode_input = self.getElement(spider.jouneryInfo[start_index]["verifycode_input"])
                verifyCode_div = self.getElement(spider.jouneryInfo[start_index]["verifycode_img"])
                isFirstLogin = True
                # 截屏截取验证码的区域并保存，最后打开识别
                while not VerifycodeUtils.checkVerifyCode(self.verifyCode, self.verifyCodeLength):
                    if not isFirstLogin:
                        verifyCode_refresh_button = self.getElement(
                            spider.jouneryInfo[start_index]["verifycode_refresh"])
                        verifyCode_refresh_button.click()
                    else:
                        isFirstLogin = False
                        verifyCode_refresh_button = self.getElement(
                            spider.jouneryInfo[start_index]["verifycode_refresh"])
                    self.driver.save_screenshot(screenshot_url)
                    verifyCode_img = Image.open(screenshot_url)
                    cut_left = int(verifyCode_div.location["x"])
                    cut_top = int(verifyCode_div.location["y"])
                    cut_right = int(verifyCode_div.location["x"] + verifyCode_div.size["width"])
                    cut_bottom = int(verifyCode_div.location["y"] + verifyCode_div.size["height"])
                    cut_area = (cut_left, cut_top, cut_right, cut_bottom)
                    verifyCode_img = verifyCode_img.crop(cut_area)
                    screenshot_cut_url = os.path.dirname(
                        os.path.dirname(os.path.abspath(__file__))) + r"\images\screenshot_cut_" + str(
                        start_index) + ".jpg"
                    verifyCode_img.save(screenshot_cut_url)
                    # 需要传入参数以识别验证码类型(数字，字母)
                    self.verifyCode = VerifycodeUtils.getVerifyCode(screenshot_cut_url,
                                                                    resultType=spider.jouneryInfo[start_index][
                                                                        "verifycode_result_type"])
                    logging.info("验证码为：" + self.verifyCode)
                    # 如果识别不正确，则灰度化、二值化图片后再识别
                    if not VerifycodeUtils.checkVerifyCode(self.verifyCode):
                        self.verifyCode = VerifycodeUtils.getVerifyCode(screenshot_cut_url, isNeedDispose=1,
                                                                        resultType=spider.jouneryInfo[start_index][
                                                                            "verifycode_result_type"])
                        logging.info("处理后的验证码为：" + self.verifyCode)
            # 写入用户名密码等参数
            username_input.clear()
            username_input.send_keys(username)
            password_input.clear()
            password_input.send_keys(password)
            if isShowVerifycode:
                verifyCode_input.clear()
                verifyCode_input.send_keys(self.verifyCode)
                # self.driver.execute_script("window.alert = function(msg){return true;};")
            submit_button.click()
            try:
                home_btn = self.getElement(spider.jouneryInfo[start_index]["login_success_div"])
                if not home_btn:
                    self.verifyCode = ""
                    user_action = True
                else:
                    body = self.driver.page_source
                    htmlResponseX = HtmlResponse(self.driver.current_url, body=body, encoding='utf-8', request=request)
                    self.driver.close()
                    self.driver.quit()
                    user_action = False
                    return htmlResponseX
            except Exception:
                self.verifyCode = ""
                user_action = True


class ChromeMiddleware(object):
    def __init__(self):
        self.user_agent_list = [ \
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1" \
            "Mozilla/5.0 (X11; CrOS i686 2268.111.0) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11", \
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1092.0 Safari/536.6", \
            "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1090.0 Safari/536.6", \
            "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/19.77.34.5 Safari/537.1", \
            "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5", \
            "Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.36 Safari/536.5", \
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3", \
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.0 Safari/536.3", \
            "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24", \
            "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24"
        ]

    def process_request(self, request, spider):
        driver = None
        logging.info("*************ChromeMiddleware*************")
        jobTemplateList = CacheFactory.get("job_template_by_url", request.url)
        if jobTemplateList != None and len(jobTemplateList) > 0:
            jobTemplate = jobTemplateList[0]
        else:
            jobTemplate = spider.jobTemplate
        if jobTemplate:
            if hasattr(jobTemplate, 'needLogin') and jobTemplate.needLogin:
                userName = jobTemplate.userName
                password = jobTemplate.passWord
                unameId = jobTemplate.unameElementId
                passwordId = jobTemplate.pwdElementId
                submitId = jobTemplate.submitElementId
                return self.login(request=request, username=userName, password=password, username_id=unameId,
                                  password_id=passwordId, submit_id=submitId)
            if jobTemplate.chromeFlag and mutex.acquire():
                try:
                    driver = webdriver.Chrome(
                        executable_path=ConfigUtils.getSpiderPorperties(ConfigUtils.KEYMAP.CHROME))
                    capabilities = self.get_desired_capabilities(spider)
                    driver.start_session(capabilities)
                    driver.set_page_load_timeout(30)
                    driver.set_script_timeout(30)
                    driver.set_window_size(1000, 10000)  # 尽量将窗口设置大一些，以应对某些网站使用懒加载
                    driver.get(request.url)
                    time.sleep(int(jobTemplate.sleepTime))
                    body = driver.page_source
                    logging.info("PhantomJS is visiting " + request.url)
                    htmlResponse = HtmlResponse(driver.current_url, body=body, encoding='utf-8', request=request)
                    driver.quit()
                    return htmlResponse
                except Exception, e:
                    urlListStatusId = request.meta.get("urlListStatusId")
                    if urlListStatusId:
                        UrlDao.updateUrlStatus(urlListStatusId, UrlStatus.FAIL, repr(Exception))
                    logging.exception("time out visiting==>%s,%s" % (request.url, str(e)))
                finally:
                    try:
                        driver.service.process.send_signal(signal.SIGTERM)  # kill the specific phantomjs child proc
                        driver.quit()
                    except Exception, e:
                        logging.error("453e:" + str(e))
                    mutex.release()
            else:
                return
        else:
            return

    def process_exception(self, request, exception, spider):
        urlListStatusId = request.meta.get("urlListStatusId")
        if urlListStatusId:
            UrlDao.updateUrlStatus(urlListStatusId, UrlStatus.FAIL, repr(exception))
        if llen(ConfigUtils.getRedisPorperties(
                KEYMAP.MAIN_SPIDER_REDIS_KEY)) == 0 and spider.taskJob.status != TaskStatus.SUCCESS:
            TaskJobDao.updateTaskJobStatus(spider.taskJob.id, TaskStatus.SUCCESS)
            UrlDao.updateUrlStatusListByTaskJobHistoryId(spider.jobTemplate.taskJobHistoryId, status=UrlStatus.STOP,
                                                         desc="The task is over and no longer crawls on this URL")
        logger.info("process_exception PhontomJsMiddleware")
        return None

    def get_desired_capabilities(self, spider=None):
        desired_capabilities = DesiredCapabilities.PHANTOMJS.copy()
        # 从USER_AGENTS列表中随机选一个浏览器头，伪装浏览器
        desired_capabilities["phantomjs.page.settings.userAgent"] = (random.choice(self.user_agent_list))
        # 不载入图片，爬页面速度会快很多
        desired_capabilities["phantomjs.page.settings.loadImages"] = False
        # desired_capabilities["phantomjs.page.settings.resourceTimeout"] = 15000
        # 利用DesiredCapabilities(代理设置)参数值，重新打开一个sessionId，我看意思就相当于浏览器清空缓存后，加上代理重新访问一次url
        # headers = {'Accept': 'application/json, text/javascript, */*; q=0.01',
        #            'Accept - Encoding': 'gzip, deflate, sdch',
        #            'Accept-Language': 'zh-CN,zh;q=0.8',  # zh-CN,zh;q=0.8   en-US,en;q=0.8
        #            'Cache-Control': 'max-age=0',
        #            'Connection': 'keep-alive'}

        # for key, value in headers.iteritems():
        #     desired_capabilities['phantomjs.page.customHeaders.{}'.format(key)] = value
        if not spider:
            return desired_capabilities
        if not hasattr(spider, "taskJob"):
            return desired_capabilities
        taskJob = spider.taskJob
        if taskJob and taskJob.proxyId:
            if taskJob.proxyType and taskJob.proxyType == ProxyType.DYNAMIC_FOR_URL:
                data = ProxyDao.contentDetail(taskJob.proxyId)
                proxyInfo = data['result']['proxy']
                time.sleep(4)
                proxy_ips = getProxyList(proxyInfo.authUrl)
                proxy = webdriver.Proxy()
                proxy.proxy_type = Type.MANUAL
                proxy.http_proxy = random.choice(proxy_ips)
                proxy.add_to_capabilities(desired_capabilities)
        return desired_capabilities

    def login(self, request, username, password, username_id, password_id, submit_id, verycode_id=None):
        driver = webdriver.PhantomJS()
        time.sleep(3)
        capabilities = self.get_desired_capabilities()
        driver.start_session(capabilities)
        driver.set_window_size(1000, 10000)
        driver.get(request.url)
        username_input = driver.find_element_by_id(username_id)
        password_input = driver.find_element_by_id(password_id)
        submit_button = driver.find_element_by_id(submit_id)
        username_input.clear()
        username_input.send_keys(username)
        password_input.clear()
        password_input.send_keys(password)
        submit_button.click()
        time.sleep(5)
        body = driver.page_source
        cookies = driver.get_cookies()
        if cookies is not None:
            items = [item["name"] + "=" + item["value"] for item in cookies]
            cookie = ';'.join(items)
            logger.info("cookie:" + cookie)
        htmlResponse = HtmlResponse(driver.current_url, body=body, encoding='utf-8', request=request)
        driver.save_screenshot("D:\\test.png")
        driver.close()
        # driver.quit()
        return htmlResponse


class PhontomJsMiddleware(object):
    def __init__(self):
        self.user_agent_list = [ \
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1" \
            "Mozilla/5.0 (X11; CrOS i686 2268.111.0) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11", \
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1092.0 Safari/536.6", \
            "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1090.0 Safari/536.6", \
            "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/19.77.34.5 Safari/537.1", \
            "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5", \
            "Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.36 Safari/536.5", \
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3", \
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3", \
            "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.0 Safari/536.3", \
            "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24", \
            "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24"
        ]

    def process_request(self, request, spider):
        driver = None
        logging.info("*************PhontomJsMiddleware*************")
        jobTemplateList = CacheFactory.get("job_template_by_url", request.url)
        if jobTemplateList != None and len(jobTemplateList) > 0:
            jobTemplate = jobTemplateList[0]
        else:
            jobTemplate = spider.jobTemplate
        # jobTemplate = spider.jobTemplate
        if jobTemplate:
            if hasattr(jobTemplate, 'needLogin') and jobTemplate.needLogin:
                userName = jobTemplate.userName
                password = jobTemplate.passWord
                unameId = jobTemplate.unameElementId
                passwordId = jobTemplate.pwdElementId
                submitId = jobTemplate.submitElementId
                return self.login(request=request, username=userName, password=password, username_id=unameId,
                                  password_id=passwordId, submit_id=submitId)
            if jobTemplate.phantomjsFlag and mutex.acquire():
                try:
                    logging.info("*************PhontomJsMiddleware*************" + request.url)
                    driver = webdriver.PhantomJS(executable_path=ConfigUtils.getSpiderPorperties(
                        ConfigUtils.KEYMAP.PHANTOMJS))  # executable_path='D:\\developTools\\phantomjs-2.1.1-windows\\bin\\phantomjs.exe'
                    capabilities = self.get_desired_capabilities(spider)
                    driver.start_session(capabilities)
                    driver.set_page_load_timeout(30)
                    driver.set_script_timeout(30)
                    driver.set_window_size(1000, 10000)  # 尽量将窗口设置大一些，以应对某些网站使用懒加载
                    driver.get(request.url)
                    time.sleep(int(jobTemplate.sleepTime))
                    body = driver.page_source
                    logging.info("PhantomJS is visiting " + request.url)
                    htmlResponse = HtmlResponse(driver.current_url, body=body, encoding='utf-8', request=request)
                    # driver.close()
                    # driver.service.process.send_signal(signal.SIGTERM)  # kill the specific phantomjs child proc
                    # driver.quit()
                    return htmlResponse
                except Exception, e:
                    urlListStatusId = request.meta.get("urlListStatusId")
                    if urlListStatusId:
                        UrlDao.updateUrlStatus(urlListStatusId, UrlStatus.FAIL, repr(Exception))
                    logging.exception("time out visiting==>%s,%s" % (request.url, str(e)))
                    # try:
                    #     if driver!=None:
                    #         logging.exception("time out visiting==>%s,%s"%(request.url,str(e)))
                    #         # driver.close()
                    #         driver.service.process.send_signal(signal.SIGTERM)  # kill the specific phantomjs child proc
                    #         driver.quit()
                    # except Exception,e:
                    #     logging.error("451e:" + str(e))
                    # return
                finally:
                    # try:
                    #     driver.close()
                    # except Exception, e:
                    #     logging.error("452e:" + str(e))
                    try:
                        driver.service.process.send_signal(signal.SIGTERM)  # kill the specific phantomjs child proc
                        driver.quit()
                    except Exception, e:
                        logging.error("453e:" + str(e))
                    mutex.release()
            else:
                return
        else:
            return

    def process_exception(self, request, exception, spider):
        urlListStatusId = request.meta.get("urlListStatusId")
        if urlListStatusId:
            UrlDao.updateUrlStatus(urlListStatusId, UrlStatus.FAIL, repr(exception))
        if llen(ConfigUtils.getRedisPorperties(
                KEYMAP.MAIN_SPIDER_REDIS_KEY)) == 0 and spider.taskJob.status != TaskStatus.SUCCESS:
            TaskJobDao.updateTaskJobStatus(spider.taskJob.id, TaskStatus.SUCCESS)
            UrlDao.updateUrlStatusListByTaskJobHistoryId(spider.jobTemplate.taskJobHistoryId, status=UrlStatus.STOP,
                                                         desc="The task is over and no longer crawls on this URL")
        logger.info("process_exception PhontomJsMiddleware")
        return None

    def get_desired_capabilities(self, spider=None):
        desired_capabilities = DesiredCapabilities.PHANTOMJS.copy()
        # 从USER_AGENTS列表中随机选一个浏览器头，伪装浏览器
        desired_capabilities["phantomjs.page.settings.userAgent"] = (random.choice(self.user_agent_list))
        # 不载入图片，爬页面速度会快很多
        desired_capabilities["phantomjs.page.settings.loadImages"] = False
        # desired_capabilities["phantomjs.page.settings.resourceTimeout"] = 15000
        # 利用DesiredCapabilities(代理设置)参数值，重新打开一个sessionId，我看意思就相当于浏览器清空缓存后，加上代理重新访问一次url
        # headers = {'Accept': 'application/json, text/javascript, */*; q=0.01',
        #            'Accept - Encoding': 'gzip, deflate, sdch',
        #            'Accept-Language': 'zh-CN,zh;q=0.8',  # zh-CN,zh;q=0.8   en-US,en;q=0.8
        #            'Cache-Control': 'max-age=0',
        #            'Connection': 'keep-alive'}

        # for key, value in headers.iteritems():
        #     desired_capabilities['phantomjs.page.customHeaders.{}'.format(key)] = value
        if not spider:
            return desired_capabilities
        if not hasattr(spider, "taskJob"):
            return desired_capabilities
        taskJob = spider.taskJob
        if taskJob and taskJob.proxyId:
            if taskJob.proxyType and taskJob.proxyType == ProxyType.DYNAMIC_FOR_URL:
                data = ProxyDao.contentDetail(taskJob.proxyId)
                proxyInfo = data['result']['proxy']
                time.sleep(4)
                proxy_ips = getProxyList(proxyInfo.authUrl)
                proxy = webdriver.Proxy()
                proxy.proxy_type = Type.MANUAL
                proxy.http_proxy = random.choice(proxy_ips)
                proxy.add_to_capabilities(desired_capabilities)
        return desired_capabilities

    def login(self, request, username, password, username_id, password_id, submit_id, verycode_id=None):
        driver = webdriver.PhantomJS()
        time.sleep(3)
        capabilities = self.get_desired_capabilities()
        driver.start_session(capabilities)
        driver.set_window_size(1000, 10000)
        driver.get(request.url)
        username_input = driver.find_element_by_id(username_id)
        password_input = driver.find_element_by_id(password_id)
        submit_button = driver.find_element_by_id(submit_id)
        username_input.clear()
        username_input.send_keys(username)
        password_input.clear()
        password_input.send_keys(password)
        submit_button.click()
        time.sleep(5)
        body = driver.page_source
        cookies = driver.get_cookies()
        if cookies is not None:
            items = [item["name"] + "=" + item["value"] for item in cookies]
            cookie = ';'.join(items)
            logger.info("cookie:" + cookie)
        htmlResponse = HtmlResponse(driver.current_url, body=body, encoding='utf-8', request=request)
        driver.save_screenshot("D:\\test.png")
        driver.close()
        # driver.quit()
        return htmlResponse


class CookieMiddleware(object):
    def __init__(self):
        self.jSessionId = None

    def process_request(self, request, spider):
        jobTemplateList = CacheFactory.get("job_template_by_url", request.url)
        if jobTemplateList != None and len(jobTemplateList) > 0:
            jobTemplate = jobTemplateList[0]
        else:
            jobTemplate = spider.jobTemplate
        # jobTemplate = spider.jobTemplate

        if jobTemplate and jobTemplate.cookie_flag and jobTemplate.cookie_obtain_url is not None:
            if self.jSessionId is None:
                self.refresh_cookie(jobTemplate.cookie_obtain_url)
                thread.start_new_thread(self.timer_cycle, (jobTemplate.cookie_refresh_cycle,
                                                           jobTemplate.cookie_obtain_url))

            JSESSIONID = self.jSessionId
            # print 'process_request', request.url, JSESSIONID
            # 添加cookie
            request.cookies['JSESSIONID'] = JSESSIONID
        else:
            return

    def timer_cycle(self, cycle_time, cookie_obtain_url):
        """定时更新Cookie，更新周期cycle_time为-1时表示不需要定时更新"""
        while cycle_time != -1:
            time.sleep(cycle_time)
            self.refresh_cookie(cookie_obtain_url)

    def refresh_cookie(self, cookie_obtain_url=None):
        """获取cookie"""
        if cookie_obtain_url is not None:
            res = urllib2.urlopen(cookie_obtain_url)
            cookie = res.headers['Set-Cookie']
            pattern = re.compile(r'JSESSIONID=([0-9a-zA-Z]+)')
            self.jSessionId = ''.join(re.search(pattern, cookie).groups())
            # print 'self.jSessionId', self.jSessionId
