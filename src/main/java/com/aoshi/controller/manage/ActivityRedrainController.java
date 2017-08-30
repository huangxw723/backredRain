package com.aoshi.controller.manage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.ActivityRedrainService;

/**
 * 红包雨活动信息管理
 * 
 * @author huangxw
 * @date 2017年03月04日
 */
@Controller
@RequestMapping("/activityRedrain")
public class ActivityRedrainController extends BaseController {
	
	@Autowired
	private ActivityRedrainService activityRedrainService;

	/**
	 * 红包雨活动列表
	 * 
	 * @author huangxw
	 * @date 2016年10月28日
	 * @return
	 */
	@RequestMapping("/getActivityRedraintList")
	public Object getActivityRedraintList() {
		return activityRedrainService.getActivityRedraintList(this);
	}

	/**
	 * 商户账号页面跳转控制
	 * 
	 * @author huangxw
	 * @date 2017年02月21日
	 * @return
	 */
	@RequestMapping("/addShopAccountInfoPage")
	public Object page() {
		return activityRedrainService.page(this);
	}
	
	
	/**
	 * 操作
	 * 
	 * @author huangxw
	 * @date 2017年02月21日
	 * @return
	 */
	@RequestMapping("/opera")
	@ResponseBody
	public Object opera() {
		return activityRedrainService.opera(this);
	}
	
	/**
	 * 删除帐号
	 * 
	 * @author huangxw
	 * @date 2017年04月19日
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete() {
		return activityRedrainService.delete(this);
	}
}
