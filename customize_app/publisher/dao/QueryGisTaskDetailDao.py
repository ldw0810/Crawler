from sqlalchemy.orm import sessionmaker

from customize_app.publisher.beans.GisTable import GisInfoField, GisInfoDetailField, AreaField, UrlReCityField
from customize_app.publisher.beans.WebTable import SearchTaskJob
from dao import baseEngine
from dao.BaseDao import with_session

Session_class = sessionmaker(bind=baseEngine)
Session = Session_class()

@with_session
def queryGisDetailAll():
    gisInfo = Session.query(GisInfoField,AreaField,UrlReCityField).filter().group_by(GisInfoField.id).join(AreaField,GisInfoField.detailAreaId==AreaField.cityId)\
        .join(UrlReCityField,GisInfoField.detailUrl==UrlReCityField.url).all()
    return gisInfo

@with_session
def queryGisDetailOne(taskJobId):
    gisInfo = Session.query(GisInfoField,AreaField,UrlReCityField).filter(GisInfoField.taskJobId == taskJobId).\
        join(AreaField,GisInfoField.detailAreaId==AreaField.cityId). \
        join(UrlReCityField, GisInfoField.detailUrl == UrlReCityField.url).all()
    return gisInfo

@with_session
def queryGisDetailBigOne(taskJobId):
    searchTaskJob=Session.query(SearchTaskJob).filter(SearchTaskJob.id==taskJobId).first()
    gisBigInfo = Session.query(GisInfoDetailField,AreaField,UrlReCityField).\
        filter(GisInfoDetailField.detailKv==searchTaskJob.key,GisInfoDetailField.contentType==SearchTaskJob.type). \
        join(AreaField, GisInfoDetailField.detailAreaId == AreaField.cityId). \
        join(UrlReCityField, GisInfoDetailField.detailUrl == UrlReCityField.url).all()
    return gisBigInfo

@with_session
def queryGisDetail(taskJobId):
    # searchTaskJob=Session.query(SearchTaskJob).filter(SearchTaskJob.id==taskJobId).first()
    return Session.query(GisInfoDetailField).filter(GisInfoDetailField.taskJobId ==taskJobId).first()