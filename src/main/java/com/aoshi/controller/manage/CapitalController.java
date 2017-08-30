package com.aoshi.controller.manage;

import com.aoshi.service.system.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.CapitalService;

/**
 * 提现管理
 * 
 * @author yangyanchao
 * @date 2016年9月8日
 */
@Controller
@RequestMapping("/capital")
public class CapitalController extends BaseController {

	@Autowired
	private CapitalService capitalService;

	/**
	 * 提现申请列表
	 * 
	 * @author yangyanchao
	 * @date 2016年9月8日
	 * @return
	 */
	@RequestMapping("/listDeposit")
	public Object listDeposit() {
		return capitalService.listDeposit(this);
	}

	/**
	 * 更新提现状态
	 * 
	 * @author yangyanchao
	 * @date 2016年9月8日
	 * @return
	 */
	@RequestMapping("/depositStatus")
	@ResponseBody
	public Object depositStatus() {
		return capitalService.depositStatus_Tx(this);
	}
	
	/**
	 *申请处理页面
	 */
	@RequestMapping(value = "/goEdit")
	public Object goEdit() {
	return capitalService.opearPage(this);
	}

	@Autowired
	UserService userService;

	@RequestMapping(value = "goAccountDetail")
	public Object goAccountDetail(ModelMap map, String account){
		map.put("data", userService.findByAccountDetail(account));
		return "manage/common/goAccountDetail";
	}
}
