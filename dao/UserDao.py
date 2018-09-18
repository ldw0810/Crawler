# coding=utf-8
from beans.UserTable import User, Group, Permission, Group_re_permission
from dao import BaseDao
from dao.BaseDao import add
from utils.ResponseUtils import parseResponse
from sqlalchemy import text
from BaseDao import query
from sqlalchemy import func
Session = BaseDao.Session


def query_users(request_info):
    """
    查询用户
    :param request_info: 
    :return: 
    """
    if not request_info.has_key('page') or not request_info.has_key('pageCount'):
        return parseResponse(-1)
    page = request_info['page']  # page 页码标识，必传参数
    page_count = request_info['pageCount']  # pageCount 每页数据，必传参数
    query = Session.query(User)
    if request_info.has_key('user'):
        user_info = request_info['user']
        if user_info.has_key('id'):
            query = query.filter(User.id == user_info['id'])
            pass
        if user_info.has_key('type'):
            query = query.filter(User.type == user_info['type'])
            pass
        if user_info.has_key('delFlag'):
            query = query.filter(User.delFlag == user_info['delFlag'])
            pass
        if user_info.has_key('status'):
            query = query.filter(User.status == user_info['status'])
            pass
        if user_info.has_key('groupId'):
            query = query.filter(User.groupId == user_info['groupId'])
    user_list = query.offset(int(page) * int(page_count)).limit(int(page_count)).all()
    Session.commit()
    return {"userList": user_list}


def add_user(user):
    """
     添加用户
    :param user: User对象
    :return: 
    """
    add(user)


def update_user(action, user):
    """
    :param action: 1:删除用户;2:变更用户信息
    :param user: User对象
    :return: 
    """
    values = {}
    if action == 1:
        values[User.delFlag] = 1
        Session.query(User).filter(User.id == user.id).update(values)
        Session.commit()
        pass
    elif action == 2:
        Session.merge(user)
        Session.commit()
    pass


def user_management(action, user):
    """
    用户管理
    :param action: 操作类型0：添加新用户；1：删除用户（假删除）;2:变更用户信息
    :param user: User对象
    :return: 
    """
    try:
        if action == 0:  # 新增租户
            add(user)
        elif action == 1 or action == 2:  # 删除租户或变更用户信息
            update_user(action, user)
    except:
        raise


def verify_password(request_data):
    """
    校验密码
    :param request_data: 字典类型如：{"userId":"userId","oldPassword":"oldPassword","type":"type"}
    :return: True 校验成功；False 校验失败
    """
    query = Session.query(User)
    if request_data.has_key('oldPassword'):
        query = query.filter(User.password == request_data['oldPassword'])
        pass
    if request_data.has_key('type'):
        query = query.filter(User.type == request_data['type'])
        pass
    result = query.first()
    if result is not None:
        return True
    else:
        return False
def query_user_permission(id,type):
    """
    查询用户权限
    :param id: 
    :param type: 0：id为用户id；1：id为用户归属组id
    :return: 
    """
    if type== '0':
        sql = """id in (select agrp.PERMISSION_ID from Auth_group_re_permission agrp where agrp.GROUP_ID in %s)""" %(conver_to_sql_where(id))
        print text(sql)
        result = query(Permission, text(sql))
        print result
    if type == '1':
        sql = """id in (select permission_id from Auth_group_re_permission where group_id = '%s')""" %(id)
        result = query(Permission, text(sql))
    return {"permissionList":result}

def query_group_list(userId):
    """
    查询分组
    :param userId: 用户ID;-1：查询所有组
    
    :return: 
    """
    if userId != '-1':
        sql = """id in %s """ % (conver_to_sql_where(userId))
        result = query(Group, text(sql))
    else:
        result = query(Group, type=1)
    return {"groupList": result}
def conver_to_sql_where(userId):
    user = query(User, text("id = '%s'" % (userId)),0)
    groupId = user.groupId
    in_where_sql = '(%s)' %groupId
    return in_where_sql
if __name__ == "__main__":
    # tt('f0980240201711e7ae1000232490c701')
    query_group_list('f0980240201711e7ae1000232490c701')
    # query_group_list('120b00b01e9911e7b0b400232490c701')
    # query_user_permission('120b00b01e9911e7b0b400232490c701','0')
    # query_user_permission('1', '1')
    # user = User()
    # user.id="fd6127e11e9611e7873800232490c701"
    # user.loginName="udate"
    # user.password="123456"
    # values = {}
    # values[User.id] = user.id
    # values[User.loginName] = user.loginName
    # values[User.password] = user.password
    #
    # print values

    # values={}
    # for field in [x for x in dir(User) if not x.startswith('_') and x != 'metadata' and getattr(user,x) is not None]:
    #     v = 'User.%s' %field
    #     print text(v)
    #     values[text(v)] = getattr(user,field)
    #     pass
    # print values
