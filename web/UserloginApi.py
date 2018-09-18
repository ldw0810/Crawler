# -*- coding:utf-8 -*-
from flask import Flask, request, jsonify, current_app, url_for, redirect, session
from flask import make_response

from beans.AuthUserModel import AuthUser, AuthUserSession, DBSession
from flask import abort
from functools import wraps
import uuid
from datetime import timedelta
import json
import time
from TaskApp import app
from dao import BaseDao
from utils import LicenseUtils
from utils.ResponseUtils import parseResponse

app.secret_key = 'B\xaa\x93\xc0\xe1\xe3|:\xe2\xb1\xeek\x19\xbf\x1f\x97c\xef\x84\xc7\xa5\xba\x0fK' # session的安全秘钥


# 定义 过期时间 单位min
TIME_EXPIRE = 30

db = DBSession()


# curl -i -H "Content-Type: application/json" -X POST -d '{"loginname":"admin","password":"admin"}' http://localhost:5000/login
# curl -i -H "Content-Type: application/json" -X POST -d '{"loginname":"","password":"ss"}' http://localhost:5000/login
# curl -i -H "Content-Type: application/json" -X POST  http://localhost:5000/heartbeat
# curl -i -H "Content-Type: application/json" -X POST  http://localhost:5000/logout


# login check
def login_check(f):
    @wraps(f)
    def decorator(*args, **kwargs):
        try:
            sessionid = session.get('Jsessionid')
            if not sessionid:
                return jsonify({'code': '0', 'message': 'session invalidate,or you are not login'})
            jsessionid = request.cookies['Jsessionid'] # 从请求cookie中获取sessionid与服务端会话中存储的sessionid做对比

            if str(sessionid) != str(jsessionid):
                return jsonify({'code': '100000011', 'messgae': 'session invalidate'})
            session_isexpire(sessionid)
            return f(*args, **kwargs)
        except Exception,e:
            return jsonify({'code':'99999999','message':'未知错误'})

    return decorator


@app.route('/login', methods=['POST'])
def login():
    print request.json, request.form

    print 'request data:%s,request.json:%s' % (request.data, request.json)
    try:
        jsonDict = str_to_json(request.data)
        if not jsonDict or 'loginname' not in jsonDict:
            abort(400)
        if 'password' not in jsonDict:
            abort(400)
        loginname = jsonDict['loginname']
        password = jsonDict['password']
    except Exception, e:
        print 'please check your request data'

    print 'loginname:%s,password:%s' % (loginname, password)
    user = db.query(AuthUser).filter(AuthUser.loginname == loginname, AuthUser.delflag == 0).first()
    print user
    if not user:
        return jsonify({'code': 0, 'message': 'user are not exit'})
    print user.password
    if user.password != password:
        return jsonify({'code': 0, 'message': 'password is wrong,please check it'})
    print user.loginname
    try:
        auth_session = db.query(AuthUserSession).filter(AuthUserSession.userid == user.id,
                                                        AuthUserSession.delflag == 0).first()
        if not auth_session:
            session_dic = insert_new_session(user.id)  # 插入新的会话
            session_id = session_dic['sessionid']
            expiretime = session_dic['expiretime']
        else:
            session_expired = time_to_ticks(auth_session.expiretime)  # session 是否已经过期
            if session_expired:
                auth_session.delflag = 1  # 如果会话过期,则删除标志至为1
                db.commit()
                session_dic = insert_new_session(user.id) # 插入新的会话
                session_id = session_dic['sessionid']
                return jsonify({'code': '10000012', 'message': 'The session has been expired,please login agin','sessionid':session_id})
            else:
                session_id = auth_session.sessionid
                expiretime = auth_session.expiretime
                session['Jsessionid'] = session_id
                id_session = session.get('sessionid')

    except Exception, e:
        return jsonify({'code': '10000002', 'message': 'Database access exception'})
    # make_session_permanent()
    # user response
    userdic = {
        'userid': user.id,
        'username': user.username,
        'loginname': user.loginname,
        'email': user.email,
        'phone': user.phone,
        'delflag': user.delflag,
        'status': user.status,
        'parentid': user.parentid,
        'type': user.type,
        'groupid': user.groupid,
        'createtime': user.createtime,
        'modifytime': user.modifytime
    }

    return jsonify({'code': 0,
                    'message': 'login success ',
                    'sessionId': session_id,
                    'sessionExpiredTimeString': expiretime,
                    'user': userdic})


@app.before_request
def make_session_permanent():
    if not LicenseUtils.check_licence(LicenseUtils.get_mac_address()):
        return parseResponse(99999999)
    session.permanent = True
    app.permanent_session_lifetime = timedelta(minutes=TIME_EXPIRE)
    BaseDao.refresh()
    # session.modified = True; 每次打开浏览器 有效期都会被重置


@app.route('/heartbeat', methods=['POST'])
@login_check
def heartbeat():
    sessionid = session.get('Jsessionid')
    if not sessionid:
        return jsonify({'code': '0', 'message': 'heartbeat failure,beaucase you are not login or session invalide'})
    user_session = db.query(AuthUserSession).filter(AuthUserSession.sessionid == sessionid).first()
    if not user_session:
        return jsonify({'code': '10000012', 'message': 'session invalidation'})
    timestr = datetime_tostring(user_session.expiretime)
    expiretime = time.mktime(time.strptime(timestr, '%Y-%m-%d %H:%M:%S'))
    session_expired = time_to_ticks(user_session.expiretime)  # session 是否已经过期
    if session_expired:
        return jsonify({'code': '10000012', 'message': 'heartbeat failure,session invalidation'})
    else:
        seconds = expiretime + TIME_EXPIRE*60
        timestr = time.localtime(seconds )
        showtime = time.strftime('%Y-%m-%d %H:%M:%S', timestr)  # 新的session过期时间
        user_session.expiretime = showtime
        db.commit()
        return jsonify({'code': '0',
                        'message': 'heartbeat success',
                        'Expiretime': showtime,
                        'interval': 1500})



@app.route('/logout', methods=['POST'])
@login_check
def logout():
    sessionid = session.get('Jsessionid')
    # 退出时 把会话过期时间设为当前时间 以便于重新登陆生成新的会话以及更新会话时间
    authsession = db.query(AuthUserSession).filter(AuthUserSession.sessionid == sessionid,
                                                   AuthUserSession.delflag == 0).first()
    if not authsession:
        return jsonify({'code':'100000010','messgae':'user not exist or status invalite'})
    currenttime = timemanager(0)
    authsession.expiretime = currenttime
    authsession.delflag = 1
    db.commit()
    session.pop('Jsessionid')
    return jsonify({'code': '0', 'message': 'logout success'})


# 格式化时间戳
def timemanager(seconds):
    ticks = time.time()
    timestr = time.localtime(seconds + ticks)
    showtime = time.strftime('%Y-%m-%d %H:%M:%S', timestr)  # session创建时间
    return showtime


# 判断时间是否过期:True:已经过期 False:还未过期
def time_to_ticks(timestr):
    current_ticks = time.time()
    time_str = datetime_tostring(timestr)
    ticks = time.mktime(time.strptime(time_str, '%Y-%m-%d %H:%M:%S'))
    print '时间戳:%s,%s:' % (ticks, current_ticks)
    if current_ticks > ticks:
        return True
    else:
        return False


# datetime-->string
def datetime_tostring(dt):
    return dt.strftime('%Y-%m-%d %H:%M:%S')


# str->json
def str_to_json(data):
    dic = json.loads(data, encoding="utf-8")
    return dic


#插入新的会话
def insert_new_session(userid):
    session_id = uuid.uuid4()
    session['Jsessionid'] = session_id  # 登陆成功 会话中添加会话id 记录登陆状态
    createtime = timemanager(0)  # 创建时间
    expiretime = timemanager(TIME_EXPIRE * 60)  # 过期时间
    user_session = AuthUserSession(sessionid=session_id, createtime=createtime, exipiretime=expiretime,
                                   userid=userid, delflag=0)  # 每次登陆插入会话信息
    db.add(user_session)
    db.commit()
    return {'sessionid':session_id,'expiretime':expiretime}


#session 过期处理
def session_isexpire(sessionid):
    authsession = db.query(AuthUserSession).filter(AuthUserSession.sessionid == sessionid,
                                                   AuthUserSession.delflag == 0).first()
    if not authsession:
        return jsonify({'code':'10000011','messgae':'session invalid'})
    else:
        is_expired = time_to_ticks(authsession.expiretime)
        if is_expired:
            return jsonify({'code':'10000012','message':'session expired'})
        else:
            pass

if __name__ == '__main__':
    app.run(debug=True)
