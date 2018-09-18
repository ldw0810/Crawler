/**
 * Created by Administrator on 2017/6/19.
 */
var totalPage;
var page = 1;
var pagesize = 10;
taskJobId = window.location.search.split("=")[1];
param = {"taskJobId": taskJobId, "action": "1", "pageNo": page, "pageSize": pagesize}
ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", param, detail, error)
function detail(resp) {
    if (resp.result) {
        $("#tbodyl").html("");
        totalPage = resp.result["count"];
        var tlist = resp.result["jobTemplateList"];
        for (var i = 0; i < tlist.length; i++) {
            data = resp.result.jobTemplateList;
            $("#tbodyl").append("<tr class='text-c'>" +
                "<td>" + data[i].name + "</td>" +
                "<td>" + data[i].url + "</td>" +
                "<td class='td-manage'>" +
                "<a style='cursor: pointer' style='text-decoration:none' title='查看' data-toggle='tooltip' data-placement='top'>" +
                "<i class='Hui-iconfont list_result' onclick='results(this,\"" + data[i]["id"] + "\",\"" + data[i]["parentId"] + "\")'>&#xe695;</i>" +
                "</a>" +
                "</td>" +
                "</tr>");
        }
    }
}
function error() {

}
function results(obj,id,parentId) {
    window.location.href = '/use/querylist.html?taskJobId=' + taskJobId +"&"+ 'id=' + id+"&"+ 'parentId='+parentId;
}

// 分页
$("#Pagination").pagination(totalPage, {
    num_edge_entries: 1,
    num_display_entries: 4,
    items_per_page: 10,
    current_page: 0,
});
function result(current_page, items_per_page, maxPage,obj) {
    $('#pageNum').val(items_per_page);
    page = current_page + 1;
    pagesize = items_per_page;
    lastPage = page;
    if(page > maxPage){
        page = maxPage;
        $(".last_text").click();
    }
    if(page <= 0){
        page = 1;
    }
    if (current_page != 0) {
        param = {"action": "1", "pageNo": page, "pageSize": pagesize, "taskJobId": taskJobId}
        ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", param, detail, error);
    } else {
        param = {"action": "1", "pageNo": 1, "pageSize": pagesize, "taskJobId": taskJobId}
        ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", param, detail, error);
    }
}

jQuery(".navBar_under li").click(function () {
    jQuery(this).siblings('li').removeClass('check');
    jQuery(this).addClass('check');
})
jQuery(".navBar_under").css("cursor", "pointer")