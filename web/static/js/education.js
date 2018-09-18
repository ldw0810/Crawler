/**
 * Created by Administrator on 2017/5/10.
 */
/**
 * Created by Administrator on 2017/5/9.
 */
var totalPage;
var data;
var page = 1;
var pagesize = 10;
var time = 1;

// var search_grapPeriod = $(".navBar_under_front .check").val();
// if(!search_grapPeriod){search_grapPeriod ="";}
// var search_status = $(".navBar_under .check").val();
// if(!search_status){search_status ="";}
// var search_content = $("#input-text").val();

// var param = {"pageNo": page, "pageSize": pagesize, "searchParam": {"status": "1"}};
var param = {}
// var param = {"pageNo":page, "pageSize":pagesize,"searchParam":{"status":search_status,"grapPeriod":search_grapPeriod,"name":search_content}};

/*调用接口*/
ajaxFunction("/publisher/getTaskList", "POST", "JSON", "application/json,charset=utf8", param, success, error);

/*接口调用失败*/
function error(resp) {
    alert(resp + "/fail");
}

/*接口调用成功*/
function success(resp) {
    data = resp['taskList'];
    totalPage = resp['count'];//接口获得
    getTable(data);
}

/*分页初始化*/
jQuery("#Pagination").pagination(totalPage, {
    num_edge_entries: 1,
    num_display_entries: 4,
    items_per_page: 10,
    current_page: 0,
});

/*分页回调函数*/
function result(current_page, items_per_page, obj) {
    $('#pageNum').val(items_per_page);
    var search_grapPeriod = $(".navBar_under_front .check").val();
    if (!search_grapPeriod) {
        search_grapPeriod = "";
    }
    var search_status = $(".navBar_under_li .check").val();
    if (!search_status) {
        search_status = "";
    }
    var search_content = $("#input-text").val();
    page = current_page + 1;
    pagesize = items_per_page;
    param = {"pageNo": current_page + 1, "pageSize": items_per_page, "searchParam": {"status": "1"}}
    // param = {"pageNo":current_page + 1, "pageSize":items_per_page,"searchParam":{"status":search_status,"grapPeriod":search_grapPeriod,"name":search_content}}
    if (time) {
        time = 0;
    } else {
        ajaxFunction("/publisher/getTaskList", "POST", "JSON", "application/json,charset=utf8", param, success, error);
    }
}

/*空值处理*/
function ifUndefined(val) {
    if (val == undefined || val == null || val == "-1") {
        return "--";
    } else {
        return val;
    }
}

/*添加表格数据*/
function showStatues(status) {
    if (ifUndefined(status["status"]) == 1) {
        statues_content = "<span>运行中</span>";
    } else if (ifUndefined(status["status"]) == 2) {
        statues_content = "<span>暂停中</span>";
    } else if (ifUndefined(status["status"]) == 3) {
        statues_content = "<span>失败</span>";
    } else if (ifUndefined(status["status"]) == 4) {
        statues_content = "<span>已完成</span>";
    } else if (ifUndefined(status["status"]) == 5) {
        statues_content = "<span>等待</span>";
    } else {
        statues_content = "<span>--</span>";
    }
    return statues_content;
}
function showGrapPeriodBut(grap) {
    if (grap["grapPeriod"] == 0) {//按次
        grapPeriod = "<a  href='javascript:void(0);' onclick='crawler(this,\"" + grap["id"] + "\")' class='ml-5' style='text-decoration:none' title='爬取数据' data-toggle='tooltip' data-placement='top'> " +
            "<i class='Hui-iconfont list_data'>&#xe616;</i>" +
            "</a>"
    } else if (grap["grapPeriod"] == 1) {//周期
        if (grap["executeStatus"] == 0) {
            grapPeriod = "<a  href='javascript:void(0);' id = 'stop' onclick='admin_stop(this,\"" + grap["id"] + "\")' class='ml-5' style='text-decoration:none' title='暂停任务' data-toggle='tooltip' data-placement='top'> " +
                "<i class='Hui-iconfont list_data'>&#xe6e5;</i>" +
                "</a>"
        } else if (grap["executeStatus"] == 1) {
            grapPeriod = "<a  href='javascript:void(0);' id = 'start' onclick='admin_start(this,\"" + grap["id"] + "\")' class='ml-5' style='text-decoration:none' title='开启任务' data-toggle='tooltip' data-placement='top'> " +
                "<i class='Hui-iconfont list_data'>&#xe6e6;</i>" +
                "</a>"
        } else {
            grapPeriod = "<a  href='javascript:void(0);' onclick='crawler(this,\"" + grap["id"] + "\")' class='ml-5' style='text-decoration:none' title='爬取数据' data-toggle='tooltip' data-placement='top'> " +
                "<i class='Hui-iconfont list_data'>&#xe616;</i>" +
                "</a>"
        }
    } else {
        grapPeriod = "<a  href='javascript:void(0);' onclick='crawler(this,\"" + grap["id"] + "\")' class='ml-5' style='text-decoration:none' title='爬取数据' data-toggle='tooltip' data-placement='top'> " +
            "<i class='Hui-iconfont list_data'>&#xe616;</i>" +
            "</a>"
    }
    return grapPeriod;
}
function showGrapPeriodtype(type) {
    var str;
    if (type == 0 || type == "0") {
        str = "按次"
    } else if (type == 1 || type == "1") {
        str = "周期"
    } else {
        str = "--"
    }
    return str;
}
function showType(type) {
    if (type == 0 || type == '0') {
        return "视频"
    } else if (type == 1 || type == '1') {
        return "音频"
    } else {
        return "图书"
    }
}
function showContentType(contentType) {
    if (contentType == undefined) {
        return "--"
    } else {
        if (contentType["name"] == undefined) {
            return "--"
        } else {
            return contentType["name"]
        }
    }
}
function getTable(data) {//添加表格数据
    var statues_content;
    var grapPeriod;
    var type;
    $("#tbodyl").html("");
    for (var i = 0; i < data.length; i++) {
        statues_content = showStatues(data[i]);
        grapPeriod = showGrapPeriodBut(data[i]);
        $("#tbodyl").append("<tr class='text-c'>" +
            "<th ><input type='checkbox'></th>" +
            "<td class='name'>" + ifUndefined(data[i]["name"]) + "</td>" +
            "<td>" + ifUndefined(data[i]["key"]) + "</td>" +
            "<td class='td-status' style='cursor:pointer'>" + data[i]["status"] + "</td>" +
            "<td>" + ifUndefined(data[i]["executeStatus"]) + "</td>" +
            "<td>" + ifUndefined(data[i]["createTime"]) + "</td>" +
            " <td class='td-manage'>" +
            "<a class='ml-5' onclick='admin_start(this,id)' style='text-decoration:none' title='开始' data-toggle='tooltip' data-placement='top'>" +
            "<i class='Hui-iconfont list_result'>&#xe631;</i>" +
            "</a>"  +
            "<a href='/use/result.html?id=" + data[i]["id"] + "' title='爬取结果' style='text-decoration:none' data-toggle='tooltip' data-placement='top'>" +
            "<i class='Hui-iconfont list_data'>&#xe616;</i></a>"+
            "<a type='submit' id='' style='text-decoration:none' onclick='admin_del(this ,\"" + data[i]["id"] + "\")' title='删除'  data-toggle='tooltip' data-placement='top'>" +
            "<i class='Hui-iconfont list_delete'>&#xe6e2;</i>" +
            "</a>" +
             "<a type='submit' id='' style='text-decoration:none'  title='投大屏'  data-toggle='tooltip' data-placement='top'>" +
            "<i class='Hui-iconfont list_copy'>&#xe61e;</i>" +
            "</a>" +
            "</td>" +
            "</tr>");
    }
}

/*复制成功*/
function copySuccess(obj) {
     layer.msg('复制成功!', {icon: 6, time: 1000});
    // var s = jQuery(obj).parents("tr").find(".name").html();
    // var p = $(obj).parents("tr");
    // var t = $(obj).parents("tr").clone(true);
    // t.find(".name").html(s + "-副本");
    // t.insertBefore(p);
}
/*复制失败*/
function copyError() {
    layer.msg('复制失败!', {icon: 6, time: 1000});
}
/*复制操作*/
function copyLine(obj, id) {
    layer.confirm('确认要复制吗？', function (index) {
        layer.closeAll('dialog');
        var param_copy = {'id': id};
        ajaxFunction("/taskCopy", "POST", "JSON", "application/json,charset=utf8", param_copy, copySuccess(obj), copyError);
    });
}

/*删除成功*/
function delsuccess(resp) {
    layer.msg('删除成功!', {icon: 6, time: 1000});
}

/*删除失败*/
function delsfail(resp) {
    layer.msg('删除失败!', {icon: 6, time: 1000});
}

/*删除操作*/
function admin_del(obj, id) {
    layer.confirm('确认要删除吗？', function (index) {
        ajaxFunction("/taskMgmt", "POST", "JSON", "application/ json,charset=utf8", {
            "action": "1",
            "id": id + "",
            "delFlag": true
        }, delsuccess, delsfail);
        document.location.reload();
    });
}

/*暂停*/
function admin_stop(obj, id) {
    var param_stop= {"taskJobId" : id, "action" : 1};
    layer.confirm('确认要暂停吗？', function (index) {
        $("#stop").replaceWith("<a  href='javascript:void(0);' id='start' onclick='admin_start(this,\"" + id + "\")' class='ml-5' style='text-decoration:none' title='开启任务' data-toggle='tooltip' data-placement='top'> " +
            "<i class='Hui-iconfont list_data'>&#xe6e6;</i>" + "</a>");
        layer.msg('已暂停!', {icon: 5, time: 1000});
        ajaxFunction("/startCralwer", "POST", "JSON", "application/ json,charset=utf8", param_stop)
    });
}
/*批量删除*/
function datadel(){
	var checked = jQuery("input[type='checkbox']:checked");
	if (checked.length) {
	    layer.confirm('确认删除这'+checked.length+'项么？',function(index){
		//此处请求后台程序，下方是成功后的前台处理……
		jQuery(obj).parents("tr").remove();
		layer.msg('已删除!',{icon:1,time:1000});
	});
	} else {
		//此处请求后台程序，下方是成功后的前台处理……
		layer.msg('未选择删除对象',{icon:1,time:2000});
	}
}


/*启用*/
function admin_start(obj, id) {
    var param_start= {"taskJobId" : id, "action" : 0};
    layer.confirm('确认要运行吗？', function (index) {
        $("#start").replaceWith("<a  href='javascript:void(0);' id='stop' onclick='admin_stop(this,\"" + id + "\")' class='ml-5' style='text-decoration:none' title='暂停任务' data-toggle='tooltip' data-placement='top'> " +
            "<i class='Hui-iconfont list_data'>&#xe6e5;</i>" + "</a>");
        layer.msg('已运行!', {icon: 6, time: 1000});
        ajaxFunction("/startCralwer", "POST", "JSON", "application/ json,charset=utf8", param_start)
    });
}

/*爬取操作*/
function crawler(obj, id) {
    layer.confirm('确认要爬取吗？', function (index) {
        layer.closeAll('dialog');
        var param_crawler= {"taskJobId" : id, "action" : 0};
        // ajaxFunction("/startCralwer", "POST", "JSON", "application/ json,charset=utf8", {
        //     "action": "0",
        //     "taskJobId": id + "",
        // }, function(){}, function(){});
    });
}
/*启动操作*/
function admin_start(obj,id){
    layer.confirm('确认要启用吗？',function(index){
    layer.msg('已开启!', {icon: 6,time:1000});
// {#    jQuery(function () {#}
// {#        jQuery("[data-toggle='tooltip']").tooltip();#}
// {#   jQuery(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_stop(this,id)" href="javascript:void(0);" title="停用" style="text-decoration:none" data-toggle="tooltip" data-placement="top" ><i class="Hui-iconfont list_result">&#xe72a;</i></a>');#}
// {#   jQuery(obj).remove();#}
// {#    } )#}
 });
}

/*搜索操作*/
function search() {
    // var wordlength = jQuery("#input-text").val().length;
    var search_grapPeriod = $(".navBar_under_front .check").val();
    if (!search_grapPeriod) {
        search_grapPeriod = "";
    }
    var search_status = $(".navBar_under_li .check").val();
    if (!search_status) {
        search_status = "";
    }
    var search_content = $("#input-text").val();
    var param = {"pageNo": page, "pageSize": pagesize, "searchParam": {"status": "1"}};
    // var param = {"pageNo": 1, "pageSize": pagesize, "searchParam": {"status": search_status}};
    // var param = {"pageNo":1, "pageSize":pagesize,"searchParam":{"status":search_status,"grapPeriod":search_grapPeriod,"name":search_content}};
    ajaxFunction("/publisher/getTaskList", "POST", "JSON", "application/json,charset=utf8", param, success, error);
    // if (wordlength == 0) {
    //     layer.msg('请输入要搜索的内容', {icon: 1, time: 2000});
    // } else {
    //     var search_grapPeriod = $(".navBar_under_front .check").val();
    //     if(!search_grapPeriod){search_grapPeriod ="";}
    //     var search_status = $(".navBar_under_li .check").val();
    //     if(!search_status){search_status ="";}
    //     var search_content = $("#input-text").val();
    //     var param = {"pageNo":1, "pageSize":pagesize,"searchParam":{"status":search_status,"grapPeriod":search_grapPeriod,"name":search_content}};
    //     ajaxFunction("/getTaskList", "POST", "JSON", "application/json,charset=utf8", param, success, error);
    // }
}
jQuery(".navBar_under li").click(function () {
    jQuery(this).siblings('li').removeClass('check');
    jQuery(this).addClass('check');
})
jQuery(".navBar_under").css("cursor", "pointer");

