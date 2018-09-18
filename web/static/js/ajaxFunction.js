function ajaxFunction(url,type,dataType,contentType,param,success,error){
    var data=JSON.stringify(param)
    $.ajax({
            url:url,
            type:type,
            dataType:dataType,
            async: false,
            contentType:"application/json,charset=utf8",
            data:data,
            success:function(resp){
                success(eval(resp))
            },
            error  :error
        })

}


// function ajaxFunction(url,type,dataType,contentType,data,callback){
//     $.ajax({
//             url:"/login",
//             type:"POST",
//             dataType:"JSON",
//             contentType:"application/json,charset=utf8",
//             data:JSON.stringify({"loginname":"admin","password":"admin"}),
//             success:function(resp){
//                 console.log(resp);
//                 return resp;
//             },
//             error:function(resp){
//                 return resp;
//             }
//         })
// }