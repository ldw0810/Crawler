#coding=utf-8
#Created by xutao on 2017-08-07.
from beans.VersionTable import Version
from dao.BaseDao import Session, with_session


@with_session
def loadVersionList():
    return Session.query(Version).filter(Version.delFlag==False).order_by(" create_time desc ").limit(10).all();