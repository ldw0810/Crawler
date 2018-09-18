/**
 * Created by Administrator on 2017/6/15.
 */
jQuery('.skin-minimal input').iCheck({
    checkboxClass: 'icheckbox-blue',
    radioClass: 'iradio-blue',
    increaseArea: '20%'
});
var cookie = '';
var taskJobId = window.location.search.split("=")[1];
var str_json = {"id": taskJobId, "type": "2"};
var userLoginBehavior = {};
var userLoginBehaviorId = '';
var autoLogin1 = '';
/*弹窗*/
function admin_add1(title, url, w, h) {
    data_window = layer_show(title, url, w, h)
}

// 展示模板类型
ajaxFunction("/getContentTypeList", "POST", "JSON", "application/json,charset=utf8", null, typeList, error);
function typeList(res) {
    var arr = res.result;
    for (var i = 0; i < arr.length; i++) {
        $("#typeList").append("<option value='" + arr[i].id + "'>" + arr[i].name + "</option>");
    }
}

/*选择父子任务*/
$("#childsList").click(function () {
    admin_add1('选择父子模板', '/developer/template/parentList.html', '800', '600');
});

// 展示入库类型
ajaxFunction("/queryDbSourceList", "POST", "JSON", "application/json,charset=utf8", null, typelist, error);
function typelist(res) {
    var arr = res.data;
    for (var i = 0; i < arr.length; i++) {
        $("#typelist").append("<option value='" + arr[i].id + "'>" + arr[i].type + "-" + arr[i].host + "-" + arr[i].dbname + "</option>");
    }
}

ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, taskList, error);

function taskList(resp) {
    console.log(resp)
    if (resp.result) {
        var data = resp.result.jobTemplate;
        userLoginBehaviorId = data.userLoginBehaviorId
        var userLoginBehavior = data.userLoginBehavior;
        $('input[name="name"]').val(data.name);
        $('input[name="sleepTime"]').val(data.sleepTime);
        $('input[name="url"]').val(data.url);
        $('input[name="rootPath"]').val(data.rootPath);
        $('input[name="databaseId"]').val(data.databaseId);
        $('input[name="desc"]').val(data.desc);
        $('input[name="tableName"]').val(data.tableName);
        $('input[name="parentId"]').val(data.parentId);

        var str = "";
        str = data.databaseId;
        $("#typelist option").each(function () {
            if ($(this).val() == str) {
                $(this).attr("selected", true);
            }
        });
        if (userLoginBehavior) {
            $('input[name="userId"]').val(userLoginBehavior.userId);
            $('input[name="passWord"]').val(userLoginBehavior.passWord);
            $('input[name="userLabel"]').val(userLoginBehavior.userLabel);
            $('input[name="passWordLabel"]').val(userLoginBehavior.passWordLabel);
            $('input[name="vertInputLabel"]').val(userLoginBehavior.vertInputLabel);
            $('input[name="vertImageLabel"]').val(userLoginBehavior.vertImageLabel);
            $('input[name="loginLabel"]').val(userLoginBehavior.loginLabel);
        }
        $('input[name="cookie_obtain_url"]').val(data.cookie_obtain_url);
        $('input[name="cookie_refresh_cycle"]').val(data.cookie_refresh_cycle);
        var requestType = data.requestType;
        var encodeType = data.encodeType;
        var cookie_flag = data.cookie_flag;
        var parseType = data.parseType;
        var phantomjsFlag = data.phantomjsFlag;
        var autoLogin = data.autoLogin;
        if (autoLogin) {
            $("#radio-m1").parent().addClass("checked");
            $("#radio-m1").get(0).checked = true;
            $('.user').css('display', 'block')
        } else {
            $("#radio-m2").parent().addClass("checked");
            $("#radio-m2").get(0).checked = true;
        }
    }
    if (requestType == 0) {
        $("#radio-z1").parent().addClass("checked");
        $("#radio-z1").get(0).checked = true;
    } else {
        $("#radio-z2").parent().addClass("checked");
        $("#radio-z2").get(0).checked = true;

    }

    $("#radio-r5").parent().removeClass("checked");
    if (encodeType == 0) {
        $("#radio-r1").parent().addClass("checked");
        $("#radio-r1").get(0).checked = true;
    } else if (encodeType == 1) {
        $("#radio-r2").parent().addClass("checked");
        $("#radio-r2").get(0).checked = true;
    } else if (encodeType == 2) {
        $("#radio-r3").parent().addClass("checked");
        $("#radio-r3").get(0).checked = true;
    } else if (encodeType == 3) {
        $("#radio-r4").parent().addClass("checked");
        $("#radio-r4").get(0).checked = true;
    } else if (encodeType == 4) {
        $("#radio-r5").parent().addClass("checked");
        $("#radio-r5").get(0).checked = true;
    }

    if (cookie_flag == true) {
        $("#radio-p1").parent().addClass("checked");
        $("#radio-p1").get(0).checked = true;
        $('.cookie').css('display', 'block');
    } else {
        $("#radio-p2").parent().addClass("checked");
        $("#radio-p2").get(0).checked = true;
    }

    if (parseType == 1) {
        $("#radio-w1").parent().addClass("checked");
        $("#radio-w1").get(0).checked = true;
    } else {
        $("#radio-w2").parent().addClass("checked");
        $("#radio-w2").get(0).checked = true;
    }

    if (phantomjsFlag == 1) {
        $("#radio-q1").parent().addClass("checked");
        $("#radio-q1").get(0).checked = true;
    } else {
        $("#radio-q2").parent().addClass("checked");
        $("#radio-q2").get(0).checked = true;
    }
}
/*判空*/
function validform() {
    return jQuery("#form-url-add").validate({
        rules: {
            name: {
                required: true
            },
            sleepTime: {
                required: true
            },
            url: {
                required: true
            },
            databaseId: {
                required: true
            },
            verificationCode: {
                required: true
            },
            cookie_obtain_url: {
                required: true
            },
            userId: {
                required: true
            },
            passWord: {
                required: true
            },
            userLabel: {
                required: true
            },
            passwordLabel: {
                required: true
            },
            loginLabel: {
                required: true
            },
            tableName: {
                required: true
            }
        }
    });
}

//     $("#parentId").val(developerParid);
window.parentShowId = function (obj) {
    $("#parent").val(obj);

}

jQuery("#saveBtn").click(function () {
    template = {"id": taskJobId};
    $("input[class^='input-text noLogin'],select").each(function (index, col) {
        var value = null;
        var key = $(this).attr("name");
        if (!key) {
            return true
        }
        switch (key) {
            case "requestType":
                value = $('input:radio[name="requestType"]:checked').val();
                break;
            case "encodeType":
                value = $('input:radio[name="encodeType"]:checked').val();
                break;
            case "cookie_flag":
                value = $('input:radio[name="cookie_flag"]:checked').val();
                cookie = value;
                break;
            case "parseType":
                value = $('input:radio[name="parseType"]:checked').val();
                break;
            case "phantomjsFlag":
                value = $('input:radio[name="phantomjsFlag"]:checked').val();
                break;
            case "autoLogin":
                value = $('input:radio[name="autoLogin"]:checked').val();
                autoLogin1 = value;
                break;
            case "cookie_refresh_cycle":
                value = $('input:radio[name="cookie_refresh_cycle"]:checked').val();
                if (!value) {
                    return
                } else {
                    break;
                }
            default:
                value = $(this).val()
        }
        if (autoLogin1 == 1) {
            userLoginBehavior = {"id": userLoginBehaviorId}
            $("input[class^='input-text Login']").each(function (index, col) {
                var value1 = null;
                var key = $(this).attr("name");
                if (!key) {
                    return true
                }
                value1 = $(this).val()
                userLoginBehavior[key] = value1;
            })
        }
        template[key] = value;
        function createJson(prop, val) {
            if (typeof val === "undefined" || typeof val === "null") {
                delete template[prop];
            }
            else {
                template[prop] = val;
            }
        }

        createJson("userLoginBehavior", userLoginBehavior);
    })
    if (cookie == 0) {
        delete template["cookie_obtain_url"];
        delete template["cookie_refresh_cycle"];
    }
    str_json = {"action": "2", "type": "0", "template": template};
    console.log(JSON.stringify(str_json));
    if (validform().form()) {
        ajaxFunction("/templateMgmt", "POST", "JSON", "application/json,charset=utf8", str_json, template_insertSuccess, error);
    }
});

function template_insertSuccess(resp) {
    if (resp.returnCode == 600) {
        layer.msg('名字重复，请重试!', {icon: 5, time: 2000});
    } else {
        window.location.href = "/developer/template/list.html?2";
    }
}

function error() {

}

$("#userAuto .iCheck-helper").click(function () {
    $('.user').css('display', 'block')
});
/*是否自动登录*/
$("#userNoauto .iCheck-helper").click(function () {
    $('.user').css('display', 'none')
});

$("#cancel").click(function () {
    window.location.herf = window.history.go(-1);
});

/*是否启用cookie*/
$("#useCookie .iCheck-helper").click(function () {
    $('.cookie').css('display', 'block')
});
/*是否启用cookie*/
$("#NotUseCookie .iCheck-helper").click(function () {
    $('.cookie').css('display', 'none')
});