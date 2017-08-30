package com.aoshi.controller.manage;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsUnit;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.UnitService;
import com.aoshi.util.AppUtil;
import com.aoshi.util.Const;
import com.aoshi.util.Jurisdiction;
import com.aoshi.util.PageData;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * UnitController
 * 
 * 单位列表管理 (add、del、edit、cha)
 * 
 * @author hxw
 * @date 16/6/20
 */
@Controller
@RequestMapping(value = "/unit")
public class UnitController extends BaseController {

	String menuUrl = "unit/unitList.do"; // 菜单地址(权限用)

	@Autowired
	private UnitService unitService;
	
	
	/**
	 * 获取单位列表
	 *@author tgb
	 *创建时间：2017年3月9日 
	 *@version 1.0
	 * @return
	 */
	@RequestMapping(value = "/unitList")
	public Object unitList(){
		return unitService.unitList(this);
	}

	 
	/**
	 * 保存
	 */
	@RequestMapping(value = "/saveUnit")
	public ModelAndView saveUnit(AsUnit unit) {
		logBefore(logger, "新增province");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		}
		ModelAndView mv = this.getModelAndView();
		try {
			unitService.save(unit);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}
	

	

	/**
	 * 修改
	 */
	@RequestMapping(value = "/goEditUnit")
	public ModelAndView goEditUnit(AsUnit unit) {
		logBefore(logger, "去修改goEditUnit页面");
		ModelAndView mv = this.getModelAndView();
		try {
			unit = unitService.findById(unit); // 根据ID读取
			mv.setViewName("manage/unit/unitEdit");
			mv.addObject("msg", "saveUnit");
			mv.addObject("unit", unit);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/deleteUnit")
	public void deleteUnit(PrintWriter out) {
		logBefore(logger, "删除deleteUnit");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		}
		PageData pd = this.getPageData();
		try {
			unitService.delete(pd.getInt("unitId"));
			out.write("success");
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}
	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除deleteAll");
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
				String ids = pd.getString("ids");
				if (StringUtils.isNotBlank(ids)) {
					String IdArr [] = ids.split(",");
					int[] ints =StringToInt(IdArr);
					unitService.deleteAll(ints);
					map.put("msg", "ok");
				} else {
					map.put("msg", "no");
				}
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}

	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}

	/* ===============================权限================================== */

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
	/**
	 * 字符数组装int类型
	 */
	public int[] StringToInt(String[] arrs){
		int[] ints = new int[arrs.length];
		for(int i=0;i<arrs.length;i++){
			ints[i] = Integer.parseInt(arrs[i]);
		}
		return ints;
	}
}
