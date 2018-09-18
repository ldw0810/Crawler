/**
 * Created by Administrator on 2017/6/15.
 */

var developerParid = window.localStorage["developerParid"];
var cookie = '';
var autoLogin1 = '';
var userLoginBehavior = {};
window.localStorage["developerParid"] = '';

jQuery('.skin-minimal input').iCheck({
    checkboxClass: 'icheckbox-blue',
    radioClass: 'iradio-blue',
    increaseArea: '20%'
});

/*选择父子任务*/
$("#childsList").click(function () {
    admin_add1('选择父子模板', '/developer/template/parentList.html', '800', '600');
    // window.location.href='/developer/template/parentList.html';
});

// 展示模板类型
ajaxFunction("/getContentTypeList", "POST", "JSON", "application/json,charset=utf8", null, typelist, error);
function typelist(res) {
    var arr = res.result;
    for (var i = 0; i < arr.length; i++) {
        $("#typeList").append("<option value='" + arr[i].id + "'>" + arr[i].name + "</option>");
    }
}

// 展示入库类型
ajaxFunction("/queryDbSourceList", "POST", "JSON", "application/json,charset=utf8", null, typeList, error);
function typeList(res) {
    var arr = res.data;
    for (var i = 0; i < arr.length; i++) {
        $("#typelist").append("<option value='" + arr[i].id + "'>" + arr[i].type + "-" + arr[i].host + "-" + arr[i].dbname + "</option>");
    }
}

/*填完模板后提交*/
jQuery("#saveBtn").click(function () {
    if (validform().form()) {
        template = {};
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
                    if(!value){
                        return
                    }else{
                        break;
                    }
                default:
                    value = $(this).val()
            }
            if (autoLogin1 == 1) {
                $("input[class^='input-text Login']").each(function (index, col) {
                    var value1 = null;
                    var key = $(this).attr("name");
                    if (!key) {
                        return true
                    }
                    value1 = $(this).val()
                    userLoginBehavior[key] = value1;
                })
                // value = userLoginBehavior;
            }
            template[key] = value;
            function createJson(prop, val) {
                if (typeof val === "undefined" || typeof val === "null" || typeof val === {}) {
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
        // cookie_refresh_cycle =  $('input[name="cookie_refresh_cycle"]').val();
        str_json = {"action": "0", "type": "0", "template": template};
        console.log(JSON.stringify(str_json));
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
            cookie_obtain_url:{
               required: true
            },
            tableName:{
                required: true
            }
        }
    });
}

/*弹窗*/
function admin_add1(title, url, w, h) {
    data_window = layer_show(title, url, w, h)
}

// 父子任务
//     $(".parentId").val(developerParid);
window.parentShowId = function (obj) {
    $("#parent").val(obj);

}

/*是否自动登录*/
$("#userAuto .iCheck-helper").click(function () {
    $('.user').css('display', 'block')
});
/*是否自动登录*/
$("#userNoauto .iCheck-helper").click(function () {
    $('.user').css('display', 'none')
});

/*是否启用cookie*/
$("#useCookie .iCheck-helper").click(function () {
    $('.cookie').css('display', 'block')
});
/*是否启用cookie*/
$("#NotUseCookie .iCheck-helper").click(function () {
    $('.cookie').css('display', 'none')
});

/*取消*/
$("#cancel").click(function () {
    window.location.herf = window.history.go(-1);
});

