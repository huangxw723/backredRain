package com.aoshi.controller.business;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsEventMapper;
import com.aoshi.service.business.BussinessActivityService;
import com.aoshi.service.manage.ActivityService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 商户活动管理Controller
 *
 * @author chenwz
 * @data 2017/5/24
 */

@Controller
@RequestMapping("/bussinessActivity")
public class BussinessActicvtyController extends BaseController {

    @Autowired
    private BussinessActivityService activityService;
    
    
    /**
     * 商户活动列表    
     * @return
     * @author chenwz
     * @date 2017年5月25日
     */
    @RequestMapping("/listAll")
    public Object listAll() {
        return activityService.listAll(this);
    }

    
    /**
     * 商户活动页面跳转中转 
     * @author chenwz
     * @date 2017年5月25日
     */
    @RequestMapping("/page")
    public Object page() {
        return activityService.topage(this);
    }

    /**
     * 修改状态 启用 禁用 
     * @author chenwz
     * 创建时间：2017年5月25日
     */
    @RequestMapping("/updateEventStatus")
    @ResponseBody
    public Object updatePrizeStatus(BaseController c) {
        return activityService.updateEventStatus(this);
    }
    
    /**
	 * 全局操作
	 * @author chenwz
	 * @date 2017年5月25日
	 * @return
	 */
	@RequestMapping("/opera")
	@ResponseBody
	public Object opera() {
		return activityService.opera(this);
	}
    
    /**
	 * 删除商户活动
	 * @author chenwwz
	 * 创建时间：2017年5月25日 
	 * @return
	 */
	@RequestMapping("/deletEvent")
	@ResponseBody
	public Object deleteEvent() {
		return activityService.deleteEvent(this);
	}

	/**
     * 查看驳回理由
     * @return
     * @author chenwz 
     * 创建时间：2017年5月26日 
     */
    @RequestMapping("/reason")
    public Object reason() {
        return activityService.reason(this);
    }
    
    /**
	 * 异步检查是否重名
	 * @author chenwz
	 * 创建时间：2017年5月26日	
	 * @return
	 */
	@RequestMapping("/isExist")
	@ResponseBody
	public Object isExist() {
		return activityService.isExist(this);
	}

    /**
     * #############################################商户活动审核管理###################################################
     */

    /**
     * 商户活动审核列表
     *
     * @return
     * @author tgb
     * @date 2017年05月25日
     */
    @RequestMapping("/listAudit")
    public Object listAudit() {
        return activityService.listAudit(this);
    }

    /**
     * 商户活动审核处理页面
     *
     * @return
     * @author tgb
     * @date 2017年05月25日
     */
    @RequestMapping("/auditEdit")
    public Object auditEdit() {
        return activityService.page(this);
    }

    /**
     * 商户活动更新审核状态
     *
     * @return
     * @author tgb
     * @date 2017年05月25日
     */
    @RequestMapping("/updateStatus")
    public Object updateStatus() {
        return activityService.updateStatus(this);
    }


    /**
     * 商户活动批量更新新审核状态
     *
     * @return
     * @author tgb
     * @date 2017年05月25日
     */
    @RequestMapping("/allAuditStatus")
    @ResponseBody
    public Object allAuditStatus(String[] ids) {
        Integer auditStatus = 1;
        return activityService.allAuditStatus(ids, auditStatus);
    }

    /**
     * 商户活动审核历史列表
     *
     * @return
     * @author tgb
     * @date 2017年05月25日
     */
    @RequestMapping("/listAuditHistory")
    public Object listAuditHistory() {
        return activityService.listAuditHistory(this);
    }

    /**
     * 商户活动查看历史详情
     *
     * @return
     * @author tgb
     * @date 2017年05月25日
     */
    @RequestMapping("/auditHistoryById")
    public Object auditHistoryById() {
        return activityService.auditHistoryById(this);
    }

}
