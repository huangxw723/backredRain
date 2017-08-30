package com.aoshi.controller.manage.yp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.yp.ShopYpService;

/**
 * 企业管理 Controller
 * 
 * @author huangxw
 * @date 2016年10月18日
 * @return
 */
@Controller
@RequestMapping("/yp/admin/ypShop")
public class ShopYpController extends BaseController {
	
	@Autowired
	private ShopYpService shopService;
	
	
	/**
	 * 查询企业列表
	 * 
	 * @author huangxwe	
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/listAll")
	public Object listAll() {
		return shopService.listAll(this);
	}

	
	/**
	 * 企业操作增删改
	 * 
	 * @author huangxw
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/opera")
	@ResponseBody
	public Object opera() {
		return shopService.opera(this);
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
		return shopService.page(this);
	}
	
	/**
	 * 查看账号
	 * 
	 * @author huangxwe
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/getAccountList")
	public Object getAccountList() {
		return shopService.getAccountList(this);
	}
	
	
	/**
	 * 更新账号状态
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateUserStatus")
	public Object updateUserStatus() {
		return shopService.updateUserStatus(this);
	}
	
	/**
	 * 查询云屏列表
	 * 
	 * @author huangxwe
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/listScreenPage")
	public Object listScreenPage() {
		return shopService.listScreenPage(this);
	}
	
}
