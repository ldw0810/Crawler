/**
 * Created by 520cloud on 2017-07-17.
 */
String.prototype.format = function(){
    var result = this.toString()//arguments[0]||"";
    if(arguments.length>0){
        var reg = new RegExp(/%s/g),//替换%s正则
            data = result,
            array = data.match(reg),
            rel = null;
        if(array){
            rel = data.split("%s");
            for(var i = 0,length = array.length;i<length;i++){
                rel.splice(i*2 + 1,0,arguments[i]||"%s");
            }
            result = rel.join("");
        }
    }
    return result;
};
(function(window){
    // var xpath="[a-zA-Z]+\[[a-zA-Z-]+\=[\"\']+[][\"\']+\]"
    var load=window.onload,docMap={};
    window.onload=function() {
        load();
    }
    function loadXPath(xpath,doc){
        var nodes=document.evaluate(xpath,doc||document.documentElement,null,XPathResult.ANY_TYPE),
            nodeArray=[];
        // var node=nodes.iterateNext()
        var node=null;
        while(node=nodes.iterateNext(),node){
            nodeArray.push(node)
        }
        return nodeArray;
    }

    function Xpath(){
        this.pathArray=[];
        this.__currentNode=null;
    }
    Xpath.prototype={
        //xpath路径信息
        pathArray:[],
        //当前选中节点信息
        nodeinfo:null,
        add:function(obj){
            if(obj instanceof Array){
                this.pathArray=obj.concat(this.pathArray)
            }else {
                this.pathArray.push(obj)
            }
        },
        setCurrentNode:function(node){
            this.__currentNode=node
        },
        getCurrentNode:function(){
            return this.__currentNode;
        },
        setParent:function (parent) {
            this.__parent=parent;
        },
        remove:function(index){
            this.pathArray.slice(index,1)
        },
        toString:function(){
            var result=""
            if(this.__parent){
                result+=this.__parent.toString();
            }else{
                result+="/";
            }
            for(var i=0;i<this.pathArray.length;i++){
                var obj=this.pathArray[i],
                    prop=obj.prop.toLocaleLowerCase(),
                    value=obj.value,
                    tag=obj.tag.toLocaleLowerCase();
                result+="/"+tag+"[@"+prop+"='"+value+"']";
            }
            return result;
        }
    }
    var ignoreAttr=["href","src","style","target","undefined"],defaultLevel=10,
        list_tag=["ul","tr"];
    //
    function closestDom(node,tagName,level) {
        var parent=node.parentElement,
            level=typeof level=="undefined"?defaultLevel:level;
        if(parent==null){
            return null;
        }
        if(parent.tagName.toLocaleLowerCase()==tagName && level>=0){
            return parent;
        }else{
            return closestDom(parent,tagName,level-1);
        }
    }

    //找出可能的列表元素
    function findList(node) {
        var result=null;
        list_tag.every(function(col){
            result=closestDom(node,col)
            if(result){
                return false;
            }
        })
        return result;
    }
    //获取目标xpath
    function getXpath(node,p) {
         var result=[],
             xpath=new Xpath();
             p=p || document;
        var tag=node.tagName,
            attributes=node.attributes,attrMap={};
        xpath.setCurrentNode(node);
        for(var key in attributes){
            var prop=attributes[key],
                nodeName=prop.nodeName,
                nodeValue=prop.nodeValue;
            if(ignoreAttr.indexOf(nodeName)!=-1 || !tag ||!nodeName||!nodeValue || nodeValue.startsWith("http://") || typeof nodeValue=="undefined" || typeof nodeName=="undefined" ||typeof nodeValue=="undefined"){
                continue
            }
            var nodes=p.querySelectorAll("%s[%s='%s']".format(tag,nodeName,nodeValue))
            attrMap[nodeName]=nodeValue
            xpath.add({prop:nodeName,tag:tag,value:nodeValue})
            if(nodes.length==1){
                return xpath;
            }else if(nodes.length>1){
                var parentElement=node.parentElement;
                var pXpath=getXpath(parentElement)
                xpath.setParent(pXpath)
                break;
            }
        }
        return xpath;
    }
    window._ui={
        // init:init,
        getXpath:getXpath,
        findList:findList,
        $x:loadXPath
    };
})(window)