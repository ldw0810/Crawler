#coding=utf-8
#Created by xutao on 2017-04-17.
from flask import render_template
from flask import request

from utils import DesUtils
from web import app
# @app.route('/<inteName>.html')
# def cate(inteName):
#     return app.send_static_file(inteName+".html")
# @app.route('/developer/param/<inteName>.html')
# def cateSndLevel(inteName):
#     return render_template('/developer/param/'+inteName+".html")

@app.route('/<inteName>.html')
def page_html(inteName):
    return render_template(inteName+".html")

@app.route('/use/<inteName>.html')
def cateFstLevel_use(inteName):
    if inteName=="list":
        username=request.args["username"]
        password=request.args["password"]
        username=DesUtils.decrypt(username)
        password=DesUtils.decrypt(password)
        if username!="test" or  password!="123456":
            return None
    return render_template('/use/'+inteName+".html")

@app.route('/developer/template/<inteName>.html')
def cateSndLevel_developer_template(inteName):
    return render_template('/developer/template/'+inteName+".html")

@app.route('/developer/param/<inteName>.html')
def cateSndLevel_developer_param(inteName):
    return render_template('/developer/param/'+inteName+".html")

@app.route('/developer/field/<inteName>.html')
def cateSndLevel_developer_field(inteName):
    return render_template('/developer/field/'+inteName+".html")

@app.route('/developer/work/<inteName>.html')
def cateSndLevel_developer_work(inteName):
    return render_template('/developer/work/'+inteName+".html")

@app.route('/developer/message/<inteName>.html')
def cateSndLevel_developer_message(inteName):
    return render_template('/developer/message/'+inteName+".html")


if __name__=="__main__":
    print DesUtils.decrypt("test"),DesUtils.decrypt("123456")