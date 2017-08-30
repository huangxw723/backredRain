<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>
<script type="text/javascript">
var tr;
/**
 * 点击图片展开或者收缩
 */
function rowClick(node) {
	var thisTr = $(node).parent("tr");
    var thisGtId = thisTr.data("id");
    var thisParentId = thisTr.data("parentid");
    var thisIdPath = thisTr.data("idpath");
    var thisStatus = thisTr.data("status");
    if(thisStatus == "close") {
    	thisTr.data("status", "open");
    	thisTr.attr("data-status", "open");
    	thisTr.find("img:first").attr("src", "static/images/menu_minus.gif");
    	thisTr.nextAll("[data-parentid='"+thisGtId+"']").fadeIn();
    	thisTr.nextAll("[data-status='open']").each(function(i, tr){
    		if($(tr).data("parentid") == thisGtId) {
    			openChild(tr);
    		}
    	});
    } else {
    	thisTr.data("status", "close");
    	thisTr.attr("data-status", "close");
    	thisTr.find("img:first").attr("src", "static/images/menu_plus.gif");
    	thisTr.nextAll("[data-idpath*='_"+thisGtId+";']").fadeOut();
    }
    function openChild(child) {
    	$(child).nextAll("[data-parentid='"+$(child).data("id")+"']").each(function(i, tr){
    		$(tr).fadeIn();
    		if($(tr).data("status") == "open") {
    			openChild(tr);
    		}
    	});
    }
}

function initTreeTable() {
	var parents = $("#table_report tbody tr:visible");
	var children = $.makeArray($("#table_report tbody tr:hidden"));
	children.reverse();
	$.each(parents, function(i, parent){
		sort(parent);
	});
	
	function sort(parent) {
		$.each(children, function(i, child){
			if($(child).data("parentid") == $(parent).data("id")) {
				$(parent).after($(child));
				sort(child);
			}
		});
	}
}

function expandAll(flag) {
	if (flag) {
		$("#table_report tbody tr").attr("data-status", "open").data("status", "open").fadeIn().find("img:first").attr("src", "static/images/menu_minus.gif");
	} else {
		$("#table_report tbody tr").attr("data-status", "close").data("status", "close").find("img:first").attr("src", "static/images/menu_plus.gif");
		$("#table_report tbody tr[data-parentid!='0']").fadeOut();
	}
}

</script>
</head>
<body>
  <div class="container-fluid" id="main-container">
    <div id="page-content" class="clearfix">
      <div class="row-fluid">
        <div class="row-fluid">
          <!-- 检索  -->
          <form action="consultation/type/typeList.do" method="post" name="Form" id="Form">
            <table>
              <tr>
                <td>
                  <span class="input-icon"> <input autocomplete="off" id="nav-search-input" type="text" name="keyWord" value="${keyWord}"
                      placeholder="这里输入关键词" /> <i id="nav-search-icon" class="icon-search"></i>
                  </span>
                </td>

                <td style="vertical-align:top;">
                  <button class="btn btn-mini btn-light" title="检索">
                    <i id="nav-search-icon" class="icon-search"></i>
                  </button>
                </td>
              </tr>
            </table>
            <!-- 检索  -->


            <table id="table_report" class="table table-striped table-bordered table-hover">
              <thead>
                <tr>
                  <th style="width: 40%;" class="center">咨询名称<a id="treeButton" href="javascript:void(0);">[收缩]</a></th>
                  <th style="width: 10%;" class="center">咨询排序</th>
                  <th style="width: 20%;" class="center">操作</th>
                </tr>
              </thead>

              <tbody>

                <!-- 开始循环 -->
                <c:choose>
                  <c:when test="${not empty typeList}">
                      <c:forEach items="${typeList}" var="var" varStatus="vs">
                        <tr data-status="close" data-name="${var.typeName}" data-id="${var.consultationTypeId}" data-parentid="${var.parentId}" data-idpath="${var.idPath}" <c:if test="${var.parentId != 0}">style="display:none;"</c:if>>
                          <td style="cursor:pointer;text-align:left;max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.typeName}" onclick="rowClick(this)">
                            <img style="margin-left: ${(var.typeLevel)*2}em" src="static/images/menu_plus.gif" />
                            ${var.typeName}
                          </td>
                          <td style="text-align:center;max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.sortOrder}">${var.sortOrder}</td>
                          <%--<td class="center">
                            <div class="inline position-relative">
                                <button class="btn btn-mini btn-info" data-toggle="dropdown" <c:if test="${vs.count ==1}">style="display: none" </c:if>>
                                  <i class="icon-cog icon-only"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
                                    <li>
                                      <a style="cursor:pointer;" title="编辑" onclick="edit(${var.consultationTypeId});" class="tooltip-success" data-rel="tooltip" title=""
                                        data-placement="left">
                                        <span class="green"> <i class="icon-edit"></i>
                                        </span>
                                      </a>
                                    </li>
                                    <li>
                                      <a style="cursor:pointer;" title="删除" onclick="del(${var.consultationTypeId});" class="tooltip-error" data-rel="tooltip" title=""
                                        data-placement="left">
                                        <span class="red"> <i class="icon-trash"></i>
                                        </span>
                                      </a>
                                    </li>
                                </ul>
                            </div>
                          </td>--%>
                          <td class='center'  style="text-align:center;">
                            <a href="javascript:void(0);" onclick="edit(${var.consultationTypeId})">编辑</a>
                            <a href="javascript:void(0);" onclick="del(${var.consultationTypeId})">删除</a>
                          </td>
                        </tr>

                      </c:forEach>
                    <%-- <c:if test="${QX.cha == 0 }">
                      <tr>
                        <td colspan="100" class="center">您无权查看</td>
                      </tr>
                    </c:if> --%>
                  </c:when>
                  <c:otherwise>
                    <tr class="main_info">
                      <td colspan="100" class="center">没有相关数据</td>
                    </tr>
                  </c:otherwise>
                </c:choose>


              </tbody>
            </table>

            <div class="page-header position-relative">
              <table style="width:100%;">
                <tr>
                  <td style="vertical-align:top;">
                  	<%--<a class="btn btn-small btn-success" onclick="add();">新增</a>--%>
                  </td>
                  <td style="vertical-align:top;">
                    <div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
                  </td>
                </tr>
              </table>
            </div>
          </form>
        </div>
        <!-- PAGE CONTENT ENDS HERE -->
      </div>
      <!--/row-->
    </div>
    <!--/#page-content-->
  </div>
  <!--/.fluid-container#main-container-->

  <!-- 返回顶部  -->
  <a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
    <i class="icon-double-angle-up icon-only"></i>
  </a>

<!-- 引入 -->
<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/ace-elements.min.js"></script>
<script src="static/js/ace.min.js"></script>

<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
<!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script>
<!-- 确认窗口 -->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
<!--提示框-->
<script type="text/javascript">

    $(top.hangge());

    $(function () {
        //单选框
        $(".chzn-select").chosen();
        $(".chzn-select-deselect").chosen({allow_single_deselect: true});
        $(".fancybox").fancybox({
            helpers: {
                title: {
                    type: 'inside'
                }
            }
        });
        $("#treeButton").click(function(){
        	if($("#treeButton").text() == "[收缩]") {
        		$("#treeButton").text("[扩展]");
        		expandAll(false);
        	} else {
        		$("#treeButton").text("[收缩]");
        		expandAll(true);
        	}
        });
        initTreeTable();
        expandAll(true);
    });

    //检索
    function search() {
    	$("#table_report tbody tr").css("color","");
    	var keyWord = $("input[name=keyWord]").val();
    	if(keyWord) {
    		$("#table_report tbody tr").attr("data-status", "close").data("status", "close").hide().find("img:first").attr("src", "static/images/menu_plus.gif");
        	$("#table_report tbody tr[data-name*='"+keyWord+"']").css("color","red").each(function(i, tr){
        		var rootId = $(tr).data("idpath").replace("_", "").split(";")[0];
        		if (rootId) {
                	$("#table_report tbody tr[data-id='"+rootId+"']").attr("data-status", "open").data("status", "open").show().find("img:first").attr("src", "static/images/menu_minus.gif");
                	$("#table_report tbody tr[data-idpath*='_"+rootId+";']").attr("data-status", "open").data("status", "open").show().find("img:first").attr("src", "static/images/menu_minus.gif");
        		} else {
        			$(tr).attr("data-status", "open").data("status", "open").show().find("img:first").attr("src", "static/images/menu_minus.gif");
        		}
        	});
    	} else {
    		expandAll(true);
    	}
    }
    //新增
    function add() {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "新增";
        diag.URL = '<%=basePath%>consultation/type/toAddType.do';
        diag.Width = 800;
        diag.Height = 600;
        diag.CancelEvent = function () { //关闭事件
            /* if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
                if ('${page.currentPage}' == '0') {
                    top.jzts();
                    setTimeout("self.location=self.location", 100);
                } else {
                	location.reload();
                }
            } */
            diag.close();
            history.go(0);
        };
        diag.show();
    }

    //删除
    function del(id) {
        bootbox.confirm("确定要删除吗?", function (result) {
            if (result) {
                top.jzts();
                var url = "<%=basePath%>consultation/type/deleteType?id="+id;
                $.get(url, function (data) {
                	if(data.msg) {
                		bootbox.alert(data.msg);
                		top.hangge();
                	} else {
                		bootbox.alert("删除成功!",function(){
                			history.go(0);
                		});
                		top.hangge();
                		
                	}
                });
            }
        });
    }

    //修改
    function edit(Id) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "编辑";
        diag.URL = '<%=basePath%>consultation/type/toEditType.do?typeId=' + Id;
        diag.Width = 500;
        diag.Height = 450;
        diag.CancelEvent = function () { //关闭事件
           /*  if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
            	location.reload();
            } */
            
            diag.close();
            history.go(0);
        };
        diag.show();
    }

</script>

</body>
</html>

