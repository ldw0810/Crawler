# from dao.PcInfoDao import PcInfoDao
# from web.PcInfoApi import start
from service.h_pc.getpcinfo import Pcinfo

if __name__=="__main__":
    # pc = PcInfoDao()
    # pc.staticUpdateOrAdd({"ip": "4", "memory": "444", "hostname": "444", "cpuphysicalnum": "4", "disktotal": "4",
    #                       "cpu_total": "4", "cpu_core_num": "4", "deployment": "4", "status": "4",
    #                       "log_url": "4"})
    #-----------------------------
    # start()
    pcinfo = Pcinfo()
    pcinfo.getio()