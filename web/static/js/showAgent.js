var proxy_id = window.location.search.split("=")[1];
var param = {"id": proxy_id, "type": "3"};
ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", param, success, error);
function success(resp) {
    if (resp["result"]) {
        if (resp["result"]["proxy"]) {
            var detail = resp["result"]["proxy"]
            var type = '';
            var title = '';
            if (detail["type"] == 1) {
                type = "静态代理"
                var title = '<tr class="text-c">' +
                    '<th width="100"  style="background: #dff0d8;">id</th>' +
                    '<th width="100"  style="background: #dff0d8;">类型</th>' +
                    '<th width="100"  style="background: #dff0d8;" >创建时间</th>' +
                    '</tr>';
                var proxy_Info = "<tr><td>" + ifUndefined(detail["id"]) +
                    "</td>" + "<td>" + type + "</td>" +
                    "<td>" + ifUndefined(detail["createTime"]) + "</td></tr>";
            } else if (detail["type"] == 2) {
                type = "动态代理(用户)"
                var title = '<tr class="text-c">' +
                    '<th width="100"  style="background: #dff0d8;">Host</th>' +
                    '<th width="100"  style="background: #dff0d8;">port</th>' +
                    '<th width="100"  style="background: #dff0d8;">类型</th>' +
                    '<th width="100"  style="background: #dff0d8;" >userName</th>' +
                    '<th width="100"  style="background: #dff0d8;" >password</th>' + '</tr>';
                var proxy_Info = "<tr><td>" + ifUndefined(detail["hostName"]) + "</td>" +
                         "<td>" + ifUndefined(detail["port"]) + "</td>" +
                    "<td>" + type + "</td>" +
                    "<td>" + ifUndefined(detail["userName"]) + "</td>" +
                    "<td>" + ifUndefined(detail["password"]) + "</td></tr>";
            } else if (detail["type"] == 3) {
                type = "动态代理(url)"
                var proxy_Info = "<tr><td>" + '接口地址' + "</td>" +
                    "<td>" + ifUndefined(detail["authUrl"]) + "</td></tr>";
            } else {}
            $("#agent").append(title).append(proxy_Info);
        }else{
              var proxy_Info = "<tr><td>" + '信息异常' + "</td></tr>";
                $("#agent").append(proxy_Info);
        }
        if (resp["result"]["staticProxyList"]){
            $("#agent_list").css("display", "block");
            var list = resp["result"]["staticProxyList"];
                 for (var i = 0; i < list.length; i++) {
                    var staticProxyList = "<tr><td>" + ifUndefined(list[i]["id"]) + "</td>" +
                        "<td>" + ifUndefined(list[i]["host"]) + "</td>" +
                        "<td>" + ifUndefined(list[i]["port"]) + "</td>" +
                        "<td>" + ifUndefined(list[i]["proxyInfoId"]) + "</td>" +
                        "<td>" + ifUndefined(list[i]["createTime"]) + "</td></tr>";
                    $("#agent_list").append(staticProxyList);
                }
        }
    }

}
function ifUndefined(val) {
    if (val == undefined || val == null || val == "-1") {
        return "--";
    } else {
        return val;
    }
}
function error() {
    console.log(error);
}