var taskJobId = window.location.search.split("=")[1];
var proxy = '';
var taskJobTimerId = '';
var proxytype = '';
var proxyId = '';
var data = '';
var str_json = {"id": taskJobId, "type": "0"}
var timeId = "", dabaseID = "";
var dabaseid = window.localStorage['dabaseID'];
window.localStorage['dabaseID'] = '';
var timerJobTimerId;

$('.skin-minimal input').iCheck({
    checkboxClass: 'icheckbox-blue',
    radioClass: 'iradio-blue',
    increaseArea: '20%'
});
$("#select_three .iCheck-helper").click(function () {
    admin_add1('静态代理', '/use/agentStatic.html', '800', '600');
    $("#agent1").hide();
    $("#agent2").hide();
});

$("#select_two .iCheck-helper").click(function () {
    admin_add1('配置代理', '/use/agent.html', '800', '600');
});


// $("#childsList").click(function () {
//     admin_add1('查看父子任务', '/use/parentList.html', '800', '600');
// });


// 展示网站类型
ajaxFunction("/getContentTypeList", "POST", "JSON", "application/json,charset=utf8", null, typeList, error);
function typeList(res) {
    var arr = res.result;
    for (var i = 0; i < arr.length; i++) {
        $("#typeList").append("<option value='" + arr[i].id + "'>" + arr[i].name + "</option>");
    }
}
window.parentShowId = function (obj) {
    $(".parentId").val(obj);

}
ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, taskList, error);


function success() {
}

function error() {
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


function dbSource(res) {
    if (res.result) {
        var type = res.result.type;
        var sss = res.result.id;
        $("#databaseIdEl").val(sss)
        if (type == "hdfs") {
            $("#radio-db4").parent().addClass("checked");
            $("#radio-db4").get(0).checked = true;
            $("#configuresq1").show();
            $("#radio-db4").val(sss);
            $("#configuresq1 tbody").html("").append("<tr class='text-c'>" +
                "<td style='height: 32px'>" + res.result["host"] + "</td>" +
                "<td>" + res.result["topic"] + "</td>" +
                "<td><a  onclick='editList2()'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
                "</tr>");

        } else if (type == "kafka") {
            $("#radio-db5").parent().addClass("checked");
            $("#radio-db5").get(0).checked = true;
            $("#configuresq2").show();
            $("#radio-db5").val(sss);
            $("#configuresq2 tbody").html("").append("<tr class='text-c'>" +
                "<td style='height: 32px'>" + res.result["host"] + "</td>" +
                "<td>" + res.result["topic"] + "</td>" +
                "<td><a class='edit0' onclick='editList3()'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
                "</tr>");
        } else if (type == "mysql") {
            $("#configuresq0").show();
            $("#radio-db3").parent().addClass("checked");
            $("#radio-db3").get(0).checked = true;
            $("#radio-db3").val(sss);
            $("#configuresq0 tbody").html("").append("<tr class='text-c'>" +
                "<td style='height: 32px'>" + res.result["host"] + "</td>" +
                "<td>" + res.result["port"] + "</td>" +
                "<td>" + res.result["username"] + "</td>" +
                "<td>" + "...." + "</td>" +
                "<td>" + res.result["dbname"] + "</td>" +
                "<td><a  class='edit0 ml-5' onclick='edit_List(" + 2 + ")' style='text-decoration:none'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
                "</tr>");
        } else if (type == "sqlserver") {
            $("#configuresq0").show();
            $("#radio-db2").parent().addClass("checked");
            $("#radio-db2").get(0).checked = true;
            $("#radio-db2").val(sss);
            $("#configuresq0 tbody").html("").append("<tr class='text-c'>" +
                "<td style='height: 32px'>" + res.result["host"] + "</td>" +
                "<td>" + res.result["port"] + "</td>" +
                "<td>" + res.result["username"] + "</td>" +
                "<td>" + "...." + "</td>" +
                "<td>" + res.result["dbname"] + "</td>" +
                "<td><a  class='edit0 ml-5' onclick='edit_List(" + 1 + ")' style='text-decoration:none'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
                "</tr>");
        } else if (type == "oracle") {
            $("#configuresq0").show();
            $("#radio-db1").parent().addClass("checked");
            $("#radio-db1").get(0).checked = true;
            $("#radio-db1").val(sss);
            $("#configuresq0 tbody").html("").append("<tr class='text-c'>" +
                "<td style='height: 32px'>" + res.result["host"] + "</td>" +
                "<td>" + res.result["port"] + "</td>" +
                "<td>" + res.result["username"] + "</td>" +
                "<td>" + "...." + "</td>" +
                "<td>" + res.result["dbname"] + "</td>" +
                "<td><a  class='edit0 ml-5'  onclick='edit_List(" + 0 + ")' style='text-decoration:none'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
                "</tr>");
        }

    }

}
function grap(res) {
    if (res.result) {
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
    } else {
        $("#configureHz").hide();
    }
}

function editPeriod() {
    localStorage["timeId"] = timeId;
    admin_add1('配置采集周期', '/use/editPL.html', '1100', '650');
}

window.parentTime = function (obj) {
    timerJobTimerId = obj;
    var str = "";
    var str_json = {"id": obj, "type": "4"};
    ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, grap, error);

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

window.parentMethod = function (obj) {
    var str_json = {"id": obj, "type": "1"}
    dabaseID = obj;
    $("#configuresq0").show();
    $("#configuresq1").hide();
    $("#configuresq2").hide();
    ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, dbSource, error);
}

function editList2() {
    admin_add1('配置入库类型', '/use/dataBase_two.html', '800', '600');
    localStorage["id"] = dabaseID;
}

window.parentMethod1 = function (obj) {
    var str_json = {"id": obj, "type": "1"}
    dabaseID = obj;
    $("#configuresql").show();
    $("#configuresq0").hide();
    $("#configuresq2").hide();
    ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, dbSource1, error);
}

function editList3() {
    admin_add1('配置入库类型', '/use/dataBase_three.html', '800', '600');
    localStorage["id"] = dabaseID;
}
window.parentMethod2 = function (obj) {
    var str_json = {"id": obj, "type": "1"}
    dabaseID = obj;
    $("#configuresq2").show();
    $("#configuresq1").hide();
    $("#configuresq0").hide();
    ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, dbSource2, error);
}

function dbSource1(res) {
    $("#configuresql tbody").html("").append("<tr class='text-c'>" +
        "<td style='height: 32px'>" + res.result["url"] + "</td>" +
        "<td>" + res.result["dbname"] + "</td>" +
        "<td><a class='edit0' onclick='editList2()'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
        "</tr>");
}

function dbSource2(res) {
    $("#configuresq2 tbody").html("").append("<tr class='text-c'>" +
        "<td style='height: 32px'>" + res.result["host"] + "</td>" +
        "<td>" + res.result["topic"] + "</td>" +
        "<td><a  onclick='editList3()'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
        "</tr>");
}

window.hideTable = function (obj) {
    if (obj == "false") {
        jQuery("#configuresq0").hide();
    }
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

function validform() {
    return $("#form-url-add").validate({
        rules: {
            name: {
                required: true
            },
            pageLimit: {
                required: true
            },
            pageOffset: {
                required: true
            },
            url: {
                required: true
            }
            // parentId: {
            //     required: true
            // }
        }
    });
}
$("#nextBtn").click(function () {
    str_json = {
        "action": "2",
        "delFlag": false,
        "status": "0",
        "id": taskJobId,
        "proxyId": proxy,
        "taskJobTimerId": timerJobTimerId,
        "databaseId": data
    };
    $("input,select").each(function (index, col) {
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

$("#cancle").click(function () {
    window.location.href = "/use/list.html?username=dGVzdA==&password=MTIzNDU2&0";
})

function insertSuccess(res) {
    if (res.returnMsg == 'Task name already exist!') {
        layer.msg('任务名称已存在,请重试！', {icon: 5, time: 2000});
    } else {
        var Id = res.result["id"];
        window.location.href = "/use/edit_mould.html?parentId=" + Id
            + "&" + "proxytype=" + proxytype;
    }
}


function agent2() {
    localStorage["id"] = proxy;
    admin_add1('配置频率', '/use/agent.html', '800', '600');
}
function agent() {
    localStorage["id"] = proxy;
    admin_add1('配置频率', '/use/agent1.html', '800', '600');
}

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
});

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

$("#select_four .iCheck-helper").click(function () {
    $("#agent1").hide();
    $("#agent2").hide();
    $("#radio-p3").parent().addClass("checked");
    proxy = '';
    $("#radio-p1").parent().removeClass("checked");
    $("#radio-p2").parent().removeClass("checked");
});

function admin_add1(title, url, w, h) {
    data_window = layer_show(title, url, w, h)
}


function taskList(res) {
    if (res.result) {
        var result = res.result.taskJob;
        $('input[name="name"]').val(result.name);
        $('input[name="keyWord"]').val(result.keyWord);
        $('#taskJobId').val(result.id);
        $('input[name="url"]').val(result.url);
        $('input[name="pageLimit"]').val(result.pageLimit);
        $('input[name="pageOffset"]').val(result.pageOffset);
        var grapInterval = result.grapInterval;
        var grapPeriod = result.grapPeriod;
        var proxyType = result.proxyType;
        var databaseId = result.databaseId;
        var encodeTypeId = result.encodeTypeId;
        var proxyId = result.proxyId;
        proxy = proxyId;
        proxytype = proxyType;
        data = databaseId;

    }

    if (grapPeriod == "1") {
        $("#radio-t1").parent().addClass("checked");
        $("#radio-t1").get(0).checked = true;
    } else if (grapPeriod == "2") {
        $("#radio-t2").parent().addClass("checked");
        $("#radio-t2").get(0).checked = true;
        $("#configureHz").show();
        var str_json = {"id": res.result.taskJob.taskJobTimerId, "type": "4"}
        ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, grap, error);
    }


    var str_json = {"id": databaseId, "type": "1"}
    dabaseID = databaseId;
    ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, dbSource, error);
    if (encodeTypeId == "0") {
        $("#radio-z1").parent().addClass("checked");
        $("#radio-z1").get(0).checked = true;
    } else if (encodeTypeId == "1") {
        $("#radio-z2").parent().addClass("checked");
        $("#radio-z2").get(0).checked = true;
    } else if (encodeTypeId == "2") {
        $("#radio-z3").parent().addClass("checked");
        $("#radio-z3").get(0).checked = true;
    } else if (encodeTypeId == "3") {
        $("#radio-z4").parent().addClass("checked");
        $("#radio-z4").get(0).checked = true;
    } else if (encodeTypeId == "4") {
        $("#radio-z5").parent().addClass("checked");
        $("#radio-z5").get(0).checked = true;
    }

    if (proxyId) {
        if (proxyType == 0) {
            $("#radio-p3").parent().addClass("checked");
            $("#radio-p3").get(0).checked = true;
            $("#agent1").hide();
            $("#agent2").hide();
        } else if (proxyType == 1) {
            $("#radio-p2").parent().addClass("checked");
            $("#radio-p1").parent().removeClass("checked");
            $("#radio-p2").get(0).checked = true;
            $("#agent1").hide();
            $("#agent2").hide();
        } else if (proxyType == 3) {
            $("#radio-p1").parent().addClass("checked");
            $("#radio-p1").get(0).checked = true;
            $('#radio-p1').attr("value", 3);
        } else if (proxyType == 2) {
            $("#radio-p1").parent().addClass("checked");
            $("#radio-p1").get(0).checked = true;
            $('#radio-p1').attr("value", 2);
        }

        var str_json = {"id": proxyId, "type": "3"}
        ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, proxy2, error);
    }

    function proxy2(res) {
        var authUrl = res.result.proxy.authUrl;
        var userName = res.result.proxy.userName;
        if (proxytype == 0) {
            authUrl = '';
            userName = '';
        }
        if (proxytype == "1") {
            authUrl = '';
            userName = '';
            $("#radio-p1").parent().removeClass("checked");
            $("#radio-p3").parent().removeClass("checked");
        }
        if (userName) {
            if (proxytype == "2") {
                $("#agent2").show();
                $("#agent1").hide();
                $("#radio-p1").parent().addClass("checked");
                $("#agent2 tbody").html("").append("<tr class='text-c'>" +
                    "<td style='height: 32px'>" + res.result.proxy.hostName + "</td>" +
                    "<td>" + res.result.proxy.port + "</td>" +
                    "<td style='height: 32px'>" + res.result.proxy.userName + "</td>" +
                    "<td>" + "...." + "</td>" +
                    "<td><a class='agent' onclick='agent()'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
                    "</tr>");
            }
        } else if (authUrl) {
            if (proxytype == "3") {
                $("#agent1").show();
                $("#agent2").hide();
                $("#radio-p1").parent().addClass("checked");
                $("#agent1 tbody").html("").append("<tr class='text-c'>" +
                    "<td style='height: 32px'>" + res.result.proxy.authUrl + "</td>" +
                    "<td><a class='agent' onclick='agent2()'><i class='Hui-iconfont list_result'>&#xe720;</i></a></td>" +
                    "</tr>");
            }

        }
    }

    window.proxyManager = function (obj) {
        var str_json = {"id": obj, "type": "3"}
        proxyId = obj;
        proxytype = "2";
        jQuery("#agent2").show();
        jQuery("#agent1").hide();
        ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, proxy2, error);
    }

    window.proxyId = function (obj) {
        proxyId = obj;
    }

    window.proxyManager1 = function (obj) {
        var str_json = {"id": obj, "type": "3"}
        proxyId = obj;
        proxytype = "3";
        jQuery("#agent1").show();
        jQuery("#agent2").hide();
        ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, proxy2, error);
    }
}

$("#cancel").click(function () {
    window.location.href = window.history.go(-1);
})

window.proxyIDMethod = function (obj) {
    proxyId = obj;
    localStorage['staticId'] = obj;
    proxytype = "1";
}