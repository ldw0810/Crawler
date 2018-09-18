# coding=utf-8
import uuid

from sqlalchemy import BOOLEAN
from sqlalchemy import Column
from sqlalchemy import DateTime
from sqlalchemy import String

from beans.BaseBean import BaseBean, Base
class NodeMonitor(BaseBean,Base):
    __tablename__ = 'node_monitor'
    id = Column("id", String(50), primary_key=True,default=lambda: unicode(uuid.uuid1()).replace('-', ''))
    name = Column("name", String(50))
    node_ip=Column("node_ip", String(255))
    node_status=Column("node_status", BOOLEAN)

    def __init__(self,name,node_ip,node_status):
        self.name=name
        self.node_ip=node_ip
        self.node_status=node_status