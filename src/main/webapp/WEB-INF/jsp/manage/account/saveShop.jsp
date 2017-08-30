
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
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=jGRH9RCPqXgfsrr2jyMLzhk1jKactdvj"></script>
<script type="text/javascript" src="static/js/common/commonutils.js"></script>

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

        <style type="text/css">
        #l-map{height:500px;width:90%;  margin-left: 20px;}
        #r-result{width:100%;}
        </style>

    <script type="text/javascript" >
        $(top.hangge());

        var isExist = false;

        $(function () {

            var type = "${shopOwner.type}";
            if(type ==2){
                //鼠标失焦后验证
                $("#vshopName").blur(function(){
                var name = $('#vshopName').val();
                var oldName = "${shopOwner.name}";
                var shopId = "${shopOwner.shopId }";
                if(!validateUtils.isEmpty(name)){
                    if(name != oldName) {
                        $.ajax({
                            type: "POST",
                            url: '<%=basePath%>account/isMerchantAccountExists.do',
                            data: {name: name,shopId:shopId},
                            dataType: 'json',
                            cache: false,
                            success: function (data) {
                                if (data) {
                                    isExist = true;
                                    $("#vshopName").tips({
                                        side: 3,
                                        msg: '该商户名称已存在!',
                                        bg: '#AE81FF',
                                        time: 2
                                    });
                                    $("#vshopName").focus();
                                    return false;
                                } else {
                                    isExist = false;
                                }
                            }
                        });
                    }
                }
            });
            }

            $("#fileInput").change(function(){
                var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
                var value = $("#fileInput").val();
                var arr = value.substr(value.lastIndexOf(".")).toLowerCase();
                if($.inArray(arr, butarr)==-1){
                    if("${action}" == 1){
                        $("#fileInput").tips({
                            side : 3,
                            msg : '请上传图片格式的文件',
                            bg : '#AE81FF',
                            time : 2
                        });
                    }
                    if("${action}" == 2){
                        $("#chImg").tips({
                            side : 3,
                            msg : '请上传图片格式的文件',
                            bg : '#AE81FF',
                            time : 2
                        });
                    }
                    return false;
                }
            });

            $("#fileInputBg3").change(function(){
                var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
                var value = $("#fileInputBg3").val();
                var arr = value.substr(value.lastIndexOf(".")).toLowerCase();
                if($.inArray(arr, butarr)==-1){
                    if("${action}" == 1){
                        $("#fileInputBg3").tips({
                            side : 3,
                            msg : '请上传图片格式的文件',
                            bg : '#AE81FF',
                            time : 2
                        });
                    }
                    if("${action}" == 2){
                        $("#chImgBg3").tips({
                            side : 3,
                            msg : '请上传图片格式的文件',
                            bg : '#AE81FF',
                            time : 2
                        });
                    }
                    return false;
                }
            });
            $("#fileInputBg4").change(function(){
                var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
                var value = $("#fileInputBg4").val();
                var arr = value.substr(value.lastIndexOf(".")).toLowerCase();
                if($.inArray(arr, butarr)==-1){
                    if("${action}" == 1){
                        $("#fileInputBg4").tips({
                            side : 3,
                            msg : '请上传图片格式的文件',
                            bg : '#AE81FF',
                            time : 2
                        });
                    }
                    if("${action}" == 2){
                        $("#chImgBg4").tips({
                            side : 3,
                            msg : '请上传图片格式的文件',
                            bg : '#AE81FF',
                            time : 2
                        });
                    }
                    return false;
                }
            });
            $("#fileInputBg5").change(function(){
                var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
                var value = $("#fileInputBg5").val();
                var arr = value.substr(value.lastIndexOf(".")).toLowerCase();
                if($.inArray(arr, butarr)==-1){
                    if("${action}" == 1){
                        $("#fileInputBg5").tips({
                            side : 3,
                            msg : '请上传图片格式的文件',
                            bg : '#AE81FF',
                            time : 2
                        });
                    }
                    if("${action}" == 2){
                        $("#chImgBg5").tips({
                            side : 3,
                            msg : '请上传图片格式的文件',
                            bg : '#AE81FF',
                            time : 2
                        });
                    }
                    return false;
                }
            });
            $("#fileInputEw").change(function(){
                var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
                var value = $("#fileInputEw").val();
                var arr = value.substr(value.lastIndexOf(".")).toLowerCase();
                if($.inArray(arr, butarr)==-1){
                    if("${action}" == 1){
                        $("#fileInputEw").tips({
                            side : 3,
                            msg : '请上传图片格式的文件',
                            bg : '#AE81FF',
                            time : 2
                        });
                    }
                    if("${action}" == 2){
                        $("#chImgEw").tips({
                            side : 3,
                            msg : '请上传图片格式的文件',
                            bg : '#AE81FF',
                            time : 2
                        });
                    }
                    return false;
                }
            });

        })

    </script>

</head>
<body>
  <form action="<%=basePath%>account/${msg }.do" name="shopForm" id="shopForm" method="post">
      <input type="hidden" name="otype" id="otype" value="${shopOwner.type}" />
      <input type="hidden" name="action" id="action" value="${pd.action }" />
      <input type="hidden" name="shopId" id=shopId value="${shopOwner.shopId }" />
      <input type="hidden" name="shopName" id="shopName"   />
      <input type="hidden" name="vbusinessDistrictId" id=vbusinessDistrictId value="" />
      <c:if test="${action == 4 or action == 2 }">
          <input type="hidden" name="shopType"  value="${shopOwner.type }" />
      </c:if>
      <c:if test="${'1' ==shopOwner.type }">
          <input type="hidden" name="tradeCategoryId" id="tradeCategoryId"  value="${shopOwner.tradeCategoryId }" />
      </c:if>
      <c:if test="${'2' ==shopOwner.type && shopOwner.auditStatus == 2  }">
          <input type="hidden" name="provinceId"   value="${shopOwner.provinceId }" />
          <input type="hidden" name="cityId"    value="${shopOwner.cityId }" />
          <input type="hidden" name="areaId"   value="${shopOwner.areaId }" />
          <input type="hidden" name="businessDistrictId"   value="${shopOwner.businessDistrictId }" />
          <input type="hidden" name="storeId"   value="${shopOwner.storeId }" />
      </c:if>
      <div id="zhongxin">
      <table id="table_report" class="table table-striped table-bordered table-hover">
       <tr>
          <th>商户类型:</th>
          <td>
             <select class="chzn-select" data-placeholder="商户类型" name="shopType" id="shopType" title="商户类型" <c:if test="${action == 4 or action == 2 }">disabled="disabled"</c:if>>
1                <option value="1" <c:if test="${'1' ==shopOwner.type }">selected="selected"</c:if>> 商场</option>
                <option value="2" <c:if test="${'2' ==shopOwner.type }">selected="selected"</c:if>> 店铺</option>
            </select>
          </td>
        </tr>
        <tr>
            <th>商户名称:</th>
            <td>
            <p id="p1" style="display:none">
                <input placeholder="2-15位，中文、英文 下划线" type="text" style="width:90%;" name="vshopName" id="vshopName" value="${shopOwner.name }" title="2-15位，中文、英文（区分大小写）" <c:if test="${action == 4}">disabled="disabled"</c:if> onkeyup="validateUtils.replaceSpaceEmpty(this);" />
            </p>
            <p id="p2" style="display:block">
            <select class="chzn-select" data-placeholder="商户名称" id="nameStoreId" title="商户名称" <c:if test="${action == 4 or action ==2}">disabled="disabled"</c:if>>
            <c:forEach items="${storList}" var="va">
                <option value="${va.name}_${va.storeId}" nameStoreId="${va.name}_${va.storeId}" <c:if test="${va.storeId ==shopOwner.storeId }">selected="selected"</c:if>> ${va.name }</option>
<%--                 <option value="${va.name}" <c:if test="${va.name ==shopOwner.name }">selected="selected"</c:if>> ${va.name }</option> --%>
            </c:forEach>
            </select>
            </p>
          </td>
        </tr>
          <c:if test="${'2' ==shopOwner.type }">
          <tr id="s_3" height="45px" style="display: none">
              <th>行业类型:</th>
              <td>
                  <select class="chzn-select" data-placeholder="行业类型" name="tradeCategoryId" id="tradeCategoryId"  <c:if test="${action == 4 }">disabled="disabled"</c:if>>
                      <c:forEach items="${baseTypes }" var="va">
                          <option value="${va.id}" <c:if test="${va.id ==shopOwner.tradeCategoryId }">selected="selected"</c:if>> ${va.name }</option>
                      </c:forEach>
                  </select>
              </td>
          </tr>
          </c:if>
          <c:if test="${'1' ==shopOwner.type }">
          <tr id="s_33" height="45px" style="display: none">
              <th>类型:</th>
              <td>
                  <select class="chzn-select" data-placeholder="类型"   <c:if test="${action == 4 or action ==2}">disabled="disabled"</c:if>>
                      <c:forEach items="${baseTypes }" var="va">
                          <option value="${va.id}" <c:if test="${va.id ==shopOwner.tradeCategoryId }">selected="selected"</c:if>> ${va.name }</option>
                      </c:forEach>
                  </select>
              </td>
          </tr>
          </c:if>
        <tr>
			<th>商户logo:</th>
			<td>
			<c:if test="${shopOwner == null || shopOwner.logoUrl== '' || shopOwner.logoUrl == null }">
                <a id="imgBox" href="javascript:void(0)">
                <img src="" width="150" id="imgHref" />
                </a>
                <input type="file" id="fileInput" name="fileInput" />

            </c:if>
            <c:if test="${shopOwner != null && shopOwner.logoUrl != '' && shopOwner.logoUrl != null }">
	        <a id="imgBox" href="<%=httpUrl%>${shopOwner.logoUrl}" title="商户logo"  name="_previewLink" >
	            <img src="<%=httpUrl%>${shopOwner.logoUrl}" alt="商户logo" width="150" id="imgHref" name="_preview"/>
	        </a>
		    <c:if test="${action != 4}">
		        <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImg()" id="chImg" />
                <span style="color: red; width: 50px;" id="msgDiv" >注： 尺寸规格750px * 750px</span>
		    </c:if>
	              <input type="file" id="fileInput" name="fileInput" style="display:none;" name="_previewButton"/>
	        </c:if>
                <c:if test="${action == 1}">
                    <span style="color: red; width: 50px;" id="msgDiv" >注： 尺寸规格750px * 750px</span>
                </c:if>
                <input id="url" name="img0" type="hidden" />
            </td>
		</tr>
          <c:if test="${action ==2}">
              <tr>
                  <th >商户背景图:</th>
                  <td>
                      <c:if test="${picUrl3 == null || picUrl3== ''  }">
                          <a id="imgBoxBg3" href="javascript:void(0)">
                              <img src="" width="150" id="imgHrefBg3" />
                          </a>
                          <input type="file" id="fileInputBg3" name="fileInputBg3" />
                      </c:if>
                      <c:if test="${picUrl3 != null && picUrl3 != ''  }">
                          <a id="imgBoxBg3" href="<%=httpUrl%>${picUrl3}" title="商户背景图"  >
                              <img src="<%=httpUrl%>${picUrl3}" alt="商户背景图" width="150" id="imgHrefBg3" />
                          </a>
                          <c:if test="${action != 4}">
                              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImgBg3()" id="chImgBg3" />
                          </c:if>
                          <input type="file" id="fileInputBg3" name="fileInputBg3" style="display:none;" />
                      </c:if>
                            <input id="urlBg3" name="img3" type="hidden" />

                      <c:if test="${picUrl4 == null || picUrl4== ''}">
                          <a id="imgBoxBg4" href="javascript:void(0)">
                              <img src="" width="150" id="imgHrefBg4" />
                          </a>
                          <input type="file" id="fileInputBg4" name="fileInputBg4" />
                      </c:if>
                      <c:if test="${picUrl4 != null && picUrl4 != ''  }">
                          <a id="imgBoxBg4" href="<%=httpUrl%>${picUrl4}" title="商户背景图"  >
                              <img src="<%=httpUrl%>${picUrl4}" alt="商户背景图" width="150" id="imgHrefBg4" />
                          </a>
                          <c:if test="${action != 4}">
                              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImgBg4()" id="chImgBg4" />
                              <input type="button" class="btn btn-mini btn-danger" value="删除" onclick="deleteImgBg('${shopPicId4}')" id="delImgBg4" />
                          </c:if>
                          <input type="file" id="fileInputBg4" name="fileInputBg4" style="display:none;" />
                      </c:if>
                          <input id="urlBg4" name="img4" type="hidden" />

                      <c:if test="${picUrl5 == null || picUrl5== '' }">
                          <a id="imgBoxBg5" href="javascript:void(0)">
                              <img src="" width="150" id="imgHrefBg5" />
                          </a>
                          <input type="file" id="fileInputBg5" name="fileInputBg5" />
                      </c:if>
                      <c:if test="${picUrl5 != null && picUrl5 != '' }">
                          <a id="imgBoxBg5" href="<%=httpUrl%>${picUrl5}" title="商户背景图"  >
                              <img src="<%=httpUrl%>${picUrl5}" alt="商户背景图" width="150" id="imgHrefBg5" />
                          </a>
                          <c:if test="${action != 4}">
                              <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImgBg5()" id="chImgBg5" />
                              <input type="button" class="btn btn-mini btn-danger" value="删除" onclick="deleteImgBg('${shopPicId5}')" id="delImgBg5" />
                          </c:if>
                          <input type="file" id="fileInputBg5" name="fileInputBg5" style="display:none;" />
                      </c:if>
                          <input id="urlBg5" name="img5" type="hidden" />
                          <span style="color: red; width: 50px;" id="msgDiv" >注：尺寸规格750px * 476px</span>
                  </td>
              </tr>
          </c:if>
		<tr>
			<th  >商户二维码:</th>
			<td>
			<c:if test="${shopOwner == null || shopOwner.qrCodeUrl== '' || shopOwner.qrCodeUrl == null }">
                <a id="imgBoxEw" href="javascript:void(0)">
                <img src="" width="150" id="imgHrefEw" />
                </a>
                <input type="file" id="fileInputEw" name="fileInputEw" />

            </c:if>
            <c:if test="${shopOwner != null && shopOwner.qrCodeUrl != '' && shopOwner.qrCodeUrl != null }">
	        <a id="imgBoxEw" href="<%=httpUrl%>${shopOwner.qrCodeUrl}" title="商户二维码" name="_previewLink" >
	            <img src="<%=httpUrl%>${shopOwner.qrCodeUrl}" alt="商户二维码" width="150" id="imgHrefEw" name="_preview"/>
	        </a>
		    <c:if test="${action != 4}">
		        <input type="button" class="btn btn-mini btn-danger" value="更改" onclick="changeImgEw()" id="chImgEw" />
                <span style="color: red; width: 50px;" id="msgDiv" >注：尺寸规格750px * 750px</span>
		    </c:if>
	              <input type="file" id="fileInputEw" name="fileInputEw" style="display:none;" name="_previewButton"/>
	        </c:if>
                <c:if test="${action == 1}">
                    <span style="color: red; width: 50px;" id="msgDiv" >注：尺寸规格750px * 750px</span>
                </c:if>
                <input id="urlEw" name="img2" type="hidden" />
            </td>
		</tr>

        <tr>
          <th>联系人:</th>
          <td>
              <input type="text" style="width:90%;" placeholder="联系人" name="contact" id="contact" value="${shopOwner.contact }" title="联系人" <c:if test="${action == 4}">disabled="disabled"</c:if> onkeyup="validateUtils.replaceSpaceEmpty(this);" />
          </td>
        </tr>
		<tr>
          <th>联系电话 :</th>
          <td>
              <input type="text" style="width:90%;" placeholder="联系电话" name="tel" id="tel" value="${shopOwner.tel }" title="联系电话" <c:if test="${action == 4}">disabled="disabled"</c:if> onkeyup="validateUtils.replaceSpaceEmpty(this);" />
          </td>
        </tr>
		<tr>
          <th>联系邮箱:</th>
          <td>
              <input type="text" style="width:90%;" placeholder="联系邮箱" name="contactMail" id="contactMail" value="${shopOwner.email }" title="邮箱地址" <c:if test="${action == 4}">disabled="disabled"</c:if> onkeyup="validateUtils.replaceSpaceEmpty(this);" />
          </td>
        </tr>
        <c:if test="${pd.action==1 }">
        <tr>
          <th>账户名称:</th>
          <td>
              <input type="text" style="width:90%;" name="account" id="account" value="${shopOwner.account }" title="账户名称" autocomplete="off"/>
          </td>
        </tr>
        <tr>
          <th>密码:</th>
          <td>
		      <input name="password" id="password" type="text" value="${shopOwner.password }" placeholder="输入密码" autocomplete="off">
		  </td>
        </tr>
       </c:if>
       <tr id="s_4" style="display: none">
          <th>商户地址:</th>
          <td>
            <select class="chzn-select" name="provinceId" id="provinceId" data-placeholder="请选择省份" style="vertical-align:top;width:150px;" <c:if test="${action==4 or shopOwner.auditStatus == 2 }">disabled="disabled"</c:if>>
                <option value=""></option>
                <c:forEach items="${provinceList}" var="var">
                <option value="${var.provinceId }" <c:if test="${var.provinceId == shopOwner.provinceId }">selected</c:if>>${var.provinceName }</option>
              </c:forEach>
            </select>
            <select class="chzn-select" name="cityId" id="cityId" data-placeholder="请选择城市" style="vertical-align:top;" <c:if test="${action==4 or shopOwner.auditStatus == 2  }">disabled="disabled"</c:if>>
                <c:if test="${action==2||action==4}">
			        <option value=""></option>
					    <c:forEach items="${cityList}" var="vc">
						    <option value="${vc.cityId}" <c:if test="${vc.cityId == shopOwner.cityId }">selected</c:if>>${vc.cityName }</option>
						</c:forEach>
				</c:if>
            </select>
            <select class="chzn-select" name="areaId" id="areaId" data-placeholder="请选择区域" style="vertical-align:top; width: 204px;" <c:if test="${action==4 or shopOwner.auditStatus == 2  }">disabled="disabled"</c:if>>
		    <c:if test="${action==2||action==4}">
			    <option value=""></option>
				    <c:forEach items="${areaList}" var="var">
					    <option value="${var.areaId }"
					<c:if test="${var.areaId == shopOwner.areaId }">selected</c:if>>${var.areaName }</option>
					</c:forEach>
				    </c:if>
            </select>
            <select class="chzn-select" name="businessDistrictId" id="businessDistrictId" data-placeholder="请选择选商圈" style="vertical-align:top;" <c:if test="${action==4 or shopOwner.auditStatus == 2  }">disabled="disabled"</c:if>>
				  <c:if test="${action==2||action==4}">
						<option value=""></option>
						    <c:forEach items="${businessDistrictList}" var="vr">
								<option value="${vr.businessDistrictId }"
						<c:if test="${vr.businessDistrictId == shopOwner.businessDistrictId }">selected</c:if>>${vr.name }</option>
							</c:forEach>
                  </c:if>
            </select>
          </td>
        </tr>
        <tr id="s_1" style="display: none">
        <th>商场:</th>
         <td>
          <select  class="chzn-select"  data-placeholder="商场" name="storeId"  id="storeId"  style="width: 675px;" <c:if test="${action == 4 or shopOwner.auditStatus == 2 }">disabled="disabled"</c:if>>
          </select>
          </td>
        </tr>
         <tr id="s_2" height="45px" style="display: none">
		    <th>所在楼层:</th>
	        <td>
		    <select class="chzn-select" data-placeholder="选择楼层" name="floor" id="floor" <c:if test="${action == 4}">disabled="disabled"</c:if>>
			    <c:forEach items="${floorList }" var="var">
				    <option value="${var }" <c:if test="${var == shopOwner.floor}">selected="selected"</c:if>>${var}</option>
				</c:forEach>
			</select>
			楼
			&nbsp;
			</td>
		</tr>
          <tr id="s_22" height="45px" style="display: none">
              <th>店铺编号:</th>
              <td>
                  <input name="region" id="region" type="text" value="${shopOwner.region }" placeholder="区域 " <c:if test="${action == 4}">disabled="disabled"</c:if> onkeyup="validateUtils.replaceSpaceEmpty(this);">
              </td>
          </tr>

<!--    使用百度地图 start-->
       <tr id="s_5" height="45px" >
          <th>地址:</th>
          <td>
            <div id="l-map"></div>
            <input <c:if test="${action == 4 or '1' ==shopOwner.type}">disabled="disabled"</c:if> type="text" style="width:90%;" name="address" id="address" value="${shopOwner.address }" placeholder="这里输入地址" title="地址" />
            <input type="hidden" name="lng" id="lng" value="${shopOwner.lng}" />
            <input type="hidden" name="lat" id="lat" value="${shopOwner.lat}" />
            <div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
          </td>
        </tr>
        <!--    使用百度地图  end-->
        <c:if test="${action != 4}">
         <tr id="operaArea">
          <td class="center" colspan="2">
            <a class="btn btn-mini btn-primary" onclick="save();">保存</a>
           <%-- <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>--%>
          </td>
        </tr>
        </c:if>
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
<input type="radio" value="苹果 " />
  </form>
  <!-- 引入 -->
  <!-- base64 -->
  <script src="static/js/base64.js"></script>
  <script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
	<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
	<!-- 压缩图片 -->
	<link rel="stylesheet" type="text/css" href="plugins/fancyBox/jquery.fancybox.css">
	<script type="text/javascript" src="plugins/fancyBox/jquery.fancybox.pack.js"></script>
	<!-- 查看图片 -->
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
    <!-- 单选框 -->
  <script type="text/javascript">
    $(top.hangge());
    $("#imgBox").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
    $("#imgBoxBg3").fancybox({
		helpers : {
			title : {
				type : 'inside'
			}
		}
	});
    $("#imgBoxBg4").fancybox({
        helpers : {
            title : {
                type : 'inside'
            }
        }
    });
    $("#imgBoxBg5").fancybox({
        helpers : {
            title : {
                type : 'inside'
            }
        }
    });

    $("#imgBoxEw").fancybox({
		helpers : {
		title : {
			type : 'inside'
		}
	   }
	});
	//商户log上传
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

	new img2base64("fileInput", "url", "imgHref", "imgBox");
	//更改图片
    function changeImg(){
        $("#fileInput").trigger("click");
    }
        //商户背景图3
        $('#fileInputBg3:visible').ace_file_input({
            no_file : '请选择图片 ...',
            btn_choose : '选择',
            btn_change : '更改',
            droppable : false,
            onchange : null,
            thumbnail : false,
            before_remove : function() {
                $("#urlBg3").val("");
                $("#imgBoxBg3").attr("href", "").hide();
                $("#imgHrefBg3").attr("src", "");
                return true;
            }
        });

        new img2base64("fileInputBg3", "urlBg3", "imgHrefBg3", "imgBoxBg3");
        //更改图片
        function changeImgBg3(){
            $("#fileInputBg3").trigger("click");
        }
    //商户背景图4
    $('#fileInputBg4:visible').ace_file_input({
        no_file : '请选择图片 ...',
        btn_choose : '选择',
        btn_change : '更改',
        droppable : false,
        onchange : null,
        thumbnail : false,
        before_remove : function() {
            $("#urlBg4").val("");
            $("#imgBoxBg4").attr("href", "").hide();
            $("#imgHrefBg4").attr("src", "");
            return true;
        }
    });

    new img2base64("fileInputBg4", "urlBg4", "imgHrefBg4", "imgBoxBg4");
    //更改图片
    function changeImgBg4(){
        $("#fileInputBg4").trigger("click");
    }
    //删除背景图
    function deleteImgBg(id){
        bootbox.confirm("确定要删除该图片吗?", function (result) {
            if (result) {
                $.ajax({
                    type: "POST",
                    url: "<%=basePath%>account/deleteShopPicImg.do",
                    data: {shopPicId:id},
                    dataType: 'json',
                    success: function () {
                        save();
                    },
                    error:function () {
                        alert("系统繁忙！");
                    }
                });
            }
        });
    }

    //商户背景图5
    $('#fileInputBg5:visible').ace_file_input({
        no_file : '请选择图片 ...',
        btn_choose : '选择',
        btn_change : '更改',
        droppable : false,
        onchange : null,
        thumbnail : false,
        before_remove : function() {
            $("#urlBg5").val("");
            $("#imgBoxBg5").attr("href", "").hide();
            $("#imgHrefBg5").attr("src", "");
            return true;
        }
    });

    new img2base64("fileInputBg5", "urlBg5", "imgHrefBg5", "imgBoxBg5");
    //更改图片
    function changeImgBg5(){
        $("#fileInputBg5").trigger("click");
    }


	//商户二维码
	$('#fileInputEw:visible').ace_file_input({
		no_file : '请选择图片 ...',
		btn_choose : '选择',
		btn_change : '更改',
		droppable : false,
		onchange : null,
		thumbnail : false,
		before_remove : function() {
		    $("#urlEw").val("");
		    $("#imgBoxEw").attr("href", "").hide();
		    $("#imgHrefEw").attr("src", "");
		return true;
		}
	});

	new img2base64("fileInputEw", "urlEw", "imgHrefEw", "imgBoxEw");
	//更改图片
    function changeImgEw(){
        $("#fileInputEw").trigger("click");
    }
	//保存
	function save(){

        if(isExist){
            $("#vshopName").tips({
                side:3,
                msg:'该名称已经存在',
                bg:'#AE81FF',
                time:2
            });
            $("#vshopName").focus();
            return false;
        }
        var action_v=$("#action").val();
        var otype= $("#otype").val();
        var nameStoreId =  $("#nameStoreId").find("option:selected").attr("nameStoreId");
        $("#shopName").val(nameStoreId);

	if(otype==2){
		//var nameReg = /^[\d\w\u4e00-\u9fa5,\.;\:"'?!\-]{2,15}$/;
        var nameReg =  new RegExp("^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9_]){2,15}$");
		if(!nameReg.test($("#vshopName").val())){
            $("#vshopName").tips({
                side:3,
                msg:'商户名称不合规范',
                bg:'#AE81FF',
                time:2
            });
			$("#vshopName").focus();
			return false;
		}
		/*if($("#vshopName").val()=="" || $("#vshopName").val()=="此商户名称已存在!"){
            $("#shopMsg").show();
			$("#vshopName").focus();
			$("#vshopName").val('');
			$("#vshopName").css("background-color","white");
		   return false;
		}*/

	if($("#tradeCategoryId").val()==""||$.trim($("#tradeCategoryId").val())==""){
		$("#tradeCategoryId").tips({
			side:3,
            msg:'选择类型',
            bg:'#AE81FF',
            time:2
        });
		$("#tradeCategoryId").focus();
		$("#tradeCategoryId").val('');
		$("#tradeCategoryId").css("background-color","white");
		return false;
	}else{
		$("#tradeCategoryId").val(jQuery.trim($('#tradeCategoryId').val()));
	}
	}

        var fileData = $('#fileInput').val();
        if(fileData != '' ){
            var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
            var arr = fileData.substr(fileData.lastIndexOf(".")).toLowerCase();
            if($.inArray(arr, butarr)==-1){
                if("${action}" == 2){
                    $("#chImg").tips({
                        side : 3,
                        msg : '请上传图片格式的文件',
                        bg : '#AE81FF',
                        time : 3
                    });
                }
                return false;
            }
        }
        var fileData = $('#fileInputBg3').val();
        if(fileData != '' ){
            var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
            var arr = fileData.substr(fileData.lastIndexOf(".")).toLowerCase();
            if($.inArray(arr, butarr)==-1){
                if("${action}" == 2){
                    $("#chImgBg3").tips({
                        side : 3,
                        msg : '请上传图片格式的文件',
                        bg : '#AE81FF',
                        time : 3
                    });
                }
                return false;
            }
        }
        var fileData = $('#fileInputBg4').val();
        if(fileData != '' ){
            var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
            var arr = fileData.substr(fileData.lastIndexOf(".")).toLowerCase();
            if($.inArray(arr, butarr)==-1){
                if("${action}" == 2){
                    $("#chImgBg4").tips({
                        side : 3,
                        msg : '请上传图片格式的文件',
                        bg : '#AE81FF',
                        time : 3
                    });
                }
                return false;
            }
        }
        var fileData = $('#fileInputBg5').val();
        if(fileData != '' ){
            var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
            var arr = fileData.substr(fileData.lastIndexOf(".")).toLowerCase();
            if($.inArray(arr, butarr)==-1){
                if("${action}" == 2){
                    $("#chImgBg5").tips({
                        side : 3,
                        msg : '请上传图片格式的文件',
                        bg : '#AE81FF',
                        time : 3
                    });
                }
                return false;
            }
        }
        var fileData = $('#fileInputEw').val();
        if(fileData != '' ){
            var butarr = [".bmp",".png",".gif",".jpeg",".jpg"];//数组存放 图片类型
            var arr = fileData.substr(fileData.lastIndexOf(".")).toLowerCase();
            if($.inArray(arr, butarr)==-1){
                if("${action}" == 2){
                    $("#chImgEw").tips({
                        side : 3,
                        msg : '请上传图片格式的文件',
                        bg : '#AE81FF',
                        time : 3
                    });
                }
                return false;
            }
        }


	 if($("#contact").val()==""){
			$("#contact").tips({
				side:3,
	            msg:'输入联系人名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#contact").focus();
			$("#contact").val('');
			$("#contact").css("background-color","white");
			return false;
		}else{
			$("#contact").val(jQuery.trim($('#contact').val()));
		}
        var tel = $("#tel").val();
        if(tel==""){
            $("#tel").tips({
                side:3,
                msg:'输入联系电话',
                bg:'#AE81FF',
                time:3
            });
            $("#tel").focus();
            return false;
        }
        // 验证手机
        var regPhone = tel.substr(0, 1);
        if ( regPhone == 1 ) {
            if ( !(/^1[34578]\d{9}$/.test( tel )) ) {
                $("#tel").tips({
                    side:3,
                    msg:'请输入正确的手机号码',
                    bg:'#AE81FF',
                    time:3
                });
                $("#tel").focus();
                return false;
            }
        } else {
            if ( !(/^0\d{2,3}-?\d{7,8}$/.test(tel)) ) {
                $("#tel").tips({
                    side:3,
                    msg:'联系电话格式不正确',
                    bg:'#AE81FF',
                    time:3
                });
                $("#tel").focus();
                return false;
            }
        }

			if($("#contactMail").val()==""){

				$("#contactMail").tips({
					side:3,
		            msg:'输入邮箱',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#contactMail").focus();
				return false;
			}else if(!ismail($("#contactMail").val())){
				$("#contactMail").tips({
					side:3,
		            msg:'邮箱格式不正确',
		            bg:'#AE81FF',
		            time:3
		        });
				$("#contactMail").focus();
				return false;
			}

        if(action_v==1){
            if($("#account").val()=="" || $.trim($("#account").val())==""){
                    $("#account").tips({
                        side:3,
                        msg:'输入账户',
                        bg:'#AE81FF',
                        time:3
                    });
                    $("#account").focus();
                    return false;
                }
            if($("#password").val()=="" || $.trim($("#password").val())==""){

                    $("#password").tips({
                        side:3,
                        msg:'输入密码',
                        bg:'#AE81FF',
                        time:3
                    });
                    $("#password").focus();
                    return false;
                }
		   }
        if(otype==2){
            if($("#action").val()==1||$("#action").val()==2){
                if($("#provinceId").val()==""||$.trim($("#provinceId").val())==""){
                    $("#provinceId").tips({
                        side:3,
                        msg:'选择省份',
                        bg:'#AE81FF',
                        time:2
                    });
                    $("#provinceId").focus();
                    $("#provinceId").val('');
                    $("#provinceId").css("background-color","white");
                    return false;
                    }else{
                        $("#provinceId").val(jQuery.trim($('#provinceId').val()));
                    }

                if($("#cityId").val()==""||$.trim($("#cityId").val())==""){

                    $("#cityId").tips({
                        side:3,
                        msg:'选择城市',
                        bg:'#AE81FF',
                        time:2
                    });
                    $("#cityId").focus();
                    $("#cityId").val('');
                    $("#cityId").css("background-color","white");
                    return false;
                }else{
                    $("#cityId").val(jQuery.trim($('#cityId').val()));
                }
                if($("#areaId").val()==""||$.trim($("#areaId").val())=="" ){
                    $("#areaId").tips({
                        side:3,
                        msg:'选择区域',
                        bg:'#AE81FF',
                        time:2
                    });
                    $("#areaId").focus();
                    $("#areaId").val('');
                    $("#areaId").css("background-color","white");
                    return false;
                }else{
                    $("#areaId").val(jQuery.trim($('#areaId').val()));
                }
            }
        }
	if(($("#action").val()==1||$("#action").val()==2)&&otype==2){
		if($("#provinceId").val()!=""&& $("#cityId").val()!="" && $("#areaId").val()!=""){
		if(($("#businessDistrictId").val()==""||$.trim($("#businessDistrictId").val())=="") && $("#vbusinessDistrictId").val()<=0){
				$("#businessDistrictId").tips({
					side:3,
		            msg:'该区域没有可供选择商圈',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#businessDistrictId").focus();
				$("#businessDistrictId").val('');
				$("#businessDistrictId").css("background-color","white");
				return false;
			}else{
				$("#businessDistrictId").val(jQuery.trim($('#businessDistrictId').val()));
			}
		}
		if(($("#provinceId").val()!=""&& $("#cityId").val()!="" && $("#areaId").val()!="")&& $("#vbusinessDistrictId").val()>0){
			if($("#businessDistrictId").val()==""||$.trim($("#businessDistrictId").val())=="" ){
					$("#businessDistrictId").tips({
						side:3,
			            msg:'请选择商圈',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#businessDistrictId").focus();
					$("#businessDistrictId").val('');
					$("#businessDistrictId").css("background-color","white");
					return false;
				}else{
					$("#businessDistrictId").val(jQuery.trim($('#businessDistrictId').val()));
				}
			}
		if($("#address").val()==""||$.trim($("#address").val())==""  ){
			$("#address").tips({
				side:3,
	            msg:'详细地址不能为空！',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#address").focus();
			$("#address").val('');
			$("#address").css("background-color","white");
			return false;
		}else{
			$("#address").val(jQuery.trim($('#address').val()));
		}
		}
		//form.submit($('#shopForm'));
        $("#shopForm").submit()
        alert("操作完成");
	}

	function ismail(mail){
		return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
		}

	//判断邮箱是否存在 不用
	function hasE(USERNAME){
		var EMAIL = $.trim($("#email").val());
		$.ajax({
			type: "POST",
			url: '<%=basePath%>user/hasE.do',
	    	data: {EMAIL:EMAIL,USERNAME:USERNAME,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 if("success" != data.result){
					 $("#email").tips({
							side:3,
				            msg:'邮箱已存在',
				            bg:'#AE81FF',
				            time:3
				        });
					setTimeout("$('#email').val('')",2000);
				 }
			}
		});
	}

	$(function(){

		if($("#provinceId").val()) {
			var provinceId = $("#provinceId").val();
		    var citySelect = $("#cityId");
		    citySelect.empty().append("<option value=''></option>");
		    var cityList = '${cityList}';
		    var cityId = '${shopOwner.cityId}';
		    $.each(JSON.parse(cityList), function(i, list){
		    	var parentId = list.provinceId;
				if(parentId == provinceId) {
					var value = list.cityId;
					var option = list.cityName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					if(cityId == list.cityId) {
						label.attr("selected", "selected");
					}
					citySelect.append(label);
				}
		 	});
		}
      if($("#cityId").val()) {
			var cityId = $("#cityId").val();
		    var areaSelect = $("#areaId");
		    areaSelect.empty().append("<option value=''></option>");
		    var areaList = '${areaList}';
		    var shopAreaId = '${shopOwner.areaId}';
		    $.each(JSON.parse(areaList), function(i, list){
		    	var parentId = list.cityId;
			if(parentId == cityId) {
				var value = list.areaId;
				var option = list.areaName;
				var label = $("<option value='"+value+"'>"+option+"</option>");
				if(shopAreaId == list.areaId) {
					label.attr("selected", "selected");
				}
				areaSelect.append(label);
			}
		 	});
		}

     //区县--商圈初始化
      if($("#areaId").val()) {
			var areaId = $("#areaId").val();
		    var businessDistrictSelect = $("#businessDistrictId");
		    businessDistrictSelect.empty().append("<option value=''></option>");
		    var businessDistrictList = '${businessDistrictList}';
		    var businessDistrictId = '${shopOwner.businessDistrictId}';
			var countNum=0;
		    $.each(JSON.parse(businessDistrictList), function(i, list){
		    	var parentId = list.areaId;
			if(parentId == areaId) {
				var value = list.businessDistrictId;
				var option = list.name;
				var label = $("<option value='"+value+"'>"+option+"</option>");

				if(businessDistrictId == list.businessDistrictId) {
					label.attr("selected", "selected");
				}
				businessDistrictSelect.append(label);
				countNum++;
			}
		 	});
			$("#vbusinessDistrictId").val(countNum);
		}
            //商场---商圈初始化事件
            if($("#businessDistrictId").val()) {
                var businessDistrictId = $("#businessDistrictId").val();
                var storSelect = $("#storeId");
                storSelect.empty().append("<option value='0'>无</option>");
                var storList = '${storList}';
                var storeId = '${shopOwner.storeId}';
                    $.each(JSON.parse(storList), function(i, list){
                        var parentId = list.businessDistrictId;
                        if(parentId == businessDistrictId) {
                            var value = list.storeId;
                            var option = list.name;
                            var label = $("<option value='"+value+"'>"+option+"</option>");
                            if(storeId == list.storeId) {
                                label.attr("selected", "selected");
                            }
                            storSelect.append(label);
                        }
                    });
            }

		//单选框
		$(".chzn-select").chosen();
		$(".chzn-select-deselect").chosen({allow_single_deselect:true});

		//联动省份select事件
		$("#provinceId").change(function(){
		    var provinceId = $("#provinceId").val();
		    var citySelect = $("#cityId");
		    citySelect.empty().append("<option value=''></option>");
		    var cityList = '${cityList}';
		    $.each(JSON.parse(cityList), function(i, list){
		    	var parentId = list.provinceId;
				if(parentId == provinceId) {
					var value = list.cityId;
					var option = list.cityName;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					citySelect.append(label);
				}
		 	});
		    citySelect.trigger("liszt:updated");
		    initDataOpera(1);
		});
		//联动城市select事件
		$("#cityId").change(function(){
		    var cityId = $("#cityId").val();
		    var areaSelect = $("#areaId");
		    areaSelect.empty().append("<option value=''></option>");
		    var areaList = '${areaList}';
		    $.each(JSON.parse(areaList), function(i, list){
		    	var parentId = list.cityId;
			if(parentId == cityId) {
				var value = list.areaId;
				var option = list.areaName;
				var label = $("<option value='"+value+"'>"+option+"</option>");
				areaSelect.append(label);
			}
			});
		    areaSelect.trigger("liszt:updated");
		    initDataOpera(2)
		});
		//联动县、区select事件

		$("#areaId").change(function(){
		    var areaId = $("#areaId").val();
		    var businessDistrictSelect = $("#businessDistrictId");
		    businessDistrictSelect.empty().append("<option value=''></option>");
		    var businessDistrictList = '${businessDistrictList}';
			var countNum=0;
		    $.each(JSON.parse(businessDistrictList), function(i, list){
		    	var parentId = list.areaId;
				if(parentId == areaId) {
					var value = list.businessDistrictId;
					var option = list.name;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					businessDistrictSelect.append(label);
					countNum++;
						}
					});
		    businessDistrictSelect.trigger("liszt:updated");
		    initDataOpera(3)
			$("#vbusinessDistrictId").val(countNum);
		});
    function initDataOpera (otype){
	switch (otype)
		{
		case 1:
			var areaSelect = $("#areaId");
			areaSelect.empty().append("<option value=''></option>");
		    areaSelect.trigger("liszt:updated");
		    var businessDistrictSelect = $("#businessDistrictId");
		    businessDistrictSelect.empty().append("<option value=''></option>");
		    businessDistrictSelect.trigger("liszt:updated");
		    var storeIdSelect = $("#storeId");
		    storeIdSelect.empty().append("<option value='0'></option>");
		    storeIdSelect.trigger("liszt:updated");
		  break;
		case 2:
			var businessDistrictSelect = $("#businessDistrictId");
		    businessDistrictSelect.empty().append("<option value=''></option>");
		    businessDistrictSelect.trigger("liszt:updated");
		    var storeIdSelect = $("#storeId");
		    storeIdSelect.empty().append("<option value='0'></option>");
		    storeIdSelect.trigger("liszt:updated");
		  break;
		case 3:
			var storeIdSelect = $("#storeId");
		    storeIdSelect.empty().append("<option value='0'></option>");
		    storeIdSelect.trigger("liszt:updated");
		  break;
		}
     }
		//联动select事件
		$("#businessDistrictId").change(function(){
		    var businessDistrictId = $("#businessDistrictId").val();
		    var storSelect = $("#storeId");
		    storSelect.empty().append("<option value='0'>无</option>");
		    var storList = '${storList}';
		    $.each(JSON.parse(storList), function(i, list){
		    	var parentId = list.businessDistrictId;
		    	 
				if(parentId == businessDistrictId) {
					var value = list.storeId;
					var option = list.name;
					var label = $("<option value='"+value+"'>"+option+"</option>");
					storSelect.append(label);
						}
					});
		    storSelect.trigger("liszt:updated");
		});
		
	});
	
	// 百度地图API功能
	function G(id) {
		return document.getElementById(id);
	}
	var map = new BMap.Map("l-map");
	map.centerAndZoom("广州",12); // 初始化地图,设置城市和地图级别。
   // map.enableScrollWheelZoom();//启动鼠标滚轮缩放地图


	var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
		{"input" : "address"
		,"location" : map
	});

	ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
		var str = "";
		var _value = e.fromitem.value;
		var value = "";
		if (e.fromitem.index > -1) {
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
		
		value = "";
		if (e.toitem.index > -1) {
			_value = e.toitem.value;
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
		G("searchResultPanel").innerHTML = str;
	});

	var myValue;
	ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
	var _value = e.item.value;
		myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
		setPlace();
	});

	function setPlace(){
		map.clearOverlays();    //清除地图上所有覆盖物
		function myFun(){
			var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
			map.centerAndZoom(pp, 18);
			map.addOverlay(new BMap.Marker(pp));    //添加标注
		}
		var local = new BMap.LocalSearch(map, { //智能搜索
		  onSearchComplete: myFun
		});
		var myGeo = new BMap.Geocoder();
		// 将地址解析结果显示在地图上，并调整地图视野    
		myGeo.getPoint(myValue, function(point){
        	if (point) {
        		$("#lng").val(point.lng);
        		$("#lat").val(point.lat);
        		local.search(myValue);
          	}
      	});
	}
	
	if($("#address").val() && $("#lng").val() && $("#lat").val()) {
		myValue = $("#address").val();
		ac.setInputValue($("#address").val());
		setPlace();
	}
		
 	$(document).ready(function(){//初始化输入框
 		var otype = $("#otype").val();
		var action = $("#action").val();
		if(otype==1 && (action==1||action==2||action==4)){
			  $("#p1").hide();
			  $("#p2").show();
	    	  $("#s_1").hide();
	    	  $("#s_2").hide();
	    	  $("#s_22").hide();
	    	  $("#s_3").hide();
	    	  $("#s_33").show();
	    	  $("#s_4").hide();////
 	    	 // $("#s_5").hide();
		}
		if(otype==2 && (action==1||action==2||action==4)){
			  $("#p1").show();
	    	  $("#p2").hide();
	    	  $("#s_1").show();
	    	  $("#s_2").show();
	    	  $("#s_22").show();
	    	  $("#s_3").show();
	    	  $("#s_33").hide();
	    	  $("#s_4").show();////
	    	  //$("#s_5").show();
		}		
		$("#shopType").change(function(){
        var type = ($(this).val());
        $("#otype").val(type);
	    if(type==2){
	    	  $("#p1").show();
	    	  $("#p2").hide();
	    	  $("#s_1").show();
	    	  $("#s_2").show();
	    	  $("#s_22").show();
	    	  $("#s_3").show();
	    	  $("#s_33").hide();
	    	  $("#s_4").show();////
	    	 // $("#s_5").show();
	    	  $("#provinceId").attr("disabled",false);
	    	  $("#cityId").attr("disabled",false);
	    	  $("#areaId").attr("disabled",false);
	    	  $("#businessDistrictId").attr("disabled",false);
	    }
	    if(type==1){
	    	  $("#p1").hide();
	    	  $("#p2").show();
	    	  $("#s_1").hide();
	    	  $("#s_2").hide();
	    	  $("#s_22").hide();
	    	  $("#s_3").hide();
	    	  $("#s_33").show();
	    	  $("#s_4").hide();////
 	    	 // $("#s_5").hide();
	    }
		})
		}); 

  </script>
</body>
</html>