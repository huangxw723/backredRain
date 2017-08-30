package com.aoshi.controller.manage.consultation.brand;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsBrand;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.consultation.brand.BrandCategoryService;
import com.aoshi.service.manage.consultation.brand.BrandService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("consultation/brand")
public class BrandController extends BaseController {
	private static final String BASEURL="consultation/brand/";

	@Autowired
	private BrandService brandService;
	@Autowired
	private BrandCategoryService brandCategoryService;
	
	/**
	 * 品牌列表
	 * @param map
	 * @return
	 */
	@RequestMapping("brandList")
	public String tagList(ModelMap map, Page page,
						  @RequestParam(value="keyWord",required=false)String keyWord){
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);

		AsBrand asBrand = new AsBrand();
		if(!StringUtils.isEmpty(keyWord)){
			asBrand.setBrandName(keyWord);
		}
		List<AsBrand> list = brandService.queryList(asBrand);
		page.setPage(list);
		map.put("list", list);
		map.put("keyWord", keyWord);

		return BASEURL+"brandList";
	}

	/**@author
	 * 去增品牌页面
	 * @param map
	 * @return
	 */
	@RequestMapping(value="toAddBrand")
	public String toAddBrand(ModelMap map){
//		List<AsYpBaseCategory> ypBaseCategoryList = brandCategoryService.getfoodCategoriesShow();
		List<AsYpBaseCategory> ypBaseCategoryList = brandCategoryService.getCategoriesShow();
		map.put("ypBaseCategoryList", ypBaseCategoryList);
		return BASEURL+"addBrand";
	}


	/**
	 * 新增品牌
	 * @param asBrand
	 * @return
	 */
	@RequestMapping("addBrand")
	@ResponseBody
	public Map<String, Object> addbrand(AsBrand asBrand){
		int result = brandService.save(asBrand,this);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("status", "0");
		map.put("msg", "操作成功！");
		return map;
	}

	/**
	 * 批量删除品牌
	 */
	@RequestMapping(value = "/deleteAllBrand")
	@ResponseBody
	public Object deleteAllBrand(ModelMap map,String []ids) {
        return brandService.deleteByBrandIds(ids);
	}

    /**
     * 删除品牌
     */
    @RequestMapping(value = "/deleteBrandById")
    @ResponseBody
    public int deleteBrandById(ModelMap map,Integer brandId) {
        return brandService.deleteByPrimaryKey(brandId);
    }


    /**
     * 编辑品牌页面
     * @param brandId
     * @param map
     * @return
     */
    @RequestMapping("toEditBrand")
    public String toEditBrand(Integer brandId,ModelMap map,String action,String otype){
        AsBrand asBrand = brandService.selectByPrimaryKey(brandId);
//		List<AsYpBaseCategory> ypBaseCategoryList = brandCategoryService.getfoodCategoriesShow();
		List<AsYpBaseCategory> ypBaseCategoryList = brandCategoryService.getCategoriesShow();
		map.put("ypBaseCategoryList", ypBaseCategoryList);
        map.put("asBrand", asBrand);
        map.put("action", action);
        map.put("otype", otype);
        return BASEURL+"editBrand";
    }

    /**
     * 更新品牌
     * @param asBrand
     * @return
     */
    @RequestMapping("updateBrand")
	@ResponseBody
    public Map updateBrand(AsBrand asBrand){
        int result = brandService.updateByPrimaryKeySelective(asBrand,this);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("status", "0");
		map.put("msg", "操作成功！");
		return map;
    }
}
