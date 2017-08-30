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
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsConsultationFood;
import com.aoshi.domain.AsConsultationShopping;
import com.aoshi.domain.AsConsultationSpots;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.consultation.consultationInfo.AsSpotsService;
import com.aoshi.util.excel.ExcelTools;
import com.github.pagehelper.PageHelper;

/**
 * 景点发布
 * 
 * @author strong
 * @version 1.0 2016年11月30日下午1:42:17
 */
@Controller
@RequestMapping("spots")
public class SpotsController extends BaseController {

	@Autowired
	private AsSpotsService asSpotsService;

	private static final String SPOTS_PATH = "/consultation/spots/";

	// 资讯类型
	private static final String INFO_NAME = "景点";

	/**
	 * excel导入
	 */
	@RequestMapping("importExcel")
	public String importDoc(MultipartFile excel, MultipartFile imgs) throws Exception {

		asSpotsService.importExcel(ExcelTools.readExcelTool(excel));
		return "redirect:cateList";
	}

	/**
	 * 预览
	 */
	@RequestMapping("preview")
	public String preview(ModelMap map, @RequestParam("id") Integer id, @RequestParam("typeId") Integer typeId) {
		AsConsultationSpots cate = this.asSpotsService.querySpotsById(id);
		if ((cate.getLine().indexOf("地铁:") > -1) && (cate.getLine().indexOf("公交:") > -1) ) {
			String metro = cate.getLine().substring(3, cate.getLine().indexOf(";公交:"));
			map.put("metro", metro);
			String bus = cate.getLine().substring(cate.getLine().indexOf("公交:"));
			map.put("bus", bus);
		} else {
			if (cate.getLine().indexOf("地铁:") > -1) {
				String metro = cate.getLine().substring(3);
				map.put("metro", metro);
			}else if(cate.getLine().indexOf("公交:") > -1){
				String bus = cate.getLine().substring(3);
				map.put("bus", bus);
			}
							
		}
		map.put("cate", cate);
		map.put("latlng", cate.getLng() + "," + cate.getLat());
		map.put("imgs", this.asSpotsService.queryImgs(id, typeId));
		return SPOTS_PATH + "preview";
	}

	/**
	 * 显示下拉框选择
	 */
	@RequestMapping("spotsRelease")
	public String querySpots(ModelMap map) {
		map.put("provinceList", this.asSpotsService.queryPro());
		map.put("foodList", this.asSpotsService.queryFood());
		map.put("info", this.asSpotsService.queryType(INFO_NAME));
		return SPOTS_PATH + "spotsRelease";
	}

	/**
	 * 查询城市
	 */
	@RequestMapping("city")
	@ResponseBody
	public List<AsCity> queryCity(@RequestParam(value = "provinceId", required = false) Integer id, ModelMap map) {
		List<AsCity> list = this.asSpotsService.queryCity(id);
		map.put("msg", list);
		return list;
	}

	/**
	 * 查询区域
	 */
	@RequestMapping("area")
	@ResponseBody
	public List<AsArea> queryArea(@RequestParam(value = "cityId", required = false) Integer id, ModelMap map) {
		List<AsArea> list = this.asSpotsService.queryArea(id);
		map.put("msg", list);
		return list;
	}

	/**
	 * 发布景点资讯
	 */
	@RequestMapping("spotsSave")
	public ModelAndView saveSpots(AsConsultationSpots spots, AsConsultationImgs asImgs, String latlng, ModelMap map,
			@RequestParam(value = "file", required = true) MultipartFile file,
			@RequestParam(value = "imgs", required = true) MultipartFile[] imgs,
			@RequestParam(value = "metro", required = false) String metro,
			@RequestParam(value = "bus", required = false) String bus) {
		this.asSpotsService.saveSpots(spots, latlng, file, imgs, asImgs, metro, bus);
		ModelAndView mv = this.getModelAndView();
		mv.addObject("msg", "success");
		mv.addObject("result", "保存成功！");
		mv.setViewName("consultation/result");
		return mv;
	}

	/**
	 * 查询景点资讯
	 */
	@RequestMapping("cateList")
	public String queryAllCate(ModelMap map, Page page, AsConsultationSpots food) {
		// 分页
		PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
		List<AsConsultationSpots> list = this.asSpotsService.queryAllCate(food);
		page.setPage(list);
		map.put("provinceList", this.asSpotsService.queryPro());
		map.put("city", food.getCityId());
		if (food.getProvinceId() != null) {
			map.put("cityList", this.asSpotsService.queryCityList(food.getProvinceId()));
		}
		map.put("food", food);
		map.put("list", list);
		return SPOTS_PATH + "list";
	}

	/**
	 * 根据id查询景点资讯
	 */
	@RequestMapping("toEdit")
	public String querySpotsById(ModelMap map, @RequestParam("id") Integer id) {
		querySpots(map);
		AsConsultationSpots cate = this.asSpotsService.querySpotsById(id);
		if ((cate.getLine().indexOf("地铁:") > -1) && (cate.getLine().indexOf("公交:") > -1) ) {
			String metro = cate.getLine().substring(3, cate.getLine().indexOf(";公交:"));
			map.put("metro", metro);
			String bus = cate.getLine().substring(cate.getLine().indexOf("公交:"));
			map.put("bus", bus);
		} else {
			if (cate.getLine().indexOf("地铁:") > -1) {
				String metro = cate.getLine().substring(3);
				map.put("metro", metro);
			}else if(cate.getLine().indexOf("公交:") > -1){
				String bus = cate.getLine().substring(3);
				map.put("bus", bus);
			}
							
		}
		map.put("cate", cate);
		map.put("latlng", cate.getLng() + "," + cate.getLat());
		return SPOTS_PATH + "edit";
	}

	/**
	 * 修改景点资讯
	 */
	@RequestMapping("cateEdit")
	public ModelAndView updateFood(AsConsultationSpots asConsultationFood, String latlng,
			@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam(value = "metro", required = false) String metro,
			@RequestParam(value = "bus", required = false) String bus) {
		asSpotsService.update(asConsultationFood, latlng, file, metro, bus);
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
	public Map<String, Object> delete(Integer consultationSpotsId, Integer typeId) {
		int status = asSpotsService.delete(consultationSpotsId, typeId);
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
		return asSpotsService.editStatus(this);
	}

	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/deleteAll", method = RequestMethod.GET)
	@ResponseBody
	public Object deleteAll(String[] ids) {
		return asSpotsService.deleteByIds(ids);
	}

	/**
	 * 批量下架
	 */
	@RequestMapping(value = "/offSaleAll", method = RequestMethod.GET)
	@ResponseBody
	public int offSaleAll(String[] ids) {
		return asSpotsService.offSaleAll(ids);
	}

	/**
	 * 编辑宣传页面
	 * 
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping("toEditMeal")
	public String toEditMeal(Integer id, Integer typeId, ModelMap map) {
		map.put("imgs", this.asSpotsService.queryImgs(id, typeId));
		return SPOTS_PATH + "mealEdit";
	}

	/**
	 * 跳转到编辑宣传图片
	 */
	@RequestMapping("toEditImg")
	public String toEdit(Integer id, ModelMap map) {
		map.put("imgs", this.asSpotsService.selectByPrimaryKey(id));
		return SPOTS_PATH + "imgEdit";
	}

	/**
	 * 编辑宣传
	 */
	@RequestMapping("imgsEdit")
	@ResponseBody
	public Map update(AsConsultationImgs asConsultationImgs) {
		int result = asSpotsService.updateByPrimaryKeySelective(asConsultationImgs, this);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("status", "0");
		map.put("msg", "操作成功！");
		return map;
	}

	/**
	 * 删除宣传图片
	 */
	@RequestMapping("deleteImg")
	@ResponseBody
	public int del(ModelMap map, Integer id) {
		return asSpotsService.deleteByPrimaryKey(id);
	}

	/**
	 * 跳转到添加宣传页面
	 */
	@RequestMapping("toAddImg")
	public String toAdd(ModelMap map, String id) {
		map.put("img", asSpotsService.selectByPrimaryKey(Integer.parseInt(id)));
		return SPOTS_PATH + "imgAdd";
	}

	/**
	 * 新增图片
	 */
	@RequestMapping("imgAdd")
	@ResponseBody
	public Map<String, Object> addImg(AsConsultationImgs asConsultationImgs) {
		int result = asSpotsService.addImg(asConsultationImgs, this);
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("status", "0");
		map.put("msg", "操作成功！");
		return map;
	}

}
