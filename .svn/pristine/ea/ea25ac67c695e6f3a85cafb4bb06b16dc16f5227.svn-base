package com.aoshi.controller.manage.consultation;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsConsultationHotel;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.domain.AsConsultationType;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.consultation.brand.BrandCategoryService;
import com.aoshi.service.manage.consultation.brand.BrandService;
import com.aoshi.service.manage.consultation.consultationInfo.AsConsultationHotelService;
import com.aoshi.service.manage.consultation.consultationInfo.AsConsultationInfoService;
import com.aoshi.service.manage.locality.AsAreaService;
import com.aoshi.service.manage.locality.AsBusinessDistrictService;
import com.aoshi.service.manage.locality.AsCityService;
import com.aoshi.service.manage.locality.AsProvinceService;
import com.github.pagehelper.PageHelper;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 控制层:
 * @author：wendy
 * @date：
 */
@Controller
@RequestMapping(value = "/consultationHotel")
public class AsConsultationHotelController extends BaseController {
	
	private static final String BASEURL = "/manage/consultationHotel/";
	
	@Autowired
    private  AsConsultationHotelService  asConsultationHotelService;
	
	@Autowired
	private BrandService brandService;
	@Autowired
	private AsConsultationInfoService asConsultationInfoService;
	@Autowired
	private AsBusinessDistrictService asBusinessDistrictService;
    @Autowired
    private AsProvinceService asProvinceService;
    @Autowired
    private AsCityService asCityService;
    @Autowired
    private AsAreaService asAreaService;
	@Autowired
	private BrandCategoryService brandCategoryService;

    /**
	 * 列表显示
	 * @param map
	 * @param page
	 * @param obj
	 * @return String
	 */
	@RequestMapping("list")
	public String list(ModelMap map, Page page, AsConsultationHotel obj) {
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);

		//搜索查询
		List<AsConsultationHotel> list = asConsultationHotelService.queryList(obj);
		page.setPage(list);
		map.put("list", list);
		
		List<AsConsultationType> typeList = asConsultationInfoService.selectByLevel(2); //资讯类型
		map.put("typeList", typeList); // 获取资讯类型
		
		map.put("provinceList", asProvinceService.list(null));// 省
		map.put("cityList", JSONArray.fromObject(asCityService.list(null)));// 市
		
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
			List<AsConsultationType> list = asConsultationHotelService.selectByName("酒店");
			mv.addObject("typeListOne", list);
			// 省份
			mv.addObject("provinceList", asProvinceService.list(null));// 省
			mv.addObject("cityList", JSONArray.fromObject(asCityService.selectAll()));// 市
			mv.addObject("areaList", JSONArray.fromObject(asAreaService.selectAll()));// 区域
			mv.addObject("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));// 商圈
			mv.addObject("brandList",brandCategoryService.getHotelListShow());//品牌
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	/**
	 * 保存新增
	 */
	@RequestMapping(value = "/saveAdd", method = RequestMethod.POST)
	public ModelAndView saveAdd(AsConsultationHotel obj, String latlng,@RequestParam(value = "file",required = true) MultipartFile file, ModelMap map
			,@RequestParam(value="imgs",required=true) MultipartFile[] imgs
			,AsConsultationImgs asImgs) {
		ModelAndView mv = this.getModelAndView();
		try {
			Date date = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			obj.setPublicTime(df.format(date));
			obj.setVisitCount(100);
			obj.setCreateTime(df.format(date));
			asConsultationHotelService.saveAdd(obj, latlng, file,imgs,asImgs);
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
	public int delete(Integer id,Integer typeId) {
		return asConsultationHotelService.deleteByPrimaryKey(id,typeId);
	}
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll(String[] ids) {
		return asConsultationHotelService.deleteByIds(ids);
	}
	
	/**
	 * to-编辑页面
	 */
	@RequestMapping("toEdit")
	public String toEdit(Integer id, ModelMap map) {
		AsConsultationHotel asConsultationCity = asConsultationHotelService.selectByPrimaryKey(id);
		List<AsConsultationType> list = asConsultationHotelService.selectByName("酒店");
		map.put("typeListOne", list);	
		// 省份
		map.put("provinceList", asProvinceService.list(null));// 省
		map.put("cityList", JSONArray.fromObject(asCityService.selectAll()));// 市
		map.put("areaList", JSONArray.fromObject(asAreaService.selectAll()));// 区域
		map.put("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));// 商圈
		map.put("brandList",brandCategoryService.getHotelListShow());//品牌
		
		// 数据-对象
		map.put("obj", asConsultationCity);
		map.put("latlng", asConsultationCity.getLat() + "," + asConsultationCity.getLng());// 经纬度
		return BASEURL + "edit";
	}
	

	
	/**
	 * 保存编辑
	 */
	@RequestMapping(value = "saveEdit", method = RequestMethod.POST)
	public ModelAndView saveEdit(AsConsultationHotel obj, @RequestParam String latlng, @RequestParam MultipartFile file) {
		ModelAndView mv = this.getModelAndView();
		try {
			if(obj.getAreaId()==null){
				//区域不选择就默认给0
				obj.setAreaId(0);
			}
			asConsultationHotelService.saveEdit(obj, latlng, file);
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
		AsConsultationHotel asConsultationCity = asConsultationHotelService.selectByPrimaryKey(id);
		// 一级
		List<AsConsultationType> typeList = asConsultationInfoService.selectByLevel(2);
		map.put("typeList", typeList);
		// 二级
		map.put("typeListTwo", JSONArray.fromObject(asConsultationInfoService.selectByLevel(3)));
		// 省份
		map.put("provinceList", asProvinceService.list(null));// 省
		map.put("cityList", JSONArray.fromObject(asCityService.list(null)));// 市
		map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));// 区域
		map.put("districtList",JSONArray.fromObject(asBusinessDistrictService.list(null)));//商圈
		map.put("brandList",brandService.queryList(null));//品牌
		
		// 数据-对象
		map.put("obj", asConsultationCity);
		map.put("latlng", asConsultationCity.getLat() + "," + asConsultationCity.getLng());// 经纬度
		return BASEURL + "editPreview";
	}
	
	/*---------------------------------------other------------------------------------*/
	/**
	 * 发布
	 */
	@RequestMapping(value = "/onSale")
	@ResponseBody
	public int onSale(Integer id) {
		AsConsultationHotel obj = asConsultationHotelService.selectByPrimaryKey(id);
		obj.setStatus(2);
		Date date = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		obj.setPublicTime(df.format(date));
		return asConsultationHotelService.onSale(obj);
	}
	
	/**
	 * 下架
	 */
	@RequestMapping(value = "/offSale")
	@ResponseBody
	public int offSale(Integer id) {
		AsConsultationHotel obj = asConsultationHotelService.selectByPrimaryKey(id);
		obj.setStatus(3);
		return asConsultationHotelService.offSale(obj);
	}

	/**
	 * 批量下架
	 */
	@RequestMapping(value = "/offSaleAll")
	@ResponseBody
	public int offSaleAll(String[] ids) {
		return asConsultationHotelService.offSaleAll(ids);
	}
	
	/*---------------------------------------other------------------------------------*/
	/**
     * 编辑逛街页面
     * @param id
     * @param map
     * @return
     */
    @RequestMapping("toEditMealHote")
    public String toEditMealHote(Integer id,ModelMap map,Integer typeId){
		List<AsConsultationImgs> imgs = this.asConsultationHotelService.queryImgs(id,typeId);
		map.put("imgs", imgs);
		map.put("consultationId", id);
		map.put("typeId", typeId);
        return BASEURL + "mealEditHote";
    }
	
	/**
	 * 跳转到添加逛街页面
	 */
	@RequestMapping("toAddImg")
	  public String toAdd(ModelMap map,String id,Integer typeId ){
		map.put("consultationId", id);
		map.put("typeId", typeId);
        return BASEURL+"imgAddHote";
    }
	
	/**
	 * 新增图片
	 */
	@RequestMapping("imgAddHote")
    @ResponseBody
    public Map<String, Object> addImg(AsConsultationImgs asConsultationImgs){
        int result = asConsultationHotelService.addImg(asConsultationImgs,this);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }
	
	  /**
	    * 跳转到编辑逛街图片
	    */
		@RequestMapping("toEditImg")  
	    public String toEditImg(Integer id,ModelMap map){        
	        map.put("imgs", this.asConsultationHotelService.selectByPrimaryKey(id));
	        return BASEURL+"imgEdit";
	    }
	
	/**
	 * 编辑逛街
	 */
	@RequestMapping("imgsEdit")
    @ResponseBody
    public Map update(AsConsultationImgs asConsultationImgs){
        int result = asConsultationHotelService.updateByPrimaryKeySelective(asConsultationImgs,this);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }
	/**
	 * 删除逛街图片
	 */
	@RequestMapping("deleteImg")
	@ResponseBody
	public int del(ModelMap map,Integer id) {
        return asConsultationHotelService.deleteByPrimaryKeys(id);
    }
}
