$(window).load(function(){

});
$(document).ready(function($) {
	// 弹出框
	$('.m-fancy').click(function(){
		var _id = $(this).attr('id').substr(1);
        $('#'+_id).show();
        $('body').append('<div class="fancy-overlay"></div>')
	});
	$('.m-close').click(function(){
		$(this).parents('.m-pop').hide();
		$('.fancy-overlay').remove();
	});
	$('body').on('click','.fancy-overlay',function(){
		$('.m-pop').hide();
		$('.fancy-overlay').remove();
	});

    // 选项卡
    $(".TAB_CLICK li").mouseover(function(){
        var tab=$(this).parent(".TAB_CLICK");
        var con=tab.attr("id");
        var on=tab.find("li").index(this);
        $(this).addClass('on').siblings(tab.find("li")).removeClass('on');
        $(con).eq(on).fadeIn().siblings(con).hide();
    });
    //hover
    $('.tab_hover').mouseover(function(event) {
            $(this).children('.tab_child').show();
        });
    $('.tab_hover').mouseleave(function(event) {
            $(this).children('.tab_child').hide();
        });

    showDiv($(".member-nav span"), $("#memberTab .m-cont"));
    showAccount($(".acc-nav span"), $(".acc-cont .a-cont"));
});
$.fn.bootstrapDropdownHover();
    //$('#dropdownMenu1').bootstrapDropdownHover();
    //$('.navbar [data-toggle="dropdown"]').bootstrapDropdownHover();

    // demo for realtime configuration and destroy
    $(function() {
        $('[data-toggle="tooltip"]').tooltip({
            container: 'body'
        });

        $('#setSticky').on('click', function() {
            $('.setdemo [data-toggle="dropdown"]').bootstrapDropdownHover('setClickBehavior', 'sticky');
        });

        $('#setDefault').on('click', function() {
            $('.setdemo [data-toggle="dropdown"]').bootstrapDropdownHover('setClickBehavior', 'default');
        });

        $('#setDisable').on('click', function() {
            $('.setdemo [data-toggle="dropdown"]').bootstrapDropdownHover('setClickBehavior', 'disable');
        });

        $('#set1000').on('click', function() {
            $('.setdemo [data-toggle="dropdown"]').bootstrapDropdownHover('setHideTimeout', 1000);
        });

        $('#set200').on('click', function() {
            $('.setdemo [data-toggle="dropdown"]').bootstrapDropdownHover('setHideTimeout', 200);
        });

        $('#destroy').on('click', function() {
            $('[data-toggle="tooltip"]').tooltip('hide');
            $('.setdemo [data-toggle="dropdown"]').bootstrapDropdownHover('destroy');
            $('#destroy, #set200, #set1000, #setDisable, #setDefault, #setSticky').prop('disabled', 'disabled');
            $('#reinitialize').prop('disabled', false);
            $('.setdemo').addClass('destroyed');
        });

        $('#reinitialize').on('click', function() {
            $('[data-toggle="tooltip"]').tooltip('hide');
            $('.setdemo [data-toggle="dropdown"]').bootstrapDropdownHover();
            $('#destroy, #set200, #set1000, #setDisable, #setDefault, #setSticky').prop('disabled', false);
            $(this).prop('disabled', 'disabled');
            $('.setdemo').removeClass('destroyed');
        });
    });


// 会员规则切换
var showDiv = function(tab, clearfix) {
    tab.click(function() {
        var indx = tab.index(this);
        // alert(indx);
        tab.removeClass('rule-on');
        $(this).addClass('rule-on');
        clearfix.addClass('dn');
        clearfix.eq(indx).removeClass('dn');
    })
}

   // 账户信息切换
var showAccount = function(tab, clearfix) {
    tab.click(function() {
        var indx = tab.index(this);
        // alert(indx);
        tab.removeClass('msg-on');
        $(this).addClass('msg-on');
        clearfix.addClass('dn');
        clearfix.eq(indx).removeClass('dn');
    })
}
