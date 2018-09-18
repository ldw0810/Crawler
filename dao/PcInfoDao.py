#coding=utf-8
from datetime import datetime
import time
from beans.PcInfoTable import StaticStorage, DynamicStorage, PcDeployment, PcHeartBeat
from dao import BaseDao
import re
from beans.NodeMonitorTable import NodeMonitor
Session = BaseDao.Session
class PcInfoDao(object):
    def __init__(self):
        print "PcInfoDao __init__"

    def getStaticAssetsList(self):
        query = Session.query(StaticStorage)
        # assetsList1 = Session.execute('SELECT * FROM t_static_pc_info').fetchall()
        assetsList = query.all()
        # test = query.first()
        newAssetlist = []
        for asset in assetsList:
            if '\n' in str(asset.hostname):
                asset.hostname=str(asset.hostname).replace("\n", "")
            newAssetlist.append(asset)
        return {"assetsList":newAssetlist}

    def getStaticByIp(self,ip):
        query = Session.query(StaticStorage)
        pcinfo = query.filter(StaticStorage.ip == ip).first()
        return pcinfo

    def getDeployment(self,ip):
        query = Session.query(PcDeployment)
        pcinfo = query.filter(PcDeployment.ip == ip).first()
        if not pcinfo:
            pcinfo = PcDeployment()
        return pcinfo

    def staticUpdateOrAdd(self,obj):
        query = Session.query(StaticStorage)
        pcinfo = query.filter(StaticStorage.ip == obj["ip"]).first()
        if pcinfo:
            print pcinfo
            query.filter(StaticStorage.assetId == pcinfo.assetId).update(
                {StaticStorage.memory: obj["memory"], StaticStorage.hostname: obj["hostname"],
                 StaticStorage.cpuphysicalnum: obj["cpuphysicalnum"], StaticStorage.disktotal: obj["disktotal"],
                 StaticStorage.cpu_total: obj["cpu_total"], StaticStorage.cpu_core_num: obj["cpu_core_num"],
                 StaticStorage.update_date: datetime.now(), StaticStorage.deployment: obj["deployment"],
                 StaticStorage.status: obj["status"], StaticStorage.log_url: obj["log_url"]})
            print "update --- success"
        else:
            addpc = StaticStorage(ip=obj["ip"],memory=obj["memory"],hostname=obj["hostname"],cpuphysicalnum=obj["cpuphysicalnum"],
                          disktotal=obj["disktotal"],cpu_total=obj["cpu_total"],cpu_core_num=obj["cpu_core_num"],
                          deployment=obj["deployment"],status=obj["status"],update_date=datetime.now(),
                          log_url=obj["log_url"])
            Session.add(addpc)
            print "add --- success"
        Session.commit()

    def dynamicAssetAdd(self, obj):
        createTime = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
        addpc = DynamicStorage(assetId=obj["assetId"], ip=obj["ip"], memory=obj["memory"],
                              cpu=obj["cpu"],io=obj["io"], online_time=obj["online_time"],
                              loadavg=obj["loadavg"],create_date=createTime,net_width=obj['net_width'],hostname=obj['hostname'],status=obj['status'])
        Session.add(addpc)
        Session.commit()
        print "dynamicAssetAdd --- success"

    def pcHeartBeatAdd(self, obj):
        addpc = PcHeartBeat(ip=obj["ip"])
        Session.add(addpc)
        Session.commit()
        print "pcHeartBeatAdd --- success"

    def getPcHeartBeat(self,ip):
        query = Session.query(PcHeartBeat)
        pcHeartBeat = query.filter(PcHeartBeat.ip == ip).all()
        return {"pcHeartBeat": pcHeartBeat}

    def getAssetDetail(self,asset_id):
        query = Session.query(StaticStorage)
        asset = query.filter(StaticStorage.assetId == asset_id).all()
        return {"asset":asset}

    #beginTime endTime 的日期格式为'2017-04-20 09:06:00'
    def getDynamicAssetDetail(self,assetId,beginTime='',endTime=''):
        query = Session.query(DynamicStorage)
        if beginTime and endTime:
            sql = "SELECT * FROM t_dynamic_pc_info WHERE UNIX_TIMESTAMP(CREATE_DATE) BETWEEN UNIX_TIMESTAMP('" + beginTime + "') AND UNIX_TIMESTAMP('" + endTime + "') And assetId='%s';" %assetId
            dynamicInfoListex = Session.execute(sql).fetchall()
            # print dynamicInfoListex
            infolist = []
            for list in dynamicInfoListex:
                dy = DynamicStorage()
                dy.id = list[0]
                dy.assetId = list[1]
                dy.ip = list[2]
                dy.memory = list[3]
                dy.cpu = list[4]
                dy.io = list[5]
                dy.online_time = list[6]
                dy.loadavg = list[7]
                dy.create_date = list[8]
                dy.net_width = list[9]
                dy.hostname =list[10]
                infolist.append(dy)
            dynamicInfoList = infolist
        else:
            dynamicInfoList = query.filter(DynamicStorage.assetId == assetId).all()
        for dynamic in dynamicInfoList:
            a = re.findall(r'(?<=:  ).*?(?=%)', str(dynamic.memory))
            if len(a) > 0:
                dynamic.memory = a[0]
            if '\n' in str(dynamic.hostname):
                dynamic.hostname = str(dynamic.hostname).replace("\n", "")
            # newDynamiclist.append(dynamic)
        newDynamiclist = self.sort_by_attr(dynamicInfoList,"create_date")
        return {"DynamicInfoList":newDynamiclist}

    def sort_by_attr(self,seq, attr):
        intermed = [(getattr(x, attr), i, x) for i, x in enumerate(seq)]
        intermed.sort()
        array = [x[-1] for x in intermed]
        array.reverse()
        newarray = array
        return newarray

    def getServerLog(self,assetId):
        query = Session.query(StaticStorage)
        asset = query.filter(StaticStorage.assetId == assetId).first()
        log_url = asset.log_url
        return {"url":log_url}


    def getNodeMonitorStatus(self,ip):
        node = Session.query(NodeMonitor).filter(NodeMonitor.node_ip==ip).first()
        if node:
            return node.node_status
        else:
            return "0"


def test():
    pc = PcInfoDao()
    # pc.staticUpdateOrAdd({"ip":"4","memory":"444","hostname":"444","cpuphysicalnum":"4","disktotal":"4",
    #                  "cpu_total":"4","cpu_core_num":"4","deployment":"4","status":"4",
    #                  "log_url":"4"})
    print pc.getDeployment('1').deployment
    # dynamicInfoList = pc.getDynamicAssetDetail('2','2017-04-20 00:00:01','2017-04-22 23:59:00')
    # print dynamicInfoList['DynamicInfoList'][0].create_date
    # print pc.getServerLog('2')