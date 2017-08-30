package com.aoshi.controller.business;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.SysUser;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.business.SettingService;
import com.aoshi.util.CommonUtils;

@Controller
@RequestMapping("/setting")
public class SettingController extends BaseController {

	@Autowired
	private SettingService settingService;

	/**
	 * 修改密码页面
	 * 
	 * @author yangyanchao
	 * @date 2016年9月8日
	 * @return
	 */
	@RequestMapping("/updatePwdPage")
	public Object updatePwdPage() {
		initialized();
		return renderView("business/common/" + "resetPwdPage");
	}

	/**
	 * 修改密码
	 * 
	 * @author yangyanchao
	 * @date 2016年9月8日
	 * @return
	 */
	@RequestMapping("/updatePwd")
	@ResponseBody
	public Object updatePwd() {
		return settingService.updatePwd(this);
	}


	/**
	 * 修改密码
	 * 
	 * @author wangjs
	 * @date 2017年02月20日
	 * @return
	 */
	@RequestMapping("/updatePass")
	@ResponseBody
	public Object updatePass(String oldPassword,String password) {
		
		return settingService.updatePass(this,oldPassword, password);
	}
	
}
