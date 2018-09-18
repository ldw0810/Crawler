#coding=utf-8
#Created by xutao on 2017-04-15.
import re

exprPattern=re.compile("\{([^,:\"{]+)\}")
def match(originStr):
    return True if exprPattern.match(originStr)!=None else False;
def render(originStr,paramDict,defaultValue=""):
    result=originStr
    if originStr==None:
        return None
    try:
        matches = re.findall(exprPattern, originStr);
        for key in matches:
            value=paramDict[key] if paramDict.has_key(key) else defaultValue
            result=result.replace("{"+key+"}",str(value))
    except Exception,e:
        pass
    return result;
if __name__=="__main__":
    # matches=re.findall(exprPattern,"asdasd{name}(asdasd){asdasd}{asdasd}");
    # print matches
    print match("123}")
