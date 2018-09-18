/**
 * Created by Administrator on 2017/5/27.
 */
// jQuery(function () {
var totalPage;
var page = 1;
var pagesize = 10;
var strL = {"action": "0", "pageNo": page, "pageSize": pagesize};
ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", strL, success, error);

function error() {
    console.log("error");
}

jQuery("#cancel").click(function () {
    layer_close();
    window.location.href = window.history.go(-1);
    ;
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
            var templateTypeName =''
            templateType = data[i].templateType;
            if(!templateType){
                templateTypeName == "--"
            }else{
                templateTypeName = templateType.name
            }
            $("#tbodyl").append("<tr class='text-c'>" +
                "<th ><input type='checkbox' name='wholeCheckBox' value=" + data[i]["id"] + "></th>" +
                "<td class='name'>" + (data[i]["name"]) + "</td>" +
                "<td style='width: 500px'>" + (data[i]["url"]) + "</td>" +
                "<td>" + ifUndefined(data[i]["desc"]) + "</td>" +
                "<td style='width: 200px'>" + ifUndefined(data[i]["createTime"]) + "</td>" +
                "<td>" + (data[i]["rootPath"]) + "</td>" +
                "<td>" + ifUndefined(templateTypeName) + "</td>" +
                "<td>" + showEncodeType(data[i]["encodeType"]) + "</td>" +
                "<td>" + showType(data[i]["requestType"]) + "</td>" +
                " <td class='td-manage'>" +
                "<a href='/developer/field/list.html?id=" + data[i]["id"] + "'  class='ml-5'title='查看字段' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
                "<i class='Hui-iconfont list_detail'>&#xe720;</i>" +
                "</a>" +
                "<a href='/developer/param/list.html?id=" + data[i]["id"] + "'  class='ml-5'title='查看参数' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
                "<i class='Hui-iconfont list_result'>&#xe60c;</i>" +
                "</a>" +
                "<a href='/developer/template/edit.html?id=" + data[i]["id"] + "'  class='ml-5'title='查看模板' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
                "<i class='Hui-iconfont list_copy'>&#xe636;</i>" +
                "</a>" +
                "<a type='submit' id='' style='text-decoration:none'  onclick='admin_del(this ,\"" + data[i]["id"] + "\")' title='删除'  data-toggle='tooltip' data-placement='top'>" +
                "<i class='Hui-iconfont list_delete'>&#xe6e2;</i>" +
                "</a>" +
                "</td>" +
                "</tr>");
        }
    }
}
function getTable1(resp1) {//添加表格数据
    if (resp1) {
        var type;
        data = resp1;
        $("#tbodyl").html("");
        for (var i = 0; i < data.length; i++) {
            var templateTypeName =''
            templateType = data[i].templateType;
            if(!templateType){
                templateTypeName == "--"
            }else{
                templateTypeName = templateType.name
            }
            $("#tbodyl").append("<tr class='text-c'>" +
                "<th ><input type='checkbox' name='wholeCheckBox' value=" + data[i]["id"] + "></th>" +
                "<td class='name'>" + (data[i]["name"]) + "</td>" +
                "<td style='width: 500px'>" + (data[i]["url"]) + "</td>" +
                "<td>" + ifUndefined(data[i]["type"]) + "</td>" +
                "<td style='width: 200px'>" + ifUndefined(data[i]["createTime"]) + "</td>" +
                "<td>" + (data[i]["rootPath"]) + "</td>" +
                "<td>" + ifUndefined(templateTypeName) + "</td>" +
                "<td>" + showEncodeType(data[i]["encodeType"]) + "</td>" +
                "<td>" + showType(data[i]["requestType"]) + "</td>" +
                " <td class='td-manage'>" +
                "<a href='/use/useList_edit.html?id=" + data[i]["id"] + "'  class='ml-5'title='查看字段' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
                "<i class='Hui-iconfont list_detail'>&#xe720;</i>" +
                "</a>" +
                "<a href='/use/useList_edit.html?id=" + data[i]["id"] + "'  class='ml-5'title='查看参数' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
                "<i class='Hui-iconfont list_result'>&#xe60c;</i>" +
                "</a>" +
                "<a href='/developer/template/edit.html?id=" + data[i]["id"] + "'  class='ml-5'title='查看模板' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
                "<i class='Hui-iconfont list_copy'>&#xe636;</i>" +
                "</a>" +
                "<a type='submit' id='' style='text-decoration:none'  onclick='admin_del(this ,\"" + data[i]["id"] + "\")' title='删除'  data-toggle='tooltip' data-placement='top'>" +
                "<i class='Hui-iconfont list_delete'>&#xe6e2;</i>" +
                "</a>" +
                "</td>" +
                "</tr>");
        }
    }
}

function gettable(resp1) {//添加表格数据
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


$("#Pagination").pagination(totalPage, {
    num_edge_entries: 1,
    num_display_entries: 4,
    items_per_page: 10,
    current_page: 0,
});
/*分页回调函数*/
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
        param = {"action": "0", "pageNo": page, "pageSize": pagesize}
        ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", param, success, error);
    } else {
        param = {"action": "0", "pageNo": 1, "pageSize": pagesize}
        ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", param, success, error);
    }
}

/*空值处理*/
function ifUndefined(val) {
    if (val == undefined || val == null || val == "-1" || val == "") {
        return "--";
    } else {
        return val;
    }
}


function showType(type) {
    if (type == 1) {
        return "GET"
    } else if (type == 0) {
        return "POST"
    } else {
        return "--"
    }
}

/*编码类型*/
function showEncodeType(type) {
    if (type == 0) {
        return "AUTO"
    } else if (type == 1) {
        return "UTF-8"
    } else if (type == 2) {
        return "GB2312"
    } else if (type == 3) {
        return "ISO8859-1"
    } else if (type == 4) {
        return "GBK"
    } else {
        return "--"
    }
}
/*删除操作*/
function admin_del(obj, id) {
    layer.confirm('确认要删除吗？', function (index) {
        template = {id: id};
        ajaxFunction("/templateMgmt", "POST", "JSON", "application/ json,charset=utf8", {
            "action": "1",
            "template": template,
            "type": "0"
        }, delsuccess, delsfail);
    });
}

/*排序*/
function tableSort() {//当前页按时间顺序排序
    var noVaildDataList = [];
    var vaildDataList = [];
    var log = $(".PX").attr("type");
    for (var i = 0; i < data.length; i++) {
        if (data[i]["createTime"] == undefined || data[i]["createTime"] == null) {
            noVaildDataList.push(data[i]);
        } else {
            vaildDataList.push(data[i]);
        }
    }
    if (log == "D") {
        vaildDataList.sort(
            function (a, b) {
                var t1 = new Date(a["createTime"]);
                var t2 = new Date(b["createTime"]);
                return t2 - t1;
            });//时间倒序\
        $(".PX i").html("&#xe6d6");
        $(".PX").attr("type", "Z");
    }
    if (log == "Z") {
        vaildDataList.sort(
            function (a, b) {
                var t1 = new Date(a["createTime"]);
                var t2 = new Date(b["createTime"]);
                return t1 - t2;
            });//时间正序
        $(".PX i").html("&#xe6d5");
        $(".PX").attr("type", "D");
    }
    data = vaildDataList.concat(noVaildDataList);
    getTable1(data);
}

$("#wholeCheckBox_title").click(function () {
    var whole = $("input:checkbox[name = 'wholeCheckBox']");
    if (!+$("#wholeCheckBox_title").attr("isoption")) {
        $("#wholeCheckBox_title").attr("isoption", 1);
        for (var i = 0; i < whole.length; i++) {
            whole[i].checked = true;
        }
    } else {
        $("#wholeCheckBox_title").attr("isoption", 0);
        for (var i = 0; i < whole.length; i++) {
            whole[i].checked = false;
        }
    }
});

/*批量删除*/
function datadel() {
    var checked = jQuery("input[type='checkbox']:checked");
    var str = "";
    var delParam = ""
        ;
    if (checked.length) {
        if (+$("#wholeCheckBox_title").attr("isoption")) {
            var ckeckLen = checked.length - 1;
        } else {
            var ckeckLen = checked.length;
        }
        layer.confirm('确认删除这' + (ckeckLen) + '项么？', function (index) {
            for (var i = 0; i < checked.length; i++) {
                if (checked[i].id == "wholeCheckBox_title") {
                    continue;
                }
                if (i == checked.length - 1) {
                    str += checked[i].value;
                    break;
                } else {
                    str += checked[i].value + ','
                }
            }
            console.log(str);
            delParam = {"ids": str, "type": "0"}
            ajaxFunction("/batchDel", "POST", "JSON", "application/ json,charset=utf8", delParam, function () {
                layer.msg('已删除!', {icon: 1, time: 1000});
                document.location.reload();
            }, function () {
                layer.msg('删除失败!', {icon: 1, time: 1000});
            });
        });
    } else {
        //此处请求后台程序，下方是成功后的前台处理……
        layer.msg('未选择删除对象', {icon: 1, time: 2000});
    }
}

/*删除成功*/
function delsuccess(resp) {
    layer.msg('删除成功!', {icon: 6, time: 1000});
    document.location.reload();
}

/*删除失败*/
function delsfail(resp) {
    layer.msg('删除失败!', {icon: 5, time: 1000});
}

// });


