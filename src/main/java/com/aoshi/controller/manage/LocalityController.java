package com.aoshi.controller.manage;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsProvince;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.locality.AsAreaService;
import com.aoshi.service.manage.locality.AsCityService;
import com.aoshi.service.manage.locality.AsProvinceService;
import com.aoshi.util.AppUtil;
import com.aoshi.util.Const;
import com.aoshi.util.PageData;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 类名称：LocalityController 创建人：star 创建时间：2016-06-17
 */
@Controller
@RequestMapping(value = "/locality")
public class LocalityController extends BaseController {

	String menuUrl = "locality/localityList.do"; // 菜单地址(权限用)

	@Autowired
	private AsProvinceService asProvinceService;

	@Autowired
	private AsCityService asCityService;

	@Autowired
	private AsAreaService asAreaService;

	/**
	 * 去管理总页面
	 */
	@RequestMapping(value = "/localityList")
	public ModelAndView goList() {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("manage/locality/localityList");
		return mv;
	}

	/**
	 * 去新增省份页面
	 */
	@RequestMapping(value = "/goAddProvince")
	public ModelAndView goAddProvince() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("manage/locality/provinceEdit");
		mv.addObject("msg", "saveProvince");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 新增省份
	 */
	@RequestMapping(value = "/saveProvince")
	public ModelAndView saveProvince(AsProvince province) {
		ModelAndView mv = this.getModelAndView();
		try {
			asProvinceService.save(province);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 去修改省份页面
	 */
	@RequestMapping(value = "/goEditProvince")
	public ModelAndView goEditProvince(AsProvince province) {
		ModelAndView mv = this.getModelAndView();
		try {
			province = asProvinceService.findById(province); // 根据ID读取
			mv.setViewName("manage/locality/provinceEdit");
			mv.addObject("msg", "editProvince");
			mv.addObject("province", province);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 修改省份
	 */
	@RequestMapping(value = "/editProvince")
	public ModelAndView editProvince(AsProvince province) {
		ModelAndView mv = this.getModelAndView();
		try {
			asProvinceService.edit(province);
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
	@RequestMapping(value = "/deleteProvince")
	public void deleteProvince(PrintWriter out) {
		PageData pd = this.getPageData();
		try {
			asProvinceService.delete(pd.getInt("provinceId"));
			out.write("success");
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 省份列表页面
	 */
	@RequestMapping(value = "/provinceList")
	public ModelAndView provinceList(Page page) {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("manage/locality/provinceList");
		PageData pd = this.getPageData();
		try {
			page.setPd(pd);
			PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
			List<AsProvince> provinceList = asProvinceService.list(pd);
			PageInfo<AsProvince> pageInfo = new PageInfo<AsProvince>(provinceList);
			page.setEntityOrField(true);
			page.setTotalResult((int) pageInfo.getTotal());
			mv.addObject("provinceList", provinceList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 批量删除省份
	 */
	@RequestMapping(value = "/deleteAllProvince")
	@ResponseBody
	public Object deleteAllProvince() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String ids = pd.getString("ids");
			if (StringUtils.isNotBlank(ids)) {
				String provinceIds[] = ids.split(",");
				asProvinceService.deleteAll(provinceIds);
				map.put("msg", "ok");
			} else {
				map.put("msg", "no");
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 去新增城市页面
	 */
	@RequestMapping(value = "/goAddCity")
	public ModelAndView goAddCity() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try {
			List<AsProvince> provinceList = asProvinceService.list(null);
			mv.setViewName("manage/locality/cityEdit");
			mv.addObject("msg", "saveCity");
			mv.addObject("pd", pd);
			mv.addObject("provinceList", provinceList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}

	/**
	 * 新增城市
	 */
	@RequestMapping(value = "/saveCity")
	public ModelAndView saveCity(AsCity city) {
		ModelAndView mv = this.getModelAndView();
		try {
			asCityService.save(city);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 去修改城市页面
	 */
	@RequestMapping(value = "/goEditCity")
	public ModelAndView goEditCity(AsCity city) {
		ModelAndView mv = this.getModelAndView();
		try {
			List<AsProvince> provinceList = asProvinceService.list(null);
			city = asCityService.findById(city); // 根据ID读取
			mv.setViewName("manage/locality/cityEdit");
			mv.addObject("msg", "editCity");
			mv.addObject("city", city);
			mv.addObject("provinceList", provinceList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 修改城市
	 */
	@RequestMapping(value = "/editCity")
	public ModelAndView editCity(AsCity city) {
		ModelAndView mv = this.getModelAndView();
		try {
			asCityService.edit(city);
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
	@RequestMapping(value = "/deleteCity")
	public void deleteCity(PrintWriter out) {
		PageData pd = this.getPageData();
		try {
			asCityService.delete(pd.getInt("cityId"));
			out.write("success");
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 城市列表页面
	 */
	@RequestMapping(value = "/cityList")
	public ModelAndView cityList(Page page) {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("manage/locality/cityList");
		PageData pd = this.getPageData();
		try {
			page.setPd(pd);
			PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
			List<AsCity> cityList = asCityService.list(pd);
			PageInfo<AsCity> pageInfo = new PageInfo<AsCity>(cityList);
			page.setEntityOrField(true);
			page.setTotalResult((int) pageInfo.getTotal());
			mv.addObject("cityList", cityList);
			mv.addObject("pd", pd);
			mv.addObject("provinceList", asProvinceService.list(null));
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}





	/**
	 * 批量删除城市
	 */
	@RequestMapping(value = "/deleteAllCity")
	@ResponseBody
	public Object deleteAllCity() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String ids = pd.getString("ids");
			if (StringUtils.isNotBlank(ids)) {
				String cityIds[] = ids.split(",");
				asCityService.deleteAll(cityIds);
				map.put("msg", "ok");
			} else {
				map.put("msg", "no");
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 去新增县区页面
	 */
	@RequestMapping(value = "/goAddArea")
	public ModelAndView goAddArea() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try {
			List<AsProvince> provinceList = asProvinceService.list(null);
			List<AsCity> cityList = asCityService.list(null);
			JSONArray cityListJson = JSONArray.fromObject(cityList);
			mv.setViewName("manage/locality/areaEdit");
			mv.addObject("msg", "saveArea");
			mv.addObject("pd", pd);
			mv.addObject("provinceList", provinceList);
			mv.addObject("cityList", cityListJson);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}

	/**
	 * 新增县区
	 */
	@RequestMapping(value = "/saveArea")
	public ModelAndView saveArea(AsArea area) {
		ModelAndView mv = this.getModelAndView();
		try {
			asAreaService.save(area);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 去修改县区页面
	 */
	@RequestMapping(value = "/goEditArea")
	public ModelAndView goEditArea(AsArea area) {
		ModelAndView mv = this.getModelAndView();
		try {
			List<AsProvince> provinceList = asProvinceService.list(null);
			List<AsCity> cityList = asCityService.list(null);
			JSONArray cityListJson = JSONArray.fromObject(cityList);
			area = asAreaService.findById(area); // 根据ID读取
			mv.setViewName("manage/locality/areaEdit");
			mv.addObject("msg", "editArea");
			mv.addObject("area", area);
			mv.addObject("provinceList", provinceList);
			mv.addObject("cityList", cityListJson);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 修改县区
	 */
	@RequestMapping(value = "/editArea")
	public ModelAndView editArea(AsArea area) {
		ModelAndView mv = this.getModelAndView();
		try {
			asAreaService.edit(area);
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
	@RequestMapping(value = "/deleteArea")
	public void deleteArea(PrintWriter out) {
		PageData pd = this.getPageData();
		try {
			asAreaService.delete(pd.getInt("areaId"));
			out.write("success");
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 县区列表页面
	 */
	@RequestMapping(value = "/areaList")
	public ModelAndView areaList(Page page) {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("manage/locality/areaList");
		PageData pd = this.getPageData();
		try {
			page.setPd(pd);
			PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
			List<AsArea> areaList = asAreaService.list(pd);
			PageInfo<AsArea> pageInfo = new PageInfo<AsArea>(areaList);
			page.setEntityOrField(true);
			page.setTotalResult((int) pageInfo.getTotal());
			mv.addObject("areaList", areaList);
			mv.addObject("pd", pd);
			mv.addObject("provinceList", asProvinceService.list(null));
			List<AsCity> cityList = asCityService.list(null);
			JSONArray cityListJson = JSONArray.fromObject(cityList);
			mv.addObject("cityList", cityListJson);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 批量删除县区
	 */
	@RequestMapping(value = "/deleteAllArea")
	@ResponseBody
	public Object deleteAllArea() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String ids = pd.getString("ids");
			if (StringUtils.isNotBlank(ids)) {
				String areaIds[] = ids.split(",");
				asAreaService.deleteAll(areaIds);
				map.put("msg", "ok");
			} else {
				map.put("msg", "no");
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}
}
