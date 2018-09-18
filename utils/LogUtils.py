# -*- coding:utf-8 -*-
# author:mdc date:2017-08-03
import logging
import psutil
import subprocess
import sys
import os,os.path
import datetime
from logging.handlers import RotatingFileHandler
from logging import FileHandler
import re,time
import ConfigUtils
"""
Example format of generated bson document:
{
    'thread': -1216977216,
    'threadName': 'MainThread',
    'level': 'ERROR',
    'timestamp': Timestamp(1290895671, 63),
    'message': 'test message',
    'module': 'test_module',
    'fileName': '/var/projects/python/log4mongo-python/tests/test_handlers.py',
    'lineNumber': 38,
    'method': 'test_emit_exception',
    'loggerName':  'testLogger',
    'exception': {
        'stackTrace': 'Traceback (most recent call last):
                       File "/var/projects/python/log4mongo-python/tests/test_handlers.py", line 36, in test_emit_exception
                       raise Exception(\'exc1\')
                       Exception: exc1',
        'message': 'exc1',
        'code': 0
    }
}
"""
class LoggingFormatter(logging.Formatter):

    DEFAULT_PROPERTIES = logging.LogRecord('', '', '', '', '', '', '', '').__dict__.keys()

    def __init__(self, fmt=None, datefmt=None,filename=None):
        self.filename = filename
        self._fmt = '%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s'
        self.datefmt = datefmt
    # def format(self, record):

    #     """Formats LogRecord into python dictionary."""
    #     # Standard document
    #     try:
    #         pid = self.getPid(self.filename)
    #     except Exception,e:
    #         pid = ""
    #     document = {
    #         'timestamp': record.asctime,
    #         'level': record.levelname,
    #         'loggerName': record.name,
    #         'fileName': record.pathname,
    #         "Instance":str(pid),
    #         'module': record.module,
    #         'method': record.funcName,
    #         'lineNumber': record.lineno,
    #         'Node':self.getHostname(),
    #         "subsystem":"Crawler",
    #         'logInfo': record.getMessage(),
    #     }
    #     # Standard document decorated with exception info
    #     if record.exc_info is not None:
    #         document.update({
    #             'exception': {
    #                 'message': str(record.exc_info[1]),
    #                 'code': 0,
    #                 'stackTrace': self.formatException(record.exc_info)
    #             }
    #         })
    #
    #     if len(self.DEFAULT_PROPERTIES) != len(record.__dict__):
    #         contextual_extra = set(record.__dict__).difference(set(self.DEFAULT_PROPERTIES))
    #         if contextual_extra:
    #             for key in contextual_extra:
    #                 document[key] = record.__dict__[key]
    #     return document

    # @staticmethod
    def getPid(self,process):
        """
        根据进程关键字获取PID
        :param process:
        :return:
        """
        cmd = "ps aux| grep '%s'|grep -v grep " % process
        # logging.info(cmd)
        out = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
        infos = out.stdout.read().splitlines()
        pidlist = []
        if len(infos) >= 1:
            for i in infos:
                pid = i.split()[1]
                if pid not in pidlist:
                    pidlist.append(pid)
            return pidlist
        else:
            return -1

    ''' 获取Linux系统主机名称 '''
    def getHostname(self):
        file = os.popen('hostname')
        self.hostname = file.read()
        if not self.hostname:
            self.hostname = ""
        return self.hostname


class LoggingHandle(FileHandler):
    def __init__(self, filefmt=None):

        _filefmt = os.path.join("logs", "%Y%m%d.log")
        self.filefmt = filefmt
        if filefmt is None:
            self.filefmt = _filefmt
        logging.Handler.__init__(self)

    def emit(self, record):
        msg = self.format(record)
        _filePath = datetime.datetime.now().strftime(self.filefmt)
        filename = self.formatter.filename
        suffix = '/'+filename+'_'
        newpath = _filePath.replace('/',suffix)
        _dir = os.path.dirname(newpath)
        try:
            if os.path.exists(_dir) is False:
                os.makedirs(_dir)
        except Exception:
            print "can not make dirs"
            print "filepath is " + newpath
            pass
        try:
            global newfilepath
            if hasattr(self,'newfile'):
                newpath = self.newfile
            with open(newpath, 'a') as _fobj:
                filesize = self.get_FileSize(newpath)
                logFileSize = ConfigUtils.getWebPorperties('LogFileSize')
                if filesize < logFileSize:
                    _fobj.write(str(msg))
                    _fobj.write("\n")
                    _fobj.flush()
                    _fobj.close()
                else:
                    newFilFmt = os.path.join("logs", "%Y%m%d%H%M%S.log")
                    filePath = datetime.datetime.now().strftime(newFilFmt)
                    suffix_new = '/' + filename + '_'
                    self.newfile = filePath.replace('/', suffix_new)
                    with open(self.newfile , 'a') as _fobj:
                        _fobj.write(str(msg))
                        _fobj.write("\n")
                        _fobj.flush()
                        _fobj.close()

                # self.queryFileInDir(str(msg),filename)

        except Exception,e:
            print "can not write to file"
            print "filepath is " + newpath
            print e.message

    def get_FileSize(self, filePath):
        """
        获取文件大小
        :param filePath:
        :return:
        """
        filePath = unicode(filePath, 'utf8')
        fsize = os.path.getsize(filePath)
        fsize = fsize / float(1024 * 1024)
        return round(fsize, 2)

    #判断是不是当天的日志
    # def log_isBelongCurrentDay(self,filePath):
    #     pattern = re.compile(r'(\d+)')
    #     page = ','.join(re.search(pattern, filePath).groups())
    #     today = time.strftime('%Y%m%d', time.localtime(time.time()))
    #     try:
    #         logdayS = time.strptime(page, "%Y%m%d%H%M%S")
    #     except Exception,e:
    #         logdayS = time.strptime(page, "%Y%m%d")
    #     logday = time.strftime('%Y%m%d',logdayS)
    #     if today == logday:
    #         return True
    #     else:
    #         return False

    #查询logs下当天有没有小于60M的file 有的话 日志写入该文件 没有的话 则创建新的file
    # def queryFileInDir(self,msg,filename):
    #     filelist = self.getCurrentFile()
    #     sizelist = []
    #     ishavefile = False
    #     datafile = ''
    #     for name in filelist:
    #         filesize = self.get_FileSize(name)
    #         sizelist.append(filesize)
    #         if filesize < 60.0:
    #             ishavefile = True
    #             datafile = name
    #             break
    #     if ishavefile == True:
    #         with open(datafile, 'a') as file:
    #             file.write(str(msg))
    #             file.write("\n")
    #             file.flush()
    #             file.close()
    #     else:
    #         newFilFmt = os.path.join("logs", "%Y%m%d%H%M%S.log")
    #         filePath = datetime.datetime.now().strftime(newFilFmt)
    #         suffix_new = '/' + filename + '_'
    #         newfilepath = filePath.replace('/', suffix_new)
    #         with open(newfilepath, 'a') as file:
    #             file.write(str(msg))
    #             file.write("\n")
    #             file.flush()
    #             file.close()
        # import numpy as np
        # alist = np.array(sizelist)
        # lesslist = alist[alist<60.0]
        # ishavefile = True if lesslist else False

    #获取当天的日志文件
    # def getCurrentFile(self):
    #     filelist = os.listdir('logs')
    #     newfileList = []
    #     for name in filelist:
    #         filepath = 'logs/' + name
    #         if self.log_isBelongCurrentDay(filepath) == True:
    #             newfileList.append(filepath)
    #     return newfileList


