package com.aoshi.controller.business;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.business.CooperationService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * 战略合作cooperationController 
 *@author tgb
 *创建时间：2017年3月8日 
 *@version 1.0
 */
@Controller
@RequestMapping(value = "/cooperation")
public class CooperationController extends BaseController {

	@Autowired
	private CooperationService cooperationService;

	/**
	 * 合作伙伴列表
	 *
	 * @author tgb 创建时间：2017年2月23日
	 * @version 1.0
	 * @return
	 */
	@RequestMapping(value = "/cooperationList")
	public Object cooperationList() {
		return cooperationService.cooperationList(this);
	}

	/**
	 * 跳转到添加合作伙伴列表
	 * @author tgb 创建时间：2017年2月23日
	 * @version 1.0
	 * @return
	 */
	@RequestMapping(value = "/addCooperation")
	public Object addCooperation() {
		return  cooperationService.addCooperation(this);
	}

	
	/**
	 * 批量删除合作伙伴
	 *@author tgb
	 *创建时间：2017年3月8日 
	 *@version 1.0
	 * @param ids
	 * @param shopId
	 * @return
	 */
    @RequestMapping(value = "/deleteCooperationIds")
    @ResponseBody
    public Map<String, Object> deleteCooperationIds(String ids, int shopId) {
        Map<String,Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotBlank(ids)) { 
                String shopIds[] = ids.split(",");
                cooperationService.deleteAll(shopIds);
            }
                map.put("msg", "ok");
                map.put("shopId", shopId);
        } catch (Exception e) {
            logger.error(e.toString(), e);
            map.put("msg", "no");
        } finally {
            logAfter(logger);
        }
        return map;
    }
    /**
     * 确定添加合作伙伴
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/addCooperationIds")
    @ResponseBody
    public Map<String, Object> addCooperationIds(String ids,int shopId) {
        Map<String,Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotBlank(ids)) {
                String shopIds[] = ids.split(",");
                cooperationService.addByPrimaryKeys(shopIds,shopId);
            }
            map.put("msg", "ok");
            map.put("shopId", shopId);
        } catch (Exception e) {
            logger.error(e.toString(), e);
            map.put("msg", "no");
        } finally {
            logAfter(logger);
        }
        return map;
    }

}
