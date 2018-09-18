var id = localStorage['id'];
var str_json = {"id": id, "type": "1"};
var dstr = "";
var dtype ="";
var typeNum  = window.location.search.split("=")[1];
if(typeNum ==0 ){
    dtype="oracle";
}else if(typeNum ==1){
     dtype="sqlserver";
}else if(typeNum ==2){
     dtype="mysql";
}
console.log(dtype);

ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, detailList, error);

function detailList(res) {
    if (res.result) {
        $(".host").val(res.result["host"]);
        $(".port").val(res.result["port"]);
        $(".username").val(res.result["username"]);
        $(".password").val(res.result["password"]);
        $(".dbname").val(res.result["dbname"]);
    }
}

function validform() {
    return $("#popDB_one").validate({
        rules: {
            host: {
                required: true
            },
            port: {
                required: true
            },
            username: {
                required: true
            },
            password: {
                required: true
            },
            dbname: {
                required: true
            }
        }
    });
}
$("#nextBtn").click(function () {
    var str_json1={};
    if (validform().form()) {
        if(id == ""){
               str_json1 = {"action": "0","type":dtype};
        }else{
             str_json1 = {"action": "2","id":id};
        }
        $("input").each(function (index, col) {
            var key = $(this).attr("name");
            if (!key) {
                return true
            }
            str_json1[key] = $(this).val();
        })

        ajaxFunction("/dbSourceMgnt", "POST", "JSON", "application/json,charset=utf8", str_json1, dataIDResp, error);

    }

})


function dataIDResp(resp) {
    var res = resp.result;
    parent.parent.databaseid = res["databaseId"];
    window.parent.parentMethod(res["databaseId"]);
    layer_close();
}


$("#cancelBtn").click(function () {
    // window.parent.hideTable("false");
    layer_close();
})
function error() {

}
