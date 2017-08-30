package com.aoshi.controller.business.yp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.business.yp.BusinessScreenDomainService;

/**
 * 终端管理 Controller
 * 
 * @author huangxw
 * @date 2016年10月18日
 * @return
 */
@Controller
@RequestMapping("/yp/business/screenDomain")
public class ScreenDomainController extends BaseController {

	@Autowired
	private BusinessScreenDomainService domainService;

	/**
	 * 查询云屏列表
	 * 
	 * @author huangxwe
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/listScreenPage")
	public Object listScreenPage() {
		return domainService.listScreenPage(this);
	}

	/**
	 * 查询站点列表
	 * 
	 * @author huangxwe
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/listAll")
	public Object listAll() {
		return domainService.listAll(this);
	}

	/**
	 * 终端操作增删�?
	 * 
	 * @author huangxw
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/updataDomain")
	@ResponseBody
	public Object updataDomain() {
		return domainService.updataDomain(this);
	}

}
