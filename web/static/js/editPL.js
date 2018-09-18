$(function () {
    var multiple = $('#multiple').multipleSelect();
    var multiple_1 = $('#multiple-1').multipleSelect();
    var multiple_2 = $('#multiple-2').multipleSelect();

    var id = localStorage["timeId"];
    if (id) {
        var str_json = {"id": id, "type": "4"}
        ajaxFunction("/contentDetail", "POST", "JSON", "application/json,charset=utf8", str_json, detailList, error);
    }


    function detailList(res) {
        if (res) {
            if (res.result["startTime"]) {
                $("#datemin").val(res.result["startTime"].split(" ")[0]);
                $("#radio-2").attr("checked", true);
            } else {
                $("#radio-1").attr("checked", true);
            }
            if (res.result["repeatTime"] == "0") {
                $("#radio-p1").attr("checked", true);
            } else {
                $("#radio-p2").attr("checked", true);
            }
            $("#hour").val(res.result["hour"]);
            $("#minute").val(res.result["minute"]);
            if (res.result["endTime"]) {
                $("#endT").val(res.result["endTime"].split(" ")[0]);
                $("#radio-e2").attr("checked", "checked");
                $("#radio-e1").removeAttr("checked");
            } else {
                $("#radio-e1").attr("checked", "checked");
                $("#radio-e2").removeAttr("checked");
            }
        }


        if (res.result["weekDay"]) {
            $("#week_Day").attr("checked", true);
            $("#day").removeAttr("checked");
            multiple_2.data().multipleSelect.openCheckCall(res.result["weekDay"].split(","));
            // $("#multiple-2").next().find(".ms-choice").html(res.result["weekDay"]);
        }
        if (res.result["monthDay"]) {
            $("#month_Day").attr("checked", true);
            $("#day").removeAttr("checked");
            multiple_1.data().multipleSelect.openCheckCall(res.result["monthDay"].split(","));
            $("#multiple-1").next().find(".ms-choice").html(res.result["monthDay"]);
        }
        if (res.result["yearMonth"]) {
            $("#year_Month").attr("checked", true);
            $("#day").removeAttr("checked");
            multiple.data().multipleSelect.openCheckCall(res.result["yearMonth"].split(","));
            $("#multiple").next().find(".ms-choice").html(res.result["yearMonth"]);
        }

    }

    $('.skin-minimal input').iCheck({
        checkboxClass: 'icheckbox-blue',
        radioClass: 'iradio-blue',
        increaseArea: '20%'
    });
    var that = this;

    $("#cancelBtn").click(function () {
        layer_close();
    })

    multiple_1.data().multipleSelect.openCallBack = function () {
        var month = multiple.data().multipleSelect.getSelects();
        var week = multiple_2.data().multipleSelect.getSelects();
        var days = multiple_1.data().multipleSelect.getSelects();
        var arr = [];
        for (var i in month) {
            arr.push(new Date("2017", month[i], 0).getDate());
        }
        var index = Math.min.apply(null, arr) + 1;
        var listDay = [];
        for (var i = index; i < 32; i++) {
            listDay.push(i);
        }
        multiple_1.data().multipleSelect.openCall(listDay);
    }

    function validform() {
        return $("#form-url-add").validate({
            rules: {
                name: {
                    required: true
                },
                time: {
                    required: true
                },
                time1: {
                    required: true
                }
            }
        });
    }

    if ($("#day").is(":checked")) {
        $("#week_Day").attr("disabled", true);
        $("#month_Day").attr("disabled", true);
        $("#year_Month").attr("disabled", true);
        $("#multiple-1").next().find(".ms-choice").css("background-color", "#ccc");
        $("#multiple-2").next().find(".ms-choice").css("background-color", "#ccc");
        $("#multiple").next().find(".ms-choice").css("background-color", "#ccc");
    } else {
        $("#week_Day").removeAttr("disabled");
        $("#month_Day").removeAttr("disabled");
        $("#year_Month").removeAttr("disabled");
        $("#multiple-2").next().find(".ms-choice").css("background-color", "#fff");
        $("#multiple-1").next().find(".ms-choice").css("background-color", "#fff");
        $("#multiple").next().find(".ms-choice").css("background-color", "#fff");
    }
    $("#day").click(function () {
        if ($("#day").is(":checked")) {
            $("#week_Day").attr("disabled", true);
            $("#month_Day").attr("disabled", true);
            $("#year_Month").attr("disabled", true);
            $("#multiple-1").next().find(".ms-choice").css("background-color", "#ccc");
            $("#multiple-2").next().find(".ms-choice").css("background-color", "#ccc");
            $("#multiple").next().find(".ms-choice").css("background-color", "#ccc");
            $("#multiple-1").next().find(".ms-choice span").html("");
            $("#multiple-2").next().find(".ms-choice span").html("");
            $("#multiple").next().find(".ms-choice span").html("");
        } else {
            $("#week_Day").removeAttr("disabled");
            $("#month_Day").removeAttr("disabled");
            $("#year_Month").removeAttr("disabled");
            $("#multiple-2").next().find(".ms-choice").css("background-color", "#fff");
            $("#multiple-1").next().find(".ms-choice").css("background-color", "#fff");
            $("#multiple").next().find(".ms-choice").css("background-color", "#fff");
        }
    })
    $("#week_Day").click(function () {
        if ($("#week_Day").is(":checked")) {
            $("#day").attr("disabled", true);
            $("#month_Day").attr("disabled", true);
            $("#multiple-1").next().find(".ms-choice").css("background-color", "#ccc");
            $("#multiple-1").next().find(".ms-choice span").html("");
        } else {
            if ($("#year_Month").is(":checked")) {
                $("#day").attr("disabled", true);
            } else {
                $("#day").removeAttr("disabled");
            }

            $("#month_Day").removeAttr("disabled");
            $("#multiple-1").next().find(".ms-choice").css("background-color", "#fff");
        }
    })
    $("#month_Day").click(function () {
        if ($("#month_Day").is(":checked")) {
            $("#day").attr("disabled", true);
            $("#week_Day").attr("disabled", true);
            $("#multiple-2").next().find(".ms-choice").css("background-color", "#ccc");
            $("#multiple-2").next().find(".ms-choice span").html("");
        } else {
            if ($("#year_Month").is(":checked")) {
                $("#day").attr("disabled", true);
            } else {
                $("#day").removeAttr("disabled");
            }

            $("#week_Day").removeAttr("disabled");
            $("#multiple-2").next().find(".ms-choice").css("background-color", "#fff");
        }
    })
    $("#year_Month").click(function () {
        if ($("#year_Month").is(":checked")) {
            $("#day").attr("disabled", true);
        } else {
            $("#day").removeAttr("disabled");
        }
    })


    $("#saveBtn").bind("click", function () {
        if($("#hour").val()=="" || $("#minute").val()==""){
            $("#infoMation").text("时分不能为空").css("visibility","visible");
            return;
        }
        if(+($("#hour").val())>60 || +($("#minute").val()) >60){
            $("#infoMation").text("时分不合法") .css("visibility","visible");
            return;
        }
        $("#radio-2").val($("#datemin").val());
        $("#radio-e2").val($("#endT").val());
        $("#week_Day").val(multiple_2.data().multipleSelect.getSelects() + "");
        $("#month_Day").val(multiple_1.data().multipleSelect.getSelects() + "");
        $("#year_Month").val(multiple.data().multipleSelect.getSelects() + "")
        //代替serialize()
        req = {"action": "0"}
        $("input,select").each(function (index, col) {
            var key = $(this).attr("name");
            if (!key) {
                return true
            }
            var value = null;
            switch (key) {
                case "week_Day":
                    value = multiple_2.data().multipleSelect.getSelects();
                    break;
                case "month_Day":
                    value = multiple_1.data().multipleSelect.getSelects();
                    break;
                case "year_Month":
                    value = multiple.data().multipleSelect.getSelects();
                case "repeatTime":
                    value = $('input:radio[name="repeatTime"]:checked').val();
                    break;
                default:
                    value = $(this).val()
            }
            if (!value) {
                return true
            }
            req[key] = Array.isArray(value) ? value.join(",") : value
        })

        ajaxFunction("/taskJobTimerMgnt", "POST", "JSON", "application/json,charset=utf8", req, dataIDResp, error);

    });

    function dataIDResp(res) {
        parent.parent.timerJobTimerId = res.timerJobTimerId;
        window.parent.parentTime(res.timerJobTimerId);
        layer_close();
    }

    function error() {

    }

})
