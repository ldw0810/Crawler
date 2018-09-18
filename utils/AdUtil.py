# -*- coding: utf-8 -*-
import hashlib
import os
import urllib2

from selenium import webdriver

SAVE_DIR="D://AD//"
def take_screenshot(url):
    """截屏"""
    if not os.path.exists(SAVE_DIR):
        os.mkdir(SAVE_DIR)
    file_path = SAVE_DIR + md5(url) + ".png"
    if not is_file_exist(file_path):
        browser = webdriver.PhantomJS()  # Get local session of firefox
        browser.set_window_size(1200, 900)
        browser.get(url)
        # browser.execute_script("""
        #     (function () {
        #         var y = 0;
        #         var step = 100;
        #         window.scroll(0, 0);
        #
        #         function f() {
        #             if (y < document.body.scrollHeight) {
        #                 y += step;
        #                 window.scroll(0, y);
        #                 setTimeout(f, 100);
        #             } else {
        #                 window.scroll(0, 0);
        #                 document.title += "scroll-done";
        #             }
        #         }
        #
        #         setTimeout(f, 1000);
        #     })();
        # """)
        #
        # for i in xrange(30):
        #     if "scroll-done" in browser.title:
        #         break
        #     time.sleep(10)
        browser.save_screenshot(file_path)
        browser.close()
    return file_path

def get_forward_url(url):
    """获取重定向路径"""
    req = urllib2.Request(url=url)
    response = urllib2.urlopen(req)
    return response.url

def md5(target):
    """
    生成md5摘要
    :param target: 
    :return: 
    """
    m = hashlib.md5()
    m.update(target)
    digest = m.hexdigest()
    return digest

def is_file_exist(file_path):
    return os.path.exists(file_path)
if __name__ == '__main__':
    print take_screenshot('http://www.qq.com/')
    print get_forward_url("http://c.l.qq.com/lclick?oid=3348981&loc=QQCOM_N_Extend_Video&soid=2sgC2gAAWTzvdAxM/AJomT/rARVN&click_data=dXNlcl9pbmZvPW9BRGptams0RXg0PSZheHBoZWFkZXI9MSZwYWdlX3R5cGU9MSZzc3A9MSZ1cF92ZXJzaW9uPVMyMDR8TDQ3JnZpZXdpcD0xNzU1OTE3NTU=&index=1&chl=478")