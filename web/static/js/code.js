/**
 * Created by Administrator on 2016/12/29.
 */
/*生成随机验证码*/
var code = "";
function createCode(id) {
    var codeLength = 4;
    var codeV = document.getElementById(id);
    code = "";
    //设置随机字符
    var random = [
        0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
    for (var i = 0; i < codeLength; i++) {
        //设置随机数范围,这设置为0 ~ 36
        var index = Math.floor(Math.random() * 36);
        code += random[index];
        $(codeV).find("b").eq(i).html(random[index])
    }

}
function validate(id) {
    var oValue = $("#"+id).val().toUpperCase();
    var msg = "请输入验证码";
    if (oValue == 0) {
        msg = "请输入验证码"
    } else if (oValue != code) {
        msg = '验证码不正确';
        document.getElementById(id).innerHTML = ' ';
        createCode("code");
    } else {
        msg = '校验成功';
    }
    return msg
}