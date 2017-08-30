package com.aoshi.controller.manage;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.AsAdvertiserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 广告客户controller
 */
@Controller
@RequestMapping("/advertiser")
public class AsAdvertiserController extends BaseController{

	@Autowired
	AsAdvertiserService asAdvertiserService;

	/**
	 * 广告客户列表
	 * @return
     */
	@RequestMapping("/listAll")
	public Object listAll() {
		return asAdvertiserService.listAll(this);
	}

	/**
	 * 页面跳转中转
	 *
	 * @author tgb
	 * @date 2016年11月2日
	 */
	@RequestMapping("/page")
	public Object page() {
		return asAdvertiserService.page(this);
	}

}
