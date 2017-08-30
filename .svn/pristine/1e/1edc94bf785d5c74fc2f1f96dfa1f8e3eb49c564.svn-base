package com.aoshi.controller.business.yp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.business.yp.BusinessScreenService;

/**
 * 终端管理 Controller
 * 
 * @author huangxw
 * @date 2016年10月18日
 * @return
 */
@Controller
@RequestMapping("/yp/business/screenInfo")
public class ScreenInfoController extends BaseController {
	
	@Autowired
	private BusinessScreenService screenService;
	
	
	/**
	 * 查询终端列表
	 * 
	 * @author huangxwe	
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/listAll")
	public Object listAll() {
		return screenService.listAll(this);
	}

	
	/**
	 * 终端操作增删改
	 * 
	 * @author huangxw
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/opera")
	@ResponseBody
	public Object opera() {
		return screenService.opera(this);
	}
	
	/**
	 * 页面跳转控制
	 * 
	 * @author huangxwe
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/page")
	public Object page() {
		return screenService.page(this);
	}
	
}
