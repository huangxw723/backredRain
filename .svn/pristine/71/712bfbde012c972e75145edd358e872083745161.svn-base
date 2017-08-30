package com.aoshi.controller.manage;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsCooperationMapper;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.dao.AsStoreMapper;
import com.aoshi.dao.AsYpBaseCategoryMapper;
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsBusinessDistrict;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsCooperation;
import com.aoshi.domain.AsProvince;
import com.aoshi.domain.AsShop;
import com.aoshi.domain.AsStore;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.entity.Page;
import com.aoshi.entity.system.User;
import com.aoshi.service.business.CooperationService;
import com.aoshi.service.manage.locality.AsAreaService;
import com.aoshi.service.manage.locality.AsBusinessDistrictService;
import com.aoshi.service.manage.locality.AsCityService;
import com.aoshi.service.manage.locality.AsProvinceService;
import com.aoshi.service.manage.locality.AsStoreService;
import com.aoshi.util.AppUtil;
import com.aoshi.util.Const;
import com.aoshi.util.DateUtil;
import com.aoshi.util.PageData;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 类名称：BusinessController 创建人：star 创建时间：2016-09-06
 */
@Controller
@RequestMapping(value = "/business")
public class BusinessController extends BaseController {

    String menuUrl = "business/businessList.do"; // 菜单地址(权限用)

    @Autowired
    private AsProvinceService asProvinceService;

    @Autowired
    private AsCityService asCityService;

    @Autowired
    private AsAreaService asAreaService;

    @Autowired
    private AsBusinessDistrictService asBusinessDistrictService;

    @Autowired
    private AsStoreService asStoreService;

	@Autowired
	private CooperationService cooperationService;

	@Autowired
	AsShopMapper asShopMapper;

    @Autowired
    AsYpBaseCategoryMapper asYpBaseCategoryMapper;

	@Autowired
	AsStoreMapper storeMapper;

	@Autowired
	AsCooperationMapper cooperationMapper;


    /**
     * 去管理总页面
     */
    @RequestMapping(value = "/businessList")
    public ModelAndView goList() {
        initialized();
        mv.setViewName("manage/locality/businessList");
        return mv;
    }

    /**
     * 去新增商圈页面
     */
    @RequestMapping(value = "/goAddDistrict")
    public ModelAndView goAddDistrict() {
        initialized();
        try {

			// pd.put("keyWord", "广东");
            List<AsProvince> provinceList = asProvinceService.list(pd);
			// pd.put("keyWord", "广州市");
            List<AsCity> cityList = asCityService.list(pd);
            JSONArray cityListJson = JSONArray.fromObject(cityList);
			// pd.remove("keyWord");
			// pd.put("provinceId", provinceList.get(0).getProvinceId());
			// pd.put("cityId", cityList.get(0).getCityId());
            List<AsArea> areaList = asAreaService.list(pd);
            JSONArray areaListJson = JSONArray.fromObject(areaList);
            mv.setViewName("manage/locality/districtEdit");
            mv.addObject("msg", "saveDistrict");
            mv.addObject("provinceList", provinceList);
            mv.addObject("cityList", cityListJson);
            mv.addObject("areaList", areaListJson);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mv;
    }



	/**
	 * 添加合作伙伴列表
	 */
	@RequestMapping(value = "/addCooperation")
	public ModelAndView addCooperation(Page page) {
        initialized();
		mv.setViewName("manage/locality/cooperationList");

		try {
			page.setPd(pd);
			PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
			List<AsStore> stores = storeMapper.selectByNoAddCooperation(pd);

			PageInfo<AsStore> pageInfo = new PageInfo<AsStore>(stores);
			page.setEntityOrField(true);
			page.setTotalResult((int) pageInfo.getTotal());
			mv.addObject("storeList", stores);
			mv.addObject("storeId", this.getPageData().getString("storeId"));
			mv.addObject("pd", pd);
			PageData attr = new PageData();
			List<AsProvince> provinceList = asProvinceService.list(attr);
			mv.addObject("provinceList", provinceList);
			List<AsCity> cityList = asCityService.list(attr);
			JSONArray cityListJson = JSONArray.fromObject(cityList);
			mv.addObject("cityList", cityListJson);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 合作伙伴列表
	 *
	 * @author tgb 创建时间：2017年2月23日
	 * @version 1.0
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/cooperationList")
	public ModelAndView cooperationList(Page page) {
        initialized();
		mv.setViewName("manage/locality/cooperationSelectList");

		try {
			page.setPd(pd);
			PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
			List<AsCooperation> stores = cooperationMapper
					.selectByCooperation(pd);

			PageInfo<AsCooperation> pageInfo = new PageInfo<AsCooperation>(
					stores);
			page.setEntityOrField(true);
			page.setTotalResult((int) pageInfo.getTotal());
			mv.addObject("storeList", stores);
			mv.addObject("storeId", this.getPageData().getString("storeId"));
			mv.addObject("pd", pd);
			PageData attr = new PageData();
			List<AsProvince> provinceList = asProvinceService.list(attr);
			mv.addObject("provinceList", provinceList);
			List<AsCity> cityList = asCityService.list(attr);
			JSONArray cityListJson = JSONArray.fromObject(cityList);
			mv.addObject("cityList", cityListJson);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 优惠券商户端 战略伙伴管理
	 * 
	 * @author tgb 创建时间：2017年2月21日
	 * @version 1.0
	 * @param page
	 * @param map
	 * @param keyWord
	 * @return
	 */
	@RequestMapping(value = "/cooperationWithCouponList")
	public String cooperationWithCouponList(Page page, ModelMap map,
			String keyWord) {

		String storeId = "";
		User user = this.getCurrentUser();
		String shopId = user.getAs_shop_id();
		if (!shopId.equals("null")) {
			AsShop asShop = asShopMapper.findByShopId(shopId);
			if (asShop != null) {
				storeId = "" + asShop.getStoreId();
			}
		}

		PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
		PageData pd = new PageData();
		pd.put("storeId", storeId);
		pd.put("keyWord", keyWord);
		List<AsCooperation> stores = cooperationMapper.selectByCooperation(pd);
		page.setPage(stores);
		map.put("storeList", stores);
		map.put("storeId", storeId);
		map.put("keyWord", keyWord);
		List<AsProvince> provinceList = asProvinceService.list(pd);
		map.put("provinceList", provinceList);
		List<AsCity> cityList = asCityService.list(pd);
		JSONArray cityListJson = JSONArray.fromObject(cityList);
		map.put("cityList", cityListJson);
		map.put("pd", pd);
		map.put("msg", "success");
		return "manage/locality/cooperationSelectList";
	}


    @RequestMapping(value = "/deleteCooperationIds")
    @ResponseBody
    public Map<String, Object> deleteCooperationIds(String ids, Page page, int storeId) {

        initialized();
        page.setPd(pd);
        PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
        pd.put("storeId", storeId);
        List<AsStore> storeList = asStoreService.needToAddCooperation(pd);
        page.setPage(storeList);
        List<AsStore> stores = storeMapper.selectAll();
        Map<String,Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotBlank(ids)) {
                String storeIds[] = ids.split(",");
                cooperationService.deleteAll(storeIds);
                map.put("msg", "ok");
            } else {
                map.put("msg", "no");
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        map.put("storeList", stores);
        map.put("ids", ids);
        map.put("pd",pd);
        return map;
    }
    /**
     * 添加合作伙伴
     *
     * @param map
     * @param ids
     * @return
     */
    @RequestMapping(value = "/addCooperationIds")
    @ResponseBody
    public Map<String, Object> addCooperationIds(String ids, Page page, int storeId) {

        initialized();
        page.setPd(pd);
        PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
        pd.put("storeId", storeId);
        List<AsStore> storeList = asStoreService.needToAddCooperation(pd);
        page.setPage(storeList);
        List<AsStore> stores = storeMapper.selectAll();
        Map<String,Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotBlank(ids)) {
                String storeIds[] = ids.split(",");
                cooperationService.addByPrimaryKeys(storeIds,storeId);
                map.put("msg", "ok");
            } else {
                map.put("msg", "no");
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        map.put("storeList", stores);
        map.put("ids", ids);
        map.put("pd",pd);
        return map;
    }

    /**
     * 新增商圈
     */
    @RequestMapping(value = "/saveDistrict")
    public ModelAndView saveDistrict(AsBusinessDistrict businessDistrict) {
        initialized();
        businessDistrict.setCreateTime(DateUtil.getTime());
        try {
            asBusinessDistrictService.save(businessDistrict);
        } catch (Exception e) {
            e.printStackTrace();
        }
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }


    /**
     * 去修改商圈页面
     */
    @RequestMapping(value = "/goEditDistrict")
    public ModelAndView goEditDistrict(AsBusinessDistrict businessDistrict) {
        initialized();
        try {

			// pd.put("keyWord", "广东");
            List<AsProvince> provinceList = asProvinceService.list(pd);
			// pd.put("keyWord", "广州市");
            List<AsCity> cityList = asCityService.list(pd);
            JSONArray cityListJson = JSONArray.fromObject(cityList);
			// pd.remove("keyWord");
			// pd.put("provinceId", provinceList.get(0).getProvinceId());
			// pd.put("cityId", cityList.get(0).getCityId());
            List<AsArea> areaList = asAreaService.list(pd);
            JSONArray areaListJson = JSONArray.fromObject(areaList);
            businessDistrict = asBusinessDistrictService.findById(businessDistrict); // 根据ID读取
            mv.setViewName("manage/locality/districtEdit");
            mv.addObject("msg", "editDistrict");
            mv.addObject("businessDistrict", businessDistrict);
            mv.addObject("provinceList", provinceList);
            mv.addObject("cityList", cityListJson);
            mv.addObject("areaList", areaListJson);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 修改商圈
     */
    @RequestMapping(value = "/editDistrict")
    public ModelAndView editDistrict(AsBusinessDistrict businessDistrict) {
        initialized();
        try {
            asBusinessDistrictService.edit(businessDistrict);
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
    @RequestMapping(value = "/deleteDistrict")
    public void deleteDistrict(PrintWriter out) {
        initialized();
        try {
            asBusinessDistrictService.delete(pd.getInt("businessDistrictId"));
            out.write("success");
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
    }

    /**
     * 商圈列表页面
     */
    @RequestMapping(value = "/listDistrict")
    public ModelAndView listDistrict(Page page) {
        initialized();
        mv.setViewName("manage/locality/districtList");

        try {
            page.setPd(pd);
            PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
            List<AsBusinessDistrict> businessDistrictList = asBusinessDistrictService.list(pd);
            PageInfo<AsBusinessDistrict> pageInfo = new PageInfo<AsBusinessDistrict>(businessDistrictList);
            page.setEntityOrField(true);
            page.setTotalResult((int) pageInfo.getTotal());
            mv.addObject("businessDistrictList", businessDistrictList);
            mv.addObject("pd", pd);
            PageData attr = new PageData();
			// attr.put("keyWord", "广东");
            List<AsProvince> provinceList = asProvinceService.list(attr);
            mv.addObject("provinceList", provinceList);
			// attr.put("keyWord", "广州市");
            List<AsCity> cityList = asCityService.list(attr);
            JSONArray cityListJson = JSONArray.fromObject(cityList);
            mv.addObject("cityList", cityListJson);
			// attr.remove("keyWord");
			// attr.put("provinceId", provinceList.get(0).getProvinceId());
			// attr.put("cityId", cityList.get(0).getCityId());
            List<AsArea> areaList = asAreaService.list(attr);
            JSONArray areaListJson = JSONArray.fromObject(areaList);
            mv.addObject("areaList", areaListJson);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 批量删除商圈
     */
    @RequestMapping(value = "/deleteAllDistrict")
    @ResponseBody
    public Object deleteAllDistrict() {
        initialized();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String ids = pd.getString("ids");
            if (StringUtils.isNotBlank(ids)) {
                String businessDistrictIds[] = ids.split(",");
                asBusinessDistrictService.deleteAll(businessDistrictIds);
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
     * 去新增商场页面
     */
    @RequestMapping(value = "/goAddStore")
    public ModelAndView goAddStore() {
        initialized();
        try {
            List<AsBusinessDistrict> districtList = asBusinessDistrictService.list(null);
            List<AsYpBaseCategory> ypBaseCategoryList = asYpBaseCategoryMapper.getmarketCategoriesShow();
            mv.setViewName("manage/locality/storeEdit");
            mv.addObject("msg", "saveStore");
            mv.addObject("districtList", districtList);
            mv.addObject("ypBaseCategoryList", ypBaseCategoryList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mv;
    }

    /**
     * 新增商场
     */
    @RequestMapping(value = "/saveStore")
    public ModelAndView saveStore(AsStore store) {
        initialized();
        store.setCreateTime(DateUtil.getTime());
        try {
            asStoreService.save(store, this.getPageData());
        } catch (Exception e) {
            e.printStackTrace();
        }
        mv.addObject("id", "createStore");
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 去修改商场页面
     */
    @RequestMapping(value = "/goEditStore")
    public ModelAndView goEditStore(AsStore store) {
        initialized();
        try {
            List<AsBusinessDistrict> districtList = asBusinessDistrictService.list(null);
            List<AsYpBaseCategory> ypBaseCategoryList = asYpBaseCategoryMapper.getmarketCategoriesShow();
            store = asStoreService.findById(store); // 根据ID读取
            mv.setViewName("manage/locality/storeEdit");
            mv.addObject("msg", "editStore");
            mv.addObject("store", store);
            mv.addObject("districtList", districtList);
            mv.addObject("ypBaseCategoryList", ypBaseCategoryList);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 修改商场
     */
    @RequestMapping(value = "/editStore")
    public ModelAndView editStore(AsStore store) {
        initialized();
        try {
            asStoreService.edit(store, this.getPageData());
        } catch (Exception e) {
            e.printStackTrace();
        }
        mv.addObject("id", "updateStore" + store.getStoreId());
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/deleteStore")
    public void deleteStore(PrintWriter out) {
        initialized();
        try {
            asStoreService.delete(pd.getInt("storeId"));
            out.write("success");
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
    }

    /**
     * 商场列表页面
     */
    @RequestMapping(value = "/listStore")
    public ModelAndView listStore(Page page) {
        initialized();
        mv.setViewName("manage/locality/storeList");

        try {
            page.setPd(pd);
            PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
            List<AsStore> storeList = asStoreService.list(pd);
            PageInfo<AsStore> pageInfo = new PageInfo<AsStore>(storeList);
            page.setEntityOrField(true);
            page.setTotalResult((int) pageInfo.getTotal());
            mv.addObject("storeList", storeList);
            mv.addObject("pd", pd);
            mv.addObject("districtList", asBusinessDistrictService.list(null));
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 批量删除商场
     */
    @RequestMapping(value = "/deleteAllStore")
    @ResponseBody
    public Object deleteAllStore() {
        initialized();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String ids = pd.getString("ids");
            if (StringUtils.isNotBlank(ids)) {
                String storeIds[] = ids.split(",");
                asStoreService.deleteAll(storeIds);
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
