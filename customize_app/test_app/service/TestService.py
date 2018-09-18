#coding=utf-8
#Created by xutao on 2017-06-28.
from beans.TemplateTable import JobTemplate, JobTemplateParam, JobTemplateField
from dao.BaseDao import Session
from service import CrawlerService
from utils import JsonUtils
from utils import RenderUtils
from utils import ResponseUtils


def parseTemplate(id,paramMap={},flag=True):
    jobTemplate=Session.query(JobTemplate).filter(JobTemplate.id==id,JobTemplate.delFlag==False).first()
    url=jobTemplate.url
    jobTemplateParamList=Session.query(JobTemplateParam).filter(JobTemplateParam.jobTemplateId==id,JobTemplateParam.delFlag==False).all()
    jobTemplateFieldList=Session.query(JobTemplateField).filter(JobTemplateField.jobTemplateId==id,JobTemplateField.delFlag==False).all()
    paramList=None;
    renderUrl=None;
    if(flag):
        paramList=CrawlerService.paraseJobTemplateList(jobTemplateParamList or [],paramMap=paramMap,loopFlag=True)
        renderUrl=RenderUtils.render(url,paramList and paramList[0]);
    return{
        "jobTemplate":jobTemplate,
        "renderUrl":renderUrl,
        "jobTemplateFieldList":jobTemplateFieldList,
        "childJobTemplateList":Session.query(JobTemplate).filter(JobTemplate.delFlag==False,JobTemplate.parentId==jobTemplate.id).all()
    }