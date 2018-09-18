#coding=utf-8
from beans.BaseBean import Base
from beans.BaseBean import BaseBean
from sqlalchemy import Column
from sqlalchemy import String
from sqlalchemy import Boolean
from sqlalchemy import DateTime
from sqlalchemy import INT
import uuid
"""
    ID  主键、id字段 Varchar（50）N 系统内部唯一标识
    DEL_FLAG    删除标识    Boolean N   默认为0/1：删除
    CREATE_TIME 创建时间    Datetime    N   创建时间
    SAVING_CNT  正在存证的记录数    Int
    SAVED_CNT   已存证的记录数 Int
    CHANGED_CNT 转化成司法证据的盗版数据总量  Int
    COMPROMISE_CNT  司法和解的数据量    Int
    PURSUE_CNT  司法起诉中的数据量   Int
    ADJUDGED_CNT    已经宣判的数据量    Int
"""

def gen_id():
   return uuid.uuid4().hex

class JudicatureTable(BaseBean,Base):
    __tablename__ = "S_judicature_info"
    id = Column("id", String(50), primary_key=True,nullable=False,default=gen_id)
    delFlag = Column("del_flag", Boolean,nullable=False)
    create_time = Column("create_time", DateTime,nullable=False)
    saving_cnt = Column("saving_cnt", INT)
    saved_cnt = Column("saved_cnt", INT)
    changed_cnt = Column("changed_cnt", INT)
    compromise_cnt = Column("compromise_cnt", INT)
    pursue_cnt = Column("pursue_cnt", INT)
    adjudged_cnt = Column("adjudged_cnt", INT)
