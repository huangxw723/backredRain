package com.aoshi.controller.manage.consultation;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsConsultationTypeMapper;
import com.aoshi.domain.AsConsultationConvenience;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.domain.AsConsultationType;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.consultation.consultationInfo.AsConsultationConvenienceService;
import com.aoshi.service.manage.consultation.consultationInfo.AsConsultationInfoService;
import com.aoshi.service.manage.locality.AsAreaService;
import com.aoshi.service.manage.locality.AsCityService;
import com.aoshi.service.manage.locality.AsProvinceService;
import com.github.pagehelper.PageHelper;

import net.sf.json.JSONArray;

/**
 * 控制层:
 * 
 * @author:wendy
 */
@Controller
@RequestMapping(value = "/consultationConvenience")
public class AsConsultationConvenienceController extends BaseController {

	// 发布资讯
	private static final String BASEURL = "/manage/consultationConvenience/";
	@Autowired
	private AsConsultationInfoService asConsultationInfoService;
	@Autowired
	private AsConsultationConvenienceService asConsultationConvenienceService;
	@Autowired
	private AsProvinceService asProvinceService;
	@Autowired
	private AsCityService asCityService;
	@Autowired
	private AsAreaService asAreaService;
	@Autowired
	private AsConsultationTypeMapper typeMapper;

	/**
	 * 列表显示
	 * 
	 * @param map
	 * @param page
	 * @param obj
	 * @return String
	 */
	@RequestMapping("list")
	public String list(ModelMap map, Page page, AsConsultationConvenience obj) {
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);

		// 搜索查询
		List<AsConsultationConvenience> list = asConsultationConvenienceService.queryList(obj);
		page.setPage(list);
		map.put("list", list);

		List<AsConsultationType> typeList = asConsultationInfoService.selectByLevel(2); // 资讯类型
		map.put("typeList", typeList); // 获取资讯类型
		map.put("typeListTwo", JSONArray.fromObject(asConsultationInfoService.selectByLevel(3)));// 二级类型

		map.put("provinceList", asProvinceService.list(null));// 省
		map.put("cityList", JSONArray.fromObject(asCityService.list(null)));// 市

		map.put("obj", obj);// 回显历史搜索记录
		return BASEURL + "list";// 列表层
	}

	/*---------------------------------------增删改------------------------------------*/
	/**
	 * to-新增页面
	 */
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() {
		ModelAndView mv = this.getModelAndView();
		try {
			mv.setViewName(BASEURL + "add");
			// 一级
			List<AsConsultationType> typeList = asConsultationInfoService.selectByLevel(2);
			mv.addObject("typeList", typeList);
			// 二级
			mv.addObject("typeListTwo", JSONArray.fromObject(asConsultationInfoService.selectByName("便民")));
		
			// 省份
			mv.addObject("provinceList", asProvinceService.list(null));// 省
			mv.addObject("cityList", JSONArray.fromObject(asCityService.selectAll()));// 市
			mv.addObject("areaList", JSONArray.fromObject(asAreaService.selectAll()));// 区域

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}

	/**
	 * 保存新增
	 */
	@RequestMapping(value = "/saveAdd", method = RequestMethod.POST)
	public ModelAndView saveAdd(AsConsultationConvenience obj, String latlng,
			@RequestParam(value = "file", required = true) MultipartFile file, MultipartFile file2, ModelMap map,
			@RequestParam(value = "imgs", required = true) MultipartFile[] imgs, AsConsultationImgs asImgs) {
		ModelAndView mv = this.getModelAndView();
		try {
			Date date = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			obj.setPublicTime(df.format(date));
			obj.setVisitCount(100);

			String type = "";
			AsConsultationType type2 = typeMapper.selectByPrimaryKey(obj.getTypeId());
			if (type2 != null) {
				type = type2.getTypeName();
			}
			if ("交通指南".equals(type))
				obj.setType(1);
			else if ("免费公园".equals(type)) {
				obj.setType(2);
			}
			asConsultationConvenienceService.saveAdd(obj, latlng, file, file2, imgs, asImgs);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public int delete(Integer id) {
		return asConsultationConvenienceService.deleteByPrimaryKey(id);
	}

	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll(String[] ids) {
		return asConsultationConvenienceService.deleteByIds(ids);
	}

	/**
	 * to-编辑页面
	 */
	@RequestMapping("toEdit")
	public String toEdit(Integer id, ModelMap map) {
		AsConsultationConvenience asConsultationConvenience = asConsultationConvenienceService.selectByPrimaryKey(id);
		// 一级
		List<AsConsultationType> typeList = asConsultationInfoService.selectByLevel(2);
		map.put("typeList", typeList);
		// 二级
		map.put("typeListTwo", JSONArray.fromObject(asConsultationInfoService.selectByName("便民")));
		// 省份
		map.put("provinceList", asProvinceService.list(null));// 省
		map.put("cityList", JSONArray.fromObject(asCityService.selectAll()));// 市
		map.put("areaList", JSONArray.fromObject(asAreaService.selectAll()));// 区域
		// 数据-对象
		map.put("obj", asConsultationConvenience);
		map.put("latlng", asConsultationConvenience.getLat() + "," + asConsultationConvenience.getLng());// 经纬度
		return BASEURL + "edit";
	}

	/**
	 * 保存编辑
	 */
	@RequestMapping(value = "saveEdit", method = RequestMethod.POST)
	public ModelAndView saveEdit(AsConsultationConvenience obj, @RequestParam String latlng,
			@RequestParam MultipartFile file, MultipartFile file2) {
		ModelAndView mv = this.getModelAndView();
		try {
			if (obj.getAreaId() == null) {
				// 区域不选择就默认给0
				obj.setAreaId(0);
			}
			//obj.setType(0);
			asConsultationConvenienceService.saveEdit(obj, latlng, file, file2);
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
		AsConsultationConvenience asConsultationConvenience = asConsultationConvenienceService.selectByPrimaryKey(id);
		// 一级
		List<AsConsultationType> typeList = asConsultationInfoService.selectByLevel(2);
		map.put("typeList", typeList);
		// 二级
		map.put("typeListTwo", JSONArray.fromObject(asConsultationInfoService.selectByLevel(3)));
		// 省份
		map.put("provinceList", asProvinceService.list(null));// 省
		map.put("cityList", JSONArray.fromObject(asCityService.list(null)));// 市
		map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));// 区域
		// 数据-对象
		map.put("obj", asConsultationConvenience);
		map.put("latlng", asConsultationConvenience.getLat() + "," + asConsultationConvenience.getLng());// 经纬度
		return BASEURL + "editPreview";
	}

	/*---------------------------------------other------------------------------------*/
	/**
	 * 发布
	 */
	@RequestMapping(value = "/onSale")
	@ResponseBody
	public int onSale(Integer id) {
		AsConsultationConvenience obj = asConsultationConvenienceService.selectByPrimaryKey(id);
		obj.setStatus(2);
		Date date = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		obj.setPublicTime(df.format(date));
		return asConsultationConvenienceService.onSale(obj);
	}

	/**
	 * 下架
	 */
	@RequestMapping(value = "/offSale")
	@ResponseBody
	public int offSale(Integer id) {
		AsConsultationConvenience obj = asConsultationConvenienceService.selectByPrimaryKey(id);
		obj.setStatus(3);
		return asConsultationConvenienceService.offSale(obj);
	}

	/**
	 * 批量下架
	 */
	@RequestMapping(value = "/offSaleAll")
	@ResponseBody
	public int offSaleAll(String[] ids) {
		return asConsultationConvenienceService.offSaleAll(ids);
	}

	

}
