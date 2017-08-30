package com.aoshi.controller.manage.consultation.navigation;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsConsultationNavigationMapper;
import com.aoshi.dao.AsYpBaseCategoryMapper;
import com.aoshi.domain.AsConsultationNavigation;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.locality.AsAreaService;
import com.aoshi.service.manage.locality.AsBusinessDistrictService;
import com.aoshi.service.manage.locality.AsCityService;
import com.aoshi.service.manage.locality.AsProvinceService;
import com.aoshi.service.manage.navigation.NavigationStoreService;
import com.github.pagehelper.PageHelper;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("consultation/navigation")
public class NavigationController extends BaseController {
	private static final String BASEURL="consultation/navigation/";
	@Autowired
	private AsConsultationNavigationMapper mapper;
	@Autowired
	AsYpBaseCategoryMapper asYpBaseCategoryMapper;
	@Autowired
	private AsProvinceService asProvinceService;
	@Autowired
	private AsCityService asCityService;
	@Autowired
	private AsAreaService asAreaService;
	@Autowired
	private AsBusinessDistrictService asBusinessDistrictService;
	@Autowired
	private NavigationStoreService navigationStoreService;

	/**
	 * 去管理总页面\
	 */
	@RequestMapping(value = "/navigationTabList")
	public ModelAndView goList() {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("consultation/navigation/navigationTabList");
		return mv;
	}

	/**
	 * 商场导航列表
	 * @param map
	 * @return
	 */
	@RequestMapping("storeList")
	public String storeList(ModelMap map, Page page){
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);
		List<AsConsultationNavigation> list = mapper.selectAllStore();
		page.setPage(list);
		map.put("list", list);
		map.put("type", 1);
		return BASEURL+"navigationStoreList";
	}

	/**
	 * 店铺导航列表
	 * @param map
	 * @return
	 */
	@RequestMapping("shopList")
	public String shopList(ModelMap map, Page page){
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);
		List<AsConsultationNavigation> list = mapper.selectAllShop();
		page.setPage(list);
		map.put("list", list);
		map.put("type", 0);
		return BASEURL+"navigationShopList";
	}

	/**@author
	 * 去增商场或者店铺导航
	 * @param map
	 * @return
	 */
	@RequestMapping(value="toAddStoreOrShop")
	public String toAddStoreOrShop(ModelMap map,String type){
		map.put("type", type);
		map.put("provinceList", asProvinceService.list(null));//省
		map.put("cityList", JSONArray.fromObject(asCityService.list(null)));//市
		map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));//区域
		map.put("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));//商圈
		if("1".equals(type)){
			//商场
			List<AsYpBaseCategory> list =asYpBaseCategoryMapper.getmarketCategoriesShow();
			map.put("ypBaseCategoryList", list);
			return BASEURL+"addNavigationStore";
		}else {
			//店铺
			List<AsYpBaseCategory> list =asYpBaseCategoryMapper.getshopCategoriesShow();
			map.put("ypBaseCategoryList", list);
			return BASEURL+"addNavigationShop";
		}
	}


	/**
	 * 新增商场或者店铺导航
	 * @param asConsultationNavigation
	 * @return
	 */
	@RequestMapping("addNavigationStore")
	@ResponseBody
	public Map<String, Object> addNavigationStore(AsConsultationNavigation asConsultationNavigation){
		int result = navigationStoreService.save(asConsultationNavigation,this);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("status", "0");
		map.put("msg", "操作成功！");
		return map;
	}


	/**
	 * 删除商场导航
	 */
	@RequestMapping(value = "/delNavigationStore")
	@ResponseBody
	public int delNavigationStore(Integer id) {
		return mapper.deleteByPrimaryKey(id);
	}

	/**
	 * 编辑商场或者店铺导航
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping("toEditStore")
	public String toEditStore(Integer id,ModelMap map,String type){
		AsConsultationNavigation asConsultationNavigation = mapper.selectById(id);
		map.put("provinceList", asProvinceService.list(null));//省
		map.put("cityList", JSONArray.fromObject(asCityService.list(null)));//市
		map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));//区域
		map.put("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));//商圈
		map.put("asConsultationNavigation", asConsultationNavigation);
		map.put("latlng",asConsultationNavigation.getLng()+","+asConsultationNavigation.getLat());//经纬度
		if("1".equals(type)){
			//商场
			List<AsYpBaseCategory> list =asYpBaseCategoryMapper.getmarketCategoriesShow();
			map.put("ypBaseCategoryList", list);
			return BASEURL+"editNavigationStore";
		}else {
			//店铺
			List<AsYpBaseCategory> list =asYpBaseCategoryMapper.getshopCategoriesShow();
			map.put("ypBaseCategoryList", list);
			return BASEURL+"editNavigationShop";
		}
	}

	/**
	 * 更新商场导航
	 * @param asConsultationNavigation
	 * @return
	 */
	@RequestMapping("updateStore")
	@ResponseBody
	public Map updateStore(AsConsultationNavigation asConsultationNavigation,String latlng){
		int result = navigationStoreService.updateByPrimaryKeySelective(asConsultationNavigation,this,latlng);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("status", "0");
		map.put("msg", "操作成功！");
		return map;
	}

}
