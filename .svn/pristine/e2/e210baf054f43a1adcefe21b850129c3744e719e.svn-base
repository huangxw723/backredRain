package com.aoshi.controller.manage.consultation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsBusinessDistrict;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.domain.AsConsultationShopping;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.consultation.consultationInfo.AsShoppingService;
import com.aoshi.util.excel.ExcelTools;
import com.github.pagehelper.PageHelper;

/**
 * 逛街资讯
 * 
 * @author strong
 * @version 1.0 2016年11月30日下午3:01:45
 */
@Controller
@RequestMapping("shopping")
public class ShoppingController extends BaseController {

	@Autowired
	private AsShoppingService asShoppingService;

	private static final String SHOPPING_PATH = "/consultation/shopping/";

	// 资讯类型
	private static final String INFO_NAME = "逛街";

	// 品类id
	private static final Integer TYPE_ID = 7;

	/**
	 * excel导入
	 */
	@RequestMapping("importExcel")
	public String importDoc(MultipartFile excel, MultipartFile imgs) throws Exception {

		asShoppingService.importExcel(ExcelTools.readExcelTool(excel));
		return "redirect:cateList";
	}

	/**
	 * 预览
	 */
	@RequestMapping("preview")
	public String preview(ModelMap map, @RequestParam("id") Integer id, @RequestParam("typeId") Integer typeId) {
		AsConsultationShopping cate = this.asShoppingService.querySpotsById(id);
		if ((cate.getRoute().indexOf("地铁:") > -1) && (cate.getRoute().indexOf("公交:") > -1) ) {
			String metro = cate.getRoute().substring(3, cate.getRoute().indexOf(";公交:"));
			map.put("metro", metro);
			String bus = cate.getRoute().substring(cate.getRoute().indexOf("公交:"));
			map.put("bus", bus);
		} else {
			if (cate.getRoute().indexOf("地铁:") > -1) {
				String metro = cate.getRoute().substring(3);
				map.put("metro", metro);
			}else if(cate.getRoute().indexOf("公交:") > -1){
				String bus = cate.getRoute().substring(3);
				map.put("bus", bus);
			}
							
		}
		map.put("cate", cate);
		map.put("latlng", cate.getLng() + "," + cate.getLat());
		map.put("imgs", this.asShoppingService.queryImgs(id, typeId));
		return SHOPPING_PATH + "preview";
	}

	/**
	 * 显示下拉框选择
	 */
	@RequestMapping("shoppingRelease")
	public String queryshopping(ModelMap map) {
		map.put("provinceList", this.asShoppingService.queryPro());
		map.put("foodList", this.asShoppingService.queryFood(TYPE_ID));
		map.put("info", this.asShoppingService.queryType(INFO_NAME));
		return SHOPPING_PATH + "shoppingRelease";
	}

	/**
	 * 查询城市
	 */
	@RequestMapping("city")
	@ResponseBody
	public List<AsCity> queryCity(@RequestParam(value = "provinceId", required = false) Integer id, ModelMap map) {
		List<AsCity> list = this.asShoppingService.queryCity(id);
		map.put("msg", list);
		return list;
	}

	/**
	 * 查询区域
	 */
	@RequestMapping("area")
	@ResponseBody
	public List<AsArea> queryArea(@RequestParam(value = "cityId", required = false) Integer id, ModelMap map) {
		List<AsArea> list = this.asShoppingService.queryArea(id);
		map.put("msg", list);
		return list;
	}

	/**
	 * 查询商圈
	 */
	@RequestMapping("business")
	@ResponseBody
	public List<AsBusinessDistrict> queryBusiness(@RequestParam(value = "areaId", required = false) Integer id,
			ModelMap map) {
		List<AsBusinessDistrict> list = this.asShoppingService.queryBusiness(id);
		map.put("msg", list);
		return list;
	}

	/**
	 * 发布逛街资讯
	 */
	@RequestMapping("shoppingSave")
	public ModelAndView saveShopping(AsConsultationShopping spots, AsConsultationImgs asImgs, String latlng,
			ModelMap map, @RequestParam(value = "file", required = true) MultipartFile file,
			@RequestParam(value = "imgs", required = true) MultipartFile[] imgs,
			@RequestParam(value = "metro", required = false) String metro,
			@RequestParam(value = "bus", required = false) String bus) {
		this.asShoppingService.saveShopping(spots, latlng, file, imgs, asImgs, metro, bus);
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "success");
		mv.addObject("result", "保存成功!");
		mv.setViewName("consultation/result");
		return mv;
	}

	/**
	 * 查询逛街资讯
	 */
	@RequestMapping("cateList")
	public String queryAllCate(ModelMap map, Page page, AsConsultationShopping food) {
		// 分页
		PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
		List<AsConsultationShopping> list = this.asShoppingService.queryAllCate(food);
		page.setPage(list);
		map.put("provinceList", this.asShoppingService.queryPro());
		map.put("city", food.getCityId());
		if (food.getProvinceId() != null) {
			map.put("cityList", this.asShoppingService.queryCityList(food.getProvinceId()));
		}
		map.put("food", food);
		map.put("list", list);
		return SHOPPING_PATH + "list";
	}

	/**
	 * 根据id查询逛街资讯
	 */
	@RequestMapping("toEdit")
	public String querySpotsById(ModelMap map, @RequestParam("id") Integer id) {
		queryshopping(map);
		AsConsultationShopping cate = this.asShoppingService.querySpotsById(id);
		if ((cate.getRoute().indexOf("地铁:") > -1) && (cate.getRoute().indexOf("公交:") > -1) ) {
			String metro = cate.getRoute().substring(3, cate.getRoute().indexOf(";公交:"));
			map.put("metro", metro);
			String bus = cate.getRoute().substring(cate.getRoute().indexOf("公交:"));
			map.put("bus", bus);
		} else {
			if (cate.getRoute().indexOf("地铁:") > -1) {
				String metro = cate.getRoute().substring(3);
				map.put("metro", metro);
			}else if(cate.getRoute().indexOf("公交:") > -1){
				String bus = cate.getRoute().substring(3);
				map.put("bus", bus);
			}
							
		}
		map.put("cate", cate);
		map.put("latlng", cate.getLng() + "," + cate.getLat());
		return SHOPPING_PATH + "edit";
	}

	/**
	 * 修改逛街资讯
	 */
	@RequestMapping("cateEdit")
	public ModelAndView updateFood(AsConsultationShopping asConsultationFood, String latlng,
			@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam(value = "metro", required = false) String metro,
			@RequestParam(value = "bus", required = false) String bus) {
		asShoppingService.update(asConsultationFood, latlng, file, metro, bus);
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "success");
		mv.addObject("result", "修改成功!");
		mv.setViewName("consultation/result");
		return mv;

	}

	/**
	 * 根据id,type删除逛街资讯
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Map<String, Object> delete(Integer consultationShoppingId, Integer typeId) {
		int status = asShoppingService.delete(consultationShoppingId, typeId);
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("status", status);
		data.put("msg", "删除成功!");
		return data;
	}

	/**
	 * 更新状态
	 */
	@RequestMapping("/editStatus")
	@ResponseBody
	public Object editStatus(BaseController c) {
		return asShoppingService.editStatus(this);
	}

	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/deleteAll", method = RequestMethod.GET)
	@ResponseBody
	public Object deleteAll(String[] ids) {
		return asShoppingService.deleteByIds(ids);
	}

	/**
	 * 批量下架
	 */
	@RequestMapping(value = "/offSaleAll", method = RequestMethod.GET)
	@ResponseBody
	public int offSaleAll(String[] ids) {
		return asShoppingService.offSaleAll(ids);
	}

	/**
	 * 编辑逛街页面
	 * 
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping("toEditMeal")
	public String toEditMeal(Integer id, Integer typeId, ModelMap map) {
		map.put("imgs", this.asShoppingService.queryImgs(id, typeId));
		return SHOPPING_PATH + "mealEdit";
	}

	/**
	 * 跳转到编辑逛街图片
	 */
	@RequestMapping("toEditImg")
	public String toEdit(Integer id, ModelMap map) {
		map.put("imgs", this.asShoppingService.selectByPrimaryKey(id));
		return SHOPPING_PATH + "imgEdit";
	}

	/**
	 * 编辑逛街
	 */
	@RequestMapping("imgsEdit")
	@ResponseBody
	public Map<String, Object> update(AsConsultationImgs asConsultationImgs) {
		int result = asShoppingService.updateByPrimaryKeySelective(asConsultationImgs, this);
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
	public int del(ModelMap map, Integer id) {
		return asShoppingService.deleteByPrimaryKey(id);
	}

	/**
	 * 跳转到添加逛街页面
	 */
	@RequestMapping("toAddImg")
	public String toAdd(ModelMap map, String id) {
		map.put("img", asShoppingService.selectByPrimaryKey(Integer.parseInt(id)));
		return SHOPPING_PATH + "imgAdd";
	}

	/**
	 * 新增图片
	 */
	@RequestMapping("imgAdd")
	@ResponseBody
	public Map<String, Object> addImg(AsConsultationImgs asConsultationImgs) {
		int result = asShoppingService.addImg(asConsultationImgs, this);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("status", "0");
		map.put("msg", "操作成功！");
		return map;
	}

}
