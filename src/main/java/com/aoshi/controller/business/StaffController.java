package com.aoshi.controller.business;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsShopStaffInfoMapper;
import com.aoshi.service.business.StaffService;

/**
 * 员工管理 Controller
 * 
 * @author yangyanchao
 * @date 2016年9月1日
 */
@Controller
@RequestMapping("/staff")
public class StaffController extends BaseController {

	@Autowired
	private StaffService staffService;

	@Autowired
	private AsShopStaffInfoMapper asShopStaffInfoMapper;

	/**
	 * 添加员工
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @return
	 */
	/*
	 * @RequestMapping("/page") public Object page() { return
	 * staffService.page(this); }
	 */

	/**
	 * 员工管理操作
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @return
	 */
	/*
	 * @RequestMapping("/opera")
	 * 
	 * @ResponseBody public Object opera() { return staffService.opera(this); }
	 */

	/**
	 * 查询店铺帐号列表
	 * 
	 * @author huangxw
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/listAll")
	public Object listAll() {
		return staffService.getShopStaffAccountList(this);
	}

	/**
	 * 添加帐号H5
	 * 
	 * @author yangyanchao
	 * @date 2016年11月2日
	 * @return
	 */
	@RequestMapping("/saveShopAccountPage")
	public Object saveShopAccountPage() {
		return staffService.saveShopAccountPage(this);
	}

	/**
	 * 更新状态
	 * 
	 * @author huangxw
	 * @date 2016年9月2日
	 * @return
	 */
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping("/accountStatus") public Object accountStatus() { return
	 * staffService.accountStatus_Tx(this); }
	 */

	/**
	 * 密码重置页面
	 * 
	 * @author huangxw
	 * @date 2016年9月3日
	 * @return
	 */
	/*
	 * @RequestMapping("/resetPwdPage") public Object resetPwdPage() {
	 * 
	 * initialized();
	 * 
	 * Conditions staff = (Conditions)
	 * asShopStaffInfoMapper.findByUserId(pd.getIntRequired("userId"));
	 * 
	 * addViewData("staff", staff); return
	 * renderView("business/staff/resetPwdPage"); }
	 */

	/**
	 * 密码重置 action
	 * 
	 * @author huangxw
	 * @date 2016年9月3日
	 * @return
	 */
	/*
	 * @RequestMapping("/resetPwd") public Object resetPwd() { return
	 * staffService.resetPwd(this); }
	 */
	
	/**
	 * 删除 action
	 * 
	 * @author huangxw
	 * @date 2016年9月3日
	 * @return
	 */
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping("/delete") public Object delete() { return
	 * staffService.delete(this); }
	 */

}
