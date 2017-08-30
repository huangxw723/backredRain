package com.aoshi.controller.manage.link;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.*;
import com.aoshi.domain.*;
import com.aoshi.entity.Page;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.manage.locality.*;
import com.aoshi.util.DateUtil;
import com.aoshi.util.PageData;
import com.aoshi.util.PropertyUtils;
import com.github.pagehelper.PageHelper;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by xjl on 2017/2/18.
 */
@Controller
@RequestMapping("link/activityLink")
public class ActivityLinkController extends BaseController {
    private static final String BASEURL="link/";
    private static final String COUPON_BASEURL="coupon/";
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
    private AsActivityLinkMapper asActivityLinkMapper;
    @Autowired
    private AsCityMapper mapper;
    @Autowired
    private AsBusinessDistrictMapper disMapper;
    @Autowired
    private AsAreaMapper asAreaMapper;
    @Autowired
    private AsStoreMapper asStoreMapper;
    @Autowired
    private AsProvinceMapper asProvinceMapper;
    @Autowired
    private AsShopOwnerInfoMapper shopOwnerInfoMapper;
    @Autowired
    private AsUserMapper asUserMapper;
    @Autowired
    private AsShopMapper asShopMapper;

    /**
     * 大转盘链接列表
     * @param map
     * @return
     */
    @RequestMapping("linkList")
    public String linkList(ModelMap map, Page page,
                           @RequestParam(value="keyWord",required=false)String keyWord,AsActivityLink asActivityLink,String itemId){
        int pageNum = page.getCurrentPage();
        int pageSize = page.getShowCount();
        PageHelper.startPage(pageNum, pageSize);
        if(!StringUtils.isEmpty(keyWord)){
            asActivityLink.setLinkName(keyWord);
        }
        if(!StringUtils.isEmpty(itemId)){
            asActivityLink.setItemId(Integer.parseInt(itemId));
        }
        List<AsActivityLink> list = asActivityLinkMapper.queryList(asActivityLink);
        if(!list.isEmpty()){
            for(AsActivityLink asActivityLink1:list){
                //定位市
                if(asActivityLink1.getRangeType()!=null &&asActivityLink1.getRangeType()==1){
                    AsCity asCity = mapper.selectByPrimaryKey(asActivityLink1.getItemId());
                    if(asCity!=null){
                        asActivityLink1.setCityName(asCity.getCityName());
                    }
                }
                //定位区
                if(asActivityLink1.getRangeType()!=null &&asActivityLink1.getRangeType()==2){
                    AsArea asArea = asAreaMapper.selectByPrimaryKey(asActivityLink1.getItemId());
                    if(asArea!=null){
                        asActivityLink1.setAreaName(asArea.getAreaName());
                        AsCity asCity = mapper.selectByPrimaryKey(asArea.getCityId());
                        if(asCity!=null){
                            asActivityLink1.setCityName(asCity.getCityName());
                        }
                    }
                }
                //定位商圈
                if(asActivityLink1.getRangeType()!=null &&asActivityLink1.getRangeType()==3){
                    AsBusinessDistrict asBusinessDistrict = disMapper.selectByPrimaryKey(asActivityLink1.getItemId());
                    if(asBusinessDistrict!=null){
                        asActivityLink1.setDisName(asBusinessDistrict.getName());
                        AsArea asArea = asAreaMapper.selectByPrimaryKey(asBusinessDistrict.getAreaId());
                        if(asArea!=null){
                            asActivityLink1.setAreaName(asArea.getAreaName());
                        }
                        AsCity asCity = mapper.selectByPrimaryKey(asBusinessDistrict.getCityId());
                        if(asCity!=null){
                            asActivityLink1.setCityName(asCity.getCityName());
                        }
                    }

                }
                //定位商场
                if (asActivityLink1.getRangeType()!=null &&asActivityLink1.getRangeType()==4){
                    AsStore asStore = asStoreMapper.selectByPrimaryKey(asActivityLink1.getItemId());
                    if(asStore!=null){
                        asActivityLink1.setStoreName(asStore.getName());
                        AsBusinessDistrict asBusinessDistrict = disMapper.selectByPrimaryKey(asStore.getBusinessDistrictId());
                        if(asBusinessDistrict!=null){
                            asActivityLink1.setDisName(asBusinessDistrict.getName());
                            AsArea asArea = asAreaMapper.selectByPrimaryKey(asBusinessDistrict.getAreaId());
                            if(asArea!=null){
                                asActivityLink1.setAreaName(asArea.getAreaName());
                            }
                            AsCity asCity = mapper.selectByPrimaryKey(asBusinessDistrict.getCityId());
                            if(asCity!=null){
                                asActivityLink1.setCityName(asCity.getCityName());
                            }
                        }
                    }
                }
            }
        }
        page.setPage(list);
        PageData pd = this.getPageData();
        map.put("provinceList", asProvinceService.list(null));//省
        map.put("cityList", JSONArray.fromObject(asCityService.list(null)));//市
        map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));//区域
        map.put("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));//商圈
        map.put("storeList",JSONArray.fromObject(asStoreService.list(null)));//商场
        map.put("keyWord", keyWord);
        map.put("pd", pd);
        map.put("list", list);
        map.put("itemId", itemId);
        map.put("page", page);
        return BASEURL+"linkList";
    }


    /**
     * 优惠券链接列表
     * @param map
     * @return
     */
    @RequestMapping("couponList")
    public String couponList(ModelMap map, Page page,
                           @RequestParam(value="keyWord",required=false)String keyWord,AsActivityLink asActivityLink,String itemId){
        int pageNum = page.getCurrentPage();
        int pageSize = page.getShowCount();
        PageHelper.startPage(pageNum, pageSize);
        if(!StringUtils.isEmpty(keyWord)){
            asActivityLink.setLinkName(keyWord);
        }
        if(!StringUtils.isEmpty(itemId)){
            asActivityLink.setItemId(Integer.parseInt(itemId));
        }
        List<AsActivityLink> list = asActivityLinkMapper.couponList(asActivityLink);
        if(!list.isEmpty()){
            for(AsActivityLink asActivityLink1:list){
                if(asActivityLink1.getRangeType()!=null){

                }
                //定位市
                if(asActivityLink1.getRangeType()!=null &&asActivityLink1.getRangeType()==1){
                    AsCity asCity = mapper.selectByPrimaryKey(asActivityLink1.getItemId());
                    if(asCity!=null){
                        asActivityLink1.setCityName(asCity.getCityName());
                    }
                }
                //定位区
                if(asActivityLink1.getRangeType()!=null &&asActivityLink1.getRangeType()==2){
                    AsArea asArea = asAreaMapper.selectByPrimaryKey(asActivityLink1.getItemId());
                    if(asArea!=null){
                        asActivityLink1.setAreaName(asArea.getAreaName());
                        AsCity asCity = mapper.selectByPrimaryKey(asArea.getCityId());
                        if(asCity!=null){
                            asActivityLink1.setCityName(asCity.getCityName());
                        }
                    }
                }
                //定位商圈
                if(asActivityLink1.getRangeType()!=null &&asActivityLink1.getRangeType()==3){
                    AsBusinessDistrict asBusinessDistrict = disMapper.selectByPrimaryKey(asActivityLink1.getItemId());
                    if(asBusinessDistrict!=null){
                        asActivityLink1.setDisName(asBusinessDistrict.getName());
                        AsArea asArea = asAreaMapper.selectByPrimaryKey(asBusinessDistrict.getAreaId());
                        if(asArea!=null){
                            asActivityLink1.setAreaName(asArea.getAreaName());
                        }
                        AsCity asCity = mapper.selectByPrimaryKey(asBusinessDistrict.getCityId());
                        if(asCity!=null){
                            asActivityLink1.setCityName(asCity.getCityName());
                        }
                    }

                }
                //定位商场
                if (asActivityLink1.getRangeType()!=null &&asActivityLink1.getRangeType()==4){
                    AsStore asStore = asStoreMapper.selectByPrimaryKey(asActivityLink1.getItemId());
                    if(asStore!=null){
                        asActivityLink1.setStoreName(asStore.getName());
                        AsBusinessDistrict asBusinessDistrict = disMapper.selectByPrimaryKey(asStore.getBusinessDistrictId());
                        if(asBusinessDistrict!=null){
                            asActivityLink1.setDisName(asBusinessDistrict.getName());
                            AsArea asArea = asAreaMapper.selectByPrimaryKey(asBusinessDistrict.getAreaId());
                            if(asArea!=null){
                                asActivityLink1.setAreaName(asArea.getAreaName());
                            }
                            AsCity asCity = mapper.selectByPrimaryKey(asBusinessDistrict.getCityId());
                            if(asCity!=null){
                                asActivityLink1.setCityName(asCity.getCityName());
                            }
                        }
                    }
                }
                //定位商户
                if (asActivityLink1.getRangeType()!=null &&asActivityLink1.getRangeType()==5){
                    AsShop shop = (AsShop) asShopMapper.selectByPrimaryKey(asActivityLink1.getItemId());
                    if(shop!=null){
                        asActivityLink1.setShopName(shop.getName());
                    }
                }
            }
        }
        page.setPage(list);
        PageData pd = this.getPageData();
        map.put("provinceList", asProvinceService.list(null));//省
        map.put("cityList", JSONArray.fromObject(asCityService.list(null)));//市
        map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));//区域
        map.put("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));//商圈
        map.put("storeList",JSONArray.fromObject(asStoreService.list(null)));//商场
       // map.put("shopOwnerInfosList",shopOwnerInfoMapper.queryList());//商户
        map.put("shopOwnerInfosList",asShopMapper.queryList());//商户
        map.put("keyWord", keyWord);
        map.put("pd", pd);
        map.put("list", list);
        map.put("itemId", itemId);
        map.put("page", page);
        return COUPON_BASEURL+"couponList";
    }

    /**
     * 大转盘去增页面
     * @param map
     * @return
     */
    @RequestMapping(value="toAdd")
    public String toAdd(ModelMap map){
        map.put("provinceList", asProvinceService.list(null));//省
        map.put("cityList", JSONArray.fromObject(asCityService.list(null)));//市
        map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));//区域
        map.put("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));//商圈
        map.put("storeList",JSONArray.fromObject(asStoreService.list(null)));//商场
        return BASEURL+"addLink";
    }

    /**
     * 优惠券去增页面
     * @param map
     * @return
     */
    @RequestMapping(value="toAddCoupon")
    public String toAddCoupon(ModelMap map){
        map.put("provinceList", asProvinceService.list(null));//省
        map.put("cityList", JSONArray.fromObject(asCityService.list(null)));//市
        map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));//区域
        map.put("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));//商圈
        map.put("storeList",JSONArray.fromObject(asStoreService.list(null)));//商场
       //map.put("shopOwnerInfosList",shopOwnerInfoMapper.queryList());//商户
        //map.put("shopOwnerInfosList",asShopMapper.queryList());//商户
        map.put("shopOwnerInfosList",asUserMapper.getUserWhitConditionsOnUse(null));//商户
        return COUPON_BASEURL+"addCouponLink";
    }


    /**
     * 新增（大转盘类型）
     * @param asActivityLink
     * @return
     */
    @RequestMapping("addLink")
    @ResponseBody
    public Map<String, Object> addLink(AsActivityLink asActivityLink, HttpServletRequest request){
        if(asActivityLink !=null){
            ValidatorBreakException.NOT_TRUE(!(asActivityLinkMapper.queryByTypeAnditemId(1,asActivityLink.getRangeType(), asActivityLink.getItemId())>0), "该活动链接已存在！");
            if(asActivityLink.getRangeType()!=null){
                switch(asActivityLink.getRangeType()){
                    default:
                        asActivityLink.setLink("");
                        break;
                    case 1:
                        asActivityLink.setLink("redRain_start.html#/attr?cityId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                        break;
                    case 2:
                        asActivityLink.setLink("redRain_start.html#/attr?areaId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                        break;
                    case 3:
                        asActivityLink.setLink("redRain_start.html#/attr?districtId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                        break;
                    case 4:
                        asActivityLink.setLink("redRain_start.html#/attr?mallId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                        break;

                }
            }
        }
        asActivityLink.setLinkType(1);
        asActivityLink.setCreateTime(DateUtil.getTime());
        int result = asActivityLinkMapper.insertSelective(asActivityLink);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }


    /**
     * 新增(优惠券类型)
     * @param asActivityLink
     * @return
     */
    @RequestMapping("addCouponLink")
    @ResponseBody
    public Map<String, Object> addCouponLink(AsActivityLink asActivityLink, HttpServletRequest request){
        if(asActivityLink !=null){
            ValidatorBreakException.NOT_TRUE(!(asActivityLinkMapper.queryByTypeAnditemId(2,asActivityLink.getRangeType(), asActivityLink.getItemId())>0), "该活动链接已存在！");
            if(asActivityLink.getRangeType()!=null){
                switch(asActivityLink.getRangeType()){
                    default:
                        asActivityLink.setLink("");
                        break;
                    case 1:
                        asActivityLink.setLink("coupon/coupon.html?cityId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                        break;
                    case 2:
                        asActivityLink.setLink("coupon/coupon.html?areaId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                        break;
                    case 3:
                        asActivityLink.setLink("coupon/coupon.html?districtId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                        break;
                    case 4:
                        asActivityLink.setLink("coupon/coupon.html?mallId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                        break;
                    case 5:
                        asActivityLink.setLink("coupon/coupon.html?shopId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                        break;

                }
            }
        }
        asActivityLink.setLinkType(2);
        asActivityLink.setCreateTime(DateUtil.getTime());
        int result = asActivityLinkMapper.insertSelective(asActivityLink);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }

    /**
     * 编辑页面（优惠券类型）
     * @param id
     * @param map
     * @return
     */
    @RequestMapping("toCouponEdit")
    public String toCouponEdit(Integer id,ModelMap map){
        AsActivityLink asActivityLink = asActivityLinkMapper.selectByPrimaryKey(id);
        if(asActivityLink!=null){
            //市
            if(asActivityLink.getRangeType()==1){
                AsCity asCity = mapper.selectByPrimaryKey(asActivityLink.getItemId());
                map.put("provinceId", asCity.getProvinceId());
                map.put("cityId", asCity.getCityId());
            }
            //区
            if(asActivityLink.getRangeType()==2){
                AsArea asArea = asAreaMapper.selectByPrimaryKey(asActivityLink.getItemId());
                map.put("provinceId", asArea.getProvinceId());
                map.put("cityId", asArea.getCityId());
                map.put("areaId", asArea.getAreaId());
            }
            //商圈
            if(asActivityLink.getRangeType()==3){
                AsBusinessDistrict asBusinessDistrict = disMapper.selectByPrimaryKey(asActivityLink.getItemId());
                map.put("provinceId", asBusinessDistrict.getProvinceId());
                map.put("cityId", asBusinessDistrict.getCityId());
                map.put("areaId", asBusinessDistrict.getAreaId());
                map.put("districtId", asBusinessDistrict.getBusinessDistrictId());
            }
            //商场
            if(asActivityLink.getRangeType()==4){
                AsStore asStore = asStoreMapper.selectByPrimaryKey(asActivityLink.getItemId());
                if(asStore!=null){
                    map.put("storeId", asStore.getStoreId());
                    AsBusinessDistrict asBusinessDistrict = disMapper.selectByPrimaryKey(asStore.getBusinessDistrictId());
                    if(asBusinessDistrict!=null){
                        map.put("provinceId", asBusinessDistrict.getProvinceId());
                        map.put("cityId", asBusinessDistrict.getCityId());
                        map.put("areaId", asBusinessDistrict.getAreaId());
                        map.put("districtId", asBusinessDistrict.getBusinessDistrictId());
                    }
                }
            }
        }
        map.put("provinceList", JSONArray.fromObject(asProvinceService.list(null)));//省
        map.put("cityList", JSONArray.fromObject(asCityService.list(null)));//市
        map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));//区域
        map.put("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));//商圈
        map.put("storeList",JSONArray.fromObject(asStoreService.list(null)));//商场
//        map.put("shopOwnerInfosList",shopOwnerInfoMapper.queryList());//商户
//        map.put("shopOwnerInfosList",asShopMapper.queryList());//商户
        map.put("shopOwnerInfosList",JSONArray.fromObject(asUserMapper.getUserWhitConditionsOnUse(null)));//商户
        map.put("asActivityLink", JSONObject.fromObject(asActivityLink));
        return COUPON_BASEURL+"editCouponLink";
    }

    /**
     * 编辑页面（大转盘类型）
     * @param id
     * @param map
     * @return
     */
    @RequestMapping("toEdit")
    public String toEdit(Integer id,ModelMap map){
        AsActivityLink asActivityLink = asActivityLinkMapper.selectByPrimaryKey(id);
        if(asActivityLink!=null){
            //市
            if(asActivityLink.getRangeType()==1){
                AsCity asCity = mapper.selectByPrimaryKey(asActivityLink.getItemId());
                map.put("provinceId", asCity.getProvinceId());
                map.put("cityId", asCity.getCityId());
            }
            //区
            if(asActivityLink.getRangeType()==2){
                AsArea asArea = asAreaMapper.selectByPrimaryKey(asActivityLink.getItemId());
                map.put("provinceId", asArea.getProvinceId());
                map.put("cityId", asArea.getCityId());
                map.put("areaId", asArea.getAreaId());
            }
            //商圈
            if(asActivityLink.getRangeType()==3){
                AsBusinessDistrict asBusinessDistrict = disMapper.selectByPrimaryKey(asActivityLink.getItemId());
                map.put("provinceId", asBusinessDistrict.getProvinceId());
                map.put("cityId", asBusinessDistrict.getCityId());
                map.put("areaId", asBusinessDistrict.getAreaId());
                map.put("districtId", asBusinessDistrict.getBusinessDistrictId());
            }
            //商场
            if(asActivityLink.getRangeType()==4){
                AsStore asStore = asStoreMapper.selectByPrimaryKey(asActivityLink.getItemId());
                if(asStore!=null){
                    map.put("storeId", asStore.getStoreId());
                    AsBusinessDistrict asBusinessDistrict = disMapper.selectByPrimaryKey(asStore.getBusinessDistrictId());
                    if(asBusinessDistrict!=null){
                        map.put("provinceId", asBusinessDistrict.getProvinceId());
                        map.put("cityId", asBusinessDistrict.getCityId());
                        map.put("areaId", asBusinessDistrict.getAreaId());
                        map.put("districtId", asBusinessDistrict.getBusinessDistrictId());
                    }
                }
            }
        }
        //map.put("provinceList", asProvinceService.list(null));//省
        map.put("provinceList", JSONArray.fromObject(asProvinceService.list(null)));//省
        map.put("cityList", JSONArray.fromObject(asCityService.list(null)));//市
        map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));//区域
        map.put("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));//商圈
        map.put("storeList",JSONArray.fromObject(asStoreService.list(null)));//商场
        //map.put("asActivityLink", asActivityLink);
        map.put("asActivityLink", JSONObject.fromObject(asActivityLink));
        
        return BASEURL+"editLink";
    }



    /**
     * 更新（大转盘类型）
     * @param asActivityLink
     * @return
     */
    @RequestMapping("updateLink")
    @ResponseBody
    public Map updateLink(AsActivityLink asActivityLink,HttpServletRequest request){    	
        if(asActivityLink !=null){
            AsActivityLink asActivityLink1 = asActivityLinkMapper.selectByPrimaryKey(asActivityLink.getActivityLinkId());
            if(!(asActivityLink.getRangeType().equals(asActivityLink1.getRangeType()) && asActivityLink.getItemId().equals(asActivityLink1.getItemId()))){
                ValidatorBreakException.NOT_TRUE(!(asActivityLinkMapper.queryByTypeAnditemId(1,asActivityLink.getRangeType(), asActivityLink.getItemId())>0), "该活动链接已存在！");
            }
            if(asActivityLink.getRangeType()!=null){
                switch(asActivityLink.getRangeType()){
                    default:
                        asActivityLink.setLink("");
                        break;
                    case 1:
                        asActivityLink.setLink("redRain_start.html#/attr?cityId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                        break;
                    case 2:
                        asActivityLink.setLink("redRain_start.html#/attr?areaId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                        break;
                    case 3:
                        asActivityLink.setLink("redRain_start.html#/attr?districtId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                        break;
                    case 4:
                        asActivityLink.setLink("redRain_start.html#/attr?mallId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                        break;

                }
            }
        }
        int result = asActivityLinkMapper.updateByPrimaryKeySelective(asActivityLink);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }

    /**
     * 更新（优惠券类型）
     * @param asActivityLink
     * @return
     */
    @RequestMapping("updateCouponLink")
    @ResponseBody
    public Map updateCouponLink(AsActivityLink asActivityLink,HttpServletRequest request){   	
        if(asActivityLink !=null){
            AsActivityLink asActivityLink1 = asActivityLinkMapper.selectByPrimaryKey(asActivityLink.getActivityLinkId());
            if(!(asActivityLink.getRangeType().equals(asActivityLink1.getRangeType()) && asActivityLink.getItemId().equals(asActivityLink1.getItemId()))){
                ValidatorBreakException.NOT_TRUE(!(asActivityLinkMapper.queryByTypeAnditemId(2,asActivityLink.getRangeType(), asActivityLink.getItemId())>0), "该活动链接已存在！");
            }
                if(asActivityLink.getRangeType()!=null){
                    switch(asActivityLink.getRangeType()){
                        default:
                            asActivityLink.setLink("");
                            break;
                        case 1:
                            asActivityLink.setLink("coupon/coupon.html?cityId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                            break;
                        case 2:
                            asActivityLink.setLink("coupon/coupon.html?areaId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                            break;
                        case 3:
                            asActivityLink.setLink("coupon/coupon.html?districtId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                            break;
                        case 4:
                            asActivityLink.setLink("coupon/coupon.html?mallId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                            break;
                        case 5:
                            asActivityLink.setLink("coupon/coupon.html?shopId="+asActivityLink.getItemId()+"&rangeType="+asActivityLink.getRangeType());
                            break;

                    }
                }
        }
        int result = asActivityLinkMapper.updateByPrimaryKeySelective(asActivityLink);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/delById")
    @ResponseBody
    public int delById(Integer activityLinkId) {
        return asActivityLinkMapper.deleteByPrimaryKey(activityLinkId);
    }

    /**
     * 批量删除
     */
    @RequestMapping(value = "/deleteAll")
    @ResponseBody
    public Object deleteAll(String []ids) {
        return asActivityLinkMapper.deleteByIds(ids);
    }
}
