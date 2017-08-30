package com.aoshi.controller.manage;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.ActivityService;


/**
 * 活动设置模块Controller
 * 
 * @author huangxuwen
 * @date 2016年9月1日
 */
@Controller
@RequestMapping(value = "/acitity")
public class ActivityController extends BaseController {

	protected boolean operaFlag;
	String menuUrl = "acitity/editPage.do"; // 菜单地址(权限用)

	@Resource(name = "activityService")
	private ActivityService activityService;

	
	/**
	 * 活动设置页面
	 * 
	 * @author huangxuwen
	 * @date 2016年9月1日
	 * @return mv
	 */
	@RequestMapping(value = "/editPage")
	public Object editPage() {
		// 进行中的活动 2 由adim 创建
		return activityService.listPage(this);
	}

	/**
	 * 添加设置
	 * 
	 * @author huangxuwen
	 * @date 2016年9月1日
	 * @return mv
	 */
	@RequestMapping(value = "/save")
	public Object save() {
		return activityService.save(this);
	}


	/**
	 * 
	 * 停止活动
	 * 
	 * @author huangxuwen
	 * @date 2016年9月1日
	 * @return mv
	 */
	@RequestMapping(value = "/shopActivity")
	@ResponseBody
	public Object shopActivity() {
		
		return activityService.updateActivity(this);
		
	}

	/**
	 * 活动历史数据
	 * 
	 * @author yangyanchao
	 * @date 2016年9月6日
	 * @return
	 */
	@RequestMapping("/listHistory")
	public Object listHistory() {
		return activityService.listHistory(this);
	}

	/**
	 * 活动礼品兑换记录
	 * 
	 * @author yangyanchao
	 * @date 2016年9月6日
	 * @return
	 */
	@RequestMapping("/receivedHistory")
	public Object receivedHistory() {
		return activityService.receivedHistory(this);
	}

	/**
	 * tab页
	 * 
	 * @author yangyanchao
	 * @date 2016年9月6日
	 * @return
	 */
	@RequestMapping("/tab")
	public Object tab() {
		initialized();
		return renderView("manage/activity/tab");
	}

}
