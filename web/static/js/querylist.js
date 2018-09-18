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
var totalPage = 0;
// var taskJobId = window.location.search.split("=")[1];
paramList=window.location.search.substring(1).split("&");
for(key in paramList){
        param=paramList[key]
        params=param.split("=")
        if(params[0]=="id"){
            jobTemplateId=params[1]
        }
        if(params[0]=="parentId"){
            parentId=params[1]
        }
        if(params[0]=="taskJobId"){
            taskJobId=params[1]
        }
    }
// var param = {"page": page, "pageCount": pagesize, "taskJob": taskJobId};
var  param = {"pageNo": page, "pageSize": pagesize, "taskJobId": taskJobId,"jobTemplateId":jobTemplateId,"parentId":parentId}
var data;
// var data = { returnCode : '0',
//     totalCount:10000,
//     resultkeys:
//         ['字段名','英文名','爬取时间','模板名称','字段值','add'],
//     result:[
//         ['aaa','name_a','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['bbb','name_b','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['ccc','name_c','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['ddd','name_d','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['eee','name_e','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['fff','name_f','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['ggg','name_g','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['hhh','name_h','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['aaa','name_a','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['bbb','name_b','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['ccc','name_c','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['ddd','name_d','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['eee','name_e','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['fff','name_f','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['ggg','name_g','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add'],
//         ['hhh','name_h','2017-04-27 08:50:01','f541c6f0-24c7-11e7-b066-e09467f6dff0','https:{detail_url}','add']
//     ]
// };
/*调用接口*/
ajaxFunction("/queryTaskJobResult", "POST", "JSON", "application/json,charset=utf8", param, success, error);
// success(data);
/*分页初始化*/
jQuery("#Pagination").pagination(totalPage, {
    num_edge_entries: 1,
    num_display_entries: 4,
    items_per_page: 10,
    current_page: 0,
});
// function tohanzi(data)
// {
//     if(data == '') return '请输入十六进制unicode';
//     data = data.split("\u");
//     var str ='';
//     for(var i=0;i<data.length;i++)
//     {
//         str+=String.fromCharCode(parseInt(data[i],16).toString(10));
//     }
//     return str;
// }
/*分页回调函数*/
function result(current_page, items_per_page, maxPage,obj) {
    $('#pageNum').val(items_per_page);
    page = current_page + 1;
    pagesize = items_per_page;
     if(page > maxPage){
        page = maxPage;
        $(".last_text").click();
    }
    //param = {"pageNo": current_page + 1, "pageSize": +items_per_page, "taskJob": taskJobId}
    param = {"pageNo": page, "pageSize": pagesize, "taskJobId": taskJobId,"jobTemplateId":jobTemplateId,"parentId":parentId}
    if (time) {
        //ajaxFunction("/queryTaskJobResult", "POST", "JSON", "application/json,charset=utf8", param, success, error);
        time = 0;
    } else {
        ajaxFunction("/queryTaskJobResult", "POST", "JSON", "application/json,charset=utf8", param, success, error);
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
    if(data["data"]){
        if(data["data"]["count"]){
            if(data["data"]["count"][0][0]){
                 totalPage = data["data"]["count"][0][0]
            }else{
                totalPage = 0
            }
        }else{
             totalPage = 0
        }
    }
    drawTabel(resp);
    console.log(resp);

}

/*添加表格字段*/
function drawTitle(title){
    $("#tabTitle").html("");
    $("#tabTitle").append("<th style='width: 25px;'>序号</th>");
    $("#fileList").attr("colspan",title.length + 1);
    for( var i= 0; i< title.length; i++){
        if(title[i]){
            $("#tabTitle").append("<th style='width:100px;max-width:150px;'>" + title[i][0] + "</th>");
        }
    }
}
/*添加表格列表*/
function drawList(list){
    $("#dataList").html("");
    if(list){
        for(var i= 0; i< list.length; i++){
            var content = "<td style='width: 25px;'>" + ( i + 1 ) + "</td>";
            for(var j= 0; j< list[i].length; j++){
                content += "<td style='width:100px;max-width:150px;'>"+list[i][j]+"</td>";
            }
             $("#dataList").append("<tr id='line_" + i + "'>" + content + "</tr>");
        }
    }
}

/*添加表格信息*/
function drawTabel(resp) {
    $("#tabTitle").html("");
    //显示总条数
    if(resp["data"]){
        if(resp["data"]["count"]){
            $("#se_count").text('["'+resp["data"]["count"][0][0]+'"]');
        }else{
             $("#se_count").text('["0"]');
        }
        //显示表格字段
        if(resp["data"]["title"]){
             drawTitle(resp["data"]["title"])
        }else{
             $("#tabTitle").append("<th>无表格内容</th>");
        }
        //显示表格列表
        if(resp["data"]["result"]){
             drawList(resp["data"]["result"])
        }else{
             $("#fileListTable").append("<tr><td>无数据</td></tr>");
        }
    }else{
       totalPage = 0;
    }

}

/*导出当前页*/
$("#currentPage").click(function(){
    var downLoadeparam = {"pageNo": page, "pageSize": pagesize,"taskJob": taskJobId,"jobTemplateId": jobTemplateId};
    ajaxFunction("/exportResultExcel", "POST", "JSON", "application/json,charset=utf8", downLoadeparam, downLoadeSuccess, downLoadeerror);
    console.log(downLoadeparam);
});

/*导出全部*/
$("#wholePage").click(function(){
    var downLoadeparam = {"pageNo": 0, "pageSize": 0, "taskJob": taskJobId, "jobTemplateId": jobTemplateId};
    ajaxFunction("/exportResultExcel", "POST", "JSON", "application/json,charset=utf8", downLoadeparam, downLoadeSuccess, downLoadeerror);
    console.log(downLoadeparam);
});
function downLoadeSuccess(resp){
    if(resp.returnMsg == "SUCCESS"){
        window.location = resp.download_url;
        layer.msg('下载成功',{icon:1,time:2000});

    }
}
function downLoadeerror(resp){
    layer.msg('下载失败',{icon:1,time:2000});
}