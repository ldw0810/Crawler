var totalPage;
var data;
var page = 1;
var pagesize = 10;
var time = 1;
var ifSearch = 0;
var lastPage = 0;
var newStaues = 0;

var search_grapPeriod = $(".navBar_under_front .check").val();
if(!search_grapPeriod){search_grapPeriod ="-1";}

var search_status = $(".navBar_under .check").val();
if(!search_status){search_status ="-1";}

var search_content = $("#input-text").val();

var param = {"pageNo":page, "pageSize":pagesize,"searchParam":{"status":search_status,"grapPeriod":search_grapPeriod,"name":search_content}};

/*调用接口*/
ajaxFunction("/getTaskList", "POST", "JSON", "application/json,charset=utf8", param, success, error);

/*接口调用成功*/
function error(resp) {
    console.log(resp + "/fail");
}

/*接口调用失败*/
function success(resp) {
    data = resp['taskList'];
    totalPage = resp['count'];//接口获得
    if(ifSearch || ifDel){
        getTable(data);
        ifSearch = 0;
        ifDel = 0;
    } else{
            $("#wholeCheckBox_title").attr("checked",false);
            $("#wholeCheckBox_title").attr("isOption",0);
            getTable(data);
    }
}
function stautsSuccess(resp){
     if(lastPage == page){
            getNewState(data);
         }else{
            $("#wholeCheckBox_title").attr("checked",false);
            $("#wholeCheckBox_title").attr("isOption",0);
            getTable(data);
     }
}

function tableSort(){//当前页按时间顺序排序
    var noVaildDataList = [];
    var vaildDataList = [];
    var log = $(".PX").attr("type");
    for(var i = 0;i < data.length; i++){
        if(data[i]["createTime"] == undefined || data[i]["createTime"] == null){
            noVaildDataList.push(data[i]);
        }else{
            vaildDataList.push(data[i]);
        }
    }
    if (log == "D"){
        vaildDataList.sort(
                 function (a, b) {
                     var t1 = new Date(a["createTime"]);
                     var t2 = new Date(b["createTime"]);
                     return t2 - t1;
                 });//时间倒序\
        $(".PX i").html("&#xe6d6");
        $(".PX").attr("type","Z");
    }
    if (log == "Z"){
        vaildDataList.sort(
         function (a, b) {
            var t1 = new Date(a["createTime"]);
            var t2 = new Date(b["createTime"]);
            return t1 - t2;
         });//时间正序
     $(".PX i").html("&#xe6d5");
     $(".PX").attr("type","D");
    }
    data = vaildDataList.concat(noVaildDataList);
    getTable(data);
}
function tableSort_1(){//当前页按时间顺序排序
    var noVaildDataList = [];
    var vaildDataList = [];
    var log = $(".PX_1").attr("type");
    for(var i = 0;i < data.length; i++){
        if(data[i]["lastExecuteTime"] == undefined || data[i]["lastExecuteTime"] == null){
            noVaildDataList.push(data[i]);
        }else{
            vaildDataList.push(data[i]);
        }
    }
    if (log == "D"){
         vaildDataList.sort(
             function (a, b) {
                 var t1 = new Date(a["lastExecuteTime"]);
                 var t2 = new Date(b["lastExecuteTime"]);
                 return t2 - t1;
                }
             );//时间倒序
        $(".PX_1 i").html("&#xe6d6");
        $(".PX_1").attr("type","Z");
    }else if(log == "Z"){
         vaildDataList.sort(
             function (a, b) {
                 var t1 = new Date(a["lastExecuteTime"]);
                 var t2 = new Date(b["lastExecuteTime"]);
                 return t1 - t2;
             }
         ) ;
        $(".PX_1 i").html("&#xe6d5");
        $(".PX_1").attr("type","D");
    }else {
        //
    }//时间正序
    data = vaildDataList.concat(noVaildDataList);
    getTable(data);
}
/*首次分页*/
jQuery("#Pagination").pagination(totalPage, {
    num_edge_entries: 1,
    num_display_entries: 4,
    items_per_page: 10,
    current_page: 0,
});
/*分页回调函数*/
function result(current_page, items_per_page, maxPage,obj) {
    $('#pageNum').val(items_per_page);
    var search_grapPeriod = $(".navBar_under_front .check").val();
    if (!search_grapPeriod) {
        search_grapPeriod = "-1";
    }
    var search_status = $(".navBar_under_li .check").val();
    if (search_status > 4 || search_status < 0) {
        search_status = "-1";
    }
    var search_content = $("#input-text").val().trim();
    lastPage = page;
    pagesize = items_per_page;
    page = current_page + 1;
    if(page > maxPage){
        page = maxPage;
        $(".last_text").click();
    }
    if(page <= 0){
        page = 1;
    }
    param = {"pageNo":page, "pageSize":items_per_page,"searchParam":{"status":search_status,"grapPeriod":search_grapPeriod,"name":search_content}}
    if (time || ifSearch || newStaues) {//搜索和首次进入不加载ajax
        time = 0;
        ifSearch = 0;
        newStaues = 0;
    } else {//翻页，刷状态
        ajaxFunction("/getTaskList", "POST", "JSON", "application/json,charset=utf8", param, success, error);
    }
}

/*空值处理*/
function ifUndefined(val) {
    if (val == undefined || val == null || val == "-1") {
        return "--";
    } else {
        return val;
    }
}

/*添加表格数据*/
function showStatues(status) {
        if (ifUndefined(status["status"]) == 1) {
            statues_content = "<span>运行中</span>";
        } else if (ifUndefined(status["status"]) == 2) {
            statues_content = "<span>暂停中</span>";
        } else if (ifUndefined(status["status"]) == 3) {
            statues_content = "<span>失败</span>";
        } else if (ifUndefined(status["status"]) == 4) {
            statues_content = "<span>已完成</span>";
        } else if (ifUndefined(status["status"]) == 0) {
            statues_content = "<span>未运行</span>";
        } else {
            statues_content = "<span>--</span>";
        }
    return statues_content;
}
function showGrapPeriodBut(grap) {
    if (grap["grapPeriod"] == 1) {//按次
        grapPeriod = "<a  id='"  +grap["id"] + "' onclick='crawler(this,\"" + grap["id"] + "\")' style='text-decoration:none' title='爬取数据' data-toggle='tooltip' data-placement='top'> " +
            "<i class='Hui-iconfont list_data'>&#xe616;</i>" +
            "</a>"
    } else if (grap["grapPeriod"] == 2) {//周期
        if (grap["executeStatus"] == 0) {
            grapPeriod = "<a  id='"  +grap["id"] + "'  onclick='admin_stop(this,\"" + grap["id"] + "\")' style='text-decoration:none' title='暂停任务' data-toggle='tooltip' data-placement='top'> " +
                "<i class='Hui-iconfont list_data'>&#xe6e5;</i>" +
                "</a>"
        } else if (grap["executeStatus"] == 1) {
            grapPeriod = "<a  id='"  +grap["id"] + "'  onclick='admin_start(this,\"" + grap["id"] + "\")' style='text-decoration:none' title='开启任务' data-toggle='tooltip' data-placement='top'> " +
                "<i class='Hui-iconfont list_data'>&#xe6e6;</i>" +
                "</a>"
        } else {
            grapPeriod = "<a  id='"  +grap["id"] + "'  onclick='crawler(this,\"" + grap["id"] + "\")' style='text-decoration:none' title='爬取数据' data-toggle='tooltip' data-placement='top'> " +
                "<i class='Hui-iconfont list_data'>&#xe616;</i>" +
                "</a>"
        }
    } else {
        grapPeriod = "<a  id='"  +grap["id"] + "'  onclick='crawler(this,\"" + grap["id"] + "\")' style='text-decoration:none' title='爬取数据' data-toggle='tooltip' data-placement='top'> " +
            "<i class='Hui-iconfont list_data'>&#xe616;</i>" +
            "</a>"
    }
    return grapPeriod;
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
function showType(type) {
    if (type == 0 || type == '0') {
        return "定向"
    } else if (type == 1 || type == '1') {
        return "批量"
    } else {
        return "--"
    }
}
function showContentType(contentType) {
    if (contentType == undefined) {
        return "--"
    } else {
        if (contentType["name"] == undefined) {
            return "--"
        } else {
            return contentType["name"]
        }
    }
}
function getNewState(data){
     var statues_content;
     for (var i = 0; i < data.length; i++) {
         statues_content = showStatues(data[i]);
         $("#"+data[i]["id"]).parent().parent().find(".td-status span").html("<span>" + statues_content + "</span>")
         // $(".td-status").eq(i).html("<span>" + statues_content + "</span>");
     }
}
function getTable(data) {//添加表格数据
    var statues_content;
    var grapPeriod;
    var type;
    $("#tbodyl").html("");
    for (var i = 0; i < data.length; i++) {
        statues_content = showStatues(data[i]);
        grapPeriod = showGrapPeriodBut(data[i]);
        $("#tbodyl").append("<tr class='text-c'>" +
            "<th ><input type='checkbox' name='wholeCheckBox' value="+data[i]["id"]+"></th>" +
            "<td class='name'>" + ifUndefined(data[i]["name"]) + "</td>" +
            "<td>" + ifUndefined(data[i]["keyWord"]) + "</td>" +
            "<td>" + showType(data[i]["type"]) + "</td>" +
            "<td class='td-status' style='cursor:pointer'>" + statues_content + "</td>" +
            "<td>" + showGrapPeriodtype(data[i]["grapPeriod"]) + "</td>" +
            "<td>" + showGrapInterval(data[i]["grapInterval"]) + "</td>" +
            "<td>" + ifUndefined(data[i]["jobTemplateId"]) + "</td>" +
            "<td>" + showContentType(data[i]["contentType"]) + "</td>" +
            "<td>" + ifUndefined(data[i]["createTime"]) + "</td>" +
            "<td class='lastExecuteTime'>" + ifUndefined(data[i]["lastExecuteTime"]) + "</td>" +
            " <td class='td-manage'>" +
            "<a href='/use/plandetails.html?id=" + data[i]["id"] + "' class='ml-5' title='查看详情' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
            "<i class='Hui-iconfont list_detail'>&#xe685;</i></a>"
            + grapPeriod +
            "<a  href='/use/template.html?id=" + data[i]["id"] + "'  class='ml-5' style='text-decoration:none' title='爬取结果' data-toggle='tooltip' data-placement='top'>" +
            "<i class='Hui-iconfont list_result'>&#xe720;</i>" +
            "</a>" +
            "<a onclick='copyLine(this,\"" + data[i]["id"] + "\")'  class='ml-5' style='text-decoration:none' title='复制' data-toggle='tooltip' data-placement='top'>" +
            "<i class='Hui-iconfont list_copy'>&#xe6ea;</i>" +
            "</a>" +
            "<a href='/use/useList_edit.html?id=" + data[i]["id"] + "'  class='ml-5'title='编辑信息' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
            "<i class='Hui-iconfont list_eidit'>&#xe60c;</i>" +
            "</a>" +
            "<a type='submit' id='' style='text-decoration:none'  onclick='admin_del(this ,\"" + data[i]["id"] + "\")' title='删除'  data-toggle='tooltip' data-placement='top'>" +
            "<i class='Hui-iconfont list_delete'>&#xe6e2;</i>" +
            "</a>" +
            "</td>" +
            "</tr>");
    }
}

/*复制成功*/
function copySuccess(obj) {
     layer.msg('复制成功!', {icon: 6, time: 1000});
    window.location.reload();
}
/*复制失败*/
function copyError() {
    layer.msg('复制失败!', {icon: 6, time: 1000});
}
/*复制操作*/
function copyLine(obj, id) {
    layer.confirm('确认要复制吗？', function (index) {
        layer.closeAll('dialog');
        var param_copy = {'id': id};
        ajaxFunction("/taskCopy", "POST", "JSON", "application/json,charset=utf8", param_copy, copySuccess, copyError);
    });
}

/*删除成功*/
var ifDel = 0;
function delsuccess(resp) {
    lastPage = 0;
    ifDel = 1
    var newPage;
    if(page <= 1){
        newPage = 0
    }else{
        newPage = page - 1;
    }
    jQuery("#Pagination").pagination(totalPage, {
        num_edge_entries: 1,
        num_display_entries: 4,
        items_per_page: pagesize,
        current_page: newPage
    });
    layer.msg('删除成功!', {icon: 6, time: 1000});
}

/*删除失败*/
function delsfail(resp) {
    layer.msg('删除失败!', {icon: 6, time: 1000});
}

/*删除操作*/
function admin_del(obj, id) {
    layer.confirm('确认要删除吗？', function (index) {
        ajaxFunction("/taskMgmt", "POST", "JSON", "application/ json,charset=utf8", {
            "action": "1",
            "id": id + "",
            "delFlag": true
        }, delsuccess, delsfail);
    });
}
var crawler_id= '';
/*暂停*/
function stop_success(resp){
     $("#"+ crawler_id).replaceWith("<a id='"  + crawler_id  + "'  onclick='admin_start(this,\"" + crawler_id + "\")' class='ml-5' style='text-decoration:none' title='开启任务' data-toggle='tooltip' data-placement='top'> " +
            "<i class='Hui-iconfont list_data'>&#xe6e6;</i>" + "</a>");
        layer.msg('已暂停!', {icon: 5, time: 1000});
         $("#"+ crawler_id).parent("td").parent("tr").children(".td-status").text("暂停中")
}
function stop_fail(resp){
        layer.msg('操作失败!', {icon: 5, time: 1000});
}

function admin_stop(obj, id) {
    var param_stop= {"taskJobId" : id, "action" : 4};
    crawler_id = id;
    layer.confirm('确认要暂停吗？', function (index) {
        ajaxFunction("/taskJobSchedulerMgnt", "POST", "JSON", "application/ json,charset=utf8", param_stop,stop_success,stop_fail)
    });
}

/*启用*/
function star_success(resp){
     $("#"+ crawler_id).replaceWith("<a id='"  + crawler_id  + "'  onclick='admin_stop(this,\"" + crawler_id + "\")' class='ml-5' style='text-decoration:none' title='暂停任务' data-toggle='tooltip' data-placement='top'> " +
            "<i class='Hui-iconfont list_data'>&#xe6e5;</i>" + "</a>");
        layer.msg('已运行!', {icon: 6, time: 1000});
        $("#"+ crawler_id).parent("td").parent("tr").children(".td-status").text("运行中")
}
function star_fail(resp){
        layer.msg('操作失败!', {icon: 5, time: 1000});
}

function admin_start(obj, id) {
    var param_start= {"taskJobId" : id, "action" : 3};
    crawler_id = id;
    layer.confirm('确认要运行吗？', function (index) {
        ajaxFunction("/taskJobSchedulerMgnt", "POST", "JSON", "application/ json,charset=utf8", param_start,star_success,star_fail)
    });
}

/*爬取操作*/
function crawler(obj, id) {
    layer.confirm('确认要爬取吗？', function (index) {
        layer.closeAll('dialog');
        var param_crawler= {"taskJobId" : id, "action" : 0};
        ajaxFunction("/startCralwer", "POST", "JSON", "application/ json,charset=utf8", {
            // "action": "0",
            "taskJobId": id+ "",
        }, successStart(), function(){});
    });
}

function successStart() {
    window.location.reload();

}

/*搜索操作*/
function search() {
    ifSearch = 1;
    var search_grapPeriod = $(".navBar_under_front .check").val();
    if (!search_grapPeriod) {
        search_grapPeriod = "-1";
    }
    var search_status = $(".navBar_under_li .check").val();
    if (search_status > 4 || search_status < 0) {
        search_status = "-1";
    }
    var search_content =$("#input-text").val().trim();
    var param = {"pageNo":1, "pageSize":pagesize,"searchParam":{"status":search_status,"grapPeriod":search_grapPeriod,"name":search_content}};
   ajaxFunction("/getTaskList", "POST", "JSON", "application/json,charset=utf8", param, success, error);
   /*首次分页*/
    jQuery("#Pagination").pagination(totalPage, {
        num_edge_entries: 1,
        num_display_entries: 4,
        items_per_page: 10,
        current_page: 0,
    });
}

jQuery(".navBar_under li").click(function () {
    jQuery(this).siblings('li').removeClass('check');
    jQuery(this).addClass('check');
})
jQuery(".navBar_under").css("cursor", "pointer")
/*批量删除*/
function datadel(){
	var checked = jQuery("input[type='checkbox']:checked");
	var str="";
	var delParam = ""
;	if (checked.length) {
    if(+$("#wholeCheckBox_title").attr("isoption")){
        var ckeckLen = checked.length - 1;
    }else{
        var ckeckLen = checked.length;
    }
	    layer.confirm('确认删除这'+(ckeckLen)+'项么？',function(index){
		for(var i = 0;i < checked.length;i++){
		    if(checked[i].id == "wholeCheckBox_title"){
		        continue;
            }
		    if(i == checked.length - 1){
		        str += checked[i].value;
		        break;
            }else{
		        str += checked[i].value + ','
            }
        }
		console.log(str);delParam = {"id":str,"action":"1"}
		 ajaxFunction("/taskMgmt", "POST", "JSON", "application/ json,charset=utf8", delParam, delsuccess, function(){layer.msg('删除失败!',{icon:1,time:1000});});
	});
	} else {
		//此处请求后台程序，下方是成功后的前台处理……
		layer.msg('未选择删除对象',{icon:1,time:2000});
	}
}

$("#wholeCheckBox_title").click(function(){
    var whole = $("input:checkbox[name = 'wholeCheckBox']");
	if(!+$("#wholeCheckBox_title").attr("isoption")){
		$("#wholeCheckBox_title").attr("isoption",1);
		for(var i=0;i<whole.length;i++){
			whole[i].checked = true;
			whole.eq(i).attr("isoption",1);
		}
  	}else{
  		$("#wholeCheckBox_title").attr("isoption",0);
  		for(var i=0;i<whole.length;i++){
			whole[i].checked = false;
			whole.eq(i).attr("isoption",0);
		}
  	}
});

$(document).keypress(function(e) {
    // 搜索，回车键响应
       if(e.which == 13) {
           search();
       }
   });

function reflash(){
    window.location.reload();
}
function reflashData(){
    var newPage;
    lastPage = page;
    newStaues = 1;
    if(page <= 1){
        newPage = 0
    }else{
        newPage = page - 1;
    }
    var search_grapPeriod = $(".navBar_under_front .check").val();
    if (!search_grapPeriod) {
        search_grapPeriod = "-1";
    }
    var search_status = $(".navBar_under_li .check").val();
    if (search_status > 4 || search_status < 0) {
        search_status = "-1";
    }
    var search_content =$("#input-text").val().trim();
    var param = {"pageNo":1, "pageSize":pagesize,"searchParam":{"status":search_status,"grapPeriod":search_grapPeriod,"name":search_content}};
   ajaxFunction("/getTaskList", "POST", "JSON", "application/json,charset=utf8", param, stautsSuccess, error);
    jQuery("#Pagination").pagination(totalPage, {
        num_edge_entries: 1,
        num_display_entries: 4,
        items_per_page: pagesize,
        current_page: newPage
    });

}
var timer = setInterval(function(){
    reflashData();
},5000);

$(window).unload(function(){
  window.clearInterval( timer );
});
