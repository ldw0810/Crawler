# !/usr/bin/env python
# encoding: utf-8

'''
收集主机的信息：
静态数据（每7天刷下就可以）：物理CPU个数，每个物理CPU中core的个数，CPU大小，MEM大小，磁盘大小,Hostname,ip

动态数据（时间可配，默认1分钟）：持续上线时间；负载均值load average w或者uptime都可以直接展示负载；IO  %util delta(use)
author ：
'''
import subprocess

from tools import Time_Tool
from subprocess import Popen, PIPE
from dao.PcInfoDao import PcInfoDao
import os,time
import psutil
import logging
# from __future__ import print_function
from collections import OrderedDict
import sys

if len(sys.argv) > 1:
	INTERFACE = sys.argv[1]
else:
	INTERFACE = 'eth0'
STATS = []

class Pcinfo(object):
    def __init__(self,ip="",memory="",hostname="",cpuphysicalnum="",disktotal="",cpu_total="",cpu_core_num="",net_width=None):
        self.ip = ip
        self.cpuphysicalnum = cpuphysicalnum
        self.disktotal = disktotal
        self.memory = memory
        self.hostname = hostname
        self.cpu_total = cpu_total
        self.cpu_core_num = cpu_core_num
        self.net_width = net_width


    ''' 获取 ifconfig 命令的输出 '''
    def __getIfconfig__(self):
        p = Popen(['ifconfig'], stdout=PIPE)
        data = p.stdout.read()
        return data

    ''' 根据空行分段落 返回段落列表'''
    def __parseData__(self, data):
        parsed_data = []
        new_line = ''
        data = [i for i in data.split('\n') if i]
        for line in data:
            if line[0].strip():
                parsed_data.append(new_line)
                new_line = line + '\n'
            else:
                new_line += line + '\n'
        parsed_data.append(new_line)
        return [i for i in parsed_data if i]

    ''' 根据输入的段落数据分析出ifconfig的每个网卡ip信息 '''
    def __parseIfconfig__(self,parsed_data):
        dic = {}
        parsed_data = [i for i in parsed_data if not (i.startswith('Io') or i.startswith('docker0'))]
        for lines in parsed_data:
            line_list = lines.split('\n')
            devname = line_list[0].split()[0]
            macaddr = line_list[0].split()[-1]
            ipaddr = line_list[1].split()[1].split(':')[1]
            break
        dic['ip'] = ipaddr
        return dic

    ''' 获取ip'''
    def getIp (self):
        data_ip = self.__getIfconfig__()
        parsed_data_ip = self.__parseData__(data_ip)
        self.ip = self.__parseIfconfig__(parsed_data_ip)
        return  self.ip

    ''' 获取网卡'''
    def get_netcard(self):
        netcard_info = []
        info = psutil.net_if_addrs()
        for k, v in info.items():
            for item in v:
                if item[0] == 2 and not item[1] == '127.0.0.1':
                    netcard_info.append((k, item[1]))
        return netcard_info

    ''' 获取Linux系统的总物理内存 '''
    def getMemory(self):
        with open('/proc/meminfo') as fd:
            for line in fd:
                if line.startswith('MemTotal'):
                    mem = int(line.split()[1].strip())
                    break
        mem = '%.f' % (mem / 1024.0) + ' MB'
        self.memory = {'memory': mem}
        return self.memory
    '''Linux系统内存使用百分比'''
    def meminfo(self):
        '''
         Return the information in /proc/meminfo
         as a dictionary
        '''
        meminfo = OrderedDict()

        with open('/proc/meminfo') as f:
            for line in f:
                meminfo[line.split(':')[0]] = line.split(':')[1].strip()
        memTotal = meminfo['MemTotal']
        memFree  = meminfo['MemFree']
        percent = memFree/memTotal
        return percent

    ''' 获取Linux系统主机名称 '''
    def getHostname(self):
        file = os.popen('hostname')
        hostname = file.read()
        self.hostname = {'hostname':hostname}
        return self.hostname

    ''' 物理CPU个数'''
    def getCPUPhysicalNum(self):
        num = psutil.cpu_count(logical=False)
        print "cpuNUM----:",num
        self.cpuphysicalnum = {'cpuphysicalnum':num}
        return self.cpuphysicalnum

    ''' 获取每个磁盘大小'''
    def getDiskTotal(self):
        totals = ''
        # print psutil.disk_partitions()
        for disk in psutil.disk_partitions():
            if not disk.fstype  == '':
                totals = totals + "disk_name:" + disk.device + "--totals:" + str(
                    (int(psutil.disk_usage(disk.mountpoint).total / 1024 / 1024 / 1024))) + "GB |"
        self.disktotal = {"disktotal":totals}
        return self.disktotal

    ''' 获取CPU的型号和CPU的核心数 '''
    def getCpuTotal(self):
        cput = {}
        num = 0
        cpu_total = ''
        with open('/proc/cpuinfo') as fd:
            for line in fd:
                if line.startswith('processor'):
                    num += 1
                if line.startswith('cpu MHz'):
                    cpu_total_list = line.split(':')[1].strip().split()
                    cpu_total = str((float(cpu_total_list[0])/1000)) + 'GHz'
        self.cpu_core_num = {'cpu_core_num': 'null'}
        self.cpu_total = {'cpu_total': cpu_total}
        cput.update(self.cpu_core_num )
        cput.update(self.cpu_total)
        return cput

    def monitor_network(self):
        time.sleep(1)
        rxstat_o = list(STATS)
        self.rx()
        self.tx()
        RX = float(STATS[0])
        print "RX", RX
        RX_O = rxstat_o[0]
        print "RX_0", RX_O
        TX = float(STATS[1])
        print "TX", TX
        TX_O = rxstat_o[1]
        print "TX_o", TX_O
        RX_RATE = round((RX - RX_O) / 1024 / 1024, 3)
        TX_RATE = round((TX - TX_O) / 1024 / 1024, 3)
        print RX_RATE, 'MB		', TX_RATE, 'MB'
        infdic = {"uploadBytes": RX_RATE, "downloadBytes": TX_RATE}
        self.net_width = {"net_width": str(infdic)}
        return self.net_width

    def rx(self):
        ifstat = open('/proc/net/dev').readlines()
        for interface in ifstat:
            if INTERFACE in interface:
                stat = float(interface.split()[1])
                STATS[0:] = [stat]

    def tx(self):
        ifstat = open('/proc/net/dev').readlines()
        for interface in ifstat:
            if INTERFACE in interface:
                stat = float(interface.split()[9])
                STATS[1:] = [stat]

    '''所有的静态信息 '''
    def get_static_pc_info(self):
        print "start find pc info----------------***********------------"
        dic = {}
        self.getIp()
        self.getCPUPhysicalNum()
        self.getDiskTotal()
        self.getMemory()
        self.getCpuTotal()
        self.getHostname()
        dic.update(self.ip)
        dic.update(self.memory)
        dic.update(self.hostname)
        dic.update(self.cpuphysicalnum)
        dic.update(self.disktotal)
        dic.update(self.cpu_total)
        dic.update(self.cpu_core_num)
        return dic

    '''持续上线时间'''
    def getOnlineTime(self):
        timetool = Time_Tool()
        time1 = timetool.formatTime(psutil.boot_time())
        time2 = timetool.formatTime(time.time())
        online_time =  str((timetool.caltime(time1, time2)))
        self.onlinetime = {"onlinetime":online_time}
        return self.onlinetime

    '''负载均值load average w或者uptime都可以直接展示负载 输出4个值 前三个是1、5、15分钟的平均进程数，第四个当前进行数'''
    def getLoadavg(self):
        file = os.popen("cat /proc/loadavg")
        f_loadavg = file.read()
        loadavgarr = f_loadavg.split(' ')
        loadavg =  loadavgarr[0] + " "+loadavgarr[1]+ " "+loadavgarr[2]+ " "+loadavgarr[3]
        self.loadavg = {"loadavg":loadavg}
        return self.loadavg

    '''获取memory使用率'''
    def getMemorystate(self):
        phymem = psutil.virtual_memory()
        line = "Memory: %5s%% %6s/%s" % (
            phymem.percent,
            str(int(phymem.used / 1024 / 1024)) + "M",
            str(int(phymem.total / 1024 / 1024)) + "M"
        )
        self.memoryRate = {'memory': line}
        return self.memoryRate

    '''获取cpu使用率'''
    def getCpuRate(self):
        cpuRate = (str)(psutil.cpu_percent(interval=0))
        self.cpuRate = {'cpuRate': cpuRate}
        return self.cpuRate

    '''IO  %util delta(use)'''
    def getio(self):
        p = Popen('iostat -x',shell=True, stdout=PIPE)
        data = p.stdout.read()
        parsed_data = self.__parseData__(data)
        dicArr = []
        pasedata = []
        index =0
        for i in parsed_data:
            index = index +1
            if (index > 3):
                pasedata.append(i)
        parsed_data =pasedata
        # parsed_data = [i for i in parsed_data  if not (i.startswith('Io') or i.startswith('docker0'))]
        for lines in parsed_data:
            iodict = {}
            line_list = lines.split('\n')
            print line_list,"llllllllllllllllllllll"
            device = line_list[0].split()[0]
            rkB_s = line_list[0].split()[5]
            wkB_s = line_list[0].split()[6]
            avgrq_sz = line_list[0].split()[7]
            await = line_list[0].split()[9]
            r_await =line_list[0].split()[10]
            util =line_list[0].split()[-1]
            iodict['device'] = device
            iodict['rkB_s'] = rkB_s
            iodict['wkB_s'] = wkB_s
            iodict['avgrq_sz'] = avgrq_sz
            iodict['await'] = await
            iodict['r_await'] = r_await
            iodict['util'] = util
            dicArr.append(iodict)
        self.io = {"io":str(dicArr)}
        return self.io


    '''所有的动态信息 '''
    def get_dynamic_pc_info(self):
        print "start find get_dynamic_pc_info info----------------***********------------"
        dic = {}
        self.getIp()
        self.getMemorystate()
        self.getCpuRate()
        self.getio()
        self.getOnlineTime()
        self.getLoadavg()
        self.monitor_network()
        self.getHostname()
        dic.update(self.ip)
        dic.update(self.memoryRate)
        dic.update(self.cpuRate)
        dic.update(self.io)
        dic.update(self.onlinetime)
        dic.update(self.loadavg)
        dic.update(self.net_width)
        dic.update(self.hostname)
        return dic

    def getPidListByProcessName(self, processName):
        """
        根据进程关键字获取PID
        :param processName:
        :return:
        """
        cmd = "ps aux| grep '%s'|grep -v grep " % processName
        out = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
        infos = out.stdout.read().splitlines()
        pidlist = []
        if len(infos) >= 1:
            for i in infos:
                pid = i.split()[1]
                if pid not in pidlist:
                    pidlist.append(pid)
        return pidlist


# 定时刷新静态数据库
def staticPcInfo():
    pcinfo = Pcinfo()
    pcinf = pcinfo.get_static_pc_info()
    pcinfoDao = PcInfoDao()
    try:
        pcinf["deployment"] = str(pcinfoDao.getDeployment(pcinf["ip"]).deployment)
    except  Exception,e:
        logging.error('you need to insert t_pc_deployment table your server ipinfo')
    pcinf["log_url"] = '/var/log/messages'
    pcinfoDao.staticUpdateOrAdd({"ip":pcinf["ip"],"memory":pcinf["memory"],"hostname":pcinf["hostname"],"cpuphysicalnum":pcinf["cpuphysicalnum"],"disktotal":pcinf["disktotal"],
                     "cpu_total":pcinf["cpu_total"],"cpu_core_num":pcinf["cpu_core_num"],"deployment":pcinf["deployment"],"status":"0",
                     "log_url":pcinf["log_url"]})

#定时添加动态数据库
def dynamicPcInfo():
    print    'In			Out'
    pcinfo = Pcinfo()
    pcinfo.rx()
    pcinfo.tx()
    ip = pcinfo.getIp()
    pcinfoDao = PcInfoDao()
    pc = pcinfoDao.getStaticByIp(ip['ip'])
    status = pcinfoDao.getNodeMonitorStatus(ip['ip'])
    if pc:
        pcinf = pcinfo.get_dynamic_pc_info()
        pcinf["assetId"] = pc.assetId
        pcinfoDao.dynamicAssetAdd({"assetId":pcinf["assetId"],"ip":pcinf["ip"],"memory":pcinf["memory"],"cpu":pcinf["cpuRate"],"io":pcinf["io"],
                     "online_time":pcinf["onlinetime"],"loadavg":pcinf["loadavg"],"net_width":pcinf["net_width"],"hostname":pcinf["hostname"],"status":status})
    else:
        staticPcInfo()
        dynamicPcInfo()

if __name__ == '__main__':
    # 定时启动任务
    # staticPcInfo()
    print "tst"
    # pcinfo = Pcinfo()
    # dynamicPcInfo()
    # monitor_network()
    # print pcinfo.getOnlineTime()
    # dic = pcinfo.get_static_pc_info()
    # print pcinfo.getCPUPhysicalNum()
    # print pcinfo.get_netcard()




    # print pcinf["ip"]
    # ''' 将获取到的所有数据信息并按简单格式对齐显示 '''
    # for k, v in pcinfo.getpcinfo().items():
    #     print '%-10s:%s' % (k, v)
    # ''' 将获取进行入库 '''
    # urlConfig = storageshell.Storage(pcinf["ip"],pcinf["memory"],pcinf["hostname"])
    # try:
    #     urlConfig.queryContent(pcinf["ip"]).hostname
    #     urlConfig.update(pcinf["ip"],{"memory":pcinf["memory"],"hostname":pcinf["hostname"]})
    #     print "update success"
    # except Exception :
    #     urlConfig.add()
    #     print "add success"
    #定时启动任务

    # data_ip = getIfconfig()
    # parsed_data_ip = parseData(data_ip)
    # ip = parseIfconfig(parsed_data_ip)
    #
    # data_dmi = getDmi()
    # parsed_data_dmi = parseData(data_dmi)
    # dmi = parseDmi(parsed_data_dmi)
    #
    # hostname = getHostname()
    # # osver = getOsVersion()
    # cpu = getCpu()
    # mem = getMemory()

    # dic.update(ip)
    # dic.update(dmi)
    # dic.update(hostname)
    # dic.update(osver)
    # dic.update(cpu)
    # dic.update(mem)




