#coding=utf-8
from beans.BaseBean import Base
from beans.BaseBean import BaseBean
from sqlalchemy import Column
from sqlalchemy import String
from sqlalchemy import Boolean
from sqlalchemy import DateTime
from sqlalchemy import SMALLINT
from sqlalchemy import INT
import uuid


"""
    ID 主键、id字段  Varchar（50）N 系统内部唯一标识
    DEL_FLAG 删除标识   Boolean N    默认为0/1：删除
    CREATE_TIME 创建时间    Datetime    N
    CONTENT_TYPE    数据类型    Tinyint(5)  0：总量 1：音乐 2：视频 3：书籍 4：扫黄打非
    TOTAL_CNT   各类型总计的侵权数量 Int
"""

def gen_id():
   return uuid.uuid4().hex
class TortTotalTable(BaseBean,Base):
    __tablename__ = "S_tort_info"
    id = Column("id", String(50), primary_key=True,nullable=False,default=gen_id)
    delFlag = Column("del_flag", Boolean,nullable=False)
    create_time = Column("create_time", DateTime,nullable=False)
    content_type = Column("content_type", SMALLINT)
    total_cnt = Column("total_cnt",INT)




