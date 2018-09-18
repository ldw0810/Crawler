import urllib2
from threading import Timer
from service.h_pc.getpcinfo import Pcinfo

def getIp():
    pc = Pcinfo()
    pc.getIp()
    return pc['ip']

def requsetpc ():
    # ip = '172.21.14.35'
    ip = getIp()
    url = "http://10.128.100.105:7879/pcHeartBeat?ip=" + ip
    req = urllib2.Request(url)
    res_data = urllib2.urlopen(req)
    res = res_data.read()
    print res

def timeHeartBeat():
    requsetpc()
    SHELLTIME = 15
    Timer(SHELLTIME, timeHeartBeat).start()
if __name__=="__main__":
    timeHeartBeat()