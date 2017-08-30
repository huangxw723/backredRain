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
import com.aoshi.domain.AsConsultationFood;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.consultation.consultationInfo.AsCateService;
import com.aoshi.util.excel.ExcelTools;
import com.github.pagehelper.PageHelper;

/**
 * 美食发布
 * 
 * @author strong
 * @version 1.0 2016年11月29日上午9:59:25
 */
@Controller
@RequestMapping("cate")
public class CateController extends BaseController {

	@Autowired
	private AsCateService asCateService;

	private static final String CATE_PATH = "/consultation/cate/";

	// 资讯类型
	private static final String INFO_NAME = "美食";

	// 品类id
	private static final Integer TYPE_ID = 6;

	/**
	 * excel跳转
	 */
	@RequestMapping("toExcel")
	public String importDoc() {
		return CATE_PATH + "excel";
	}

	/**
	 * excel导入
	 */
	@RequestMapping("importExcel")
	public ModelAndView importDoc(MultipartFile excel, MultipartFile imgs) throws Exception {
		asCateService.importExcel(ExcelTools.readExcelTool(excel), ExcelTools.readExcelTool(imgs));
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "success");
		mv.addObject("result", "导入成功!");
		mv.setViewName("consultation/result");
		return mv;
	}

	/**
	 * 预览
	 */
	@RequestMapping("preview")
	public String preview(ModelMap map, @RequestParam("id") Integer id, @RequestParam("typeId") Integer typeId) {
		AsConsultationFood cate = this.asCateService.queryCateById(id);
		map.put("cate", cate);
		map.put("latlng", cate.getLng() + "," + cate.getLat());
		map.put("imgs", this.asCateService.queryImgs(id, typeId));
		return CATE_PATH + "preview";
	}

	/**
	 * 显示下拉框选择
	 */
	@RequestMapping("cateRelease")
	public String queryCate(ModelMap map) {
		map.put("provinceList", this.asCateService.queryPro());
		map.put("info", this.asCateService.queryType(INFO_NAME));
		map.put("foodList", this.asCateService.queryFood(TYPE_ID));
		return CATE_PATH + "cateRelease";
	}

	/**
	 * 查询城市
	 */
	@RequestMapping("city")
	@ResponseBody
	public List<AsCity> queryCity(@RequestParam(value = "provinceId", required = false) Integer id, ModelMap map) {
		List<AsCity> list = this.asCateService.queryCity(id);
		map.put("msg", list);
		return list;
	}

	/**
	 * 查询区域
	 */
	@RequestMapping("area")
	@ResponseBody
	public List<AsArea> queryArea(@RequestParam(value = "cityId", required = false) Integer id, ModelMap map) {
		List<AsArea> list = this.asCateService.queryArea(id);
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
		List<AsBusinessDistrict> list = this.asCateService.queryBusiness(id);
		map.put("msg", list);
		return list;
	}

	/**
	 * 发布美食资讯
	 */
	@RequestMapping(value = "cateSave")

	public ModelAndView saveCate(AsConsultationFood food, AsConsultationImgs asImgs, String latlng,
			@RequestParam(value = "file", required = true) MultipartFile file,
			@RequestParam(value = "imgs", required = true) MultipartFile[] imgs) {
		asCateService.saveCate(food, latlng, file, imgs, asImgs);
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "success");
		mv.addObject("result", "添加成功!");
		mv.setViewName("consultation/result");
		return mv;

	}

	/**
	 * 查询美食资讯
	 */
	@RequestMapping("cateList")
	public String queryAllCate(ModelMap map, Page page, AsConsultationFood food) {
		// 分页
		PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
		List<AsConsultationFood> list = this.asCateService.queryAllCate(food);
		page.setPage(list);
		map.put("provinceList", this.asCateService.queryPro());
		map.put("city", food.getCityId());
		if (food.getProvinceId() != null) {
			map.put("cityList", this.asCateService.queryCityList(food.getProvinceId()));
		}
		map.put("food", food);
		map.put("list", list);
		return CATE_PATH + "cateList";
	}

	/**
	 * 根据id查询美食资讯
	 */
	@RequestMapping("toEdit")
	public String queryCateById(ModelMap map, @RequestParam("id") Integer id) {
		queryCate(map);
		AsConsultationFood cate = this.asCateService.queryCateById(id);
		map.put("cate", cate);
		map.put("latlng", cate.getLng() + "," + cate.getLat());
		return CATE_PATH + "cateEdit";
	}

	/**
	 * 修改美食资讯
	 */
	@RequestMapping("cateEdit")
	public ModelAndView updateFood(AsConsultationFood asConsultationFood, String latlng,
			@RequestParam(value = "file", required = false) MultipartFile file) {
		asCateService.update(asConsultationFood, latlng, file);
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "success");
		mv.addObject("result", "修改成功!");
		mv.setViewName("consultation/result");
		return mv;

	}

	/**
	 * 根据id和typeId删除美食资讯
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Map<String, Object> delete(Integer consultationFoodId, Integer typeId) {
		int status = asCateService.delete(consultationFoodId, typeId);
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
		return asCateService.editStatus(this);
	}

	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/deleteAll", method = RequestMethod.GET)
	@ResponseBody
	public Object deleteAll(String[] ids) {
		return asCateService.deleteByIds(ids);
	}

	/**
	 * 批量下架
	 */
	@RequestMapping(value = "/offSaleAll", method = RequestMethod.GET)
	@ResponseBody
	public int offSaleAll(String[] ids) {
		return asCateService.offSaleAll(ids);
	}

	/**
	 * 编辑菜式页面
	 * 
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping("toEditMeal")
	public String toEditMeal(Integer id, Integer typeId, ModelMap map) {
		map.put("imgs", this.asCateService.queryImgs(id, typeId));
		return CATE_PATH + "cateMealEdit";
	}

	/**
	 * 跳转到编辑菜式图片
	 */
	@RequestMapping("toEditImg")
	public String toEdit(Integer id, ModelMap map) {
		map.put("imgs", this.asCateService.selectByPrimaryKey(id));
		return CATE_PATH + "imgEdit";
	}

	/**
	 * 编辑菜式
	 */
	@RequestMapping("imgsEdit")
	@ResponseBody
	public Map<String, Object> update(AsConsultationImgs asConsultationImgs) {
		int result = asCateService.updateByPrimaryKeySelective(asConsultationImgs, this);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("status", "0");
		map.put("msg", "操作成功！");
		return map;
	}

	/**
	 * 删除菜式图片
	 */
	@RequestMapping("deleteImg")
	@ResponseBody
	public int del(ModelMap map, Integer id) {
		return asCateService.deleteByPrimaryKey(id);
	}

	/**
	 * 跳转到添加菜式页面
	 */
	@RequestMapping("toAddImg")
	public String toAdd(ModelMap map, String id) {
		map.put("img", asCateService.selectByPrimaryKey(Integer.parseInt(id)));
		return CATE_PATH + "imgAdd";
	}

	/**
	 * 新增图片
	 */
	@RequestMapping("imgAdd")
	@ResponseBody
	public Map<String, Object> addImg(AsConsultationImgs asConsultationImgs) {
		int result = asCateService.addImg(asConsultationImgs, this);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("status", "0");
		map.put("msg", "操作成功！");
		return map;
	}
}
