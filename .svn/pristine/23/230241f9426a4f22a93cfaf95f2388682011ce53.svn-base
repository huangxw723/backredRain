//js获取项目根路径，如： http://localhost:8083/TenantManage
//function getRootPath(){
//  //获取当前网址，如： http://localhost:8083/TenantManage/share/index.html
//  var curWwwPath = window.document.location.href;
//  //获取主机地址之后的目录，如： TenantManage/share/index.html
//  var pathName = window.document.location.pathname;
//  var pos = curWwwPath.indexOf(pathName);
//  //获取主机地址，如： http://localhost:8083
//  var localhostPaht = curWwwPath.substring(0,pos);
//  //获取带"/"的项目名，如：/TenantManage
//  var projectName = pathName.substring(0,pathName.substr(1).indexOf('/') + 1);
//  return(localhostPaht + projectName);
//}

// 获取域名
var index = location.href.indexOf("TenantManage");
var host = location.href.substring(0, index);

/*
if( location.href.indexOf("localhost") != -1 ) {

  var host = "http://yunyingtest.aoshimall.com/redRain/";
  // var host = "http://yiyuanpai.aoshimall.com/redRain/"; // 测试
  // var host = "http://192.168.1.122/redRain/" // 旭文
}
*/

// 图片路径
template.helper('imgRoute', function (price, type) {
    // console.log(price,type)
    return "http://120.24.240.62:8099/"
});

//var isDebug = 'test';
//if (isDebug == 'host') {
//
//    var host = "http://192.168.1.176:8080/redRainInterface/"; // 开发
//
//} else if (isDebug == 'test') {
//
//    var host = "http://yiyuanpai.aoshimall.com/redRain/"; // 测试
//
//} else if (isDebug == 'formal') {
//
//    var host = "http://aoshipro.aoshimall.com/redRainInterface/"; // 正式库
//
//} else if (isDebug == 'condition') {
//
//    var host = "http://192.168.1.122:8080/";
//    // var host = "http://192.168.1.155:8080/";
//}
