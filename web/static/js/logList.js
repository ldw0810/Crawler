/*更新左侧导航*/
$("aside").html("");
var aside_content = '<div id="use">' +
    '<ul class="work">' +
    '<li id="menu-user5" class="checked">' +
    '<a style="text-decoration: none" href="#" onclick="window.history.go(-1);" title="返回" name="">' +
    '<i class="Hui-iconfont">&#xe6d4;</i>' +
    '<span>返回</span>' +
    '</a>' +
    '</li>' +
    '</ul>' +
    '</div>';
$("aside").append(aside_content);

/*调用接口取数据*/
var page = 1;
var pagesize = 10;
var time = 1;
var taskJobId = window.location.search.split("=")[1];
var  param = {"pageNo": page, "pageSize": pagesize, "taskJobId": taskJobId}
var data;
/*调用接口*/
ajaxFunction("/getTaskJobHistory", "POST", "JSON", "application/json,charset=utf8", param, success, error);
/*分页初始化*/
jQuery("#Pagination").pagination(data["result"]["count"], {
    num_edge_entries: 1,
    num_display_entries: 4,
    items_per_page: 10,
    current_page: 0,
});
/*分页回调函数*/
function result(current_page, items_per_page, maxPage,obj) {
    $('#pageNum').val(items_per_page);
    page = current_page + 1;
    pagesize = items_per_page;
    if(page > maxPage){
        page = maxPage;
        $(".last_text").click();
    }
    if(page <= 0){
        page = 1;
    }
    param = {"pageNo": page, "pageSize": +items_per_page, "taskJobId": taskJobId}
    if (time) {
        time = 0;
    } else {
        ajaxFunction("/getTaskJobHistory", "POST", "JSON", "application/json,charset=utf8", param, success, error);
    }
}



/*接口调用失败*/
function error(resp) {
    console.log(resp + "/fail");
}

/*接口调用成功*/
function success(resp) {
    // alert(resp + "/success");
    data = resp;
    drawTabel(resp);
    console.log(resp);

}
/*空值处理*/
function ifUndefined(val) {
    if (val == undefined || val == null || val == "-1") {
        return "--";
    } else {
        return val;
    }
}
function showStatues(status) {
        if (status["status"] == 1) {
            statues_content = "<span>运行中</span>";
        } else if (ifUndefined(status["status"]) == 2) {
            statues_content = "<span>暂停中</span>";
        } else if (ifUndefined(status["status"]) == 3) {
            statues_content = "<span>失败</span>";
        } else if (ifUndefined(status["status"]) == 4) {
            statues_content = "<span>已完成</span>";
        } else if (ifUndefined(status["status"]) == 5) {
            statues_content = "<span>未运行</span>";
        } else {
            statues_content = "<span>--</span>";
        }
    return statues_content;
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

/*添加表格字段*/
function drawTitle(title){
    $("#tabTitle").append("<th>序号</th>");
    $("#tabTitle").append("<th>日志id</th>");
    $("#tabTitle").append("<th>任务id</th>");
    $("#tabTitle").append("<th>创建时间</th>");
    $("#tabTitle").append("<th>状态</th>");
    $("#tabTitle").append("<th>种类</th>");
}
/*添加表格列表*/
function drawList(list){
    $("#dataList").html("");
    if(list){
        for(var i= 0; i< list.length; i++){
            var content = "<td>" + ( i + 1 ) + "</td>"+
                "<td><a onClick='showlogList(\"" + list[i]["id"] + "\")'>" + list[i]["id"] + "</a></td>"+
                "<td>"+list[i]["taskJobId"]+"</td>"+
                "<td>"+list[i]["createTime"]+"</td>"+
                "<td>"+showStatues(list[i])+"</td>"+
                "<td>"+showType(list[i]["type"])+"</td>";
             $("#dataList").append("<tr id='line_" + i + "'>" + content + "</tr>");
        }
    }
}

function showlogList(id){
     window.location = "/use/logDetail.html?id=" + id;
}

/*添加表格信息*/
function drawTabel(resp) {
    $("#tabTitle").html("");
    //显示总条数
    if(resp["result"]["count"]){
        $("#se_count").text('['+resp["result"]["count"]+']');
    }else{
         $("#se_count").text('["0"]');
    }
    //显示表格字段
    drawTitle();
    //显示表格列表
    if(resp["result"]["resultList"]){
         drawList(resp["result"]["resultList"])
    }else{
         $("#fileListTable").append("<tr><td>无数据</td></tr>");
    }
}

/*导出当前页*/
$("#currentPage").click(function(){
    var downLoadeparam = {"pageNo": page, "pageSize": pagesize, "taskJob": taskJobId};
    ajaxFunction("/exportResultExcel", "POST", "JSON", "application/json,charset=utf8", downLoadeparam, downLoadeSuccess, downLoadeerror);
    console.log(downLoadeparam);
});

/*导出全部*/
$("#wholePage").click(function(){
    var downLoadeparam = {"pageNo": 0, "pageSize": 0, "taskJob": taskJobId};
    ajaxFunction("/exportResultExcel", "POST", "JSON", "application/json,charset=utf8", downLoadeparam, downLoadeSuccess, downLoadeerror);
    console.log(downLoadeparam);
});
function downLoadeSuccess(resp){
    // if(resp.returnMsg == "SUCCESS"){
    //     layer.msg('下载成功',{icon:1,time:2000});
    //     window.location.herf = resp.download_url;
    // }
}
function downLoadeerror(resp){
    // layer.msg('下载失败',{icon:1,time:2000});
}