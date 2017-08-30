<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aoshi.util.PropertyUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
            
            if($("#beaconchoosed").val()==null || $("#beaconchoosed").val()==""){
				$("#choose2").tips({
					side:3,
					msg:'选择beacon',
					bg:'#AE81FF',
					time:2
				});
				$("#choose").focus();
				return false;
			}
			
			if($("#prizechoosed").val()==null || $("#prizechoosed").val()==""){
				$("#choose").tips({
					side:3,
					msg:'选择礼品',
					bg:'#AE81FF',
					time:2
				});
				$("#choose").focus();
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
            
			if(document.getElementById("page-content").style.display !='none'){
				$("#btn-success").tips({
					side:3,
					msg:'点击选择',
					bg:'#AE81FF',
					time:2
				});
				$("#btn-success").focus();
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
<form action="link/beaconGroup/addBeacon.do" name="usersForm" id="usersForm" method="post">
	<input type="hidden" id="close" value="0"/>
	<input type="hidden" id="shopchoosed" name="shopchoosed" value=""/>
	<input type="hidden" id="prizechoosed" name="prizechoosed" value=""/>
	<input type="hidden" id="beaconchoosed" name="beaconchoosed" value=""/>
    <input type="hidden" id="prizeIds" name="prizeIds" value="${prizeIds}"/>
    <input type="hidden" id="beaconIds" name="beaconIds" value="${beaconIds}"/>
	<div id="zhongxin" >
		<table id="table_report" class="table table-striped table-bordered table-hover" style="overflow:scroll;">
            <tr height="45px">
                <td width="100px">beacon组名:</td>
                <td>
                    <input type="text" style="width:370px;" name="beaconName" id="beaconName"  placeholder="这里输入beacon组名" title="beacon组名" />
                </td>
            </tr>
            <tr height="45px">
				<td style="width: 100px">选择beacon:</td>
				<td>
					<%--<select id="example-post" name="multiselect[]" multiple="multiple">--%>
						<%--<c:forEach items="${beaconList}" var="beacon">--%>
							<%--<option value="${beacon.beaconId}">${beacon.beaconUid}</option>--%>
						<%--</c:forEach>--%>
					<%--</select>--%>

                    <span id="choose2"><a href="javascript:void(0)" onclick="chooseBeacon();">未选择</a></span>
				</td>
			</tr>

			<tr height="45px">
				<td style="width: 100px">选择礼品:</td>
				<td>
					<span id="choose"><a href="javascript:void(0)" onclick="choosePrize();">未选择</a></span>
				</td>
			</tr>
            <tr height="45px">
                <td style="width: 100px">每人每天参与次数:</td>
                <td>
                    <input type="text" style="width:100px;" name="perCount" id="perCount"  placeholder="参与次数" title="每人每天参与次数" />
                </td>
            </tr>
		</table>
        <div id="page-content" class="clearfix" style="display: none">
        <div id="page-content2" class="clearfix" style="display: none">
                <div class="row-fluid">
                    <div id="zhongxin" >
                        <div class="row-fluid">
                            <table id="table_report" class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th class="center">
                                        <label>
                                            <input type="checkbox" id="zcheckbox" />
                                            <span class="lbl"></span>
                                        </label>
                                    </th>
                                      <th class="center">名称范围</th>
                                      <th class="center">mac地址</th>
                                      <th class="center">UUID</th>
                                      <th class="center">蓝牙名称</th>
                                      <th class="center">major</th>
                                      <th class="center">minor</th>
                                      <th class="center">终端名称</th>
                                      <th class="center">上屏编码</th>
                                      <th class="center">下屏编码</th>
                                      <th class="center">上下屏系统</th>
                                      <th class="center">上下屏型号</th>                 
                                      <th class="center">终端地址</th>
                                      <th class="center">屏幕类型</th>
                                </tr>
                                </thead>
                                <tbody>
                                <!-- 开始循环 -->
                                <c:choose>
                                    <c:when test="${not empty beaconList}">
                                        <c:forEach items="${beaconList}" var="var" varStatus="vs">
                                            <tr>
                                                <td class='center' style="width: 30px;">
                                                    <label>
                                                        <input type='checkbox' name='ids' value="${var.beaconId}" />
                                                        <span class="lbl"></span>
                                                    </label>
                                                </td>
                                                 <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.beaconName}">${var.beaconName}</td>
                                                 <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.beaconMac}">${var.beaconMac}</td>
                                                 <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.beaconUid}">${var.beaconUid}</td>
                                                 <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.beaconBlue}">${var.beaconBlue}</td>
                                                 <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.major}">${var.major}</td>
                                                 <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.minor}">${var.minor}</td>
                                                 <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.screenName}">${var.screenName}</td>
                                                 <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.upScreenCode}">${var.upScreenCode}</td>
                                                 <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.downScreenCode}">${var.downScreenCode}</td>
                                                 <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.screenSystem}">${var.screenSystem}</td>
                                                 <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.screenModel}">${var.screenModel}</td>
                                                 <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.screenAddress}">${var.screenAddress}</td>
                                                 <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.screenType}">${var.screenType}</td> 
                                            </tr>

                                        </c:forEach>
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
                                            <a class="btn btn-small btn-success" id="btn-success" onclick="makeAll('确定要选择选中的数据吗?');">选择</a>
                                        </td>
                                        <td style="vertical-align:top;">
                                            <div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!--/row-->
            </div>
            <div class="row-fluid">
                <div id="zhongxin" >
                    <div class="row-fluid">
                        <table id="table_report" class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th class="center">
                                    <label>
                                        <input type="checkbox" id="zcheckbox" />
                                        <span class="lbl"></span>
                                    </label>
                                </th>
                                <th class="center">礼品编号</th>
                                <th class="center">礼品名称</th>
                                <th class="center">礼品类型</th>
                                <th class="center">礼品数量(余/总)</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 开始循环 -->
                            <c:choose>
                                <c:when test="${not empty asPrizeConfigs}">
                                    <c:forEach items="${asPrizeConfigs}" var="var" varStatus="vs">
                                        <tr>
                                            <td class='center' style="width: 30px;">
                                                <label>
                                                    <input type='checkbox' name='ids' value="${var.prizeConfigId}" />
                                                    <span class="lbl"></span>
                                                </label>
                                            </td>
                                            <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.prizeConfigId}">${var.prizeConfigId}</td>
                                            <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.name}">${var.name}</td>
                                            <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.categoryName}">${var.categoryName}</td>
                                            <td class='center' style="max-width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;" title="${var.surplusCounts}/${var.counts}">${var.surplusCounts}/${var.counts}</td>
                                        </tr>

                                    </c:forEach>
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
                                        <a class="btn btn-small btn-success" id="btn-success" onclick="makeAll('确定要选择选中的数据吗?');">选择</a>
                                    </td>
                                    <td style="vertical-align:top;">
                                        <div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!--/row-->
        </div>
        <div class="center" colspan="2" style="text-align: center">
            <a class="btn btn-mini btn-primary" onclick="save();" style="margin-top: -1px">保存</a>
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
    function choosePrize(){
    	var prizeIds=0;
    	if($("#prizeIds").val()==""||$.trim($("#prizeIds").val())==""){
    		 prizeIds = 0;
    	}
    	
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="选择礼品";
        diag.URL = '<%=basePath%>link/beaconGroup/choosePrize.do?idse='+prizeIds;
        diag.Width = 1200;
        diag.Height = 700;
        diag.CancelEvent = function(){ //关闭事件
            diag.close();
        };
        top.Dialog.getCheckboxPrizeId = function(str) {
            $("#prizechoosed").val(str)  
            $("#choose a").empty().html("已选择")
        }
        diag.show();

    }

    //选择beacon
    function chooseBeacon(){
    	var beaconIds=0;
    	if($("#beaconIds").val()==""||$.trim($("#beaconIds").val())==""){
    		 beaconIds = 0;
    	}
    	
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="选择beacon";
        diag.URL = '<%=basePath%>link/beaconGroup/chooseBeacon.do?idse='+beaconIds;
        diag.Width = 1500;
        diag.Height = 700;
        diag.CancelEvent = function(){ //关闭事件
            diag.close();
        };
        top.Dialog.getCheckBoxBeaconId = function(str) {
            $("#beaconchoosed").val(str)  
            $("#choose2 a").empty().html("已选择")
        }
        diag.show();

    }

</script>
</body>
</html>