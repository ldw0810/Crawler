/**
 * Created by Administrator on 2017/6/16.
 */
/*取消按钮*/
var workId='';
$("#cancel").click(function () {
    window.location.href = window.history.go(-1);
});

/*保存按钮*/
$("#nextBtn").click(function () {
    if (workId) {
        str_json = {"action": "2", "delFlag": false, "status": "0", "id": workId, "proxyId": proxyId};
    } else {
        str_json = {
            "action": "0",
            "delFlag": false,
            "status": "0",
            "taskJobTimerId": self.timerJobTimerId,
        };
    }
    $("#radio-p1").val(self.ptype);
    $("input,select").each(function (index, col) {
        var value = null;
        var key = $(this).attr("name");
        if (!key) {
            return true
        }
        str_json[key] = value;
    })
    console.log(JSON.stringify(str_json));
    if (validform().form()) {
        ajaxFunction("/taskMgmt", "POST", "JSON", "application/json,charset=utf8", str_json, insertSuccess, error);
    }
});

/*判空*/
function validform() {
    return $("#form-url-add").validate({
        rules: {
            name: {
                required: true
            }
        }
    });
}

function insertSuccess(res) {
        // var parentId = res.result["id"]
        window.location.href = "/use/webModel.html"
            // ?parentId=" + parentId + "&" + "proxytype=" + proxytype;
        // workId = parentId;
}

function error(){}
