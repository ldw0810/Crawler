/**
 * Created by Administrator on 2017/6/19.
 */
var totalPage;
var page = 1;
var pagesize = 10;
id = window.location.search.split("=")[1];
param = {"taskJobId": id, "action": "1", "pageNo": page, "pageSize": pagesize}
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
                "</tr>");
        }
    }
}
function error() {

}
// 分页
$("#Pagination").pagination(totalPage, {
    num_edge_entries: 1,
    num_display_entries: 4,
    items_per_page: 10,
    current_page: 0,
});
function result(current_page, items_per_page, obj) {
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
        param = {"action": "1", "pageNo": page, "pageSize": pagesize, "taskJobId": id}
        ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", param, detail, error);
    } else {
        param = {"action": "1", "pageNo": 1, "pageSize": pagesize, "taskJobId": id}
        ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", param, detail, error);
    }
}