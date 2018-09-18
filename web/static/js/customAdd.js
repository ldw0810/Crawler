/**
 * Created by Administrator on 2017/6/16.
 */
var self = this;
var dabaseID = "";
var timeId = "";
var proxyId = '';
var proxytype = '';
localStorage["id"] = '';
localStorage["timeId"] = '';
var dtype = '';
var workId = window.localStorage['ID'];
var dabaseid = window.localStorage['dabaseID'];
var proxyId = window.localStorage['proxyId'];
var proxytype = window.localStorage['proxytype'];
window.localStorage['ID'] = '';
window.localStorage['dabaseID'] = '';
window.localStorage['proxyId'] = '';
window.localStorage['proxytype'] = '';

$('.skin-minimal input').iCheck({
    checkboxClass: 'icheckbox-blue',
    radioClass: 'iradio-blue',
    increaseArea: '20%'
});

if (proxyId && proxyId !== '') {
    if (proxytype == '2') {
        $('#agent2').show();
        var str_json = {"id": proxyId, "type": "3"}
        ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, proxy1, error);
    } else if (proxytype == '3') {
        var str_json = {"id": proxyId, "type": "3"}
        $('#agent1').show();
        ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, proxy2, error);
    }
}

function validform() {
    return $("#form-url-add").validate({
        rules: {
            name: {
                required: true
            },
            url: {
                required: true
            },
            pageLimit: {
                required: true
            },
            pageOffset: {
                required: true
            }
            // parentId:{
            //     required: true
            // }
        }
    });
}


// 返回展示入库表格
var str_d = {"id": dabaseid, "type": "1"}
ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_d, cldbList, error);
function cldbList(res) {
    if (res.result) {
        if (res.result["type"] == "oracle") {
            dabaseID = res.result["id"]
            $("#configuresq0").show();
            $("#configuresq0 tbody").html("").append("<tr class='text-c'> " +
                "<td style='height: 32px'>" + res.result["host"] + "</td>" +
                "<td>" + res.result["port"] + "</td>" +
                "<td>" + res.result["username"] + "</td>" +
                "<td>" + "...." + "</td>" +
                "<td>" + res.result["dbname"] + "</td>" +
                "<td><a  class=' ml-5' onclick='edit_List(" + 0 + ")' style='text-decoration:none'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
                "</tr>");
        } else if (res.result["type"] == "sqlserver") {
            dabaseID = res.result["id"]
            $("#configuresq0").show();
            $("#configuresq0 tbody").html("").append("<tr class='text-c'> " +
                "<td style='height: 32px'>" + res.result["host"] + "</td>" +
                "<td>" + res.result["port"] + "</td>" +
                "<td>" + res.result["username"] + "</td>" +
                "<td>" + "...." + "</td>" +
                "<td>" + res.result["dbname"] + "</td>" +
                "<td><a  class=' ml-5' onclick='edit_List(" + 1 + ")' style='text-decoration:none'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
                "</tr>");

        } else if (res.result["type"] == "mysql") {
            dabaseID = res.result["id"]
            $("#configuresq0").show();
            $("#configuresq0 tbody").html("").append("<tr class='text-c'> " +
                "<td style='height: 32px'>" + res.result["host"] + "</td>" +
                "<td>" + res.result["port"] + "</td>" +
                "<td>" + res.result["username"] + "</td>" +
                "<td>" + "...." + "</td>" +
                "<td>" + res.result["dbname"] + "</td>" +
                "<td><a  class=' ml-5' onclick='edit_List(" + 2 + ")' style='text-decoration:none'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
                "</tr>");

        } else if (res.result["type"] == "hdfs") {
            dabaseID = res.result["id"]
            $("#configuresql").show();
            $("#configuresql tbody").html("").append("<tr class='text-c'>" +
                "<td style='height: 32px'>" + res.result["url"] + "</td>" +
                "<td>" + res.result["dbname"] + "</td>" +
                "<td><a  onclick='editList2()'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
                "</tr>");

        } else if (res.result["type"] == "kafka") {
            dabaseID = res.result["id"]
            $("#configuresq2").show();
            $("#configuresq2 tbody").html("").append("<tr class='text-c'>" +
                "<td style='height: 32px'>" + res.result["host"] + "</td>" +
                "<td>" + res.result["topic"] + "</td>" +
                "<td><a  onclick='editList3()'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
                "</tr>");

        }
    }

}


// 展示网站类型
ajaxFunction("/getContentTypeList", "POST", "JSON", "application/json,charset=utf8", null, typeList, error);
function typeList(res) {
    var arr = res.result;
    for (var i = 0; i < arr.length; i++) {
        $("#typeList").append("<option value='" + arr[i].id + "'>" + arr[i].name + "</option>");
    }
}

// 父子任务
window.parentShowId = function (obj) {
    $(".parentId").val(obj);

}

// 打开各种按钮弹窗
$("#select_one .iCheck-helper").click(function () {
    var s = $('input:radio[name="grapPeriod"]:checked').val();
    if (s == 2) {
        admin_add1('配置采集周期', '/use/editPL.html', '1100', '650');
        // $("#configureHz").show();
        // $("#configuresq0").hide();
        // $("#configuresq1").hide();
        // $("#configuresq2").hide();

    }
});

$("#select_two .iCheck-helper").click(function () {
    admin_add1('配置代理', '/use/agent.html', '800', '600');
});

$("#select_three .iCheck-helper").click(function () {
    admin_add1('静态代理', '/use/agentStatic.html', '800', '600');
});
$(".hov").click(function () {
    admin_add1('配置频率', '/use/editPL.html', '1100', '650');
});
$(".edit1").click(function () {
    admin_add1('配置频率', '/use/dataBase_two.html', '1100', '650');
});
$(".edit2").click(function () {
    admin_add1('配置频率', '/use/dataBase_three.html', '800', '600');
});
$(".edit0").click(function () {
    admin_add1('配置频率', '/use/dataBase_one.html', '800', '600');
});
$(".sqledit0").click(function () {
    admin_add1('配置频率', '/use/dataBase_three.html', '800', '600');
});
$("#parentTask").click(function () {
    admin_add1('选择父任务', '/use/parentList.html', '800', '600');
});

$("#childsList").click(function () {
    admin_add1('选择父子任务', '/use/parentList.html', '800', '600');
});

$("#select_db1 .iCheck-helper").click(function () {
    localStorage["id"] = '';
    var s = $('input:radio[name="databaseId_T"]:checked').val();
    if (s == 0) {
        admin_add1('配置入库类型ORACLE', '/use/dataBase_one.html?s=0', '800', '600');
        $("#configuresq0").hide();
        $("#configuresq1").hide();
        $("#configuresq2").hide();
        // $("#configureHz").hide();
    }
})
$("#select_db2 .iCheck-helper").click(function () {
    localStorage["id"] = '';
    var s = $('input:radio[name="databaseId_T"]:checked').val();
    if (s == 1) {
        admin_add1('配置入库类型SQLSERVER', '/use/dataBase_one.html?s=1', '800', '600');
        $("#configuresq0").hide();
        $("#configuresq1").hide();
        $("#configuresq2").hide();
        // $("#configureHz").hide();
    }
});
$("#select_db3 .iCheck-helper").click(function () {
    localStorage["id"] = '';
    var s = $('input:radio[name="databaseId_T"]:checked').val();
    if (s == 2) {
        admin_add1('配置入库类型MYSQL', '/use/dataBase_one.html?s=2', '800', '600');
        $("#configuresq0").hide();
        $("#configuresq1").hide();
        $("#configuresq2").hide();
        // $("#configureHz").hide();
    }
});
$("#select_db4 .iCheck-helper").click(function () {
    localStorage["id"] = '';
    var s = $('input:radio[name="databaseId_T"]:checked').val();
    if (s == 3) {
        admin_add1('配置入库类型HDFS', '/use/dataBase_two.html', '800', '600');
        $("#configuresq0").hide();
        $("#configuresq0").hide();
        $("#configuresq2").hide();
        // $("#configureHz").hide();
    }
});
$("#select_db5 .iCheck-helper").click(function () {
    localStorage["id"] = '';
    var s = $('input:radio[name="databaseId_T"]:checked').val();
    if (s == 4) {
        admin_add1('配置入库类型KAFKA', '/use/dataBase_three.html', '800', '600');
        $("#configuresq0").hide();
        $("#configuresql").hide();
        $("#configuresq0").hide();
        // $("#configureHz").hide();

    }
});

// ORACLE入库
window.parentMethod = function (obj) {
    var str_json = {"id": obj, "type": "1"}
    dabaseID = obj;
    $("#databaseIdAdd").val(obj);
    $("#configuresq0").show();
    $("#configuresq1").hide();
    $("#configuresq2").hide();
    ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, dbList, error);
}
function dbList(res) {
    var obj = "";
    if (res.result['type'] == "oracle") {
        obj = "0";
    } else if (res.result['type'] == "sqlserver") {
        obj = "1";
    } else if (res.result['type'] == "mysql") {
        obj = "2";
    }
    $("#configuresq0 tbody").html("").append("<tr class='text-c'> " +
        "<td style='height: 32px'>" + res.result["host"] + "</td>" +
        "<td>" + res.result["port"] + "</td>" +
        "<td>" + res.result["username"] + "</td>" +
        "<td>" + "...." + "</td>" +
        "<td>" + res.result["dbname"] + "</td>" +
        "<td><a  class='edit0 ml-5' onclick='edit_List(" + obj + ")' style='text-decoration:none'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
        "</tr>");
}


window.hideTable = function (obj) {
    if (obj == "false") {
        jQuery("#configuresq0").hide();
    }
}

window.proxyId = function (obj) {
    proxyId = obj;
}

window.proxyManager = function (obj) {
    var str_json = {"id": obj, "type": "3"}
    proxyId = obj;
    proxytype = "2";
    jQuery("#agent2").show();
    jQuery("#agent1").hide();
    ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, proxy1, error);
}

window.proxyManager1 = function (obj) {
    var str_json = {"id": obj, "type": "3"}
    proxyId = obj;
    proxytype = "3";
    jQuery("#agent1").show();
    jQuery("#agent2").hide();
    ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, proxy2, error);


}
function proxy1(res) {
    $("#agent2 tbody").html("").append("<tr class='text-c'>" +
        "<td style='height: 32px'>" + res.result.proxy.hostName + "</td>" +
        "<td>" + res.result.proxy.port + "</td>" +
        "<td style='height: 32px'>" + res.result.proxy.userName + "</td>" +
        "<td   type='password' style='width: 50px'>" + "...." + "</td>" +
        "<td><a class='agent' onclick='agent()'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
        "</tr>");
}
function proxy2(res) {
    $("#agent1 tbody").html("").append("<tr class='text-c'>" +
        "<td style='height: 32px'>" + res.result.proxy.authUrl + "</td>" +
        "<td><a class='agent2' onclick='agent2()'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
        "</tr>");
}
function agent2() {
    localStorage["id"] = proxyId;
    admin_add1('配置频率', '/use/agent.html', '800', '600');
}
function agent() {
    localStorage["id"] = proxyId;
    admin_add1('配置频率', '/use/agent1.html', '800', '600');
}

// HDFS入库
window.parentMethod1 = function (obj) {
    var str_json = {"id": obj, "type": "1"}
    dabaseID = obj;
    $("#databaseIdAdd").val(obj);
    $("#configuresql").show();
    $("#configuresq0").hide();
    $("#configuresq2").hide();
    ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, dbList1, error);
}

function dbList1(res) {
    $("#configuresql tbody").html("").append("<tr class='text-c'>" +
        "<td style='height: 32px'>" + res.result["url"] + "</td>" +
        "<td>" + res.result["dbname"] + "</td>" +
        "<td><a class='edit0' onclick='editList2()'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
        "</tr>");
}

window.hideTable2 = function (obj) {
    if (obj == "false") {
        $("#configuresql").hide();
    }
}
window.hideTable3 = function (obj) {
    if (obj == "false") {
        $("#configuresq2").hide();
    }
}

// KAFA入库
window.parentMethod2 = function (obj) {
    var str_json = {"id": obj, "type": "1"}
    dabaseID = obj;
    $("#databaseIdAdd").val(obj);
    $("#configuresq2").show();
    $("#configuresq1").hide();
    $("#configuresq0").hide();
    ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, dbList2, error);
}

function dbList2(res) {

    $("#configuresq2 tbody").html("").append("<tr class='text-c'>" +
        "<td style='height: 32px'>" + res.result["host"] + "</td>" +
        "<td>" + res.result["topic"] + "</td>" +
        "<td><a class='edit0' onclick='editList3()'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
        "</tr>");
}

// 采集周期
window.parentTime = function (obj) {
    timeId = obj;
    var str = "";
    var str_json = {"id": obj, "type": "4"};
    ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, timeList, error);


}
function timeList(res) {
    var stime, etime, str, hzstr = "", wd = "每周", md = "每月", yd = "每年";
    if (res.result["startTime"]) {
        stime = res.result["startTime"].split(" ")[0];
    } else {
        stime = "立即执行";
    }
    if (res.result["repeatTime"] == "0") {
        str = "只执行一次";
    } else if (res.result["repeatTime"] == "1") {
        str = "执行多次";
    }

    if (!res.result["weekDay"] && !res.result["monthDay"] && !res.result["yearMonth"]) {
        if (res.result["repeatTime"] == "1") {
            hzstr = "每日" + res.result["hour"] + "时" + res.result["minute"] + "分";
            wd = "", md = "", yd = "";
        } else {
            hzstr = res.result["hour"] + "时" + res.result["minute"] + "分";
            wd = "", md = "", yd = "";
        }
    } else {
        if (res.result["weekDay"]) {
            wd += res.result["weekDay"];
        } else {
            wd = "";
        }
        if (res.result["monthDay"]) {
            md += res.result["monthDay"];
        } else {
            md = "";
        }
        if (res.result["yearMonth"]) {
            yd += res.result["yearMonth"];
        } else {
            yd = "";
        }

    }

    if (res.result["endTime"]) {
        etime = res.result["endTime"].split(" ")[0];
    } else {
        etime = "无限期";
    }
    $("#configureHz tbody").html("").append("<tr class='text-c'>" +
        "<td style='height: 32px'>" + stime + "</td>" +
        "<td>" + str + "</td>" +
        "<td>" + yd + md + wd + hzstr + "</td>" +
        "<td>" + etime + "</td>" +
        "<td><a class='edit0' onclick='editPeriod()'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
        "</tr>");
    $("#configureHz").show();
}


function editPeriod() {
    localStorage["timeId"] = timeId;
    admin_add1('配置采集周期', '/use/editPL.html', '1100', '650');
}


// 下一步保存任务
$("#nextBtn").click(function () {
    if (workId) {
        str_json = {"action": "2", "delFlag": false, "status": "0", "id": workId, "proxyId": proxyId};
    } else {
        str_json = {
            "action": "0",
            "delFlag": false,
            "status": "0",
            "taskJobTimerId": self.timerJobTimerId,
            "proxyId": proxyId
        };
    }
    // $('input:radio[name="databaseId"]:checked').val(self.databaseid);
    $("#radio-p1").val(self.ptype);
    $("input,select").each(function (index, col) {
        var value = null;
        var key = $(this).attr("name");
        if (!key) {
            return true
        }
        switch (key) {
            case "proxyType":
                value = $('input:radio[name="proxyType"]:checked').val();
                break;
            case "grapPeriod":
                value = $('input:radio[name="grapPeriod"]:checked').val();
                break;
            case "databaseId":
                value = dabaseID;
                break;
            case "encodeTypeId":
                value = $('input:radio[name="encodeTypeId"]:checked').val();
                break;
            default:
                value = $(this).val()
        }
        str_json[key] = value;
    })
    console.log(JSON.stringify(str_json));
    if (validform().form()) {
        ajaxFunction("/taskMgmt", "POST", "JSON", "application/json,charset=utf8", str_json, insertSuccess, error);

    }

});

function insertSuccess(res) {
    if (res.returnMsg == 'Task name already exist!') {
        layer.msg('任务名称已存在,请重试！', {icon: 5, time: 2000});
    } else {
        var parentId = res.result["id"]
        window.location.href = "/use/webModel.html?parentId=" + parentId + "&" + "proxytype=" + proxytype;
        workId = parentId;
    }
}


function error() {

}


function edit_List(obj) {
    if (obj == "0") {
        admin_add1('配置入库类型ORACLE', '/use/dataBase_one.html?s=' + obj, '800', '600');
    } else if (obj == "1") {
        admin_add1('配置入库类型SQLSERVER', '/use/dataBase_one.html?s=' + obj, '800', '600');
    } else if (obj == "2") {
        admin_add1('配置入库类型MYSQL', '/use/dataBase_one.html?s=' + obj, '800', '600');
    }
    localStorage["id"] = dabaseID;
}

function editList2(obj) {
    admin_add1('配置入库类型HDFS', '/use/dataBase_two.html', '800', '600');
    localStorage["id"] = dabaseID;
}
function editList3() {
    admin_add1('配置入库类型KAFKA', '/use/dataBase_three.html', '800', '600');
    localStorage["id"] = dabaseID;
}


function admin_add1(title, url, w, h) {
    data_window = layer_show(title, url, w, h)
}
$("#cancel").click(function () {
    window.location.href = window.history.go(-1);
})


