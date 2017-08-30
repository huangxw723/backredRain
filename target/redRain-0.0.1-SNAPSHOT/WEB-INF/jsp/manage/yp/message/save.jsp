<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String httpUrl = PropertyUtils.getHTTP_URL();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<!--引入弹窗组件start-->
		<script type="text/javascript" src="plugins/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="plugins/attention/zDialog/zDialog.js"></script>
		<!--引入弹窗组件end-->
		<!--提示框-->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
        <script src="plugins/ckeditor/ckeditor.js"></script>
  		<script src="plugins/ckeditor/config.js"></script>
		<script type="text/javascript" src="static/js/common/commonutils.js"></script>
	   <script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script>
	   <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
<script type="text/javascript">
$(top.hangge());
$(function() {
	   $('.date-picker').datepicker();
		$(".chzn-select").chosen(); 
		$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
		
		CKEDITOR.replace('descp',{
			width:1100,
			
		});
		CKEDITOR.instances.illustration.on('blur', function() { 
          var d = this.getData(); 
          this.setData(d); 
        }); 
	});

	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }
	
	//保存
	function save(){

		var title = $('#title').val();
		if(validateUtils.isEmpty(title)){
			alert('请填写消息标题')
			return
		}
		
		var oEditor = CKEDITOR.instances.descp; 
		var content = oEditor.getData();
		if(validateUtils.isEmpty(content)){
			alert('请填写正文内容')
			return
		}else{
			$('#descp').val(content);
		}
        if(!checkFileSize(document.getElementById('files'))){
            return
        }
        $("#usersForm").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
	}
</script>
	</head>
<body>
<div id="page-content" class="clearfix">

	<div class="row-fluid">
<form action="yp/admin/message/saveMessage.do" name="usersForm" id="usersForm" method="post"  enctype="multipart/form-data">
	<input type="hidden" name="action" id="action" value="${action}"/>
	<input type="hidden" name="type" id="userId" value="1"/>

	<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
		<tr height="45px">
			<td>标题名称:</td>
			<td><input type="text" name="title" id="title" value="${pd.title}" style="width: 370px" onkeyup="validateUtils.replaceSpaceEmpty(this);" <c:if test="${action == 4}">disabled="disabled"</c:if>/></td>
		</tr>
		
		<tr>
			<td>正文内容:</td>
			<td>

				<textarea name="descp" id="descp">${pd.descp }</textarea>
	            
	        </td>
		</tr>
	   </table>
	<c:if test="${empty achment}">
		<a class="btn btn-mini btn-primary" onclick="addLine();">添加附件</a>
		<table id="myTable" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
		</table>
	  </c:if>
	<c:if test="${not empty achment}">
		<c:choose>
			<c:when test="${not empty achment}">
	<a class="btn btn-mini btn-primary" onclick="addLine();">添加附件</a>
	<table id="myTable" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
				<c:forEach items="${achment}" var="var" varStatus="vs">
					<tr height="45px">
						<td><a href="javascript:void(0);" onclick="attachmentUrl(${var.attachmentName});">${var.attachmentName}</a></td>
						<td class='center' style="text-align:center;">
						<a href="javascript:void(0);" onclick="downAttach(${var.sysAttachmentId})">下载</a>
							<a href='javascript:void(0);' onclick="viewFile('${var.attachmentUrl}');">预览</a>
							<a href='javascript:void(0);' onclick="deleteFile('${var.sysAttachmentId}',this);">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
				</c:forEach>
	        </table>
			</c:when>
			<c:otherwise>
				<tr class="main_info">
					<td colspan="10" class="center">没有相关数据</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</c:if>
	<div id="zhongxin" align="center" >
				<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
				<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>

	</div>
     <div id="zhongxin2" class="center" style="display:none">
      <br />
      <br />
      <br />
      <br />
      <br />
      <img src="static/images/jiazai.gif" />
      <br />
      <h4 class="lighter block green">提交中...</h4>
    </div>
</form>
	</div>
	<!-- PAGE CONTENT ENDS HERE -->
</div><!--/row-->
	<script type="text/javascript">
	$(top.hangge());
    function viewFile(id){
        window.open("<%=httpUrl%>"+id);
    }
    function downAttach(id){
        window.location.href='<%=basePath%>yp/admin/message/downFile.do?itemId='+id;
    }

    function addLine(){
        var tr=$("<tr height=\"45px\">"
            +"<td><input type=\"file\" name=\"files\" id=\"files\" value=\"${pd.title}\" style=\"width: 330px\" onkeyup=\"validateUtils.replaceSpaceEmpty(this);\"/></td>"
            +"<td class='center' style=\"text-align:center;\">"
            +"<a href=\"javascript:void(0);\" onclick=\"query(${var.versionId})\"></a>&nbsp;&nbsp;&nbsp;&nbsp;"
            +"<a href=\"javascript:void(0);\" onclick=\"removeline(this)\">删除</a>&nbsp"
            +"</td>"
            +"</tr>");
        tr.appendTo("#myTable");
        $("input[name=files]").trigger("onclick");
    }

    function removeline(ojb){
        var tr = ojb.parentNode.parentNode;
        var tbody= tr.parentNode;
        tbody.removeChild(tr);
    }
    function deleteFile(id,ojb){
        var tr = ojb.parentNode.parentNode;
        var tbody= tr.parentNode;
        tbody.removeChild(tr);
        $.ajax({
            type: "POST",
            url: '<%=basePath%>yp/admin/message/operDeleFile.do',
            data: {itemId:id},
            dataType:'json',
            cache: false,
            success: function(data){
                alert(data);
                if(data>0){

				}
            }
        });
    }
    deleteFile
  </script>
</body>
</html>