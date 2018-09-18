/**
 * Created by Administrator on 2017\6\23 0023.
 */
/**
 * Created by Administrator on 2017\6\23 0023.
 */
/***获取模板id进行查询对应模板下的字段**/
$(function(){
    var id =location.search.substr(4);
    var data={
        id:id,
        type:2
    };
    ajaxFunction("/contentDetail","POST", "JSON", "application/ json,charset=utf8", data,success,error);
});

function success(resp){
    var data = resp.result.jobTemplateParamList;
    if(data.length){getTable(data)};
}
function error(){
    console.log('error');
}
function getTable(data){
    $("#paramBody").html();
    for(var i=0;i<data.length;i++){
         $('#paramBody').append("<tr class='text-c'>"+
             "<td><input type='checkbox' name='wholeCheckBox' value="+data[i].id+"></td>"+
             "<td>"+data[i].paramNameCn+"</td>"+
             "<td>"+data[i].paramNameEn+"</td>"+
             "<td>"+data[i].paramValue+"</td>"+
             "<td>"+data[i].paramCondition+"</td>"+
             "<td>"+data[i].delFlag+"</td>"+
             "<td>"+
             "<a href='/developer/param/paramEdit.html?id="+data[i].id +
             "' class='ml-5' title='编辑字段' style='text-decoration:none' data-toggle='tooltip' data-placement='top'><i class='Hui-iconfont list_detail'>&#xe720;</i></a>"+
            "</a></td>"+
        "</tr>"
         )
    }
}

$("#wholeCheckBox_title").click(function () {
    var whole = $("input:checkbox[name = 'wholeCheckBox']");
    if (!+$("#wholeCheckBox_title").attr("isoption")) {
        $("#wholeCheckBox_title").attr("isoption", 1);
        for (var i = 0; i < whole.length; i++) {
            whole[i].checked = true;
        }
    } else {
        $("#wholeCheckBox_title").attr("isoption", 0);
        for (var i = 0; i < whole.length; i++) {
            whole[i].checked = false;
        }
    }
});
/*批量删除*/
function datadel(){
	var checked = jQuery("input[type='checkbox']:checked");
	var str="";
	var delParam = ""
;	if (checked.length) {
    if(+$("#wholeCheckBox_title").attr("isoption")){
        var ckeckLen = checked.length - 1;
    }else{
        var ckeckLen = checked.length;
    }
    // if(!+$("#wholeCheckBox_title").attr("isoption")&&ckeckLen==1){
    //
    // }else{
         layer.confirm('确认删除这'+(ckeckLen)+'项么？',function(index){
		    for(var i = 0;i < checked.length;i++){
		        if(checked[i].id == "wholeCheckBox_title"){
		            continue;
                }
		        if(i == checked.length - 1){
		            str += checked[i].value;
		            break;
                }else{
		            str += checked[i].value + ','
                }
            }
		    console.log(str);delParam = {"ids":str,"type":"1"}
		    ajaxFunction("/batchDel", "POST", "JSON", "application/ json,charset=utf8", delParam, function(){layer.msg('已删除!',{icon:1,time:1000});document.location.reload();}, function(){layer.msg('删除失败!',{icon:1,time:1000});});
	    });
	// }
    }else {
		//此处请求后台程序，下方是成功后的前台处理……
		layer.msg('未选择删除对象',{icon:1,time:2000});
	}

}



