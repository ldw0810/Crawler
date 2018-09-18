#coding=utf-8
from lxml import etree
def getData(data,path):
    while((type(data)==list) and len(data)>0):
        data = data[0]
    tempData = data.xpath(path)
    if((type(tempData)==list) and len(tempData)>0):
        result = tempData[0]
        if(type(result)==etree._Element):
            return result.text;
        return tempData[0];
def getJSONData(data,field_exp):
    result = data;
    if field_exp==".":
        return result;
    field_exps = field_exp.split(".")
    for  key in field_exps:
        result = result[key]
    return result
def getRootXPath(data,field_exp):
    return data.xpath(field_exp)
def getXpathData(data,field_exp):
    return data.xpath(field_exp).extract()

