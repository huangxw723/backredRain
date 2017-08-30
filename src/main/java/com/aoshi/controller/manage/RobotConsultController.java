package com.aoshi.controller.manage;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.RobotConsultService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *  小宝咨询controller
 * @author tgb
 * @date 2017年05月05日
 */
@Controller
@RequestMapping("/robotConsult")
public class RobotConsultController extends BaseController{

	@Autowired
	RobotConsultService robotConsultService;

	/**
	 *  小宝咨询列表
	 * @return
     */
	@RequestMapping("/listAll")
	public Object listAll() {
		return robotConsultService.listAll(this);
	}

	/**
	 *  小宝咨询页面跳转中转
	 *
	 * @author tgb
	 * @date 2017年05月05日
	 */
	@RequestMapping("/page")
	public Object page() {
		return robotConsultService.page(this);
	}

}
