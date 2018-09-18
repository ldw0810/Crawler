# coding=utf-8
from web import app
from beans.UserTable import User
from dao import UserDao
from utils.RequestUtils import loadParams
from utils.ResponseUtils import parseResponse
from dao import BaseDao
from sqlalchemy import text
# app = Flask(__name__)


# @app.errorhandler(Exception)
# def error_500(error):
#     """这个handler可以catch住所有的abort(500)和raise exeception."""
#     print error
#     return parseResponse(-1)


@app.route('/getUserList', methods=['POST'])
def query_users():
    """
    查询用户列表
    :return: 
    """
    request_params = loadParams()
    if request_params.has_key('userId'):
        userId = request_params['userId']
        if userId == '-1':
            data = BaseDao.query(User,type=1)
        else:
            data = BaseDao.query(User,text('id="'+userId+'"'),type=0)
    return parseResponse(0, {"userlist":data})


@app.route('/userMgmt', methods=['POST'])
def user_management():
    """
    用户管理（增加、删除、更新）
    :return: 
    """
    request_params = loadParams()
    if request_params.has_key('action') and request_params.has_key('user'):
        action = request_params['action']
        user_info = request_params['user']
        pass
    else:
        return parseResponse(10000000)
    user = User()
    for key in user_info:
        if hasattr(user, key):
            setattr(user, key, user_info[key])
    UserDao.user_management(int(action), user)
    return parseResponse(0)


@app.route('/verifyPassword', methods=['POST', 'GET'])
def verify_password():
    """
    密码校验
    :return: 
    """
    request_params = loadParams()
    is_success = UserDao.verify_password(request_params)
    if is_success:
        return parseResponse(0)
    else:
        return parseResponse(-1)

@app.route('/getUserPermission', methods=['POST'])
def get_user_permission():
    request_params = loadParams()
    if request_params.has_key('userId'):
        userId = request_params['userId']
        pass
    if request_params.has_key('type'):
        type = request_params['type']
        pass
    if userId is None or type is None:
        return parseResponse(-1)
    else:
        data = UserDao.query_user_permission(userId,type)
        return parseResponse(0,data)

@app.route('/getGroupList', methods=['POST'])
def get_group_list():
    request_params = loadParams()
    if request_params.has_key('userID'):
        data = UserDao.query_group_list(request_params['userID'])
        return parseResponse(0, data)
    else:
        return parseResponse(-1)
if __name__ == '__main__':
    app.run()
