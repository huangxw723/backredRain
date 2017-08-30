package com.aoshi.controller.manage;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsGoodsType;
import com.aoshi.service.manage.GoodsTypeService;
import com.aoshi.util.Const;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.Jurisdiction;
import com.aoshi.util.PageData;
import com.aoshi.util.PropertyUtils;
import com.google.gson.Gson;

/**
 * 类名称：GoodsAttrController 创建人：star 创建时间：2016-06-21
 */
@Controller
@RequestMapping(value = "/goodsType")
public class GoodsTypeController extends BaseController {

	String menuUrl = "goodsType/list.do"; // 菜单地址(权限用)

	@Autowired
	private GoodsTypeService goodsTypeService;

	/**
	 * 去新增商品类型界面
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() throws Exception {
		logBefore(logger, "去新增asGoodsType页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd;
		pd = this.getPageData();
		List<PageData> datas = collectData();
		Gson gson = new Gson();
		String json = gson.toJson(datas);
		mv.addObject("data", json);
		mv.setViewName("manage/goodsType/goodsTypeEdit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 新增商品类型
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save(AsGoodsType record) throws Exception {
		logBefore(logger, "新增asGoodsType");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		}
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		int flag = goodsTypeService.save(record, pd);
		if (flag != 1) {
			mv.addObject("msg", "failed");
			return mv;
		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 去修改商品类型页面
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit(AsGoodsType goodsType) {
		logBefore(logger, "去修改asGoodsType页面");
		ModelAndView mv = this.getModelAndView();
		try {
			goodsType = goodsTypeService.findById(goodsType); // 根据ID读取
			mv.setViewName("manage/goodsType/goodsTypeEdit");
			mv.addObject("goodsType", goodsType);
			mv.addObject("msg", "edit");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 组装数据 成树
	 * 
	 * @return
	 * @throws Exception
	 */
	private List<PageData> collectData() throws Exception {
		List<AsGoodsType> datas = goodsTypeService.listAll();
		List<PageData> nodes = new ArrayList<PageData>();
		if (datas != null && datas.size() > 0) {
			for (int i = 0; i < datas.size(); i++) {
				PageData node = new PageData();
				node.put("id", datas.get(i).getGoodsTypeId());
				node.put("pId", datas.get(i).getParentId());
				node.put("name", datas.get(i).getTypeName());
				nodes.add(node);
			}
		}
		return nodes;
	}

	/**
	 * 修改商品类型
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit(AsGoodsType goodsType) throws Exception {
		logBefore(logger, "修改asGoodsType");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		}
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		int flag = goodsTypeService.edit(goodsType, pd);
		if (flag != 1) {
			mv.addObject("msg", "failed");
			return mv;
		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) {
		logBefore(logger, "删除asGoodsType");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		}
		PageData pd = new PageData();
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			pd = this.getPageData();
			List<AsGoodsType> children = goodsTypeService.findChildren(pd);
			if (children.size() == 0) {
				Integer goodsTypeId = pd.getInt("goodsTypeId");
				int result = goodsTypeService.getTypeRelation(goodsTypeId);
				if (result > 0) {
					out.write("exist");
					out.close();
					return;
				}
				AsGoodsType goodsType = new AsGoodsType();
				goodsType.setGoodsTypeId(goodsTypeId);
				goodsType = goodsTypeService.findById(goodsType);
				String oldPath = goodsType.getTypeImg();
				goodsTypeService.delete(goodsType.getGoodsTypeId());
				if (StringUtils.isNotBlank(oldPath)) {
					ftpConManager.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(), PropertyUtils.getFTP_PASS());
					if (ftpConManager.getFiles(Const.FILEPATHIMGDIR + oldPath).length != 0) {
						boolean flag = ftpConManager.removeFile(Const.FILEPATHIMGDIR + oldPath);
						if (!flag) {
							out.write("failed");
							out.close();
						}
					}
				}
				out.write("success");
			} else {
				out.write("failed");
			}
			out.close();
		} catch (Exception e) {
			out.write("failed");
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 分类列表
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list() {
		logBefore(logger, "分类列表asGoodsType");
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("manage/goodsType/goodsTypeList");
		try {
			List<AsGoodsType> goodsTypeList = goodsTypeService.listAll();
			mv.addObject("goodsTypeList", goodsTypeList);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
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

}
