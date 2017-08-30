package com.aoshi.controller.manage.consultation;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsDictParam;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.consultation.consultationInfo.AsCouponDistanceService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 优惠券周边距离配置控制层:
 * @author：wendy
 * @date
 */
@Controller
@RequestMapping(value = "/couponDistance")
public class AsCouponDistanceController extends BaseController {
	
	private static final String BASEURL = "/manage/couponDistance/";
	
	@Autowired
	private  AsCouponDistanceService  asCouponDistanceService;
	
    /**
	 * 列表显示
	 * @param map
	 * @param page
	 * @param obj
	 * @return String
	 */
	@RequestMapping("list")
	public String list(ModelMap map, Page page, AsDictParam obj) {
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);

		//搜索查询 
		obj.setDictCode("param_distance");
		//obj.setCreateTime("2016-11-24 17:20:07");
		List<AsDictParam> list = asCouponDistanceService.queryList(obj);
		page.setPage(list);
		map.put("list", list);

		map.put("obj", obj);//回显历史搜索记录
		return BASEURL + "list";//列表层
	}

	/**
	 * to-编辑页面
	 */
	@RequestMapping("toEdit")
	public String toEdit(Integer id, ModelMap map) {
		//根据id查询
		AsDictParam asDictParam = asCouponDistanceService.selectByPrimaryKey(id);	
		// 数据-对象
		map.put("obj", asDictParam);
		return BASEURL + "edit";
	}
	
	/**
	 * 保存编辑
	 */
	@RequestMapping(value = "saveEdit", method = RequestMethod.POST)
	public ModelAndView saveEdit(AsDictParam obj) {
		ModelAndView mv = this.getModelAndView();
		try {
			asCouponDistanceService.saveEdit(obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * to-预览页面
	 */
	@RequestMapping("toEditPreview")
	public String toEditPreview(Integer id, ModelMap map) {
		AsDictParam asDictParam = asCouponDistanceService.selectByPrimaryKey(id);
		// 数据-对象
		map.put("obj", asDictParam);
		return BASEURL + "editPreview";
	}
}
