#coding=utf-8
#Created by xutao on 2017-05-03.
from beans.TaskTable import ProxyInfo, StaticProxyInfo, ProxyType
from dao import BaseDao
from dao.BaseDao import Session, with_session
from utils import RequestUtils

@with_session
def queryProxyById(proxyId):
    return Session.query(ProxyInfo).filter(ProxyInfo.id==proxyId,ProxyInfo.delFlag==False).all()

#添加代理
@with_session
def proxyAddProxy(proxy):
    Session.add(proxy)
    return {"proxyInfo":proxy}
def contentDetail(id):
    proxy=Session.query(ProxyInfo).filter(ProxyInfo.id==id,ProxyInfo.delFlag==False).first()
    staticProxyList=None
    if proxy!=None and proxy.type==ProxyType.STATIC:
        staticProxyList=Session.query(StaticProxyInfo).filter(StaticProxyInfo.proxyInfoId==id,ProxyInfo.delFlag==False).all()
    return {"result":{"proxy":proxy,"staticProxyList":staticProxyList}}
def proxyAddByFile(file):
    pass
def proxyMod(proxy):
    return BaseDao.updateByPrimary(proxy,ProxyInfo)
def proxyModify(proxy):
    proxy_new = Session.query(ProxyInfo).filter(ProxyInfo.id==proxy.id,ProxyInfo.delFlag==False).one()
    proxy_new.authUrl = proxy.authUrl
    Session.commit()
    return {'result':{'proxyInfo':proxy_new}}
def proxyAdd(proxy):
    type=proxy.type
    if type==ProxyType.STATIC:
        ipList=RequestUtils.parseProxyFile();
        result=addStaticProxyList(ipList)
    else:
        result=proxyAddProxy(proxy)
        Session.add(proxy)
        Session.commit()
    return {"result":result}
def addStaticProxyList(ipList):
    staticProxyInfoList=[]
    if len(ipList)<=0:
        return None
    proxyInfo=ProxyInfo(type=ProxyType.STATIC)
    Session.add(proxyInfo)
    for ip in ipList:
        infp=ip.split(":")
        if len(infp)==2:
            staticProxyInfo=StaticProxyInfo(host=infp[0],port=infp[1],proxyInfoId=proxyInfo.id)
            Session.add(staticProxyInfo)
            staticProxyInfoList.append(staticProxyInfo)
    Session.commit()
    return {"proxyInfo":proxyInfo,"staticProxyInfoList":staticProxyInfoList}