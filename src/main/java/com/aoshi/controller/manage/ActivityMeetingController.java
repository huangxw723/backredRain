package com.aoshi.controller.manage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.ActivityMeetingService;
import com.aoshi.service.manage.PrizeConfigService;

/**
 * 明星见面会管理 Controller
 * 
 * @author tgb
 * @date 2017年03月04日
 */
@Controller
@RequestMapping("/activityMeeting")
public class ActivityMeetingController extends BaseController {

	@Autowired
	private ActivityMeetingService activityMeetingService;

	/**
	 * 页面跳转中转
	 * 
	 * @author tgb
	 * @date 2017年03月04日
	 */
	@RequestMapping("/page")
	public Object page() {
		return activityMeetingService.page(this);
	}

	/**
	 * 全局操作
	 * 
	 * @author tgb
	 * @date 2017年03月04日
	 * @return
	 */
	@RequestMapping("/opera")
	@ResponseBody
	public Object opera() {
		return activityMeetingService.opera(this);
	}

	/**
	 * 列表
	 * 
	 * @author tgb
	 * @date 2017年03月04日
	 * @return
	 */
	@RequestMapping("/listAll")
	public Object listAll() {
		return activityMeetingService.listAll(this);
	}

	/**
	 * 异步检查是否重名
	 *
	 * @author tgb 创建时间：2017年3月6日
	 * @version 1.0
	 * @return
	 */
	@RequestMapping("/isExist")
	@ResponseBody
	public Object isExist() {
		return activityMeetingService.isExist(this);
	}

	/**
	 * 删除明星见面会
	 *@author tgb
	 *创建时间：2017年4月19日 
	 *@version 1.0
	 * @return
	 */
	@RequestMapping("/deleteActivityMeeting")
	@ResponseBody
	public Object deleteActivityMeeting() {
		return activityMeetingService.deleteActivityMeeting(this);
	}
}
