var searchURL = window.location.search.split("=")[1];
var param = {"id": searchURL, "type": "0"};
var data;
var self_job;
var childrenList = [];
var parent = [];

$("aside").html("");
var aside_content = '<div id="use">' +
    '<ul class="work">' +
    '<li id="menu-user5" class="checked">' +
    '<a style="text-decoration: none" onclick="window.history.go(-1);" title="返回" name="">' +
    '<i class="Hui-iconfont">&#xe6d4;</i>' +
    '<span>返回</span>' +
    '</a>' +
    '</li>' +
    '</ul>' +
    '</div>';
$("aside").append(aside_content);

ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", param, success, error);
function error(resp) {
    console.log(resp + "/fail");
}
function success(resp) {
    if(resp['result']){
         if(resp['result']["dbSourse"]){
             databaseSource =  resp['result']["dbSourse"]['type']
         }else{
             databaseSource = "--"
         }
        if(resp['result']["parent"]!= "" && resp['result']["parent"] != undefined){
            parent = resp['result']["parent"];
            showFather(parent);
        }
        if(resp['result']["brotherList"] != undefined && resp['result']["brotherList"] != ""){
            brotherList = resp['result']["brotherList"];
            showBrothers(brotherList);
        }
        if(resp['result']["childrenList"] != undefined && resp['result']["childrenList"] != ""){
            childrenList = resp['result']["childrenList"];
            showChildren(childrenList);
        }
        if(resp['result']["taskJob"]){
            self_job = resp['result']["taskJob"];
            selfDetail(self_job,databaseSource);
        }
        if(resp['result']["jobTemplateList"]){
            window.jobTemplateList = resp['result']["jobTemplateList"];
        }
    }
}
window.getJobTemplateList=function(){
    return  window.jobTemplateList
}

function ifUndefined(val) {
    if(val == undefined || val == null || val == "-1"){
        return "--";
    }else{
        return val;
    }
}
function showType(type){
    if(type == 0||type == '0'){
        return "定向"
    }else if(type == 1||type == '1'){
        return "批量"
    }else{
        return "--"
    }
}
function showGrapPeriodtype(type) {
    var str;
    if (type == 1 || type == "1") {
        str = "按次"
    } else if (type == 2 || type == "2") {
        str = "周期"
    } else {
        str = "--"
    }
    return str;
}
function showGrapInterval(type) {
    var str;
    if (type || type == 0 || type == '0') {
        str = type + "ms";
    } else {
        str = "--"
    }
    return str;
}
function showContentType(contentType){
    if(contentType == undefined){
        return "--"
    }else{
        if(contentType["name"] == undefined){
            return "--"
        }else{
             return contentType["name"]
        }
    }
}

/**添加任务数据**/
function selfDetail(self_job,databaseSource){
    var statues_content;
    detailId = self_job["id"];
    $("#detail_id").text(ifUndefined(self_job["id"]));
    $("#detail_lastExecuteTime").text(ifUndefined(self_job["lastExecuteTime"]));
    $("#detail_createTime").text(ifUndefined(self_job["createTime"]));
    // $("#detail_url").text(ifUndefined(self_job["url"]));
    $("#detail_type").text(showType(self_job["type"]));
     if(ifUndefined(self_job["status"]) == 1){
            statues_content = "<span>运行中</span>";
        }else if(ifUndefined(self_job["status"]) == 2){
            statues_content = "<span>暂停中</span>";
        }else if(ifUndefined(self_job["status"]) == 3){
            statues_content = "<span>失败</span>";
        }else if(ifUndefined(self_job["status"]) == 4){
            statues_content = "<span>已完成</span>";
        }else if(ifUndefined(self_job["status"]) == 5){
            statues_content = "<span>未运行</span>";
        }else{
            statues_content = "<span>--</span>";
        }
    $("#detail_statues").append(statues_content);
    $("#detail_content_type").html(showContentType(self_job["contentType"]))
    $("#detail_jobTemplateId a").html(ifUndefined(self_job["jobTemplateId"]));
    if(ifUndefined(self_job["jobTemplateId"]) == "--" || self_job["jobTemplateId"] == "-1"){
        $("#detail_jobTemplateId a").attr("onclick","layer.msg('无模板信息', {icon: 1, time: 2000})");
    }

    $("#detail_databaseSource").text(ifUndefined(databaseSource));
    $("#detail_databaseId").text(ifUndefined(self_job["databaseId"]));
    $("#detail_tableName").text(ifUndefined(self_job["tableName"]));
    if(!(parent && childrenList && brotherList)){
        $("#detail_parentId a").attr("onclick","layer.msg('无子父节点', {icon: 1, time: 2000})");
    }else{
        $("#detail_parentId a").html("节点详情");
    }
    $("#detail_pageLimit").text(ifUndefined(self_job["pageLimit"]));

    $("#detail_proxyID").val(self_job["proxyId"]);
    if(self_job["proxyType"] == 1 ){
        $("#detail_proxyType a").text("静态代理");
    }else if(self_job["proxyType"] == 2){
        $("#detail_proxyType a").text("动态代理(用户)");
    }else if(self_job["proxyType"] == 3){
        $("#detail_proxyType a").text("动态代理(url)");
    }else{
        $("#detail_proxyType a").text("--");
        $("#detail_proxyType a").attr("onclick","layer.msg('无代理信息', {icon: 1, time: 2000})");
    }

    $("#detail_log a").text("日志列表");
    $("#detail_log a").attr("href","/use/logList.html?id="+self_job["id"]);
     if(ifUndefined(self_job["id"]) == "--" ||  self_job["id"] == "-1"){
         $("#detail_log a").attr("onclick","layer.msg('无日志信息', {icon: 1, time: 2000})");
         $("#detail_log a").attr("href","#");
    }
}
// function addTitle(){
//
// }
// function addStatues(){
//
// }

/**父亲任务数据**/
function showFather(parent){
    if(parent){
        var statues_content;
        var title = '<tr>'+
                    '<th scope="col" colspan="10" class="success">父任务</th>'+
                    '</tr>'+
                    '<tr class="text-c" id="father">'+
                    '<th>任务名称</th>'+
                    '<th class="url_colum">URL</th>'+
                    '<th>类型</th>'+
                    '<th>当前状态</th>'+
                    '<th>采集周期</th>'+
                    '<th>采集间隔</th>'+
                    '<th>模板名称</th>'+
                    '<th>创建时间</th>'+
                    '<th>最近执行时间</th>'+
                    '<th>操作</th>'+
                    '</tr>';
         if(ifUndefined(parent["status"]) == 2){
            statues_content = "<span>运行中</span>";
        }else if(ifUndefined(parent["status"]) == 1){
            statues_content = "<span>未激活</span>";
        }else if(ifUndefined(parent["status"]) == 3){
            statues_content = "<span>暂停</span>";
        }else if(ifUndefined(parent["status"]) == 4){
            statues_content = "<span>失败</span>";
        }else if(ifUndefined(parent["status"]) == 6){
            statues_content = "<span>等待</span>";
        }else if(ifUndefined(parent["status"]) == 5){
            statues_content = "<span>已完成</span>";
        }else{
            statues_content = "<span>--</span>";
        }
        var parentContent = '<tr>' +
                        '<td>'+ ifUndefined(parent['name']) + '</td><td>' + ifUndefined(parent['url']) + '</td><td>' +showType(parent['type']) +
                        '</td><td>' + statues_content + '</td><td>' + showGrapInterval(parent['grapInterval']) + '</td><td>' + showGrapPeriodtype(parent['grapPeriod']) +
                        '</td><td>' + ifUndefined(parent['jobTemplateId']) + '</td><td>' + ifUndefined(parent['createTime']) + '</td><td>' + ifUndefined(parent['lastExecuteTime']) + '</td>' +
                        '<td class="td-manage"><a href="/use/plandetails.html?id=' + parent["id"] + '"style="text-decoration:none" data-toggle="tooltip" data-placement="top" title="查看详情" >' +
                        '<i class="Hui-iconfont list_eidit">&#xe685;</i></a></td>'
                        '<tr>';
         $("#tbodyl_parent").append(title).append(parentContent);
    }
}
function showBrothers(brotherList){
    var statues_content;
    if(brotherList){
         var title = '<tr>'+
                    '<th scope="col" colspan="10" class="active">兄弟任务</th>'+
                    '</tr>'+
                    '<tr class="text-c" id="father">'+
                    '<th>任务名称</th>'+
                    '<th class="url_colum">URL</th>'+
                    '<th>类型</th>'+
                    '<th>当前状态</th>'+
                    '<th>采集周期</th>'+
                    '<th>采集间隔</th>'+
                    '<th>模板名称</th>'+
                    '<th>创建时间</th>'+
                    '<th>最近执行时间</th>'+
                    '<th>操作</th>'+
                    '</tr>';
        $("#tbodyl_brother").append(title);
        for(var i = 0;i<brotherList.length;i++){
            if(ifUndefined(brotherList[i]["status"]) == 2){
                statues_content = "<span>运行中</span>";
            }else if(ifUndefined(brotherList[i]["status"]) == 1){
                statues_content = "<span>未激活</span>";
            }else if(ifUndefined(brotherList[i]["status"]) == 3){
                statues_content = "<span>暂停</span>";
            }else if(ifUndefined(brotherList[i]["status"]) == 4){
                statues_content = "<span>失败</span>";
            }else if(ifUndefined(brotherList[i]["status"]) == 6){
                statues_content = "<span>等待</span>";
            }else if(ifUndefined(brotherList[i]["status"]) == 5){
                statues_content = "<span>已完成</span>";
            }else{
                statues_content = "<span>--</span>";
            }
            var brotherContent = '<tr>' +
                                    '<td>'+ ifUndefined(brotherList[i]['name']) + '</td>' +
                                    '<td>' + ifUndefined(brotherList[i]['url']) + '</td><td>' + showType(brotherList[i]['type']) + '</td>' +
                                    '<td>' + statues_content + '</td>' +
                                    '<td>' + showGrapInterval(brotherList[i]['grapInterval']) + '</td>' +
                                    '<td>' + showGrapPeriodtype(brotherList[i]['grapPeriod']) + '</td>' +
                                    '<td>' + ifUndefined(brotherList[i]['jobTemplateId']) + '</td>' +
                                    '<td>' + ifUndefined(brotherList[i]['createTime']) + '</td>' +
                                    '<td>' + ifUndefined(brotherList[i]['lastExecuteTime']) + '</td>' +
                                    '<td class="td-manage">' +
                                        '<a href="/use/plandetails.html?id=' +brotherList[i]["id"] + '" title="查看详情" data-toggle="tooltip" data-placement="top" style="text-decoration:none">' +
                                        '<i class="Hui-iconfont list_eidit">&#xe685;</i></a></td>'
                                '<tr>';
                $("#tbodyl_brother").append(brotherContent);
        }
    }
}

/**孩子任务数据**/
function showChildren(childrenList){
    var statues_content;
    if(childrenList){
         var title = '<tr>'+
                    '<th scope="col" colspan="10" class="warning">子任务</th>'+
                    '</tr>'+
                    '<tr class="text-c" id="father">'+
                    '<th>任务名称</th>'+
                    '<th class="url_colum">URL</th>'+
                    '<th>类型</th>'+
                    '<th>当前状态</th>'+
                    '<th>采集周期</th>'+
                    '<th>采集间隔</th>'+
                    '<th>模板名称</th>'+
                    '<th>创建时间</th>'+
                    '<th>最近执行时间</th>'+
                    '<th>操作</th>'+
                    '</tr>';
        $("#tbodyl_child").append(title);
        for(var i = 0;i<childrenList.length;i++){
            if(ifUndefined(childrenList[i]["status"]) == 2){
                statues_content = "<span>运行中</span>";
            }else if(ifUndefined(childrenList[i]["status"]) == 1){
                statues_content = "<span>未激活</span>";
            }else if(ifUndefined(childrenList[i]["status"]) == 3){
                statues_content = "<span>暂停</span>";
            }else if(ifUndefined(childrenList[i]["status"]) == 4){
                statues_content = "<span>失败</span>";
            }else if(ifUndefined(childrenList[i]["status"]) == 6){
                statues_content = "<span>等待</span>";
            }else if(ifUndefined(childrenList[i]["status"]) == 5){
                statues_content = "<span>已完成</span>";
            }else{
                statues_content = "<span>--</span>";
            }
            var childrenContent = '<tr>' +
                                    '<td>'+ ifUndefined(childrenList[i]['name']) + '</td>' +
                                    '<td>' + ifUndefined(childrenList[i]['url']) + '</td>' +
                                     '<td>' + showType(childrenList[i]['type']) + '</td>' +
                                    '<td>' + statues_content + '</td>' +
                                    '<td>' + showGrapInterval(childrenList[i]['grapInterval']) + '</td>' +
                                    '<td>' + showGrapPeriodtype(childrenList[i]['grapPeriod']) + '</td>' +
                                    '<td>' + ifUndefined(childrenList[i]['jobTemplateId']) + '</td>' +
                                    '<td>' + ifUndefined(childrenList[i]['createTime']) + '</td>' +
                                    '<td>' + ifUndefined(childrenList[i]['lastExecuteTime']) + '</td>' +
                                    '<td class="td-manage">' +
                                        '<a href="/use/plandetails.html?id=' +childrenList[i]["id"] + '" title="查看详情" style="text-decoration:none" data-toggle="tooltip" data-placement="top">' +
                                        '<i class="Hui-iconfont list_eidit">&#xe685;</i></a></td>'
                                    '<tr>';
                $("#tbodyl_child").append(childrenContent);
        }
    }
}
/**父亲、兄弟、孩子任务数据**/
function showChildTable(list,flag){
    var statues_content;
    if(list){
         var title = '<tr>'+
                    '<th scope="col" colspan="10" class="warning">子任务</th>'+
                    '</tr>'+
                    '<tr class="text-c" id="father">'+
                    '<th>任务名称</th>'+
                    '<th class="url_colum">URL</th>'+
                    '<th>类型</th>'+
                    '<th>当前状态</th>'+
                    '<th>采集周期</th>'+
                    '<th>采集间隔</th>'+
                    '<th>模板名称</th>'+
                    '<th>创建时间</th>'+
                    '<th>最近执行时间</th>'+
                    '<th>操作</th>'+
                    '</tr>';
         if(flag == 0){
             $("#tbodyl_parent").append(title);
         }else if(flag == 1){
             $("#tbodyl_brother").append(title);
         }else if(flag == 2){
             $("#tbodyl_child").append(title);
         }else{
             //
         }
        for(var i = 0;i<list.length;i++){
            if(ifUndefined(list[i]["status"]) == 2){
                statues_content = "<span>运行中</span>";
            }else if(ifUndefined(list[i]["status"]) == 1){
                statues_content = "<span>未激活</span>";
            }else if(ifUndefined(list[i]["status"]) == 3){
                statues_content = "<span>暂停</span>";
            }else if(ifUndefined(list[i]["status"]) == 4){
                statues_content = "<span>失败</span>";
            }else if(ifUndefined(list[i]["status"]) == 6){
                statues_content = "<span>等待</span>";
            }else if(ifUndefined(list[i]["status"]) == 5){
                statues_content = "<span>已完成</span>";
            }else{
                statues_content = "<span>--</span>";
            }
            var content = '<tr>' +
                                    '<td>'+ ifUndefined(list[i]['name']) + '</td><td>' + ifUndefined(list[i]['url']) + '</td><td>' + ifUndefined(list[i]['type']) +
                                    '</td><td>' + statues_content + '</td><td>' + showGrapInterval(list[i]['grapInterval']) + '</td><td>' + showGrapPeriodtype(list[i]['grapPeriod']) +
                                    '</td><td>' + ifUndefined(list[i]['jobTemplateId']) + '</td><td>' + ifUndefined(list[i]['createTime']) + '</td><td>' + ifUndefined(list[i]['lastExecuteTime']) + '</td>' +
                                    '<td class="td-manage"><a href="/use/plandetails.html?id=' +list[i]["id"] + '" title="查看详情" style="text-decoration:none" data-toggle="tooltip" data-placement="top"></a>' +
                                    '<i class="Hui-iconfont list_eidit">&#xe685;</i></td>'
                                    '<tr>';
            if(flag == 0){
                $("#tbodyl_parent").append(content);
             }else if(flag == 1){
                 $("#tbodyl_brother").append(content);
             }else if(flag == 2){
                 $("#tbodyl_child").append(content);
             }else{
                 //
             }
        }
    }
}

// function showlogList(obj){
//     turnToPage('日志详情', '/use/logList.html', '600', '350');
// }


/*查看代理*/
function showAgent(){
    var proxy_Id = $("#detail_proxyID").val();
    // alert(proxy_Id);
    turnToPage('代理详情', '/use/showAgent.html?proxyId='+ proxy_Id, '1000', '500');
}

/*查看模板字段*/
function showTemplateDetail(obj){
    var templateId = obj.text;
    if(templateId){
         turnToPage('模板详情', '/use/templateDetail.html?templateId='+templateId, '1000', '600');
    }else{
        $("#detail_jobTemplateId a").attr("onclick","layer.msg('无字段信息', {icon: 1, time: 2000})");
    }

}
// function showContentType(obj){
//      $("#detail_content_type a").html("人头");
// }

function turnToPage(title, url, w, h){
    data_window = layer_show(title, url, w, h)
}

/*
 参数解释：
 title	标题
 url		请求的url
 id		需要操作的数据id
 w		弹出层宽度（缺省调默认值）
 h		弹出层高度（缺省调默认值）
 */
// function admin_stop(obj, id) {
//     layer.confirm('确认要停用吗？', function (index) {
//         jQuery(obj).parents("tr").find(".td-status").html('<span class="label label-fail radius" onClick="admin_start(this,' + id + ')">已禁用</span>');
//         layer.msg('已停用!', {icon: 5, time: 1000});
//         ajaxFunction("/updateTaskStatus", "POST", "JSON", "application/ json,charset=utf8", {
//             "status": "2",
//             "id": id + ""
//         })
//     });
// }


/*管理员-启用*/
// function admin_start(obj, id) {
//     layer.confirm('确认要启用吗？', function (index) {
//         jQuery(obj).parents("tr").find(".td-status").html('<span class="label label-success radius" onClick="admin_stop(this,' + id + ')">已启用</span>');
//         layer.msg('已启用!', {icon: 6, time: 1000});
//         ajaxFunction("/updateTaskStatus", "POST", "JSON", "application/ json,charset=utf8", {
//             "status": "1",
//             "id": id + ""
//         })
//     });
// }

 borToggle();
function showParent(obj){
    $("#tbodyl_child").slideToggle("fast",borToggle).insertAfter("#tbodyl");
     $("#tbodyl_brother").slideToggle("fast",borToggle).insertAfter("#tbodyl");
    $("#tbodyl_parent").slideToggle("fast",borToggle).insertAfter("#tbodyl");
}

function borToggle(){
     if($("#tbodyl_child").css("display") == "none"){
            $("#tbodyl_down").addClass("bor");
        }else{
            $("#tbodyl_down").removeClass("bor");
        }
     // if($("#tbodyl_parent").css("display") == "none"){
     //        $("#tbodyl_down").addClass("bor");
     //    }else{
     //        $("#tbodyl_down").removeClass("bor");
     //    }
}
jQuery("#detail_url").click(function () {
    id = window.location.search.split("=")[1];
    window.location.href='/use/url_detail.html?id='+id;
})