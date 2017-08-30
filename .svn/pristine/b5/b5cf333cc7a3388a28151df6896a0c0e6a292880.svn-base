<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="static/css/font-awesome.min.css" />
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/css/chosen.css" />
	<%--<link rel="stylesheet" href="static/css/ace.min.css" />--%>
	<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
	<link rel="stylesheet" href="static/css/ace-skins.min.css" />
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>

	<link href="static/css/bootstrap.min.css" rel="stylesheet" />
	<link href="static/css/bootstrap-example.css" rel="stylesheet" />
	<link href="static/css/prettify.css" rel="stylesheet" />
	<link href="static/css/bootstrap-multiselect.css" rel="stylesheet" />

	<script type="text/javascript" src="static/js/prettify.js"></script>
	<script type="text/javascript" src="static/js/bootstrap-3.3.2.min.js"></script>
	<script type="text/javascript" src="static/js/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="static/js/bootstrap-multiselect.js"></script>
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>

    <style>
        .glyphicon {
            position: relative;
            top: 1px;
            display: inline-block;
            font-family: 'Glyphicons Halflings';
            font-style: normal;
            font-weight: 400;
            line-height: 1;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        .glyphicon-remove-circle {
            background: url("../../../upload/close.png") no-repeat;
            -webkit-background-size: 10px 10px;
            background-size: 10px 10px;
            width: 10px;
            height: 10px;
        }
        .btn:first-child {
            margin-top: -9px;
        }
    </style>
	<script type="text/javascript">
		$(top.hangge());

		$(function() {
			$(".chzn-select").chosen();
			$(".chzn-select-deselect").chosen({allow_single_deselect:true});
		});


		//保存
		function save(){
			if($("#beaconName").val()==""||$.trim($("#beaconName").val())==""){
				$("#beaconName").tips({
					side:3,
					msg:'beacon组名',
					bg:'#AE81FF',
					time:2
				});
				$("#beaconName").focus();
				return false;
			}
			//校验和限制参与次数输入0~100
			var re =/^\d*$/;
			var nubmer = $("#perCount").val();			
			if (!re.test(nubmer))
			{
			  alert("请输入正确的数值,只允许输入整数!");			
			  return false;
			} if(nubmer > 100 || nubmer < 1){
		        alert('输入的数不能小于1且不能大于100');		       
		        return false;
		    }
			
                var selected = [];
                $('#example-post option:selected').each(function () {
                    selected.push($(this).val());
                });
                $("#shopchoosed").val(selected)

			// 提交表单
			form.submit($('#usersForm'));

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

						alert(data.msg)

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

	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			window.prettyPrint() && prettyPrint();
		});
	</script>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function() {
		$('#example-post').multiselect({
			includeSelectAllOption: true,
			enableFiltering: true
		});
	});
</script>
<form action="link/beaconGroup/update.do" name="usersForm" id="usersForm" method="post">
	<input type="hidden" id="close" value="0"/>
	<input type="hidden" id="shopchoosed" name="shopchoosed" value=""/>
	<input type="hidden" id="prizechoosed" name="prizechoosed" value="${prizechoosed}"/>	
	<input type="hidden" id="beaconDesc" name="beaconDesc" value="${beaconDesc}"/>
	<input type="hidden" id="beaconLinkId" name="beaconLinkId" value="${asBeaconLink.beaconLinkId}"/>
	<input type="hidden" id="beaconchoosed" name="beaconchoosed" value="${beaconchoosed}"/>
	<input type="hidden" id="prizeIds" name="prizeIds" value="${prizeIds}"/>
    <input type="hidden" id="beaconIds" name="beaconIds" value="${beaconIds}"/>
	<div id="zhongxin" >
		<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
			<tr height="45px">
				<td width="100px">beacon组名:</td>
				<td>
					<input type="text" style="width:370px;" name="beaconName" id="beaconName" value="${asBeaconLink.beaconName}" placeholder="这里输入beacon组名" title="beacon组名" />
				</td>
			</tr>
			<tr height="45px">
				<td style="width: 100px">选择beacon:</td>
			
				<td>
					<c:choose>
						<c:when test="${fn:length(beaconRelationList)<=0}">
							<span id="choose2"><a href="javascript:void(0)" onclick="chooseBeacon(0);">未选择</a></span>
						</c:when>
						<c:otherwise>
							<span id="choose2"><a href="javascript:void(0)" onclick="chooseBeacon(${asBeaconLink.beaconLinkId});">已选择</a></span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>

			<tr height="45px">
				<td style="width: 100px">选择礼品:</td>
				<td>
					<c:choose>
						<c:when test="${fn:length(mapperList)<=0}">
							<span id="choose"><a href="javascript:void(0)" onclick="choosePrize(0);">未选择</a></span>
						</c:when>
						<c:otherwise>
							<span id="choose"><a href="javascript:void(0)" onclick="choosePrize(${asBeaconLink.beaconLinkId});">已选择</a></span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr height="45px">
                <td style="width: 100px">每人每天参与次数:</td>
                <td>
                    <input type="text" style="width:100px;" name="perCount" id="perCount"  placeholder="这里输入每人每天参与次数" title="每人每天参与次数" value="${asBeaconLink.perCount}"/>
                </td>
            </tr>
		</table>
            <div class="center" colspan="2" style="text-align: center">
                <a class="btn btn-mini btn-primary" onclick="save();"style="margin-top: -1px">保存</a>
                <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
            </div>
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
<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->


<script type="text/javascript">
	$(top.hangge());

	$(document).ready(function(){
		$("#adUrlType").change(function(){
			if($(this).val()&&$(this).val()==1){
				$("#msgDiv").hide();
				$("#msgDivScreen").show();
			}else{
				$("#msgDiv").show();
				$("#msgDivScreen").hide();
			}
		});

	});

	$(function() {

        if($("#beaconDesc").val()!=""){
            $('#example-post option').each(function(i){
                if($(this).val()==$("#beaconDesc").val().split(",")[i]){
                    $(this).attr("selected","selected");
                }
                var beaconDesc=$("#beaconDesc").val()
                $(".multiselect-selected-text").html(beaconDesc);
            });
        }

		//单选框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});

		$("#zcheckbox").click(function(){
			$('input[name="ids"]').prop("checked",this.checked);
		});
		$('input[name="ids"]').click(function(){
			var flag=true;
			$('input[name="ids"]').each(function(){
				if(!this.checked){
					flag=false;
				}
			});
			$("#zcheckbox").prop("checked",flag);
		})

	});

	//选择礼品
	function choosePrize(id){
		var  prizeIds = 0;
    	if($("#prizeIds").val()==""||$.trim($("#prizeIds").val())==""){
    		 prizeIds = 0;
    	}
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="选择礼品";
		diag.URL = '<%=basePath%>link/beaconGroup/editPrize.do?action=2&id='+id+'&idse='+prizeIds;
		diag.Width = 1200;
		diag.Height = 700;
		diag.CancelEvent = function(){ //关闭事件
			diag.close();
		};
		top.Dialog.getCheckboxPrizeId = function(str) {
			$("#prizechoosed").val(str);
			console.info(str);
			$("#choose a").empty().html("已选择");
		};
		diag.show();

	}

	//选择beacon
	function chooseBeacon(id){
		var beaconIds = 0;
    	if($("#beaconIds").val()==""||$.trim($("#beaconIds").val())==""){
    		 beaconIds = 0;
    	}
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="选择beacon";
		diag.URL = '<%=basePath%>link/beaconGroup/editBeacon.do?action=2&id='+id+'&idse='+beaconIds;
		diag.Width = 1300;
		diag.Height = 700;
		diag.CancelEvent = function(){ //关闭事件
			diag.close();
		};
		top.Dialog.getCheckBoxBeaconId = function(str) {
			$("#beaconchoosed").val(str);	
			console.info(str);
			$("#choose2 a").empty().html("已选择");
		}
		diag.show();

	}
    
</script>
</body>
</html>