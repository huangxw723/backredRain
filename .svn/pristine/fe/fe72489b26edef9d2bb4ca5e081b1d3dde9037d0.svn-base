package com.aoshi.controller.bank;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.bank.ShopWithdrawService;
import com.aoshi.service.manage.integration.ShopPointService;

/**
 * 
 * @ClassName: ShopWithdrawController
 * @Description: 提现设置
 * @author wangjs
 * @date 2017年2月25日 上午11:14:01
 *
 */
@Controller
@RequestMapping(value = "/withdraw")
public class ShopWithdrawController extends BaseController {
	@Autowired
	private ShopWithdrawService shopWithdrawService;

	/**
	 * 
	 * @Title findAllWithdraw
	 * @author wangjs
	 * @version 3.0
	 * @return Object
	 * @Description 获取提现设置信息
	 * @time 2017年2月25日 上午11:14:30
	 */
	@RequestMapping(value = "/setwithdraw")
	public Object findAllWithdraw() {

		return shopWithdrawService.getSetWithdraw(this);
	}

	/**
	 * 
	 * @Title  updateWithdraw
	 * @author  wangjs   
	 * @version 3.0 
	 * @param withdrawId
	 * @param withdrawValue
	 * @return Object
	 * @Description
	 * @time 2017年2月25日 上午11:15:41
	 */
	@RequestMapping(value = "/updatewithdraw")
	public Object updateWithdraw(String withdrawId, String withdrawValue) {
		shopWithdrawService.updateWithdrawTx(withdrawId, withdrawValue);
		return shopWithdrawService.getSetWithdraw(this);
	}
}
