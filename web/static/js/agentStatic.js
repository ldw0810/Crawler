/**
 * Created by Administrator on 2017/6/9.
 */
var staticId1 = localStorage['staticId'];
    localStorage['staticId'] = '';
str_json = {"id": staticId1, "type": "3"}
ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, showData, error1);
var data;
var param = '';
var staticId = '';
var localStatic=''
var again;
function loadJson(json) {
    if (json.staticProxyInfoList.length !== 0) {
        $("#agent").html('');
        staticId = '';
        var length = json.staticProxyInfoList.length;
        staticId = json.proxyInfo.id;
        localStatic = json.proxyInfo.id;
        for (var i = 0; i < length; i++) {
            var result = json.staticProxyInfoList[i];
            ip = result.host;
            port = result.port;
            $("#agent").append("<tr class='text-c'>" +
                "<tr style='height: 60px'>" +
                "<td >" + ip + "</td>" +
                "<td >" + port + "</td>" +
                "</tr>" +
                "</tr>"
            );
        }
        jQuery("#nextBtn").removeClass("disabled").addClass("btn-primary");
        $('#showOrNot').show();
        console.log(json);
    }
}

function showData(resp) {
    if (resp.result.staticProxyList) {
        var length = resp.result.staticProxyList.length;
        for (var i = 0; i < length; i++) {
            var result = resp.result.staticProxyList[i];
            ip = result.host;
            port = result.port;
            $("#agent").append("<tr class='text-c'>" +
                "<tr style='height: 60px'>" +
                "<td >" + ip + "</td>" +
                "<td >" + port + "</td>" +
                "</tr>" +
                "</tr>"
            );
        }
        jQuery("#nextBtn").removeClass("disabled").addClass("btn-primary");
        $('#showOrNot').show();
    }
}

function checkSubmit(file) {
    if (!file || !file.value) {
        layer.msg('请导入文件!', {icon: 5, time: 2000});
        return false
    }
    return true
}

function success() {
    layer.msg('提交成功！', {icon: 6, time: 1000});
}
function error() {
    layer.msg('提交失败!', {icon: 6, time: 1000});
}

$("#nextBtn").click(function () {
    window.parent.proxyIDMethod(staticId);
    layer_close();
});
$("#cancelBtn").click(function () {
    layer_close();
});

function error1(){}
