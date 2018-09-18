function validform() {
    return jQuery("#form-url-add").validate({
        rules: {
            paramNameCn: {
                required: true
            },
            paramNameEn: {
                required: true
            },
            paramValue: {
                required: true
            },
            nextParamValue: {
                required: true
            },
            paramCondition: {
                required: true
            }
        }
    });
}

$("#saveBtn").click(function () {
   if (validform().form()){
       var jobTemplateId = $("#jobTemplateId").val();
        var paramNameCn = $("#paramNameCn").val();
       var paramNameEn = $("#paramNameEn").val();
       var paramValue = $("#paramValue").val();
       var nextParamValue = $("#nextParamValue").val();
       var paramCondition = $("#paramCondition").val();
       var rex = /"/g;
       paramCondition = paramCondition.replace(rex,'/"');
       nextParamValue = nextParamValue.replace(rex,'/"');
       paramValue = paramValue.replace(rex,'/"');
       var content={paramNameCn:paramNameCn,paramNameEn:paramNameEn,paramValue:paramValue,nextParamValue:nextParamValue,paramCondition:paramCondition,jobTemplateId:jobTemplateId}
       var data = {
            type:"1",
            param: content,
            action:"0"
        };
        ajaxFunction("/templateMgmt","POST","JSON","application/json,charset=utf8",data,success,error);
    }
})

/**序列化后的数据转换为json格式**/
function formToJson(str) {
            str=str.replace(/&/g,"\",\"");
            str=str.replace(/=/g,"\":\"");
            str="{\""+str+"\"}";
            str=eval('('+str+')');
             return str;
 }

function success(){
    window.location.href = "/developer/template/list.html?1";
    layer_close();
}
function error(){
    layer.msg('输入有误!', {icon: 5, time: 2000});
}

$("#cancel").click(function () {
    layer_close();
    window.location.href = "/developer/template/list.html?1";
})
/***获取模板名称*/
function getTemplate(){
    var param = {"action": "0","pageNo": 1,"pageSize": 1000};
    ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", param, get_success, get_error);
}
function get_success(resp){
    var data=resp.result.jobTemplateList;
    for(var i = 0;i<data.length;i++){
         $("#jobTemplateId").append( "<option value="+data[i].id+
            ">"+data[i].name+
            "</option>"
        )
    }
}
function get_error(){

}
$(function(){
    getTemplate();
})


