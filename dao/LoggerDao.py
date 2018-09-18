#coding=utf-8
#Created by xutao on 2017-04-28.
import uuid
from datetime import datetime

from sqlalchemy import text

from beans.LoggerTable import LogInfo
from beans.TaskTable import TaskJobHistory, TaskJob
from beans.TemplateTable import JobTemplate
from dao import BaseDao
from dao.BaseDao import with_session, Page, Session


class LoggerType():
    ADD="101"
    DEL="102"
    MOD="103"
    START="104"
    STOP="105"
    URL_TO_REDIS="106"
    CRAWLER_URL_RESPONSE="107"
    END="107"
@with_session
def getLogList(id,pageNo=1,pageSize=10):
    # sql=text("select * from task_job_history where task_job_id='%s' and del_flag=0 order by create_time desc limit"%(taskJobId))
    return BaseDao.getPageResult(page=Page(pageNo,pageSize),paramMap={"taskJobHistoryId":id},
                                 clzz=[LogInfo,JobTemplate],join=[JobTemplate,JobTemplate.id==LogInfo.jobTemplateId])
@with_session
def getTaskJobHistory(taskJobId,pageNo=1,pageSize=10):
    return BaseDao.getPageResult(page=Page(pageNo,pageSize),paramMap={"taskJobId":taskJobId},clzz=[TaskJobHistory])
@with_session
def addTaskJobLogger(taskJob=None,type=LoggerType.ADD,userId=None,jobTemplateId=None,taskJobHistoryId=None,content='',url=None,status=None):
    logInfo=LogInfo()
    logInfo.id=uuid.uuid1()
    logInfo.objectId=taskJob.id
    logInfo.delFlag=False
    logInfo.createTime=datetime.now()
    logInfo.url=url
    logInfo.userId=userId or taskJob.createUserId
    logInfo.content=u"[taskJobId:%s][type:%s][userId:%s][taskJobStatus:%s]" \
                    u"[content:%s][jobTemplateId:%s][taskJobHistoryId:%s]"%(taskJob.id,type,userId,taskJob.status,content,jobTemplateId,taskJobHistoryId)
    logInfo.type=type
    logInfo.jobTemplateId=jobTemplateId
    logInfo.taskJobHistoryId=taskJobHistoryId
    logInfo.status=status
    return BaseDao.add(logInfo)

if __name__=="__main__":
    print getTaskJobHistory("cbce6400-407d-11e7-8890-a575af0cccbb")
    print getLogList("7278ac21-40ec-11e7-a3c2-e09467f6dff0")