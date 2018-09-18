/**
 * Created by Administrator on 2017/5/16.
 */
paramList=window.location.search.substring(1).split("&");
id=null;
executeStatus=null;
for(key in paramList){
    param=paramList[key]
    params=param.split("=")
    if(params[0]=="id"){
        id=params[1]
    }
    if(params[0]=="executeStatus"){
        executeStatus=params[1]
    }
}
var socket;
function connect() {
    var host = webSocketUrl
    socket = new WebSocket(host);
    try {
        socket.onopen = function (msg) {
            console.log("连接成功！");
        };

        socket.onmessage = function (msg) {
            try{
                if (typeof msg.data == "string") {
                    var data2 = msg.data;
                    var  d=JSON.parse(data2.replace(/'/g, '"'));
                    taskJobId = d.taskJobId
                    if(d.action=="2"){
                        param = {"taskJobId":taskJobId}
                        ajaxFunction("/queryGisDetailBigByDetailKv", "POST", "JSON", "application/ json,charset=utf8", param,detail,error)
                    }
                }
            }catch (E){
                console.log("error!");
            }
        };
        // socket.onclose = function (msg) { alert("socket closed!") };
    }catch (ex) {
        log(ex);
    }
}
connect();

    type = localStorage["type"];
    function showModle() {
        if($(".movie").hasClass("flag")){
        $(".movie").css("display","block");
        $("#genuine").find("i").html("&#xe6a1;");
        $(".movie").removeClass("flag");
        }else{
             $(".movie").css("display","none");
        $("#genuine").find("i").html("&#xe600;");
        $(".movie").addClass("flag");
        }
    }
    function showpiracy() {
        if($(".name").hasClass("flag")){
        $(".name").css("display","block");
        $("#piracy").find("i").html("&#xe6a1;");
        $(".name").removeClass("flag");
        }else{
             $(".name").css("display","none");
        $("#piracy").find("i").html("&#xe600;");
        $(".name").addClass("flag");
        }
    }
    // param = {"taskJobId":id}
    // ajaxFunction("/queryGisDetailBigByDetailKv", "POST", "JSON", "application/ json,charset=utf8", param,detail,error)
function  detail(resp) {
    $("#tbody").html("");
    data = resp['data'];
    dataResult = data[0][0];
    dataid = dataResult.id;
    str = dataResult.genuineInfo;
    arrGenuine = str.split(";");
    srt1 = data[0].piracyInfo;
    arrPiracy = str.split(";");
     $("#tbody").append("<div class='row cl'>"+
         "<span  id='key1' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>侵权内容名称</span>"+
         "<span  id='value1' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.detailKv+"</span>"+
		 "</div>"+"</hr>"+
		 "<div class='row cl'>"+
         "<span id='key2' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>疑似盗版网站URL</span>"+
         "<span id='value2' class='form-label col-xs-2 col-sm-4' text-align: left;'>"+dataResult.detailUrl+"</span>"+
		 "</div>"+"</hr>"+
		 "<div class='row cl'>"+
         "<span id='key3' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>疑似盗版网站归属地</span>"+
         "<span id='value3' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.detailArea+"</span>"+
		 "</div>"+"</hr>"+
		 "<div class='row cl'>"+
         "<span id='key4' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>基础信息匹配度</span>"+
         "<span id='value4' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.suitability+"</span>"+
		 "</div>"+"</hr>"+
         "<div class='row cl'>"+
         "<span id='key5' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>百度搜索指数</span>"+
         "<span id='value5' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.baiduSearchCnt+"</span>"+
		 "</div>"+"</hr>"+
		 "<div class='row cl'>"+
         "<span id='key6' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>好搜搜索指数</span>"+
         "<span id='value6' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.haosouSearchCnt+"</span>"+
		 "</div>"+"</hr>"+
         "<div class='row cl'>"+
         "<span id='key7' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>搜狗搜索指数</span>"+
         "<span id='value7' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.sougouSearchCnt+"</span>"+
		 "</div>"+"</hr>"+
         "<div class='row cl'>"+
         "<span id='key8' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>微信搜索指数</span>"+
         "<span id='value8' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.weixinSearchCnt+"</span>"+
		 "</div>"+"</hr>"+
		 "<div class='row cl'>"+
         "<span id='key9' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>匹配范围</span>"+
         "<span id='value9' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.suitabilityRange+"</span>"+
		 "</div>"+"</hr>"+
		 "<span style='width:20%'>"+
		 "<div id='genuine' onclick='showModle()'><i class='Hui-iconfont list_result'>&#xe6a1;</i>正版基础信息详情"+
		 "<div class='movie' style='margin-left: 20px'>"+
		 "<div>"+"<span id='key10' style='width:20%'>"+chooseType(type)+"</span>"+
		 "<span id='value10'  class='span-status' style=' float: right;margin-right: 1000px;'>"+arrGenuine[0]+"</span>"+"</div>"+
		 "<div>"+"<span id='key11' style='width:20%'>"+chooseType1(type)+"</span>"+
		 "<span id='value11'  class='span-status' style=' float: right;margin-right: 1000px;'>"+arrGenuine[1]+"</span>"+"</div>"+
		 "<div>"+"<span id='key12' style='width:20%'>"+chooseType2(type)+"</span>"+
		 "<span id='value12' class='span-status' style=' float: right;margin-right: 1000px;'>"+arrGenuine[2]+"</span>"+"</div>"+
		 "</div>"+"</div>"+"</span>"+
		  "<span style='width:20%'>"+
		 "<div id='piracy'' onclick='showpiracy()'><i class='Hui-iconfont list_result'>&#xe6a1;</i>盗版基础信息详情"+
		 "<div class='name' style='margin-left: 20px'>"+
		 "<div>"+"<span id='key13' style='width:20%'>"+chooseType(type)+"</span>"+
		 "<span id='value13'  class='span-status' style=' float: right;margin-right: 1000px;'>"+arrPiracy[0]+"</span>"+"</div>"+
		 "<div>"+"<span id='key14' style='width:20%'>"+chooseType1(type)+"</span>"+
		 "<span id='value14' class='span-status' style=' float: right;margin-right: 1000px;'>"+arrPiracy[1]+"</span>"+"</div>"+
		 "<div>"+"<span id='key15' style='width:20%'>"+chooseType2(type)+"</span>"+
		 "<span  id='value15'  class='span-status' style=' float: right;margin-right: 1000px;'>"+arrPiracy[2]+"</span>"+"</div>"+
		 "</div>"+"</div>"+"</span>"+
		 "<div class='row cl'>"+
         "<span id='key16' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>盗版源头</span>"+
         "<span id='value16' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.piracySource+"</span>"+
		 "</div>"+"</hr>"+
		 "<div class='row cl'>"+
         "<span id='key17' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>预估影响指数</span>"+
         "<span id='value17' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.estimatedImpactCnt+"</span>"+
		 "</div>"+"</hr>"+
		 "<div class='row cl'>"+
         "<span id='key18' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>盗版内容传播率</span>"+
         "<span id='value18' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.transmissionRate+"</span>"+
		 "</div>"+"</hr>"+
		 "<div class='row cl'>"+
         "<span id='key19' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>盗版资源内容大小</span>"+
         "<span id='value19' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.resourceSize+"</span>"+
		 "</div>"+"</hr>"+
		 "<div class='row cl'>"+
         "<span id='key20' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>传播范围</span>"+
         "<span id='value20' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.spreadScope+"</span>"+
		 "</div>"+"</hr>"+
		 "<div class='row cl'>"+
         "<span id='key21' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>预估影响量</span>"+
         "<span id='value21' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.estimatedImpactCnt+"</span>"+
		 "</div>"+"</hr>"+
		 "<div class='row cl'>"+
         "<span id='key22' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>盗版资源内容大小</span>"+
         "<span id='value22' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.resourceSize+"</span>"+
		 "</div>"+"</hr>"+
		 "<div class='row cl'>"+
         "<span id='key23' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>盗版资源上架日期</span>"+
         "<span id='value23' class='form-label col-xs-2 col-sm-4' style='width:20%;text-align: left;'>"+dataResult.resourceInDate+"</span>"+
		 "</div>"+"</hr>"+
         " <div class='row cl' style='margin-top: 20px;'>"+
         "<span class='col-xs-1 col-sm-1 col-xs-offset-2 col-sm-offset-2'>"+
         "<input class='btn btn-primary radius' onclick='saveCertificate()' type='button' id='nextBtn' value='&nbsp;&nbsp;存证&nbsp;&nbsp;'>"+
         "</span>"+
         "<span class='col-xs-1 col-sm-1 col-xs-offset-2 col-sm-offset-2'>"+
         "<input class='btn btn-default radius' type='button' id='cancelBtn' onclick='window.history.back();return false;' value='&nbsp;&nbsp;取消&nbsp;&nbsp;'>"+
         "</span>"+"</div>"
     )
}
function  chooseType(type) {
    if(type == 0){
        return "电影名称";
        arrayType = ["电影名称,导演,年代"];
    }else if(type == 1){
        arrayType = ["专辑名,歌手名,歌名"];
        return "专辑名";
    }else if(type == 2){
         return "书名";
        arrayType = ["书名,作者,年代"];
    }
}
function  chooseType1(type) {
    if(type == 0){
        return "年代";
    }else if(type == 1){
        return "歌名";
    }else if(type == 2){
         return "年代";
    }
}
function  chooseType2(type) {
    if(type == 0){
        return "导演";
    }else if(type == 1){
        return "歌手名";
    }else if(type == 2){
         return "作者";
    }
}
function  saveCertificate(){
        a=[]
        for(var i= 1;i<23;i++){
            a.push($("#key"+i).text()+':')
            a.push($("#value"+i).text()+'\n');
        }
        str=a.join(',');
        var reg = /(?=,(\s\S)*),/g;
        str = str.replace(reg, '');
        console.log("str"+str);
        param ={"content":str,"phone":"15850751716","name":id,"id":dataid};
      ajaxFunction("/saveCert", "POST", "JSON", "application/ json,charset=utf8", param,successSave,error)

}
function successSave(resp){
    if(resp.returnMsg == "SUCCESS"){
        layer.msg('存证成功!', {icon: 6,time:2000});
        $("#nextBtn").removeClass("btn-primary").addClass("disabled");
        $("#nextBtn").val("已存证");
        param ={"id":id};
        ajaxFunction("/publisher/updateExecuteStatus", "POST", "JSON", "application/ json,charset=utf8", param,successStatus,error);
        window.location.href="/use/use_list.html?4"
    }else{
        layer.msg('存证失败!', {icon: 5,time:2000});
    }
}
function successStatus(resp){
    var a = 0
;}
function  error(){
    console.log("error")
}