import uuid

from sqlalchemy import Boolean
from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import ForeignKey
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy.orm import relationship
from beans.BaseBean import BaseBean, Base
from dao.BaseDao import query, querySql


class GisInfoField(BaseBean,Base):
    __tablename__ = 's_gis_info'
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTtime = Column("create_time", DateTime)
    contentType = Column("content_type", Integer)
    provinceId = Column("province_id", Integer)
    provinceCnt = Column("province_cnt", Integer)
    latitLongit = Column("latit_longit", String(512))
    taskJobId = Column("task_job_id", String(50))
    overseasType = Column("overseas_type", String(50))
    overseasCnt = Column("overseas_cnt", Integer)
    detailAreaId = Column("detail_area_id", Integer)
    detailUrl = Column("detail_url", String(512))
    detailCnt = Column("detail_cnt", Integer)
    detailKv = Column("detail_kv", String(512))
    detailJudicature = Column("detail_judicature", Integer)
    def __init__(self, id=None, delFlag=0, createTtime="",contentType=None,provinceId=None, provinceCnt=None,
                 latitLongit=None, taskJobId=None, overseasType=None,overseasCnt=None, detailAreaId=None,
                 detailUrl=None, detailCnt=None, detailKv=None, detailJudicature=None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag = delFlag
        self.createTtime = createTtime
        self.contentType = contentType
        self.provinceId = provinceId
        self.provinceCnt = provinceCnt
        self.latitLongit = latitLongit
        self.taskJobId = taskJobId
        self.overseasType = overseasType
        self.overseasCnt = overseasCnt
        self.detailAreaId = detailAreaId
        self.detailUrl = detailUrl
        self.detailCnt = detailCnt
        self.detailKv = detailKv
        self.detailJudicature = detailJudicature

class GisInfoDetailField(BaseBean,Base):
    __tablename__ = 's_gis_detail_info'
    id = Column("id", String(50), primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTtime = Column("create_time", DateTime)
    contentType = Column("content_type", Integer)
    detailAreaId = Column("detail_area_id", String(50))
    detailUrl = Column("detail_url", String(512))
    detailKv = Column("detail_kv", String(512))
    networkCnt = Column("network_cnt", Integer)
    baiduSearchCnt = Column("baidu_search_cnt", Integer)
    haosouSearchCnt = Column("haosou_search_cnt", Integer)
    sougouSearchCnt = Column("sougou_search_cnt", Integer)
    weixinSearchCnt = Column("weixin_search_cnt", Integer)
    allCnt = Column("all_cnt", Integer)
    suitability = Column("suitability", String(50))
    suitabilityRange = Column("suitability_range", Integer)
    genuineInfo = Column("genuine_info", String(512))
    piracyInfo = Column("piracy_info", String(512))
    piracySource = Column("piracy_source", String(50))
    estimatedImpactCnt = Column("estimated_impact_cnt", Integer)
    transmissionRate = Column("transmission_rate", String(50))
    spreadScope = Column("spread_scope", Integer)
    resourceSize = Column("resource_size", String(50))
    resourceInDate = Column("resource_in_date", DateTime)
    taskJobId = Column("task_job_id", String(512))
    def __init__(self, id=None, delFlag=0, createTtime="",
                 contentType=None, detailAreaId=None, detailUrl=None, detailKv=None,networkCnt=None,
                 baiduSearchCnt=None, haosouSearchCnt=None, sougouSearchCnt=None, weixinSearchCnt=None,
                 allCnt=None,suitability=None, suitabilityRange=None, genuineInfo=None, piracyInfo=None,
                 piracySource=None, estimatedImpactCnt=None, transmissionRate=None,spreadScope=None,
                 resourceSize=None, resourceInDate="", taskJobId=None):
        self.id = id if id != None else uuid.uuid1()
        self.delFlag = delFlag
        self.createTtime = createTtime
        self.contentType = contentType
        self.detailAreaId = detailAreaId
        self.detailUrl = detailUrl
        self.detailKv = detailKv
        self.networkCnt=networkCnt
        self.baiduSearchCnt=baiduSearchCnt
        self.haosouSearchCnt=haosouSearchCnt
        self.sougouSearchCnt=sougouSearchCnt
        self.weixinSearchCnt=weixinSearchCnt
        self.allCnt=allCnt
        self.suitability=suitability
        self.suitabilityRange=suitabilityRange
        self.genuineInfo=genuineInfo
        self.piracyInfo=piracyInfo
        self.piracySource=piracySource
        self.estimatedImpactCnt=estimatedImpactCnt
        self.transmissionRate=transmissionRate
        self.spreadScope=spreadScope
        self.resourceSize=resourceSize
        self.resourceInDate=resourceInDate
        self.taskJobId=taskJobId


class AreaField(BaseBean,Base):
    __tablename__ = 's_area'
    id = Column("id", String(50), primary_key=True)
    cityId = Column("city_id", String(50))
    lat = Column("lat", Integer)
    lng = Column("lng", Integer)
    code = Column("code", String(8))
    def __init__(self, id=None, cityId=None,
                 province=None, city=None, country=None, lat=None, lng=None, code=None):
        self.id=id
        self.cityId=cityId
        self.lat=lat
        self.lng=lng
        self.code=code

class UrlReCityField(BaseBean, Base):
    __tablename__ = 'url_re_city'
    id = Column("id", Integer, primary_key=True)
    name = Column("name", String(250))
    url = Column("url", String(250))
    type = Column("type", Integer)
    ip = Column("ip", String(50))
    country = Column("country", String(50))
    countryId = Column("country_id", String(50))
    area = Column("area", String(50))
    areaId = Column("area_id", String(50))
    region = Column("region", String(50))
    regionId = Column("region_id", String(50))
    city = Column("city", String(50))
    cityId = Column("city_id", String(50))
    def __init__(self, id=None, name=None, url=None, type=None, ip=None, country=None,
                 countryId=None, area=None, areaId=None, region=None, regionId=None, city=None, cityId=None):
        self.id = id
        self.name = name
        self.url = url
        self.type = type
        self.ip = ip
        self.country = country
        self.countryId = countryId
        self.area = area
        self.areaId = areaId
        self.region = region
        self.regionId = regionId
        self.city = city
        self.cityId = cityId

class GisProvinceInfo(BaseBean, Base):
    __tablename__ = 's_gis_province_info'
    id = Column("id", Integer, primary_key=True)
    delFlag = Column("del_flag", Boolean)
    createTtime = Column("create_time", DateTime)
    provinceName = Column("province_name", String(512))
    provinceCnt = Column("province_Cnt", String(512))
    def __init__(self, id=None, delFlag=0, createTtime="", provinceName=None, provinceCnt=None):
        self.id = id
        self.delFlag = delFlag
        self.createTtime = createTtime
        self.provinceName = provinceName
        self.provinceCnt = provinceCnt