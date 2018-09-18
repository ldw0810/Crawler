/**
 * Created by Administrator on 2017/5/27.
 */
// jQuery(function () {

var totalPage;
var page = 1;
var pagesize = 10;

var strL = {"action": "0", "pageNo": page, "pageSize": pagesize};
// var strL = {"action": "0"};
ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", strL, success, error);

function error() {
    console.log("error");
}

jQuery("#cancel").click(function () {
    layer_close();
})

function success(resp) {
    resp1 = resp['result'];
    totalPage = resp['count'];//接口获得
    getTable(resp1);
}

function getTable(resp1) {//添加表格数据
    if (resp1) {
        var type;
        totalPage = resp1["count"];
        data = resp1.jobTemplateList;
        $("#tbodyl").html("");
        for (var i = 0; i < data.length; i++) {
            $("#tbodyl").append(
                "<tr class='text-c'>" +
                "<th ><input type='radio' name='radio_tj' id=" + data[i].id + "></th>" +
                "<td >" + data[i].name + "</td>" +
                "<td >" + data[i].url + "</td>" +
                "</tr>");
        }
    }
}

/*分页回调函数*/
function result(current_page, items_per_page, obj) {
    $('#pageNum').val(items_per_page);
    page = current_page + 1;
    pagesize = items_per_page;
    if (current_page != 0) {
        param = {"action": "0", "pageNo": page, "pageSize": pagesize}
        ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", param, success, error);
    } else {
        param = {"action": "0", "pageNo": 1, "pageSize": pagesize}
        ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", param, success, error);
    }
}

/*首次分页*/
jQuery("#Pagination").pagination(totalPage, {
    num_edge_entries: 1,
    num_display_entries: 4,
    items_per_page: 10,
    current_page: 0,
})
function savebtn() {
    judgeRadioClicked();
    layer_close();
}
function cancle() {
    layer_close();
}

/*判断哪个选中了*/
function judgeRadioClicked() {
    var radios = document.getElementsByName("radio_tj");
    for (var i = 0; i < radios.length; i++) {
        if (radios[i].checked) {
            window.parent.parentShowId(radios[i].id);
        }
    }

}






