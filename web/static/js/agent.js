/**
 * Created by Administrator on 2017/5/4.
 */
var address = "";
var id = localStorage['id'];
var str_json = {"id": id, "type": "3"}
var dstr = "";
var addressHistory = '';

$(function () {
    $('.skin-minimal input').iCheck({
        checkboxClass: 'icheckbox-blue',
        radioClass: 'iradio-blue',
        increaseArea: '20%'
    });

    $("#selectD1 .iCheck-helper").click(function () {
        $("#address").show();
        $("#agent2").hide();
    })

    $("#selectD1 #radio-d1-label").click(function () {
        $("#address").show();
        $("#agent2").hide();
    })

    $("#selectD2 #radio-d2-label").click(function () {
        $("#agent2").show();
        $("#address").hide();
    })

    $("#selectD2 .iCheck-helper").click(function () {
        $("#agent2").show();
        $("#address").hide();
    })

    $("#cancelBtn").click(function () {
        layer_close();
    })


})
$("#agentBtn").click(function () {
    if (validform().form()) {
        var radio = $('input:radio[name="agent"]:checked').val();
        var proxy = $("#form1").serialize();
        value = '3';
        action ='';

        if (radio == 0) {
        if(addressHistory){
            var str_json = {"action": "2", "type": "3","id":addressHistory};
        }else {
            var str_json = {"action": "0", "type": "3"};
        }}

        if (radio == 1) {
            proxy = $("#form2").serialize();
            if(addressHistory){
            var str_json = {"action": "2", "type": "2","id":addressHistory};
        }else {
            var str_json = {"action": "0", "type": "2"};
        }
            value = '2';
        }
        parent.parent.ptype = value;
        $("input").each(function (index, col) {
            var key = $(this).attr("name");
            if (!key) {
                return true
            }
            // if(radio == 1){
                switch (key) {
                case "authUrl":
                    value = '';
                    break;
                default:
                    value = $(this).val()
            }
            // }
            str_json[key] = $(this).val();
        })
        console.log(JSON.stringify(str_json));
        ajaxFunction("/proxyMgmt", "POST", "JSON", "application/json,charset=utf8", str_json, proxyResp, error);
        layer_close();
    }
})
function proxyResp(resp) {
    console.log("proxyResp");
    var res = resp.result.proxyInfo;
    var radio = $('input:radio[name="agent"]:checked').val();
    parent.parent.id = res["id"];
    console.log(res["id"]);
    if (radio == 1) {
        window.parent.proxyManager(res["id"]);
    } else {
        window.parent.proxyManager1(res["id"]);
    }
}
function error() {
    console.log("proxyRespError")
}
function validform() {
    var radio = $('input:radio[name="agent"]:checked').val();
    if(radio == 1){
        return $("#form2").validate({
        rules: {
            hostName: {
                required: true
            },
            port: {
                required: true
            },
            userName: {
                required: true
            },
            password: {
                required: true
            }
        }
    });
    }else{
        return $("#form1").validate({
        rules: {
            authUrl: {
                required: true
            }
        }
    });
    }
}
ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, agent, error);
function agent(res) {
    var radio = $('input:radio[name="agent"]:checked').val();
    if (res.result.proxy !== null) {
        if (radio == 0) {
            $('input[name="authUrl"]').val(res.result.proxy.authUrl);
            addressHistory = res.result.proxy.id
        } else {
            $("#form2").show();
            $("#agentOne").hide();
            $("#agentTwo").show();
            $('input[name="hostName"]').val(res.result.proxy.hostName);
            $('input[name="port"]').val(res.result.proxy.port);
            $('input[name="userName"]').val(res.result.proxy.userName);
            $('input[name="password"]').val(res.result.proxy.password);
            addressHistory = res.result.proxy.id
        }
    }
}