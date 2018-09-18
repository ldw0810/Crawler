var id =location.search.substr(4);
var str="&id="+id;
/***页面展示默认数据**/
function ajaxdata(){
     var id =location.search.substr(4);
    var data={
        id:id,
        type:6
    };
    ajaxFunction("/contentDetail","POST", "JSON", "application/ json,charset=utf8", data,ajax_success,ajax_error);
}
function ajax_success(resp){
    console.log('success');
    console.log(resp);
      var data = resp.jobTemlateField;
    $("#fieldNameEn").val(data.fieldNameEn);
     $('#jobTemplateId').val(data.jobTemplateId);
     $("#dataType").val(data.dataType);
    $("#dataLength").val(data.dataLength);
    $("#fieldValue").val(data.fieldValue);
    $("#fieldNameCn").val(data.fieldNameCn);
    $("#regExp").val(data.regExp);
    $("#split").val(data.split);
    $("#func").val(data.func);

}
function ajax_error(){

}
function validform() {
    return jQuery("#form-url-add").validate({
        rules: {
            jobTemplateId: {
                required: true
            },
            dataType: {
                required: true
            },
            dataLength: {
                required: true,
                isInteger: true
            },
            fieldValue: {
                required: true
            },
            fieldNameEn: {
                required: true
            },
            fieldNameCn:{
                required: true
            }
        }
    });
}


$("#saveBtn").click(function () {
    if (validform().form()){
        var fieldValue = $("#fieldValue").val();
        var rex = /"/g;
        var fieldNameCn = $("#fieldNameCn").val();
        var fieldNameEn = $("#fieldNameEn").val();
        var dataLength = $("#dataLength").val();
        var dataType = $("#dataType").val();
        var jobTemplateId = $("#jobTemplateId").val();
        var func = $("#func").val();
        var regExp = $("#regExp").val();
        var split = $("#split").val();
        /*var content = "jobTemplateId="+jobTemplateId+"&dataType="+dataType+"&dataLength="+dataLength+"&fieldValue="+fieldValue+"&fieldNameEn="+fieldNameEn+"&fieldNameCn="+fieldNameCn+"&func="+
                        func+"&regExp="+regExp+"&split="+split+str;*/
        fieldValue = fieldValue.replace(rex,'/"');
        func =  func.replace(rex,'/"');
        regExp = regExp.replace(rex,'/"');
        split = split.replace(rex,'/"');
        var content = {jobTemplateId:jobTemplateId,
                            dataType:dataType,
                            dataLength:dataLength,
                            fieldValue:fieldValue,
            fieldNameEn:fieldNameEn,fieldNameCn:fieldNameCn,func:func,regExp:regExp,split:split,id:id

        };
        var data = {
            type:"2",
            field:content,
            action:"2"
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

$("#cancel_field").click(function () {
    layer_close();
    window.location.href = "/developer/template/list.html?1";
})
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
    ajaxdata();
     getTemplate();

})

