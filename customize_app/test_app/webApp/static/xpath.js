/**
 * Created by 520cloud on 2017-06-28.
 */
function loadPath(xpath,doc){
    var nodes=document.evaluate(xpath,doc||document.documentElement,null,XPathResult.ANY_TYPE);
    // var node=nodes.iterateNext()
    var node=null;
    while(node=nodes.iterateNext(),node){
        console.log(node+"===")
    }
}
