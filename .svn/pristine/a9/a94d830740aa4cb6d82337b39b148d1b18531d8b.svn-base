package com.aoshi.controller.manage;

import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.common.asenum.DictParam;
import com.aoshi.common.asenum.baseTypeEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsAreaMapper;
import com.aoshi.dao.AsBusinessDistrictMapper;
import com.aoshi.dao.AsCityMapper;
import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.dao.AsProvinceMapper;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.dao.AsShopOwnerInfoMapper;
import com.aoshi.dao.AsShopPicMapper;
import com.aoshi.dao.AsStoreMapper;
import com.aoshi.dao.AsYpBaseCategoryMapper;
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsBusinessDistrict;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsProvince;
import com.aoshi.domain.AsShop;
import com.aoshi.domain.AsShopOwnerInfo;
import com.aoshi.domain.AsShopPic;
import com.aoshi.domain.AsStore;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.ShopOwnerService;
import com.aoshi.util.Conditions;

/**
 * 商家管理 Controller
 * 
 * @author yangyanchao
 * @date 2016年9月1日
 */
@Controller
@RequestMapping("/shopowner")
public class ShopOwnerController extends BaseController {

	@Autowired
	private ShopOwnerService shopOwnerService;

	@Autowired
	private AsShopOwnerInfoMapper asShopOwnerInfoMapper;
	
	@Autowired
	private AsShopMapper asShopMapper;
	
	@Autowired
    private AsBusinessDistrictMapper asBusinessDistrictMapper;
	
	@Autowired
	private AsYpBaseCategoryMapper ypBaseCategoryMapper;
	
	@Autowired
	private AsDictParamMapper asDictParamMapper;
	
	@Autowired
    private AsProvinceMapper provinceMapper;

    @Autowired
    private AsCityMapper asCityMapper;

    @Autowired
    private AsAreaMapper asAreaMapper;
    
    @Autowired
    private AsStoreMapper asStoreMapperr ;
    
    @Autowired
    private AsShopPicMapper shopPicMapper;
	

	/**
	 * 总控页面
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/tab")
	public Object tab(){
		return renderView("manage/shopowner/tag");
	}

	/**
	 * 页面跳转控制
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/page")
	public Object page() {
		return shopOwnerService.page(this);
	}

	/**
	 * 密码重置页面
	 * 
	 * @author yangyanchao
	 * @date 2016年9月3日
	 * @return
	 */
	@RequestMapping("/resetPwdPage")
	public Object resetPwdPage() {
		return shopOwnerService.resetPwdPage(this);
	}

	/**
	 * 密码重置 action
	 * 
	 * @author yangyanchao
	 * @date 2016年9月3日
	 * @return
	 */
	@RequestMapping("/resetPwd")
	public Object resetPwd() {
		return shopOwnerService.resetPwd(this);
	}

	/**
	 * 查询商家列表
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/listAll")
	public Object listAll() {
		return shopOwnerService.listAll(this);
	}

	/**
	 * 商家信息操作
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/opera")
	@ResponseBody
	public Object opera() {
		return shopOwnerService.opera(this);
	}
	
	/*=====================================================================================================*/

	
	  /**
     * 店铺审核列表-业主    
     * @return
     * @author chenwz
     * @date 2017年06月09日
     */
    @RequestMapping("/getShopOwnerListAudit")
    public Object getShopOwnerListAudit() {
        return shopOwnerService.getShopOwnerListAudit(this);
    }
    
    /**
     * 商户审核列表-运营
     * @return
     * @author chenwz
     * @date 2017年06月09日
     */
    @RequestMapping("/getShopOperatListAudit")
    public Object getShopOperatListAudit() {
        return shopOwnerService.getShopOperatListAudit(this);
    }
	
   
    /**
     * 更新审核状态
     * @return
     * @author chenwz
     * @date 2017年06月12日
     */
    @RequestMapping("/updateStatus")
    public Object updateStatus() {
        return shopOwnerService.updateStatus(this);
    }
    
    /**
     * 批量更新新审核状态
     * @return
     * @author chenwz
     * @date 2017年06月12日
     */
    @RequestMapping("/allAuditStatus")
    @ResponseBody
    public Object allAuditStatus(String[] ids,Integer status) {
    	Integer auditStatus = 0;
    	if(status == 2){
    		 auditStatus = 1;
    		return shopOwnerService.allAuditStatus(ids, auditStatus);
    	}else if(status == 3){
    		 auditStatus = 2;  		
		}       
    	return shopOwnerService.allAuditStatus(ids, auditStatus);
        
    }
    
    
    /**
     * 查看 审批 操作 --》去管理总页面
     */
    @RequestMapping(value = "/toshopInfoListPage")    
    public ModelAndView goList(Integer action,Integer shopId,Integer shopOwnerId,Integer status) {
        initialized();       
        mv.addObject("action", action);
        mv.addObject("shopId",shopId);
        mv.addObject("shopOwnerId", shopOwnerId);
        mv.addObject("status", status);
        mv.setViewName("manage/shopowner/shopInfoListPage");
        return mv;
    }
 
    /**
     * 商家个人信息列表页面
     */
    @RequestMapping(value = "/shopInfo")
    public ModelAndView shopInfoList(Integer shopOwnerId) {
        initialized();           
        AsShopOwnerInfo shopOwnerDate= asShopOwnerInfoMapper.findByShopOwnerId(shopOwnerId);
        mv.addObject("shopOwnerDate",shopOwnerDate);
        mv.setViewName("manage/shopowner/shopInfo");
        return mv;
    }
   
    /**
     * 商户信息列表页面
     */
    @RequestMapping(value = "/shopOwnerInfo")
    public ModelAndView shopOwnerInfoList(Integer action,Integer shopId,Integer shopOwnerId,Integer status,Page page) {
        initialized();
        mv.addObject("action", action);   
        List<AsShopPic> shopPics = shopPicMapper.selectByShopId(shopId);
        AsShop shopDate =asShopMapper.selectByPrimaryKey(shopId.toString());
        List<AsProvince> provinceList = provinceMapper.selectByAttr(pd);
        List<AsCity> cityList = asCityMapper.selectByAttr(null);
        JSONArray cityListJson = JSONArray.fromObject(cityList);
        List<AsArea> areaList = asAreaMapper.selectByAttr(null);
        JSONArray areaListJson = JSONArray.fromObject(areaList);
        List<AsStore> storList = asStoreMapperr.getStorList(null);
        List<AsBusinessDistrict> businessDistrictList = asBusinessDistrictMapper.selectByAttr(null);
        JSONArray businessDistrictListJson = JSONArray.fromObject(businessDistrictList);
        if(shopDate.getType() == 2){
        addField("type", baseTypeEnum.INDUSTRY.getId());
        }
        List<Conditions> baseTypes = ypBaseCategoryMapper.queryListAll(pd);
        Object floorList = asDictParamMapper.findByKeyCode(DictParam.PARAM_SHOP_FLOOR_OPT);
        if (floorList != null) {
            floorList = JSONArray.fromObject(floorList);
        }
        mv.addObject("businessDistrictList", businessDistrictListJson);
        mv.addObject("baseTypes", baseTypes);
        mv.addObject("shopDate", shopDate);
        mv.addObject("floorList", floorList);
        mv.addObject("provinceList", provinceList);
        mv.addObject("cityList", cityListJson);
        mv.addObject("areaList", areaListJson);
        mv.addObject("storList", storList);
        mv.addObject("shopOwnerInfoId",shopOwnerId);
        mv.addObject("status", status);
        mv.addObject("shopPics", shopPics);
        mv.setViewName("manage/shopowner/shopOwnerInfo");
        return mv;
    }
}
