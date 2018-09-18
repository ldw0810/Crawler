# -*- coding:utf-8 -*-
import uuid
from sqlalchemy import Column,INT,String
from sqlalchemy import create_engine,ForeignKey,Column,Integer,String,Text,DateTime,\
    and_,or_,SmallInteger,Float,DECIMAL,desc,asc,Table,join,event,VARCHAR,Boolean,SMALLINT,null
from beans.BaseBean import BaseBean, Base
from sqlalchemy.orm import sessionmaker

class TotalInfo(BaseBean,Base):
    __tablename__ = 'S_total_info'
    id = Column('ID', VARCHAR(50), primary_key=True, default=lambda key: uuid.uuid4(), nullable=False)  # 唯一标示
    delflag = Column('DEL_FLAG', Boolean, nullable=False)  # 删除标志
    createtime = Column('CREATE_TIME', DateTime, nullable=False)  # 创建时间
    periodtype = Column('PERIOD_TYPE', SMALLINT )  # 数据周期
    timedis = Column('TIME_DIS', VARCHAR(512))  # 检测时间区间
    contenttype = Column('CONTENT_TYPE', SMALLINT)  # 数据类型
    tortcnt = Column('TORT_CNT', INT)  # 侵权数量


class HotInfo(BaseBean,Base):
    __tablename__ = 'S_hot_info'
    id = Column('ID',VARCHAR(50), primary_key=True, default=lambda key: uuid.uuid4(), nullable=False) # 唯一标示
    delflag = Column('DEL_FLAG',Boolean, nullable=False)  # 删除标志
    createtime = Column('CREATE_TIME', DateTime, nullable=False)  # 创建时间
    periodtype = Column('PERIOD_TYPE',SMALLINT,default=0)  # 数据周期
    timedis = Column('TIME_DIS',VARCHAR(512))  # 监测时间区间
    contenttype = Column('CONTENT_TYPE',SMALLINT)  # 数据类型
    sourceurl = Column('SOURCE_URL',VARCHAR(2048))  # 爬取得网站
    rankid = Column('RANK_ID',VARCHAR(10))  # 热门内容排名
    exponent = Column('EXPONENT',VARCHAR(512))  # 热门指数
    hottrend = Column('HOT_TREND',SMALLINT) #热门趋势 0:持平 1:上升 2:下降
    detailimg = Column('DETAIL_IMG',VARCHAR(512)) # 详情海报地址
    detailinfo = Column('DETAIL_INFO', VARCHAR(2048))  # 详情描述信息
    keywords = Column('KEY_WORDS',VARCHAR(512)) #关键词

class GisInfo(BaseBean,Base):
    __tablename__ = 'S_gis_info'
    id = Column('ID', VARCHAR(50), primary_key=True, default=lambda key: uuid.uuid4(), nullable=False)  # 唯一标示
    delflag = Column('DEL_FLAG', Boolean, nullable=False)  # 删除标志
    createtime = Column('CREATE_TIME', DateTime, nullable=False)  # 创建时间
    periodtype = Column('PERIOD_TYPE', SMALLINT)  # 监测时间区间
    timedis = Column('TIME_DIS', VARCHAR(512))  # 数据类型
    contenttype = Column('CONTENT_TYPE', SMALLINT)  # 数据类型
    provinceid = Column('PROVINCE_ID', INT)  # 各省份id
    provincecnt = Column('PROVINCE_CNT', INT)  # 各省份的侵权数据总量
    latitLongit = Column('LATIT-LONGIT', VARCHAR(512))  # 经纬度
    taskjobid = Column('TASK_JOB_ID', VARCHAR(50))  # 任务id
    overseasid = Column('OVERSEAS_ID', VARCHAR(50))  # 海外地区id
    overseascnt = Column('OVERSEAS_CNT', INT)  # 海外地区侵权数量
    detailareaid = Column('DETAIL_AREA_ID', INT)  # 归属地区
    detailurl = Column('DETAIL_URL', VARCHAR(512))  # 侵权url
    detailcnt = Column('DETAIL_CNT', INT)  # 侵权数量
    detailkv = Column('DETAIL_KV', VARCHAR(512)) #侵权内容名称
    detailjudicature = Column('DETAIL_JUDICATURE', VARCHAR(512))#侵权内容 存证状态


class AginstPornography(BaseBean,Base):
    __tablename__ = 'S_anti_vice_info'
    id = Column('ID', VARCHAR(50), primary_key=True, default=lambda key: uuid.uuid4(), nullable=False)  # 唯一标示
    delflag = Column('DEL_FLAG', Boolean, nullable=False)  # 删除标志
    createtime = Column('CREATE_TIME', DateTime, nullable=False)  # 创建时间
    totalcnt = Column('TOTAL_CNT',INT)  # 总数据量
    webcnt = Column('WEB_CNT', INT)  # 检测网页数据量
    imgcnt = Column('IMG_CNT', INT)  # 检测图片数据量
    video_cnt = Column('VIDEO_CNT', INT)  # 检测视频数据量
    text_cnt = Column('TEXT_CNT', INT)  # 检测文字数据量
    saved_cnt = Column('SAVED_CNT', INT)  # 已存证数据量
    antiVice_cnt = Column('ANTI_VICE_CNT', INT)  # 移交扫黄办数据量
    surveillance_cnt = Column('INT_SURVEILLANCE_CNT', INT)  # 移交网监数据量

class HighCharts(BaseBean,Base):
    __tablename__ = 'S_highcharts_info'
    id = Column('ID', VARCHAR(50), primary_key=True, default=lambda key: uuid.uuid4(), nullable=False)  # 唯一标示
    delflag = Column('DEL_FLAG', Boolean, nullable=False)  # 删除标志
    createtime = Column('CREATE_TIME', DateTime, nullable=False)  # 创建时间
    totalcnt = Column('TOTAL_CNT', INT)  # 总数据量
    contenttype = Column('CONTENT_TYPE', SMALLINT)  # 数据类型

