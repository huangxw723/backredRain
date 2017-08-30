$(function() {
	if (typeof ($.cookie('menusf')) == "undefined") {
		$("#sidebar").attr("class", "");
	} else {
		$("#menusf").attr("checked", true);
		$("#sidebar").attr("class", "menu-min");
	}
});

// 保存缩放菜单状态
function menusf() {
	if (document.getElementsByName('menusf')[0].checked) {
		$.cookie('menusf', 'ok');
		$("#sidebar").attr("class", "menu-min");
	} else {
		$.cookie('menusf', '', {
			expires : -1
		});
		$("#sidebar").attr("class", "");
	}
}
