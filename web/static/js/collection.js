var barsData = [];
var peiData = [];
var lineData = [];

/*采集指数接口调用*/
// ajaxFunction("/totalCollectByType", "POST", "JSON", "application/json,charset=utf8", "", peiSuccess, error);
/*采集网站接口调用*/
// ajaxFunction("/totalCollectByTemplate", "POST", "JSON", "application/json,charset=utf8", "", barsSuccess, error);
/*数据采集趋势接口调用*/
ajaxFunction("/totalCollectListener", "POST", "JSON", "application/json,charset=utf8", "", success, error);


function success(resp){
    // resp["data"][0] = [{"count":123445,"name":"旅游"},{"count":23445,"name":"旅游1"},{"count":1234455,"name":"旅游2"},{"count":1234445,"name":"旅游3"}];
    //
    // resp["data"][1] = [{"count":12342342345,"name":"########","percent":0.8},{"count":12342342345,"name":"########","percent":0.8},
    //     {"count":12342342345,"name":"########","percent":0.7},
    //     {"count":12342342345,"name":"########","percent":0.6},
    //     {"count":12342342345,"name":"########","percent":0.5}
    // ];
    if(resp["data"][0]){
        peiSuccess(resp["data"][0]);
        drawPie(peiData);/*采集指数报表展示*/
    }else{
        $(".pieContent").html("暂无数据!");
    }
    if(resp["data"][1]){
       barsSuccess(resp["data"][1]);
       drawBars(barsData);/*采集指数报表展示*/
    }else{
        $(".barContent").html("暂无数据!");
    }
    if(resp["data"][2]){
        lineSuccess(resp["data"][2]);
        drawCollectTrend(lineData);/*数据采集趋势报表展示*/
    }else{
        $(".subContent").html("暂无数据!");
    }
}
/*接口调用失败*/
function error(resp) {
    console.log(resp + "/fail");
}
/*转换单位*/
function getUnit(max){
    var getUnit = {};
    var newNum;
    var length = max.toString().length;
    if(length >= 0 && length <= 5){
        newNum = 1;
        getUnit = {"divisor" : newNum ,"unit" : "B" }
    }else if(length > 5 && length <= 10){
        newNum = 1024
        getUnit = {"divisor" : newNum ,"unit" : "KB" }
    }else{
        newNum = 1024 * 1024;
        getUnit = {"divisor" : newNum ,"unit" : "MB" }
    }
     return getUnit;
}
/*获取最大值*/
function getMax(data){
    var max = +data[0]["count"];
    var len = data.length;
    for (var i = 1; i < len; i++){
        if (+data[i]["count"] > max) {
            max = +data[i]["count"];
        }
    }
    return max;
}
/*采集指数接口调用成功*/
function peiSuccess(data) {
    var max;
    var getUnite = {"divisor" : 1 ,"unit" : "B" };
    max = getMax(data);
    getUnite = getUnit(max);
    peiUnit = getUnite["unit"];
    for(var i = 0; i < data.length; i++){
        var item = {"value":(data[i]["count"]/getUnite["divisor"]).toFixed(1),"name":data[i]["name"]};
        peiData.push(item);
    }
}

/*采集指数接口调用成功*/
function barsSuccess(data){
    var max;
    var getUnite = {"divisor" : 1 ,"unit" : "B" };
    max = getMax(data);
    getUnite = getUnit(max);
    barUnit = getUnite["unit"];
    for(var i = 0; i < data.length; i++){
        var item = {"num":(data[i]["count"]/getUnite["divisor"]).toFixed(1),"name":data[i]["name"],"percent":data[i]["percent"],"value":data[i]["percent"]};
        barsData.push(item);
    }
}

/*数据采集趋势接口调用成功*/
function lineSuccess(data){
    var max;
    var getUnite = {"divisor" : 1 ,"unit" : "B" };
    max = getMax(data);
    getUnite = getUnit(max);
    lineUnit = getUnite["unit"];
    for(var i = 0; i < data.length; i++){
        var item = {"time":data[i]["time"],"data": (data[i]["count"]/getUnite["divisor"]).toFixed(1)};
        lineData.push(item);
    }
}

/**添加采集网站合集**/
function drawBars(data){
    $(".barContent").html("");
    var item;
    for(var i = 0;i < data.length;i++){
        item = ' <div class="barItem">' +
                '<span class="progressName">'+data[i]["name"]+'</span>' +
                '<progress class="progressBar" value="'+data[i]["value"]+'" max="1"></progress>' +
                // '<span class="progressPercent">'+(data[i]["percent"]).toString().split(".")[1]+'%</span>' +
                '<span class="progressPercent">&nbsp;'+(Math.round(data[i]["percent"] * 10000)/100).toFixed(1)+'%</span>' +
                '<span class="progressNum">'+data[i]["num"]+ "&nbsp;" +barUnit +'</span>' +
                '</div>' ;
        $(".barContent").append(item);
    }
}

/**添加采集指数合计**/
function drawPie(data){
    var unit ;
    unit = peiUnit;
    var myChart = echarts.init(document.getElementsByClassName('pieContent')[0]);
    var option = {
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        toolbox: {
            show : false,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {
                    show: true,
                    type: ['pie', 'funnel']
                },
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        calculable : true,
        series : [
            {
                name:'单位:'+ unit,
                type:'pie',
                radius : [30, 130],
                center : ['50%', '50%'],
                roseType : 'area',
                data: data
        }
        ]
    };
  myChart.setOption(option);
}

/**添加数据采集趋势**/
function drawCollectTrend(){
    var trendUnite = [];
    trendUnite.push("体量(" + lineUnit + ")");
    $(".subContent").html("暂无数据!");
    var myChart = echarts.init(document.getElementById('subContent'));
    var option = {
    // title: {
    //     text: '折线图堆叠'
    // },
    tooltip: {
        trigger: 'axis',
        formatter: "{a} <br/>{b} : {c}"
    },
    legend: {
        data:trendUnite
    },
    grid: {
        left: '8%',
        right: '8%',
        bottom: '3%',
        containLabel: true
    },
    // toolbox: {
    //     feature: {
    //         saveAsImage: {}
    //     }
    // },
    xAxis: {
        type: 'category',
        boundaryGap: false,//lineData
        data: getTime(lineData)
    },
    yAxis: {
        type: 'value'
    },
    series: [
        {
            name:trendUnite,
            type:'line',
            stack: '总量',
            data: getNum(lineData)
        }
    ]
};
    myChart.setOption(option);
}

function getTime(lineData){
    var time  = [];
    for(var i = lineData.length - 1; i >= 0; i--){
        time.push(lineData[i]["time"]);
    }
    return time;
}

function getNum(lineData){
    var num  = [];
    for(var i = lineData.length - 1; i >= 0; i--){
        num.push(lineData[i]["data"]);
    }
    return num;
}


