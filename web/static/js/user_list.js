/**
 * Created by Administrator on 2017/5/15.
 */
/*管理员-增加*/
function admin_add(title,url,w,h){
	layer_show(title,url,w,h);
}
function genertable(obj,id){
	layer.confirm('确认要生成表吗？',function(index){
	    jQuery.ajax({
	        url:"../createtable/"+id,
			type:"post"
		}).done(function(){
		    parent.reload();
		})
		//此处请求后台程序，下方是成功后的前台处理……
	});
}
function crawler(obj,id){
	layer.confirm('确认要修改密码？',function(index){
	    jQuery.ajax({
	        url:"../crawler/"+id,
			type:"post"
		}).done(function(){
		    parent.reload();
		})
		//此处请求后台程序，下方是成功后的前台处理……
	});
}
/*管理员-删除*/
function admin_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		//此处请求后台程序，下方是成功后的前台处理……

		jQuery(obj).parents("tr").remove();
		layer.msg('已删除!',{icon:1,time:1000});
	});
}
function datadel(){
	var checked = jQuery("input[type='checkbox']:checked");
	if (checked.length) {
	    layer.confirm('确认删除这'+checked.length+'项么？',function(index){
		//此处请求后台程序，下方是成功后的前台处理……
		jQuery(obj).parents("tr").remove();
		layer.msg('已删除!',{icon:1,time:1000});
	});
//		layer.msg('确认删除这'+checked.length+'项么？',{icon:1,time:2000});
	} else {
		//此处请求后台程序，下方是成功后的前台处理……
		layer.msg('未选择删除对象',{icon:1,time:2000});
	}
}
/*管理员-编辑*/
function admin_edit(title,url,id,w,h){
	layer_show(title,url,w,h);
}
/*管理员-停用*/
function admin_stop(obj,id){
	layer.confirm('确认要停用吗？',function(index){
		//此处请求后台程序，下方是成功后的前台处理……

		jQuery(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_start(this,id)" href="javascript:;" title="启用" style="text-decoration:none"><i class="Hui-iconfont">&#xe615;</i></a>');
		jQuery(obj).parents("tr").find(".td-status").html('<span class="label label-default radius">已禁用</span>');
		jQuery(obj).remove();
		layer.msg('已停用!',{icon: 5,time:1000});
	});
}

/*管理员-启用*/
function admin_start(obj,id){
	layer.confirm('确认要启用吗？',function(index){
		//此处请求后台程序，下方是成功后的前台处理……

		jQuery(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_stop(this,id)" href="javascript:;" title="停用" style="text-decoration:none"><i class="Hui-iconfont">&#xe631;</i></a>');
		jQuery(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
		jQuery(obj).remove();
		layer.msg('已启用!', {icon: 6,time:1000});
	});
}
function crawler(obj,id){
	layer.confirm('确认要修改密码？',function(index){
	    jQuery.ajax({
	        url:"../crawler/"+id,
			type:"post"
		}).done(function(){
		    parent.reload();
		})
		//此处请求后台程序，下方是成功后的前台处理……
	});
}
function search() {
	var wordlength = jQuery("#input-text").val().length;
	if(wordlength == 0){
	    layer.msg('请输入要搜索的内容',{icon:1,time:2000});
	}else{

	}
}
function admin_stop1(obj,id){
	layer.confirm('确认启用代理吗？',function(index){
		//此处请求后台程序，下方是成功后的前台处理……
		jQuery(obj).parents("tr").find(".td-status2").html('<span class="label label-success radius" onClick="admin_start1(this,id)">已启用</span>');
		jQuery("#status2").text("已启用")
		layer.msg('已启用!',{icon: 6,time:1000});
		data.del_flag = 1;
	});
}

function admin_start1(obj,id){
	layer.confirm('确认要禁用代理吗？',function(index){
		//此处请求后台程序，下方是成功后的前台处理……
		jQuery(obj).parents("tr").find(".td-status2").html('<span class="label label-fail radius" onClick="admin_stop1(this,id)">已禁用</span>');
		jQuery("#status2").text("以禁用");
		layer.msg('已禁用!', {icon: 5,time:1000});
		data.del_flag = 0;
	});
}
jQuery(".navBar_under li").click(function(){
		  jQuery(this).siblings('li').removeClass('check');
		  jQuery(this).addClass('check');
  })
	jQuery(".navBar_under").css("cursor","pointer");

/*为空校验*/
function validform() {
    return $("#form-url-add").validate({
        rules: {
            name: {
                required: true
            },
            url: {
                required: true
            }
        }
    });
}

/*提交按钮*/
$("#saveBtn_edit").click(function () {

    str_json = {}
    if (validform().form()) {
        ajaxFunction("/taskMgmt", "POST", "JSON", "application/json,charset=utf8", str_json, insertSuccess, error);
    }
})
/*提交成功*/
function insertSuccess() {
    console.log("insertSuccess");
}

/*提交失败*/
function error() {
    console.log("error");
}