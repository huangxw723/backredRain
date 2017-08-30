$(function(){
	var userType;
	// 确定商户类型
	$('.select_icon ').on('click', function(){
		$('.select_icon').find('i').removeClass('renewal_icon');
		$(this).find('i').addClass('renewal_icon')
		userType = parseInt( $(this).attr('data-userType') );
		sessionStorage.setItem("userType", userType);
	});


	/**
	 * [description]
	 *  - 注册
	 * @Author StoneZhou
	 * @DateTime  2017-06-23T17:16:57+0800
	 */

  var sbStatus = true;
	$('.register_button').on('click', function( event ) {

    var phone = $('.phone').val();
    var password = $('.password').val();

    // 验证类型
		if ( userType == undefined ) {
      webToast('请选择商户类型',"middle",1000);
      return false;
		}

    // 验证密码
    if ( !(/^[\w.]{6,20}$/.test(password)) ) {
      webToast('请输入正确的密码',"middle",1000);
      return false;
    }

    // 验证手机号码
    if(!(/^1[34578]\d{9}$/.test(phone)) ){
      webToast('手机号码格式不正确',"middle",1000);
      return false;
    }

    if ( sbStatus ) {

      sbStatus = false;

      $.ajax({
        url: host + 'codeMerchant/register.do',
        data: {
          account: $('.user_name').val(),
          password: password,
          phone: phone,
          userType: userType
        },
        beforeSend: function (xhr) {
          $(".loader").show(); // 数据加载成功之前，使用loading组件
        }
      }).done(function( data ) {

        sbStatus = true;
        $(".loader").hide();
        webToast(data.msg,"middle",1500);

        if ( data.status == 0 ) {
          sessionStorage.setItem("token", data.data.token );
          setTimeout(function(){
            window.location.href = 'flow_path.html';
          }, 2000);
        }
        console.log(data);
      }).fail(function( data ) {

        sbStatus = true;
        $(".loader").hide();
        console.log("error");

      });
    }

	});

  $(document).keyup(function ( event ) {
    if(event.keyCode == 13){
      $('.register_button').click();
    }
  });
	
});
