# -*- coding: utf-8 -*-
import ssl
import urllib
import urllib2
import os
import logging
APPKEY = "201704200001"
APPSECRET = "3c83c82982ad40eba1417bc047e6543a"
PHONE = "13989899898"
ssl._create_default_https_context = ssl._create_unverified_context
base_url = "https://www.cunnar.com:15443"


def sort_asc(dict):
    """
    字典的key进行升序排序
    :param dict: 
    :return: 
    """
    keys = sorted(dict)
    values = []
    for key in keys:
        value = "%(key)s=%(value)s" % {"key": key, "value": dict[key]}
        values.append(value)
    return "&".join(values)


def md5(target):
    """
    生成md5摘要
    :param target: 
    :return: 
    """
    import hashlib
    m = hashlib.md5()
    m.update(target + APPSECRET)
    digest = m.hexdigest()
    return digest


def generate_sign(dict):
    """
    生成签名
    :param dict: 
    :return: 
    """
    param = sort_asc(dict)
    return md5(param)


def str2dict(value):
    import json
    result = json.loads(value)
    return result


def sha1_file_with_path(path, block_size=64 * 1024):
    """
    sha1算法计算文件的hash值
    :param path: 
    :param block_size: 
    :return: 
    """
    import hashlib
    if not isinstance(path,unicode):
        path = unicode(path, "utf8")
    with open(path, 'rb') as f:
        sha1 = hashlib.sha1()
        while True:
            data = f.read(block_size)
            if not data:
                break
            sha1.update(data)
    retsha1 = sha1.hexdigest()
    return retsha1


def get_file_length(path):
    """
    获取文件大小
    :param path: 
    :return: 
    """
    import os
    try:
        if not isinstance(path,unicode):
            path = unicode(path, "utf8")
        size = os.path.getsize(path)
        return size
    except Exception as err:
        print "error:", err


def account_exist(phone=None, email=None, out_id=None):
    param = {}
    param['app_key'] = APPKEY
    if phone:
        param['phone'] = phone
        p = 'phone=' + phone
    elif email:
        param['email'] = email
        p = 'email=' + email
    elif out_id:
        param['out_id'] = out_id
        p = 'out_id=' + out_id
    sign = generate_sign(param)
    url = base_url + "/opencloud/api/account/exist.json?app_key=%s&sign=%s&sign_type=MD5&%s" % (APPKEY, sign, p)
    result = get_response(url)
    return result


def authorize():
    url = base_url + "/opencloud/api/oauth2/authorize?app_key=201704200001&redirect_uri=https://www.baidu.com"
    req = urllib2.Request(url)
    res_data = urllib2.urlopen(req)
    res = res_data.read()
    print res


def access_token(user_id):
    """
    根据UserID获取access_token
    :param phone: 
    :param email: 
    :param out_id: 
    :return: 
    """
    param = {}
    param['user_id'] = user_id
    param['app_key'] = APPKEY
    sign = generate_sign(param)
    url = base_url + "/opencloud/api/account/access_token.json?app_key=%s&sign=%s&sign_type=MD5&user_id=%s" % (
        APPKEY, sign, user_id)
    response = get_response(url)
    if response['code'] == 0:
        return response['access_token']
    else:
        return False
    pass


def access_token_by_code(redirect_url='http://www.baidu.com'):
    """
    根据code获取access_token
    :param redirect_url: 
    :return: 
    """
    import AuthCode
    code = AuthCode.getAuthCode()
    param = dict(grant_type="authorization_code",
                 redirect_uri=redirect_url,
                 app_key=APPKEY,
                 code=code)
    sign = generate_sign(param)
    url = base_url + "/opencloud/api/oauth2/access_token.json?app_key=%s&sign=%s&sign_type=MD5&grant_type=authorization_code&redirect_uri=%s&code=%s" % (
        APPKEY, sign, redirect_url, code)
    response = get_response(url)
    if response['code'] == 0:
        return response['access_token']
    else:
        return False
    pass


def get_userid(phone=None, email=None, out_id=None):
    """
    获取userId
    :param phone: 
    :param email: 
    :param out_id: 
    :return: 
    """
    param = {}
    param['app_key'] = APPKEY
    if phone:
        param['phone'] = phone
        p = 'phone=' + phone
    elif email:
        param['email'] = email
        p = 'email=' + email
    elif out_id:
        param['out_id'] = out_id
        p = 'email=' + out_id
    sign = generate_sign(param)
    url = base_url + "/opencloud/api/account/get_key.json?app_key=%s&sign=%s&sign_type=MD5&%s" % (APPKEY, sign, p)
    response = get_response(url)
    if response['code'] == 0:
        return response['user_id']
    else:
        return False


def create_file(access_token, name, file_size, file_hash):
    import uuid
    url = base_url + "/opencloud/api/account/file/create.json"
    data = {}
    data['access_token'] = access_token
    data['id'] = str(uuid.uuid4())
    data['name'] = name
    data['length'] = file_size
    data['hash'] = file_hash
    response = get_response(url, data)
    print response
    if response['code'] == 0:
        return response['file_id']
    else:
        return False


def upload_file(file_path, access_token, file_id, index=0):
    from poster.encode import multipart_encode
    from poster.streaminghttp import register_openers
    try:
        register_openers()
        url = base_url + "/opencloud/api/account/file/upload.json?access_token=%s&file_id=%s&index=%s" % (
            access_token, file_id, index)
        data = {}
        if not isinstance(file_path,unicode):
            file_path = unicode(file_path, "utf8")
        data['inputStream'] = open(file_path, 'rb')
        datagen, headers = multipart_encode(data)
        request = urllib2.Request(url, data=datagen, headers=headers)
        res = urllib2.urlopen(request)
        response = str2dict(res.read())
        print response
        if response and response['upload_length'] != 0:
            return True
        else:
            return False
    except Exception, e:
        print e
        return False


def get_response(url, post_param=None):
    result = {u'code': 0, u'message': u'success'}
    try:
        if post_param:
            param_urlencode = urllib.urlencode(post_param)
            req = urllib2.Request(url=url, data=param_urlencode)
        else:
            req = urllib2.Request(url=url)

        response = urllib2.urlopen(req)

        result.update(str2dict(response.read()))
    except urllib2.HTTPError,err:
        result.update(code=-1,message=err.read())
        logging.error(err.read())
    except Exception, e:
        result[u'code'] = -1
        result[u'message'] = 'failed'
        logging.error(e.message)
    return result


# def sha1_file_with_c(content):
#     """
#     sha1算法计算文件的hash值
#     :param path:
#     :param block_size:
#     :return:
#     """
#     import hashlib
#     sha1 = hashlib.sha1()
#     sha1.update(content)
#     retsha1 = sha1.hexdigest()
#     return retsha1


def deposit_cert(content, name, phone=None, email=None, out_id=None):
    """
    存证
    :param content: 要存的文本内容
    :param name: 要在存证平台创建的文件名(名字唯一)
    :param phone: 
    :param email: 
    :param out_id: 
    :return: 
    """
    if not content:
        return
    path = create_local_file(content, name)
    if not path:
        return
    response = account_exist(phone, email, out_id)
    if response['code'] == 0:
        if response['account_exist']:  # 判断账号是否存在
            if response['account_permission']:  # 判断账号是否已经授权
                user_id = get_userid(phone)
                if user_id:
                    token = access_token(user_id)
                    return go_upload_file(token, name, path)
                else:
                    return False
            else:
                token = access_token_by_code()
                return go_upload_file(token, name, path)
        else:
            user_id = registerAccount(phone, email, out_id)
            if user_id:
                token = access_token(user_id)
                return go_upload_file(token, name, path)
            else:
                return False
    else:
        return False


def go_upload_file(access_token, name, file_path):
    if access_token:
        filedId = create_file(access_token, name, get_file_length(file_path),
                              sha1_file_with_path(file_path))
        if filedId:
            flag = upload_file(file_path, access_token, filedId)
            if os.path.exists(file_path):
                os.remove(file_path)
            return flag
        else:
            return False
    else:
        return False


def registerAccount(phone=None, email=None, out_id=None):
    # POST請求 opencloud/api/account/create.json
    requrl = "https://www.cunnar.com:15443/opencloud/api/account/create.json"
    MD5Book = {k: v for k, v in {
        'app_key': APPKEY,
        'phone': phone,
        'email': email,
        'out_id': out_id
    }.iteritems() if v}

    param = {k: v for k, v in {
        'app_key': APPKEY,
        'sign': generate_sign(MD5Book),
        'sign_type': 'MD5',
        'phone': phone,
        'email': email,
        'out_id': out_id
    }.iteritems() if v}
    try:
        response = get_response(requrl, param)
        if response['code'] == 0:
            return response['user_id']
        else:
            return False
            # test_data_urlencode = urllib.urlencode(param)
            # req = urllib2.Request(url=requrl, data=test_data_urlencode)
            # res_data = urllib2.urlopen(req)
            # res = res_data.read()
            # return res
            # req = urllib2.Request(url)
            # res_data = urllib2.urlopen(req)
            # print res_data
            # res = res_data.read()
            # print res
    except Exception, e:
        return False


def getAlreadyFileLen(access_token=None, file_id=None):
    # GET请求 /opencloud/api/account/file/length.json already
    param = '?access_token=' + access_token + '&file_id=' + file_id
    requrl = "https://www.cunnar.com:15443/opencloud/api/account/file/length.json" + param
    try:
        req = urllib2.Request(url=requrl)
        res_data = urllib2.urlopen(req)
        res = res_data.read()
        # {'upload_length':Long}  已上传文件大小
        # 创建网页文件信息创建通话录音信息
        # 文件解析通知接口 上传文件流下载文件流

        return res
    except Exception, e:
        return e


def create_local_file(content, file_name):
    try:
        file = open(file_name + ".txt", 'w')
        file.write(content)
        file.close()
        path = file_name + ".txt"
        return path
    except Exception, e:
        return False


def query_certs(phone=None, email=None, out_id=None):
    """
    查询存证列表
    :param phone: 
    :param email: 
    :param out_id: 
    :return: 
    """
    token = access_token(get_userid(phone, email, out_id))
    if not token:
        return False
    url = base_url + "/opencloud/api/account/file/query.json?access_token=" + token+"&count=1000"
    return get_response(url)


def get_download_cert_url(file_id, phone=None, email=None, out_id=None):
    """
    获取存证下载地址
    :param file_id: 
    :param phone: 
    :param email: 
    :param out_id: 
    :return: 
    """
    token = access_token(get_userid(phone, email, out_id))
    url = base_url + "/opencloud/api/account/file/download.json?access_token=%(token)s&file_id=%(file_id)s" % {
        'token': token, 'file_id': file_id}
    return url


if __name__ == "__main__":
    path = "D:/test.txt"
    # create_file("yyppcc","xiaominmiaomia")
    # print deposit_cert("woshiceshineiorong1102","1102ypc",phone="15228800363")
    # print registerAccount(phone="13630225743")
    # print access_token(get_userid("15228800363"))
    # print query_certs("23963465-8973-495e-99b5-e6170225939f")
    # print get_userid("15228800363")
    # print get_download_cert_url("1187922", "15228800363")
    print query_certs("15228800363")
    pass
