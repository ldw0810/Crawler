/**
 * Created by Administrator on 2017/5/22.
 */

var totalPage;
var page = 1;
var pagesize = 10;
var arrCheck = [];
var time = 1;
$('.skin-minimal input').iCheck({
    checkboxClass: 'icheckbox-blue',
    radioClass: 'iradio-blue',
    increaseArea: '20%'
});
paramList = window.location.search.substring(1).split("&");
ID = null;
proxytype = null;
for (key in paramList) {
    param = paramList[key]
    params = param.split("=")
    if (params[0] == "parentId") {
        ID = params[1]
    }
    if (params[0] == "databaseId") {
        datsbaseID = params[1]
    }
    if (params[0] == "proxyId") {
        proxyId = params[1]
    }
    if (params[0] == "proxytype") {
        proxytype = params[1]
    }
}

/*获取模板*/
str_json = {"id": ID, "type": "5"}
ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, showTemplate, error);


/*获取模板后展示*/
function showTemplate(resp) {
    if (resp.result.jobTemplateFieldList.length) {
        $('#showOrNot').show();
        $("#saveBtn").removeClass("disabled").addClass("btn-primary");
        console.log(resp)
        var length = resp.result.jobTemplateFieldList.length;
        for (var i = 0; i < length; i++) {
            var result = resp.result.jobTemplateFieldList[i];
            jobTemplateId = result.jobTemplateId;
            $("#agent").append("<tr class='text-c'>" +
                "<tr style='height: 60px'>" +
                "<th ><input type='checkbox' name='wholeCheckBox' value=" + result["id"] + "></th>" +
                "<td >" + result.fieldNameCn + "</td>" +
                "<td >" + result.fieldValue + "</td>" +
                "</tr>" +
                "</tr>"
            );
        }
        var whole = $("input:checkbox[name = 'wholeCheckBox']");
        $("#wholeCheckBox_title").attr("isoption", 1);
        for (var i = 0; i < whole.length; i++) {
            whole[i].checked = true;
        }
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
$("#chooseT1").click(function () {
    $(".template_one").show();
    $("#chooseT1").addClass("btn-primary");
    $("#chooseT2").removeClass("btn-primary");
    $("#seachArea").css("display", "none");
    $(".template_two").hide();
    $("#saveBtn").removeClass("btn-primary").addClass("disabled");
});
$("#chooseT2").click(function () {
    $(".template_two").show();
    $(".template_one").hide();
    $("#seachArea").css("display", "inline-block");
    $("#chooseT2").addClass("btn-primary");
    $("#chooseT1").removeClass("btn-primary");
    $("#saveBtn").removeClass("disabled").addClass("btn-primary");
});

var strL = {"action": "0", "pageNo": page, "pageSize": pagesize,"parentId":"-1"};
ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", strL, seccessList, error);
function seccessList(res) {
    if (res.result) {
        $("#tlistBody tbody").html("");
        $("#chooseAll").attr("isoption", 0);
        $("#chooseAll").css("background-image", "url('/static/images/g2.jpg')");
        totalPage = res.result["count"];
        var tlist = res.result["jobTemplateList"];
        if (tlist.length) {
            for (var i = 0; i < tlist.length; i++) {
                $("#tlistBody tbody").append("<tr class='text-c'>" +
                    "<tr style='height: 60px'>" +
                    "<td><input type='checkbox'name='result' onclick='showDetail(this)' id='" + tlist[i].id + "'></td>" +
                    "<td>" + tlist[i].id +
                    "<td>" + ifUndefined(tlist[i].name) + "</td>" +
                    "<td>" + ifUndefined(tlist[i].createUserId) + "</td>" +
                    "</td>" +
                    "<td>" + ifUndefined(tlist[i].url) + "</td>" +
                    "</tr>" +
                    "</tr>"
                );
            }
            if (arrCheck.length) {
                for (var i = 0; i < arrCheck.length; i++) {
                    if (arrCheck[i] == page) {
                        var whole = $("input:checkbox[name = 'result']");
                        $("#chooseAll").attr("isoption", 1);
                        $("#chooseAll").css("background-image", "url('/static/images/g1.jpg')");
                        for (var i = 0; i < whole.length; i++) {
                            whole.get(i).checked = true;
                        }
                    }
                }
            }
        }
    }


}

function showDetail(obj) {
    if ($(obj).is(':checked')) {
        var id = $(obj).attr("id");
        var strL = {"id": id, "type": "2"};
        ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", strL, showSuccess, error);
    } else {
        if ($(obj).parents("tr").next().attr("class") == "") {
            $(obj).parents("tr").next().remove();
        }
    }
}

function showSuccess(res) {
    if (res.result) {
        var list = res.result["jobTemplateFieldList"];
        var id = res.result["jobTemplate"].id;
        console.log(list);
        if (list.length) {
            if ($("#" + id).parents("tr").next().attr("class") == "") {
                $("#" + id).parents("tr").next().remove();
            }
            $("#" + id).parents("tr").after("<div class='' style='padding-left:20px;width: 350%;'></div>")
            for (var i = 0; i < list.length; i++) {
                $("#" + id).parents("tr").next().append("<span style='margin-right:10px'><input type='checkbox'name='resChild' id='" + list[i].id + "'>" + list[i].fieldNameCn + "</span><br/>");
            }
        }
    }

}


var jobTemplateId = "";
function checkSubmit(file) {
    if (!file || !file.value) {
        layer.msg('请导入模板!', {icon: 5, time: 2000});
        return false
    }
    return true
}
function loadJson(json) {
    if (json.result.jobTemplateFieldList.length) {
        var length = json.result.jobTemplateFieldList.length;
        for (var i = 0; i < length; i++) {
            var result = json.result.jobTemplateFieldList[i];
            jobTemplateId = result.jobTemplateId;
            $("#agent").append("<tr class='text-c'>" +
                "<tr style='height: 60px'>" +
                "<th ><input type='checkbox'  id='wholeCheckBox_title' name='wholeCheckBox' value=" + result["id"] + "></th>" +
                "<td >" + result.fieldNameCn + "</td>" +
                "<td >" + result.fieldValue + "</td>" +
                "</tr>" +
                "</tr>"
            );
        }
        $("#saveBtn").removeClass("disabled").addClass("btn-primary");
        $('#showOrNot').show();
        $("#wholeCheckBox_title").attr("isoption", 0);
    }
}

function chooseAllBox() {
    var whole = $("input:checkbox[name = 'result']");
    if (!+$("#chooseAll").attr("isoption")) {
        $("#chooseAll").attr("isoption", 1);
        $("#chooseAll").css("background-image", "url('/static/images/g1.jpg')");
        for (var i = 0; i < whole.length; i++) {
            whole.get(i).checked = true;
        }
        arrCheck.push(page);
    } else {
        $("#chooseAll").attr("isoption", 0);
        for (var i = 0; i < whole.length; i++) {
            whole.get(i).checked = false;
        }
        $("#chooseAll").css("background-image", "url('/static/images/g2.jpg')");
    }

}
function savemould() {
    if ($("#chooseT1").hasClass("btn-primary")) {
        var taskJobId = ID;
        var div = document.getElementById("agent");
        var inputs = div.getElementsByTagName("input");
        var chooseIds = '';
        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].id == "wholeCheckBox_title") {
                continue;
            }
            if (inputs[i].checked == true) {
                chooseIds += $(inputs[i]).data("id") + ',';
            }
        }
        var str_json = {"taskJobId": taskJobId, "jobTemplateId": jobTemplateId, "fieldIds": chooseIds, "type": "0"}
        console.log(JSON.stringify(str_json));
        ajaxFunction("/taskJobReField", "POST", "JSON", "application/json,charset=utf8", str_json, mould, error);

    } else {
        var json = {};
        var taskJobId = ID;
        var templates = [];
        $('input[name="result"]:checked').each(function () {
            var id = $(this).attr("id");
            if ($("#" + id).parents("tr").next().attr("class") == "") {
                var obj = $("#" + id).parents("tr").next();
                var list = $(obj).find(":checkbox");
                if (list.length) {
                    var str = "";
                    for (var i = 0; i < list.length; i++) {
                        if (list[i].checked == true) {
                            str += $(list[i]).attr("id") + ',';
                        }
                    }
                    str = str.substring(0, str.length - 1);
                    json = {"id": id, "fieldIds": str};
                }

            }

            templates.push(json);
        });
        var count=0;
        for (var i = 0; i < templates.length; i++) {
            if (templates[i]["fieldIds"] == "") {
                ++count;
            }
        }
        if (count == templates.length) {
            layer.msg('请选择字段!', {icon: 5, time: 2000});
        } else {
            var str_json = {"taskJobId": taskJobId, "templates": templates};
            ajaxFunction("/saveTaskJobTemplate", "POST", "JSON", "application/json,charset=utf8", str_json, mould2, error);
        }


    }


}

function mould2() {
    window.location.href = "/use/list.html?username=" + "dGVzdA==" + "&" + "password=" + "MTIzNDU2";
}
function mould() {
    // str_json = {"action": "2", "id": ID, "jobTemplateId": jobTemplateId};
    // ajaxFunction("/taskMgmt", "POST", "JSON", "application/json,charset=utf8", str_json, function () {
    // }, error);
    window.location.href = "/use/list.html?username=dGVzdA==&password=MTIzNDU2";

}

function error(resp) {
    console.log(resp + "/fail");
}
function success(resp) {
    console.log(resp + "success");
}


function cancle() {
    window.localStorage["proxytype"] = proxytype;
    str_json = {"id": ID, "type": "0"}
    ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, successResult, error);
    window.location.href = window.history.go(-2);
}
$("#cancelBtn").click(function () {
    $("#debug").removeClass("btn-warning");
});

function successResult(resp) {
    if (resp.result.taskJob) {
        var taskJob = resp.result.taskJob;
        window.localStorage["ID"] = ID;
        window.localStorage["dabaseID"] = taskJob.databaseId;
        window.localStorage["proxyId"] = taskJob.proxyId;
    }

}

// 分页
$("#Pagination").pagination(totalPage, {
    num_edge_entries: 1,
    num_display_entries: 4,
    items_per_page: 10,
    current_page: 0,
});
/*分页回调函数*/
function result(current_page, items_per_page, obj) {
    page = current_page + 1;
    pagesize = items_per_page;
    $('#pageNum').val(items_per_page);
    var search_content = $("#input-text").val().trim();
    if (time) {//搜索和首次进入不加载ajax
        time = 0;
    } else {
        if (current_page != 0) {
            param = {"action": "0", "name": search_content, "pageNo": page, "pageSize": pagesize,"parentId":"-1"}
            ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", param, seccessList, error);
        } else {
            param = {"action": "0", "name": search_content, "pageNo": 1, "pageSize": pagesize,"parentId":"-1"}
            ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", param, seccessList, error);
        }
    }
}
/*全选*/
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

function error(resp) {
    console.log(resp + "/fail");
}
function success(resp) {
    console.log(resp + "success");
}
$("#cancelBtn").click(function () {
    $("#debug").removeClass("btn-warning");
});

function search() {
    var search_content = $("#input-text").val().trim();
    var strL = {"action": "0", "name": search_content, "pageNo": 1, "pageSize": pagesize,"parentId":"-1"};
    ajaxFunction("/loadTemplateList", "POST", "JSON", "application/json,charset=utf8", strL, seccessList, error);
    $("#Pagination").pagination(totalPage, {
        num_edge_entries: 1,
        num_display_entries: 4,
        items_per_page: pagesize,
        current_page: 0,
    });
}