/**
 * Created by 520cloud on 2017-06-27.
 */
XMLHttpRequest.prototype.o_open=XMLHttpRequest.prototype.open;
XMLHttpRequest.prototype.open=function(type,url,flag){
    this.o_open(type,'/testApp/loadUrl?url='+encodeURIComponent(url),flag);
};
var lastElement=null,className=null;
function getTop(e){
var offset=e.offsetTop;
if(e.offsetParent!=null) offset+=getTop(e.offsetParent);
return offset;
}
//获取元素的横坐标（相对于窗口）
function getLeft(e){
var offset=e.offsetLeft;
if(e.offsetParent!=null) offset+=getLeft(e.offsetParent);
return offset;
}
var _hoverDiv=null;
window.__defineGetter__("hoverDiv",function () {
    if(!_hoverDiv){
        _hoverDiv=document.getElementById("ui-see-hover")
    }
    return _hoverDiv;
})
var moveFlag=false;
function hoverClass(e){
    if(hoverDiv){
        moveFlag=true;
        var left=getLeft(e),top=getTop(e);
        hoverDiv.style.display="block"
        hoverDiv.style.left=left+"px";
        hoverDiv.style.top=top+"px";
        hoverDiv.style.width=e.clientWidth+"px"; //获取元素的宽度
        hoverDiv.style.height=e.clientHeight+"px";
        // console.log(_.getXpath(e)+"")
        var listNode=_ui.findList(e),result=null,currentNodeXpath=_ui.getXpath(e),result="";
        if(listNode){
            result=_ui.getXpath(listNode)
        }
        if(currentNodeXpath){
            node=currentNodeXpath.getCurrentNode();
            for(var i=0;i<node.attributes.length;i++){
                var prop=node.attributes[i],
                    nodeName=prop.nodeName,
                    nodeValue=prop.nodeValue;
                result+="<p>%s:%s</p>".format(nodeName,nodeValue)
            }
        }
        // console.log("===="+$x);
        parent.clear()
        parent.showInfo("当前元素xpath:"+currentNodeXpath);
        parent.showInfo("<div>可能的列表元素:"+result+"</div>")
        parent.showInfo(result)

    }
    event.stopPropagation();
    event.preventDefault();
}
function bindOnHover(){
    var elements=document.querySelectorAll("a,button,input,div:not(#ui-see-hover),span,img,b");//
    for(var i=0;i<elements.length;i++){
        var el=elements[i];
        el.onclick=(function(e){
            return function(){
                hoverClass(e)
            }
        })(el);
        el.onmouseover=(function(e){
            return function(event){
                hoverClass(e)
            }
        })(el)
    }
}
document.addEventListener('DOMNodeInserted',bindOnHover,false);
document.addEventListener('DOMAttrModified',bindOnHover,false);
document.addEventListener('DOMNodeRemoved',bindOnHover,false);
function bindRightClick(){
    var body=document.getElementsByTagName("body")[0]
    function rightMouse(event) {
        if(hoverDiv && event.button==0){
            hoverDiv.style.display="none";
             event.stopPropagation();
             event.preventDefault();
             return;
        }
    }
    body.onmousedown=rightMouse
    body.onmouseup=function () {
         if(hoverDiv && event.button==0){
             event.stopPropagation();
             event.preventDefault();
             return;
        }
    }
}
window.onload=function(){
    _hoverDiv=document.getElementById("ui-see-hover")
    if(!_hoverDiv){
        _hoverDiv=document.createElement("div");
        _hoverDiv.id='ui-see-hover';
        _hoverDiv.className='ui-see-hover';
        var body=document.getElementsByTagName("body")[0];
        body.appendChild(_hoverDiv)
    }
    bindOnHover();
    bindRightClick();
    var jobTemplateFieldList=templateInfo.jobTemplateFieldList,
        jobTemplate=templateInfo.jobTemplate,
        rootPath=jobTemplate.rootPath;
    parent.appendChildJobTemplate(templateInfo.childJobTemplateList)
    jobTemplateFieldList.forEach(function(jobTemplateField){
        var fieldValue=jobTemplateField.fieldValue.replace(/[/]{0,2}@[^/]+$/,"").replace(/[/]{0,2}[^/]+\(\)$/,""),
            fieldNameEn=jobTemplateField.fieldNameEn;
        var fieldValueOrigin=rootPath&&!fieldValue.startsWith("//")?(fieldValue?(rootPath+"/"+fieldValue):rootPath):fieldValue;
        var fieldList=null;
        try{
           fieldList =_ui.$x(fieldValueOrigin);
        }catch(e){
            alert("%s:%s[%s]".format(fieldNameEn,fieldValue,e))
        }
        var originPathStr=rootPath&&!fieldValue.startsWith("//")?(jobTemplateField.fieldValue?(rootPath+"/"+jobTemplateField.fieldValue):rootPath):jobTemplateField.fieldValue;
        var text=_ui.$x(originPathStr);
        // text=text.replace(/<[^<>]+>/g,"");
       if(text && text.length>0){
           if (Object.prototype.toString.call(text[0])=="[object Attr]"){
                text=text[0].value;
            }else if (Object.prototype.toString.call(text[0])=="[object Text]"){
                text=text[0].textContent;
            }else {
                text=text[0]
           }
       }else{
            text=""
       }

        parent.appendParam(fieldNameEn,text+"##"+JSON.stringify(jobTemplateField))
        fieldList.forEach(function(field){
            field.style.backgroundColor="red";
            field.style.opacity=0.5;
            var doc=document.createElement("div");
            doc.style.backgroundColor="red";
            doc.innerHTML="选中标签";
            field.prepend(doc);
        })

    });
    for(var i=0;i<jobTemplateFieldList.length;i++){

    }
    // loadXpathNodes(document,"//div[@class='ui-see-hover']")
}