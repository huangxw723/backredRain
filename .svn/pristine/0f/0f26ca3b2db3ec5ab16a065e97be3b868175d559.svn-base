package com.aoshi.controller.business;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.business.ShopService;

/**
 * 商家模块
 * 
 * @author yangyanchao
 * @date 2016年9月7日
 */
@Controller
@RequestMapping("/shop")
public class ShopController extends BaseController {

	@Autowired
	private ShopService shopService;

	/**
	 * 店铺礼品记录
	 * 
	 * @author yangyanchao
	 * @date 2016年9月6日
	 * @return
	 */
	@RequestMapping("/receivedHistoryByShop")
	public Object receivedHistoryByShop() {
		return shopService.receivedHistoryByShop(this);
	}

	/**
	 * 查看礼品详情
	 * 
	 * @author yangyanchao
	 * @date 2016年9月7日
	 * @return
	 */
	@RequestMapping("/prizeDetail")
	public Object prizeDetail() {
		return shopService.prizeDetail(this);
	}
}
