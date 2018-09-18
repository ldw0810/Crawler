#coding=utf-8
from customize_app.publisher.beans.TotalTable import TortReInfoField
from dao.BaseDao import Session

def queryTortTotal(id):
    return Session.query(TortReInfoField).filter(TortReInfoField.id==id,
                                                 TortReInfoField.contentType==0,
                                                 TortReInfoField.delFlag==0).all()
