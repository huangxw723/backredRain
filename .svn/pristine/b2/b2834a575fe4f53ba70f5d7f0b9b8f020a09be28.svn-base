//console.log('${sessionScope.treeData}');
function zTreeOnClick(event,treeId,treeNode){
	console.log(treeNode.level);
	if(!treeNode.checked){
		location.href="<%=basePath%>yp/admin/template/toEditUserTemplate.do?userTemplateId="+treeNode.userTemplateId
				+"&path="+treeNode.path+"&rootUserTemplateId="+treeNode.rootUserTemplateId
	}
			
}
 

	var userTemplateId = "${sessionScope.userTemplate.userTemplateId}";
	var rootUserTemplateId = "${sessionScope.rootUserTemplateId}";
	if(undefined==rootUserTemplateId || rootUserTemplateId==""||rootUserTemplateId==null){
		rootUserTemplateId = userTemplateId;
	}
	var userId = "${sessionScope.userTemplate.userId}";
	var data = '${sessionScope.userModules}';
	//console.log(data);
	if(data != undefined && data != "" && data !="[]"){
		var userModules = JSON.parse(data);
		$.each(userModules,function(index,value){
			var position = value.position;
			var icon = value.icon;
			var div = $("div[position="+position+"]");
			if(icon != undefined && icon !=""){
				$(div).css("background","url(<%=httpUrl%>"+icon+")");
				$(div).css("background-size","cover");
			}
			$(div).find("span[name=content]").text(value.content);
			$(div).attr("userModuleId",value.userModuleId);
			if(undefined != value.userModuleId && value.userModuleId !=null&&value.userModuleId!=""){
				if(value.template ==null){
					$(div).find("a[temp_select]").show();
				}else{
					$(div).find("a[temp_edit]").show();
					$(div).find("a[temp_edit]").data("str",JSON.stringify(value.template));
				}
				
				
			}
		})
	}
	
	
	function setText1(_this){
		$("[position]").removeClass("on");
		$(_this).addClass("on");
	}
	
	function selectType(){
		var value = $("[name=type]:checked").data("val");
		if(undefined == value){
			alert("请选择服务类型");
			return ;
		}
		var selected = $(".on");
		if(selected.length == 0){
			alert("请选择模块");
			return ;
		}
		$(".on").find("span[name=content]").text(value);
	}
	function selectFile(_this,evt){
		if(evt){
			evt.stopPropagation();
		}
		$(_this).parents("div[position]").find("input[type=file]").click();
	}
	
	function showPic(_this){
		var files = _this.files;
		//console.log(files);
		var FR= new FileReader();
	    FR.onload = function(e) {
	     // console.log(e.target.result);
	     //压缩base64
	      var result = base64Shorter(e.target.result);
	      var _div = $(_this).parents("div[position]")[0];
	      $(_div).css("background","url("+result+")");
	      $(_div).css("background-size","cover");
	    };       
	    FR.readAsDataURL( files[0] );
		
		//$(_this).parents("div[position]").css
	}
	
	function selectTemplate(_this){
		var parentUserModuleId = $(_this).parents("div[position]").attr("userModuleId");
		var parentUserTemplateId = userTemplateId;
		if(undefined==parentUserModuleId||parentUserModuleId==""||parentUserModuleId==null){
			return ;
		}
		
		location.href='<%=basePath%>yp/admin/template/getTemplates.do?parentUserModuleId='+parentUserModuleId+
				"&parentUserTemplateId="+parentUserTemplateId
				+"&rootUserTemplateId="+rootUserTemplateId
	}
	
	function editTemplate(_this){
		var template = JSON.parse($(_this).data("str"));
		var userTemplateId = template.id;
		var rootUserTemplateId = template.rootUserTemplateId;
		var path = template.path;
		var userId = template.userId;
		location.href='<%=basePath%>yp/admin/template/toEditUserTemplate.do?userTemplateId='+userTemplateId+
				"&rootUserTemplateId="+rootUserTemplateId+"&path="+path+"&userId="+userId;
	}
	
	var submitFlag = false;
	$(document).ready(function(){
		zTreeObj = $.fn.zTree.init($("#tree"), setting, JSON.parse(nodeStr));
		
		$("#subBtn").on("click",function(){
			if(submitFlag){
				 alert("正在保存中，请勿重复提交!");
				 return ;
			}
			submitFlag = true;
			var modules = $("div[position]");
			var moduleStr = [];
			
			$.each(modules,function(index,value){
				moduleStr.push({
					userModuleId:$(value).attr("userModuleId"),
					userTemplateId:userTemplateId,
					userId:userId,
					content:$(value).find("span[name=content]").text(),
					position:$(value).attr("position")
				})
			})
			//console.log(JSON.stringify(moduleStr));
			$("#moduleStr").val(JSON.stringify(moduleStr));
			
			$("form")[0].submit();
		})
		
		$("#delBtn").on("click",function(){
			if(confirm("确认删除该模版吗?")){
				$.ajax({
					type: "POST",
					url: '<%=basePath%>yp/admin/template/delTemplate.do',
			    	data: {userTemplateId:userTemplateId},
					dataType:'json',
					//beforeSend: validateData,
					cache: false,
					success: function(data){
						if(data.msg){
							bootbox.alert(data.msg,function(result){
	                			
	                		});
						}else if(data.template){
							var template = data.template;
							bootbox.alert("删除成功",function(result){
								location.href="<%=basePath%>yp/admin/template/toEditUserTemplate.do?userTemplateId="+template.userTemplateId
								+"&path="+template.path+"&rootUserTemplateId="+template.rootUserTemplateId;
	                		});
						}else{
							bootbox.alert("删除成功",function(result){
								location.href="<%=basePath%>yp/admin/template/getUserTemplates.do";
							})
							
						}
					}
				});
			}
		})
	})