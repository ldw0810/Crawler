window.refresh = function(){
   window.location.reload();
}

function popOracle() {
    admin_add1('配置入库类型ORACLE', '/use/dataBaseDB_one.html?s=0', '800', '600');
}

function popServer() {
    admin_add1('配置入库类型SQLSERVER', '/use/dataBaseDB_one.html?s=1', '800', '600');
}

function popMysql() {
    admin_add1('配置入库类型MYSQL', '/use/dataBaseDB_one.html?s=2', '800', '600');
}

function popHdfs() {
    admin_add1('配置入库类型HDFS', '/use/dataBaseDB_two.html', '800', '600');
}

function popKafka() {
    admin_add1('配置入库类型KAFKA', '/use/dataBaseDB_three.html', '800', '600');
}

ajaxFunction("/queryDbSourceList", "POST", "JSON", "application/json,charset=utf8", null, typeList, error);
function typeList(resp) {
    if (resp.data) {
        var list = resp.data;
        if (list.length) {
            $("#tbody1").html("");
            for (var i = 0; i < list.length; i++) {
                var type = list[i]["type"];
                if (type == "kafka") {
                    $("#dbTbody tbody").append("<tr class='text-c'>" +
                        "<td><input type='checkbox'></td>" +
                        "<td>" + type + "</td>" +
                        "<td>" + list[i]["host"] + "</td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "<td>" + list[i]["topic"] + "</td>" +
                       " <td class='td-manage'>" +
                        "<a href='javascript:(0)' onclick='popKafka(\"" + list[i]["id"] + "\")' class='ml-5'title='编辑信息' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
                        "<i class='Hui-iconfont list_eidit'>&#xe60c;</i>" +
                        "</a>" +
                        "</td>" +
                        "</tr>"
                    );

                } else if (type == "hdfs") {
                    $("#dbTbody tbody").append("<tr class='text-c'>" +
                        "<td><input type='checkbox'></td>" +
                        "<td>" + type + "</td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "<td></td>" +
                        "<td>" + list[i]["dbname"] + "</td>" +
                        "<td></td>" +
                        "<td>" + list[i]["url"] + "</td>" +
                        "<td></td>" +
                             " <td class='td-manage'>" +
                        "<a href='javascript:(0)' onclick='popHdfs(\"" + list[i]["id"] + "\")' class='ml-5'title='编辑信息' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
                        "<i class='Hui-iconfont list_eidit'>&#xe60c;</i>" +
                        "</a>" +
                        "</td>" +
                        "</tr>"
                    );
                } else if (type == "mysql") {
                    $("#dbTbody tbody").append("<tr class='text-c'>" +
                        "<td><input type='checkbox'></td>" +
                        "<td>" + type + "</td>" +
                        "<td>" + list[i]["host"] + "</td>" +
                        "<td>" + list[i]["username"] + "</td>" +
                        "<td>" + "..." + "</td>" +
                        "<td>" + list[i]["dbname"] + "</td>" +
                        "<td>" + list[i]["port"] + "</td>" +
                        "<td></td>" +
                            "<td></td>" +
                        " <td class='td-manage'>" +
                        "<a href='javascript:(0)' onclick='popMysql(\"" + list[i]["id"] + "\")' class='ml-5'title='编辑信息' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
                        "<i class='Hui-iconfont list_eidit'>&#xe60c;</i>" +
                        "</a>" +
                        "</td>" +
                        "</tr>"
                    );
                }else if( type == "oracle"){
                     $("#dbTbody tbody").append("<tr class='text-c'>" +
                        "<td><input type='checkbox'></td>" +
                        "<td>" + type + "</td>" +
                        "<td>" + list[i]["host"] + "</td>" +
                        "<td>" + list[i]["username"] + "</td>" +
                        "<td>" + "..." + "</td>" +
                        "<td>" + list[i]["dbname"] + "</td>" +
                        "<td>" + list[i]["port"] + "</td>" +
                        "<td></td>" +
                            "<td></td>" +
                        " <td class='td-manage'>" +
                        "<a href='javascript:(0)' onclick='popOracle(\"" + list[i]["id"] + "\")' class='ml-5'title='编辑信息' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
                        "<i class='Hui-iconfont list_eidit'>&#xe60c;</i>" +
                        "</a>" +
                        "</td>" +
                        "</tr>"
                    );
                }else if(type == "sqlserver"){
                     $("#dbTbody tbody").append("<tr class='text-c'>" +
                        "<td><input type='checkbox'></td>" +
                        "<td>" + type + "</td>" +
                        "<td>" + list[i]["host"] + "</td>" +
                        "<td>" + list[i]["username"] + "</td>" +
                        "<td>" + "..." + "</td>" +
                        "<td>" + list[i]["dbname"] + "</td>" +
                        "<td>" + list[i]["port"] + "</td>" +
                        "<td></td>" +
                            "<td></td>" +
                        " <td class='td-manage'>" +
                        "<a href='javascript:(0)' onclick='popSqlserver(\"" + list[i]["id"] + "\")' class='ml-5'title='编辑信息' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
                        "<i class='Hui-iconfont list_eidit'>&#xe60c;</i>" +
                        "</a>" +
                        "</td>" +
                        "</tr>"
                    );
                }
            }
        }
    }

}

function popKafka(obj){
        admin_add1('配置入库类型KAFKA', '/use/dataBaseDB_three.html', '800', '600');
         localStorage["id"] = obj;
}

function popHdfs(obj){
     admin_add1('配置入库类型HDFS', '/use/dataBaseDB_two.html', '800', '600');
      localStorage["id"] = obj;
}

function popMysql(obj){
    admin_add1('配置入库类型MYSQL', '/use/dataBaseDB_one.html?s=2', '800', '600');
    localStorage["id"] = obj;
}

function popOracle(obj){
    admin_add1('配置入库类型ORACLE', '/use/dataBaseDB_one.html?s=0', '800', '600');
     localStorage["id"] = obj;
}

function popSqlserver(obj){
    admin_add1('配置入库类型SQLSERVER', '/use/dataBaseDB_one.html?s=1', '800', '600');
    localStorage["id"] = obj;
}


/*空值处理*/
function ifUndefined(val) {
    if (val == undefined || val == null || val == "-1") {
        return "--";
    } else {
        return val;
    }
}

function error() {

}

function admin_add1(title, url, w, h) {
    data_window = layer_show(title, url, w, h)
}