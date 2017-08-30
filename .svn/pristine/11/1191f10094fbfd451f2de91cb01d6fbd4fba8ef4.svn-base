package com.aoshi.controller.manage.consultation.brand;

import com.aoshi.common.asenum.ConsultationCategoryTypeEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.consultation.brand.BrandCategoryService;
import com.github.pagehelper.PageHelper;
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
@RequestMapping("consultation/brandCategory")
public class BrandCategoryController extends BaseController {
	private static final String BASEURL="consultation/brandCategory/";

	@Autowired
	private BrandCategoryService brandCategoryService;

	/**
	 * 去管理总页面
	 */
	@RequestMapping(value = "/brandTabList")
	public ModelAndView goList() {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("consultation/brandCategory/brandTabList");
		return mv;
	}

	/**
	 * 全部的美食品类列表
	 * @param map
	 * @return
	 */
	@RequestMapping("brandFoodCategoryList")
	public String brandFoodCategoryList(ModelMap map, Page page,String type){
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);
		List<AsYpBaseCategory> list = brandCategoryService.getfoodCategories();
		page.setPage(list);
		map.put("list", list);
		map.put("type", type);
		return BASEURL+"brandCategoryList";
	}

	/**
	 * 逛街分类列表
	 * @param map
	 * @return
	 */
	@RequestMapping("brandShoppingCategoryList")
	public String brandShoppingCategoryList(ModelMap map, Page page,String type){
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);
		List<AsYpBaseCategory> list = brandCategoryService.getshoppingCategories();
		page.setPage(list);
		map.put("list", list);
		map.put("type", type);
		return BASEURL+"brandShoppingCategoryList";
	}

	/**
	 * 商场分类列表
	 * @param map
	 * @return
	 */
	@RequestMapping("marketCategoryList")
	public String marketCategoryList(ModelMap map, Page page,String type){
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);
		List<AsYpBaseCategory> list = brandCategoryService.getmarketCategories();
		page.setPage(list);
		map.put("list", list);
		map.put("type", type);
		return BASEURL+"marketCategoryList";
	}

	/**
	 * 店铺分类列表
	 * @param map
	 * @return
	 */
	@RequestMapping("shopCategoryList")
	public String shopCategoryList(ModelMap map, Page page,String type){
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);
		List<AsYpBaseCategory> list = brandCategoryService.getshopCategories();
		page.setPage(list);
		map.put("list", list);
		map.put("type", type);
		return BASEURL+"shopCategoryList";
	}

	/**
	 * 菜式分类列表
	 * @param map
	 * @return
	 */
	@RequestMapping("dishesList")
	public String dishesList(ModelMap map, Page page,String type){
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);
		List<AsYpBaseCategory> list = brandCategoryService.getdishesList();
		page.setPage(list);
		map.put("list", list);
		map.put("type", type);
		return BASEURL+"dishesList";
	}

    /**
     * 酒店品牌分类列表
     * @param map
     * @return
     */
    @RequestMapping("hotelList")
    public String hotelList(ModelMap map, Page page,String type){
        int pageNum = page.getCurrentPage();
        int pageSize = page.getShowCount();
        PageHelper.startPage(pageNum, pageSize);
        List<AsYpBaseCategory> list = brandCategoryService.getHotelList();
        page.setPage(list);
        map.put("list", list);
        map.put("type", type);
        return BASEURL+"hotelList";
    }


	/**@author
	 * 去增美食品类页面
	 * @param map
	 * @return
	 */
	@RequestMapping(value="toAddBrandFoodCategory")
	public String toAddBrandCategory(ModelMap map,String type){
		map.put("type", type);
		if(null!=type && !type.isEmpty() && type.equals(String.valueOf(ConsultationCategoryTypeEnum.DELICIOUS_FOOD_TYPE.getId()))){
			return BASEURL+"addBrandFoodCategory";
		}else if(null!=type && !type.isEmpty() && type.equals(String.valueOf(ConsultationCategoryTypeEnum.SHOPPING_CLASSIFICATION_TYPE.getId()))){
			return BASEURL+"addBrandShoppingCategory";
		}else if(null!=type && !type.isEmpty() && type.equals(String.valueOf(ConsultationCategoryTypeEnum.Marketing_CLASSIFICATION_TYPE.getId()))){
			return BASEURL+"addmarketCategory";
		}else if(null!=type && !type.isEmpty() && type.equals(String.valueOf(ConsultationCategoryTypeEnum.SHOP_CLASSIFICATION_TYPE.getId()))){
			return BASEURL+"addShopCategory";
		}else if(null!=type && !type.isEmpty() && type.equals(String.valueOf(ConsultationCategoryTypeEnum.DISHES_TYPE.getId()))){
			return BASEURL +"addDishes";
		}else {
            return BASEURL +"addHotel";
        }

	}


	/**
	 * 新增美食品类和逛街分类
	 * @param asYpBaseCategory
	 * @return
	 */
	@RequestMapping("addBrandFoodCategory")
	@ResponseBody
	public Map<String, Object> addBrandFoodCategory(AsYpBaseCategory asYpBaseCategory,String type){
		int result = brandCategoryService.save(asYpBaseCategory,type);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("status", "0");
		map.put("msg", "操作成功！");
		return map;
	}


	/**
	 * 删除美食品类
	 */
	@RequestMapping(value = "/deleteCategory")
	@ResponseBody
	public int deleteCategory(Integer id) {
		return brandCategoryService.deleteByPrimaryKey(id);
	}

	/**
	 * 编辑美食品类
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping("toEditCategory")
	public String toEditCategory(Integer id,ModelMap map){
		AsYpBaseCategory asYpBaseCategory = brandCategoryService.selectById(id);
		map.put("asYpBaseCategory", asYpBaseCategory);
		return BASEURL+"editBrandFoodCategory";
	}

	/**
	 * 更新美食品类
	 * @param asYpBaseCategory
	 * @return
	 */
	@RequestMapping("updateBrandCategory")
	@ResponseBody
	public Map updateBrandCategory(AsYpBaseCategory asYpBaseCategory){
		int result = brandCategoryService.updateByPrimaryKeySelective(asYpBaseCategory);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("status", "0");
		map.put("msg", "操作成功！");
		return map;
	}
}
