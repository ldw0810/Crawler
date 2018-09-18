# coding=utf-8

import time
from selenium import webdriver

def getElement(element_tuple,driver):
    if isinstance(element_tuple, tuple) and getattr(driver, "find_element_by_" + element_tuple[0]):
        return getattr(driver, "find_element_by_" + element_tuple[0])(element_tuple[1])
    return ""
def getAuthCode(username="13989899898",
                password="a123456789",
                baseurl="https://www.cunnar.com:15443",
                app_key="201704200001"):
    json=dict(
        username=username,
        username_input=("id", "name"),  # 用户名input框的查找类型和名称
        password=password,
        password_input=("id", "password"),  # 密码input框的查找类型和名称
        login_button=("id", "login"),  # 登录按钮的查找类型和名称
    )
    driver = webdriver.PhantomJS()
    url=baseurl+"/opencloud/api/oauth2/authorize?redirect_uri=http://www.baidu.com&app_key="+app_key
    driver.get(url)
    username_input=getElement(json['username_input'],driver)
    password_input=getElement(json['password_input'],driver)
    submit_button = getElement(json["login_button"],driver)
    username = json["username"]
    password =json["password"]
    username_input.clear()
    username_input.send_keys(username)
    password_input.clear()
    password_input.send_keys(password)
    submit_button.click()
    time.sleep(1)
    return driver.current_url.split('code=')[1]



if __name__=="__main__":
    getAuthCode()
    # PcInfoDao.test()
    # paramDict={"value":"12"}
    # # exec("pageCount=1")
    # exec('value=1;pageCount=5;out=value<=pageCount')
    # value= RenderUtils.render("out",paramDict)
    # eval("out")
    # Flag=True
    # print Flag == True