<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>
</head>
<body>
  <div class="container-fluid" id="main-container">
    <div id="page-content" class="clearfix">
      <div class="row-fluid">
        <div class="row-fluid">
          <!-- 检索  -->
          <form action="attrType/attrButeList.do" method="post" name="Form" id="Form">
            <table>
              <tr>
                <td style="vertical-align:top;"> 
                  <select class="chzn-select" name="attrTypeId" id="attrTypeId" data-placeholder="请选择类型" style="vertical-align:top;width: 150px;">
                    <option value=""></option>
                    <option value="">全部</option>
                    <c:forEach items="${attrTypeList}" var="attrType">
                      <option value="${attrType.attrTypeId }" <c:if test="${pd.attrTypeId==attrType.attrTypeId}">selected</c:if>>${attrType.typeName }</option>
                    </c:forEach>
                  </select>
                </td>
                <td>
                  <span class="input-icon">
                    <input autocomplete="off" id="nav-search-input" type="text" name="keyword" value="${keyword}" placeholder="这里输入关键词" />
                    <i   class="icon-search"></i>
                  </span>
                </td>
                <td style="vertical-align:top;">
                  &nbsp;
                  <button class="btn btn-mini btn-light" onclick="search();" title="检索">
                    <i id="nav-search-icon" class="icon-search"></i>
                  </button>
                </td> <td style="vertical-align:top;">
                  &nbsp;
                <c:if test="${QX.add == 1 }">
                    <a class="btn btn-small btn-success" onclick="add();">新增</a>
                  </c:if>
                </td>
              </tr>
            </table>
            <!-- 检索  -->


            <table id="table_report" class="table table-striped table-bordered table-hover">
              <thead>
                <tr>
                  <th class="center">
                    <label>
                      <input type="checkbox" id="zcheckbox" />
                      <span class="lbl"></span>
                    </label>
                  </th>
                  <th class="center">序号</th>
						<th class="center">属性名称</th>
						<th class="center">属性添加类别</th>
						<th class="center">属性选择类型</th>
						<th class="center">属性值</th>
                        <th class="center">操作</th>
                </tr>
              </thead>

              <tbody>

                <!-- 开始循环 -->
                <c:choose>
                  <c:when test="${not empty attributeList}">
                    <c:if test="${QX.cha == 1 }">
                      <c:forEach items="${attributeList}" var="var" varStatus="vs">
                        <tr>
                          <td class='center' style="width: 30px;">
                            <label>
                              <input type='checkbox' name='ids' value="${var.attributeId}" />
                              <span class="lbl"></span>
                            </label>
                          </td>
                          <td class='center' style="width: 30px;">${vs.index+1}</td>
                          <td style="max-width: 100px;overflow: hidden;white-space: nowrap;text-align:center;text-overflow: ellipsis;" title="${var.attrName}">${var.attrName}</td>
                          <c:if test="${var.attrInputType == 1 }" >
                                <td style="max-width: 50px;overflow: hidden; text-align:center; white-space: nowrap;text-overflow: ellipsis;" title="选择输入">选择输入</td>
                           </c:if>
                           <c:if test="${var.attrInputType == 2 }" >
                                <td style="max-width: 50px;overflow: hidden; text-align:center; white-space: nowrap;text-overflow: ellipsis;" title="手动输入">手动输入</td>
                           </c:if>
                           <c:if test="${var.attrType == 1 }" >
                                <td style="max-width: 50px;overflow: hidden; text-align:center; white-space: nowrap;text-overflow: ellipsis;" title="唯一属性">唯一属性</td>
                           </c:if>
                           <c:if test="${var.attrType == 2 }" >
                                <td style="max-width: 50px;overflow: hidden; text-align:center; white-space: nowrap;text-overflow: ellipsis;" title="单选属性">单选属性</td>
                           </c:if>
                          <td style="max-width: 190px;overflow: hidden;white-space: nowrap;text-align:center;text-overflow: ellipsis;" title="${var.attrValues}">${var.attrValues}</td>
                          
                          <%--<td style="width: 180px;" class="center">
                            <c:if test="${QX.edit != 1 && QX.del != 1 }">
                              <span class="label label-large label-grey arrowed-in-right arrowed-in">
                                <i class="icon-lock" title="无权限"></i>
                              </span>
                            </c:if>
                             <a class='btn btn-mini btn-success' title="查看属性值" onclick="viewAttr('${var.attributeId}');">
		                            <i class='icon-eye-open'></i>
		                     </a>
                            <div class="inline position-relative">
                              <c:if test="${QX.edit == 1 || QX.del == 1 }">
                                <button class="btn btn-mini btn-info" data-toggle="dropdown">
                                  <i class="icon-cog icon-only"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
                                  <c:if test="${QX.edit == 1 }">
                                    <li>
                                      <a style="cursor:pointer;" title="编辑" onclick="edit('${var.attributeId}');" class="tooltip-success" data-rel="tooltip" title=""
                                        data-placement="left">
                                        <span class="green">
                                          <i class="icon-edit"></i>
                                        </span>
                                      </a>
                                    </li>
                                  </c:if>
                                 
                                  <c:if test="${QX.del == 1 }">
                                    <li>
                                      <a style="cursor:pointer;" title="删除" onclick="del('${var.attributeId}');" class="tooltip-error"
                                        data-rel="tooltip" title="" data-placement="left">
                                        <span class="red">
                                          <i class="icon-trash"></i>
                                        </span>
                                      </a>
                                    </li>
                                  </c:if>
                                </ul>
                              </c:if>
                            </div>
                          </td>--%>
                          <td class='center'  style="text-align:center;">
                            <%--<a href="javascript:void(0);" onclick="viewAttr('${var.attributeId}')">查看</a>--%>
                            <a href="javascript:void(0);" onclick="edit(${var.attributeId})">编辑</a>
                            <a href="javascript:void(0);" onclick="del('${var.attributeId}')">删除</a>
                          </td>
                        </tr>

                      </c:forEach>
                    </c:if>
                    <c:if test="${QX.cha == 0 }">
                      <tr>
                        <td colspan="100" class="center">您无权查看</td>
                      </tr>
                    </c:if>
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
                    <c:if test="${QX.del == 1 }">
                      <a class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除">
                        <i class='icon-trash'></i>
                      </a>
                    </c:if>
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
  <!--提示框-->
  <script type="text/javascript">
		$(top.hangge());
		$(function() {
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
		});
		
		//检索
		function search(){
			top.jzts();
			var form = $("#Form");
			form.find('#currentPage').attr('name','currentPage');
			form.find('#showCount').attr('name','showCount');
			$("#Form").submit();
		}
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>attrType/goAddAttrButeType.do';
			 diag.Width = 600;
			 diag.Height = 400;
			 diag.CancelEvent = function(){ //关闭事件
				 /* if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 top.jzts();
						 setTimeout("self.location=self.location",100);
					 }else{
						 if(typeof(nextPage) == "function") {
							nextPage(${page.currentPage});
						}
					 }
				} */
				history.go(0);
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>attrType/deleteAttribut.do?attributeId="+Id;
					$.get(url,function(data){
						if(typeof(nextPage) == "function") {
							nextPage(${page.currentPage});
						}
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>attrType/goEditAttrButeType.do?attributeId='+Id;
			 diag.Width = 600;
			 diag.Height = 400;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if(typeof(nextPage) == "function") {
						nextPage(${page.currentPage});
					}
				}
				diag.close();
			 };
			 diag.show();
		}
		//查看
		function viewAttr(Id){
			var diag = new top.Dialog();
			diag.Drag=true;
			diag.Title ="属性值";
			diag.URL = '<%=basePath%>attribute/goAttrButeView.do?attributeId='+Id;
			diag.Width = 300;
			diag.Height = 300;
			diag.OKEvent = function(){
				diag.close();
			};
			diag.show();
		}
		</script>

  <script type="text/javascript">
		$(function() {
			//复选框
			$('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
					
			});
			
		});
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  }
					}
					if(str==''){
						bootbox.dialog("您没有选择任何内容!", 
							[
							  {
								"label" : "关闭",
								"class" : "btn-small btn-success",
								"callback": function() {
									//Example.show("great success");
									}
								}
							 ]
						);
						
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>attrType/deleteAllAttrbute.do',
						    	data: {ids:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 if(data.msg == 'ok') {
										 if(typeof(nextPage) == "function") {
											nextPage(${page.currentPage});
										}
									 }
								}
							});
						}
					}
				}
			});
		}
  </script>

</body>
</html>

