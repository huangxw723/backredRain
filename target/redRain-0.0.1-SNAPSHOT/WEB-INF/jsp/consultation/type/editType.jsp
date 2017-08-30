<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
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
<%@ include file="../../system/admin/top.jsp"%>
<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/demo.css" />
<link type="text/css" rel="stylesheet" href="plugins/zTree/3.5/zTreeStyle.css" />
<script type="text/javascript" src="plugins/zTree/3.5/jquery.ztree.core.min.js"></script>

<script type="text/javascript">
	/**
	 * 点击保存的时候
	 */
	function save() {
		
		if ($("#typeName").val() == "") {
			$("#typeName").tips({
				side : 3,
				msg : '输入咨询名称',
				bg : '#AE81FF',
				time : 2
			});
			$("#typeName").focus();
			return false;
		}
		var checkInt = /^[0-9]*[1-9][0-9]*$/;
		if ($("#sortOrder").val() == "") {
			$("#sortOrder").tips({
				side : 3,
				msg : '输入排序',
				bg : '#AE81FF',
				time : 2
			});
			$("#sortOrder").focus();
			return false;
		}
		if (!checkInt.test($("#sortOrder").val())) {
			$("#sortOrder").tips({
				side : 3,
				msg : '排序输入有误',
				bg : '#AE81FF',
				time : 2
			});
			$("#sortOrder").focus();
			return false;
		}
        form.submit($('#Form'));
//		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}

    form = {

      submit:function(formElement){


        var iUrl = formElement.attr('action');
        var data = new Object();
        $.each(formElement.serializeArray(),function(index,item){

          var key = item.name;
          var value = item.value;
          data[key] = value;
        });

        $.ajax({
          type: "POST",
          url: iUrl,
          data: data,
          dataType: "json",
          success: function(data){
            if(data.status == 0){

              formElement[0].reset()

              var element = document.getElementById('zhongxin');
              element.style.display = 'none';
              top.Dialog.close();

            }

          },
          error:function(data){
            alert('系统繁忙')
          }
        });
      }
    }
	/**
	 * base 64 加密
	 */
	function changeImg() {
		$("#fileInput").trigger("click");
	}
	/**
	 * 树的设置
	 */
	var setting = {
		data : {
			simpleData : {
				enable : true
			}
		},
		callback : {
			beforeClick : treeClick
		}
	};

	/**
	 * 点击树的时候.
	 */
	function treeClick(treeId, treeNode, clickFlag) {
		$("#parentId").val(treeNode.id);
		$("#parentName").val(treeNode.name);
		$("#typeLevel").val(treeNode.level + 1);
		var idPath = "";
		$.each(treeNode.getPath(), function(i, node) {
			idPath += "_" + node.id + ";";
		});
		$("#idPath").val(idPath);
	}
	$(document).ready(function() {
		$("p").click(function() {
			$(this).hide();
		});
		var zn = '${typeList}';
		if(zn != '') {
			$.fn.zTree.init($("#tree"), setting, JSON.parse(zn));
		}
	});
</script>

</head>
<body>
  <form action="consultation/type/updateType.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
    <input type="hidden" name="consultationTypeId" id="consultationTypeId" value="${asConsultationType.consultationTypeId }" />
    <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
        <tr>
          <th>分类名称:</th>
          <td>
            <input type="text" style="width:90%;" name="typeName" id="typeName" value="${asConsultationType.typeName}" placeholder="这里输入咨询名称" title="咨询名称" />
          </td>
        </tr>
          <tr>
            <th>选择父节点${asConsultationType.typeLevel}:</th>
            <td>
              <input type="hidden" name="idPath" id="idPath" value="${asConsultationType.idPath}"/>
              <input type="hidden" name="parentId" id="parentId" value="${asConsultationType.parentId}" />
              <input type="hidden" name="typeLevel" id="typeLevel" value="${asConsultationType.typeLevel}" />
              <input type="text" style="width:90%;" disabled name="parentName" id="parentName" value="${pAsConsultationType.typeName}"/>
              <a onclick="document.getElementById('parentId').value='';document.getElementById('parentName').value='';" style="color: red;"
                href="javascript:void(0)">
                <i class="icon-remove"></i>
              </a>
              <ul id="tree" class="ztree" style="width: auto ;height:auto; " />
            </td>
          </tr>
        <tr>
          <th>分类排序:</th>
          <td>
            <input name="sortOrder" id="sortOrder" type="number" value="${asConsultationType.sortOrder}" placeholder="请在这里输入咨询排序" title="咨询排序" />
          </td>
        </tr>
        <tr>
          <td class="center" colspan="2">
            <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
          </td>
        </tr>
      </table>
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
  <!-- 引入 -->
  <script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
  <script src="static/js/bootstrap.min.js"></script>
  <script src="static/js/ace-elements.min.js"></script>
  <script src="static/js/ace.min.js"></script>
  <script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
  <!-- 单选框 -->
  <script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script>
  <!-- base64 -->
  <script src="static/js/base64.js"></script>
  <script src="static/js/base64Compress.js"></script>
  <link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
  <script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
  <script type="text/javascript">
	$(top.hangge());
	function EL(id) { return document.getElementById(id); } // Get el by ID helper function
	function readFile1() {
		  if (this.files && this.files[0]) {
		    var FR= new FileReader();
		    FR.onload = function(e) {
		      //EL("img").src       = e.target.result;
		     // console.log(e.target.result);
		     //压缩base64
		      var result = base64Shorter(e.target.result);
		      $("#image1").prop("src",result);
		      
		    };       
		    FR.readAsDataURL( this.files[0] );
		  }
	}

	//EL("inp").addEventListener("change", readFile, false);
	EL("inp1").addEventListener("change", readFile1, false);
	function addImg(inp){
		$("#"+inp).click();
	};
	
	/* //上传
	$('#fileInput:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
			$("#url").val("");
			$("#imgBox").attr("href", "").hide();
			$("#imgHref").attr("src", "");
			return true;
		}
	});
	 */
	//new img2base64("fileInput", "url", "imgHref", "imgBox");

	$("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
	
  </script>
</body>
</html>