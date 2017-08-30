package com.aoshi.controller.manage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aoshi.controller.base.BaseController;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.AsShippingService;

/**
 * ShippingController
 * 
 * 说明列表管理 (add、del、edit、cha)
 * 
 * @author hxw
 * @date 16/6/20
 */
@Controller
@RequestMapping(value = "/shipping")
public class ShippingController extends BaseController {

	String menuUrl = "shipping/shippingList.do"; // 菜单地址(权限用)

	@Autowired
	private AsShippingService shippingService;

	/**
	 * 配送商列表
	 * 
	 * @author yangyanchao
	 * @date 2016年7月8日
	 * @return
	 */
	@RequestMapping(value = "/shippingList")
	public Object shippingList() {
		return shippingService.shippingList(this);
	}

	/**
	 * 配送管理 添加/修改页面
	 * 
	 * @author yangyanchao
	 * @date 2016年7月7日
	 * @return
	 */
	@RequestMapping("/goShippingCfgPage")
	public Object goShippingCfgPage() {
		return shippingService.goShippingCfgPage(this);
	}

	/**
	 * 添加/修改 配送记录
	 * 
	 * @author yangyanchao
	 * @date 2016年7月7日
	 * @return
	 */
	@RequestMapping("/operaShipping")
	public Object operaShipping() {
		return shippingService.operaShipping(this);
	}

	/**
	 * 添加/编辑 配送模板H5
	 * 
	 * @author yangyanchao
	 * @date 2016年7月8日
	 * @return
	 */
	@RequestMapping("/goShippingTplPage")
	public Object goShippingTplPage() {
		return shippingService.goShippingTplPage(this);
	}
}
