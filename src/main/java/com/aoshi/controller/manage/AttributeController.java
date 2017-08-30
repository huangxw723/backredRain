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
import com.aoshi.domain.AsAttribute;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.AsAttributeService;
import com.aoshi.util.AppUtil;
import com.aoshi.util.Const;
import com.aoshi.util.Jurisdiction;
import com.aoshi.util.PageData;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * AttributeController
 * 
 * 商品属性表管理 (add、del、edit、cha)
 * 
 * @author hxw
 * @date 16/6/20
 */
@Controller
@RequestMapping(value = "/attribute")
public class AttributeController extends BaseController {

	String menuUrl = "attribute/attributekList.do"; // 菜单地址(权限用)

	@Autowired
	private AsAttributeService attributeService;

	/**
	 * 商品属性列表
	 */
	@RequestMapping(value = "/attributeList")
	public ModelAndView attributeList(Page page) {
		logBefore(logger, "列表attributekList");
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("manage/attribute/attributeList");
		PageData pd = this.getPageData();
		try {
			page.setPd(pd);
			PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
			List<AsAttribute> AsAttribute = attributeService.list(pd);
			PageInfo<AsAttribute> pageInfo = new PageInfo<AsAttribute>(AsAttribute);
			page.setEntityOrField(true);
			page.setTotalResult((int) pageInfo.getTotal());
			mv.addObject("attributeList", AsAttribute);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 保存商品属性列表
	 */
	@RequestMapping(value = "/saveAttribute")
	public ModelAndView saveAttribute(AsAttribute attribute) {
		logBefore(logger, "新增province");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		}
		ModelAndView mv = this.getModelAndView();
		try {
			attributeService.save(attribute);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}
	

	

	/**
	 * 修改商品属性列表
	 */
	@RequestMapping(value = "/goEditSaveAttribute")
	public ModelAndView goEditSaveAttribute(AsAttribute attribute) {
		logBefore(logger, "去修改province页面");
		ModelAndView mv = this.getModelAndView();
		try {
			attribute = attributeService.findById(attribute); // 根据ID读取
			mv.setViewName("manage/attribute/attributeEdit");
			mv.addObject("msg", "saveAttribute");
			mv.addObject("attribute", attribute);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 删除商品属性列表
	 */
	@RequestMapping(value = "/deleteAttribute")
	public void deleteAttribute(PrintWriter out) {
		logBefore(logger, "删除attributeId");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		}
		PageData pd = this.getPageData();
		try {
			attributeService.delete(pd.getInt("attributeId"));
			out.write("success");
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}
	/**
	 * 商品属性列表批量删除
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
					attributeService.deleteAll(ints);
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
	/**
	 * 商品属性视图页面
	 */
	@RequestMapping(value = "/goAttrButeView")
	public ModelAndView goAttrButeView() {
		logBefore(logger, "去查看goAttrButeView页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try {
			AsAttribute attribute =new AsAttribute();
			attribute.setAttributeId(pd.getInt("attributeId"));
			attribute = attributeService.findById(attribute); // 根据ID读取
			mv.setViewName("manage/attrType/attrButeview");
			mv.addObject("pd", pd);
			mv.addObject("attribute", attribute);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

}
