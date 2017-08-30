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
import com.aoshi.domain.AsConsultationInfo;
import com.aoshi.domain.AsConsultationType;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.consultation.consultationInfo.AsConsultationInfoService;
import com.aoshi.service.manage.locality.AsAreaService;
import com.aoshi.service.manage.locality.AsCityService;
import com.aoshi.service.manage.locality.AsProvinceService;
import com.github.pagehelper.PageHelper;

import net.sf.json.JSONArray;

/**
 * 控制层:
 * @author：wendy
 * @date：
 */
@Controller
@RequestMapping(value = "/consultationInfo")
public class ConsultationInfoController extends BaseController {
	
	// 发布资讯
	private static final String BASEURL = "/manage/consultationInfo/";

	@Autowired
	private AsConsultationInfoService asConsultationInfoService;

	@Autowired
	private AsProvinceService asProvinceService;
	@Autowired
	private AsCityService asCityService;
	@Autowired
	private AsAreaService asAreaService;
	
	/**
	 * 列表显示
	 * @param map
	 * @param page
	 * @param obj
	 * @return String
	 */
	@RequestMapping("list")
	public String list(ModelMap map, Page page, AsConsultationInfo obj) {
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);

		//搜索查询
		List<AsConsultationInfo> list = asConsultationInfoService.queryList(obj);
		page.setPage(list);
		map.put("list", list);
		
		List<AsConsultationType> typeList = asConsultationInfoService.selectByLevel(2); //资讯类型
		map.put("typeList", typeList); // 获取资讯类型
		map.put("typeListTwo", JSONArray.fromObject(asConsultationInfoService.selectByLevel(3)));//二级类型
		
		map.put("provinceList", asProvinceService.list(null));// 省
		map.put("cityList", JSONArray.fromObject(asCityService.list(null)));// 市
		map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));// 区域
		
		map.put("obj", obj);//回显历史搜索记录
		return BASEURL + "list";//列表层
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
			mv.addObject("typeListTwo", JSONArray.fromObject(asConsultationInfoService.selectByName("百科")));
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
	public ModelAndView saveAdd(AsConsultationInfo obj, String latlng,@RequestParam(value = "file",required = true) MultipartFile file, ModelMap map) {
		ModelAndView mv = this.getModelAndView();
		try {
			Date date = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			obj.setPublicTime(df.format(date));
			obj.setVisitCount(100);
			asConsultationInfoService.saveAdd(obj, latlng, file);
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
		return asConsultationInfoService.deleteByPrimaryKey(id);
	}
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll(String[] ids) {
		return asConsultationInfoService.deleteByIds(ids);
	}
	
	/**
	 * to-编辑页面
	 */
	@RequestMapping("toEdit")
	public String toEdit(Integer id, ModelMap map) {
		AsConsultationInfo asConsultationCity = asConsultationInfoService.selectByPrimaryKey(id);
		// 一级
		List<AsConsultationType> typeList = asConsultationInfoService.selectByLevel(2);
		map.put("typeList", typeList);
		// 二级
		map.put("typeListTwo", JSONArray.fromObject(asConsultationInfoService.selectByName("百科")));
		// 省份
		map.put("provinceList", asProvinceService.list(null));// 省
		map.put("cityList", JSONArray.fromObject(asCityService.selectAll()));// 市
		map.put("areaList", JSONArray.fromObject(asAreaService.selectAll()));// 区域
		
		// 数据-对象
		map.put("obj", asConsultationCity);
		map.put("latlng", asConsultationCity.getLat() + "," + asConsultationCity.getLng());// 经纬度
		return BASEURL + "edit";
	}
	
	
	/**
	 * to-预览页面
	 */
	@RequestMapping("toEditPreview")
	public String toEditPreview(Integer id, ModelMap map) {
		AsConsultationInfo asConsultationCity = asConsultationInfoService.selectByPrimaryKey(id);
		// 一级
		List<AsConsultationType> typeList = asConsultationInfoService.selectByLevel(2);
		map.put("typeList", typeList);
		// 二级
		map.put("typeListTwo", JSONArray.fromObject(asConsultationInfoService.selectByLevel(3)));
	    // 数据-对象
		map.put("obj", asConsultationCity);
		map.put("latlng", asConsultationCity.getLat() + "," + asConsultationCity.getLng());// 经纬度
		return BASEURL + "editPreview";
	}
	/**
	 * 保存编辑
	 */
	@RequestMapping(value = "saveEdit", method = RequestMethod.POST)
	public ModelAndView saveEdit(AsConsultationInfo obj, String latlng, String oldIamge) {
		ModelAndView mv = this.getModelAndView();
		try {
			if(obj.getAreaId()==null){
				//区域不选择就默认给0
				obj.setAreaId(0);
			}
			asConsultationInfoService.saveEdit(this.getPageData(), obj, latlng, oldIamge);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/*---------------------------------------other------------------------------------*/
	/**
	 * 发布
	 */
	@RequestMapping(value = "/onSale")
	@ResponseBody
	public int onSale(Integer id) {
		AsConsultationInfo obj = asConsultationInfoService.selectByPrimaryKey(id);
		obj.setStatus(2);
		Date date = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		obj.setPublicTime(df.format(date));
		return asConsultationInfoService.onSale(obj);
	}
	
	/**
	 * 下架
	 */
	@RequestMapping(value = "/offSale")
	@ResponseBody
	public int offSale(Integer id) {
		AsConsultationInfo obj = asConsultationInfoService.selectByPrimaryKey(id);
		obj.setStatus(3);
		return asConsultationInfoService.offSale(obj);
	}

	/**
	 * 批量下架
	 */
	@RequestMapping(value = "/offSaleAll")
	@ResponseBody
	public int offSaleAll(String[] ids) {
		return asConsultationInfoService.offSaleAll(ids);
	}

}
