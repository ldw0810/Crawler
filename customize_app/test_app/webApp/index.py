#coding=utf-8
#Created by xutao on 2017-06-26.
import json
import urllib
import urllib2
import sys

import flask
import logging

import re
from flask import Flask,request
from flask import make_response
from flask import render_template
from werkzeug.datastructures import ImmutableMultiDict

from beans.TemplateTable import JobTemplate, JobTemplateField
from customize_app.test_app.service import TestService
from engine.spiders import TemplateSpidersList
from utils import ConfigUtils
from utils import JsonUtils
from utils import RenderUtils
from utils import RequestUtils
from utils import ResponseUtils

reload(sys)
sys.setdefaultencoding('utf8')
host=None;
cookie=None;
refer=None;
headers=None;
app=Flask(__name__)
ignoreType=[".js",".png",".css",".jpg",".jpeg",".gif"]
@app.before_request
def before_request():
    url=request.url
    # if(ignoreType.indexOf())
    for index,value in enumerate(ignoreType):
        urlStr=url.split("testApp")
        if(len(urlStr)<=1):
            continue
        if url.endswith(value) and "testApp/loadUrl" not in url and "testApp/static/" not in url:
            return flask.redirect("/testApp/loadUrl?url="+urlStr[1])

@app.route("/testApp/index")
def index():
    url = request.args.get("url");
    param={};
    for key in request.args:
        paramValue=request.args.get(key)
        paramList=paramValue.split("##")
        value=paramList[0]
        if(len(paramList)>=2):
            jobTemplateField=paramList[1] if len(paramList)>1 else None;
            jobTemplateField=json.loads(jobTemplateField)
            jobTemplateField=RequestUtils.parseResToClass(JobTemplateField,jobTemplateField)
            regExp=jobTemplateField.regExp
            split=jobTemplateField.split
            func=jobTemplateField.func
            # extraData=jobTemplateField.extraData
            if regExp != None and regExp != "":
                pattern = re.compile(regExp);
                tempStr = value
                matches = pattern.search(tempStr)
                if matches != None and len(matches.groups()) > 0 and (func == None or func == ""):
                    value = split.join(matches.groups())
                elif matches != None and (len(matches.groups()) == 0 and matches != None or (func != None and func != "")):
                    value = matches.group()
                else:
                    value = ""
            if func != None and func != "":
                value = func.replace("{value}", value)
                # if extraData != None:
                #     value = RenderUtils.render(value, extraData)
                value = eval(value)
        param[key]=value

    jobTemplateId = request.args.get("jobTemplateId")
    data = {}
    originUrl=None;
    if jobTemplateId != None and jobTemplateId != "":
        data = TestService.parseTemplate(jobTemplateId,param)
        url = data.get("renderUrl")
        originUrl=url
        url=RenderUtils.render(url,param)
    if url!=None:
        url=urllib.quote_plus(str(url))
        url='/testApp/loadUrl?jobTemplateId=%s&url=%s'%(jobTemplateId or '',url);
    else:
        url=""
    return render_template("index.html",originUrl=originUrl,url=url,jobTemplateId=jobTemplateId)
    # return app.send_static_file('index.html')
@app.route("/testApp/loadUrl")
def loadUrl():
    args=request.args;
    url=args.get("url")
    jobTemplateId=args.get("jobTemplateId")
    request.args=ImmutableMultiDict()
    data = {}
    if jobTemplateId != None and jobTemplateId != "":
        data = TestService.parseTemplate(jobTemplateId,flag=False)
        # url = data.get("renderUrl")
    global host,cookie,refer,headers
    if (url.startswith("http")):
        host=urllib2.splittype(url)
        refer=url
        if host!=None:
            proto, rest = urllib.splittype(url)
            res, host = urllib.splithost(rest)
            host=proto+"://"+res
    else:
        url=host+url
    request.url=url
    send_headers = {
        # 'Host':'www.jb51.net',
        'User-Agent':'Mozilla/5.0 (Windows NT 6.2; rv:16.0) Gecko/20100101 Firefox/16.0',
        'Accept':'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        'Connection':'keep-alive'}
    postRequest = urllib2.Request(url,headers=send_headers)
    response=None;
    try:
        response = urllib2.urlopen(postRequest)
    except Exception,e:
        logging.error("error"+str(e))
    result=response.read()
    cookie=response.headers.get("set-cookie")
    data=JsonUtils.stringify(data)
    result=result.replace("<head>","""
    <script>var templateInfo=%s;parent.setData(%s)</script>
     <script src="/static/analysis.js" type='text/javascript' charset='utf-8'></script>
    <head><script src="/static/head.js" type='text/javascript' charset='utf-8'></script>
    <script src="/static/xpath.js" type='text/javascript' charset='utf-8'></script>
    <link rel="stylesheet" href="/static/head.css" type="text/css" media="screen">
    """%(str(data),str(data))).replace("</body>","""<div id="ui-see-hover" class="ui-see-hover"></div></body>""")
    if "</body>" not in result:
        result=result.replace("</html>","""</html><div id="ui-see-hover" class="ui-see-hover"></div></body></html>""")
    # if "</body>" not in result:
    #     result=result+"""</body><div id="ui-see-hover" class="ui-see-hover"></div></body></html>"""
    res=make_response(result)
    res.headers=response.headers.dict
    # response.flush()
    res.headers["Cookie"]=cookie
    # # 输出请求百度得到的数据
    # res.data =
    return res


def start():
    app.run(host=ConfigUtils.getWebPorperties("CONFIG_HOST"),port=5002,threaded=True)
start()

# if __name__=="__main__":
#     print str(u'asd')

