from threading import Timer
from service.h_pc.getpcinfo import staticPcInfo,dynamicPcInfo

def runstaticPcInfo ():
    staticPcInfo()
    SHELLTIME = 300
    Timer(SHELLTIME, runstaticPcInfo).start()

def rundynamicPcInfo ():
    dynamicPcInfo()
    SHELLTIME = 300
    Timer(SHELLTIME, rundynamicPcInfo).start()

def start():
    runstaticPcInfo()
    rundynamicPcInfo()
if __name__=="__main__":
    start()
