package com.aoshi.service.manage.yp;

import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.common.asenum.DictParam;
import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.common.asenum.UserTypeEnum;
import com.aoshi.common.asenum.baseTypeEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsAreaMapper;
import com.aoshi.dao.AsCityMapper;
import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.dao.AsProvinceMapper;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.dao.AsShopOwnerInfoMapper;
import com.aoshi.dao.AsShopStaffInfoMapper;
import com.aoshi.dao.AsStoreMapper;
import com.aoshi.dao.AsUserMapper;
import com.aoshi.dao.AsYpBaseCategoryMapper;
import com.aoshi.dao.AsYpScreenDomainMapper;
import com.aoshi.dao.AsYpScreenInfoMapper;
import com.aoshi.dao.AsYpShopAreaMapper;
import com.aoshi.dao.SysUserMapper;
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsProvince;
import com.aoshi.domain.AsShop;
import com.aoshi.domain.AsStore;
import com.aoshi.domain.AsYpScreenDomain;
import com.aoshi.domain.AsYpShopArea;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.Conditions;
import com.aoshi.util.DomainUtils;
import com.aoshi.util.PropertyUtils;
import com.aoshi.util.Tools;

@Service
public class ShopYpService extends AsBaseService {

	private final static String PAGE_PATH = "manage/yp/ypShop/";
	private final static String domainUrl = "http://haipaitest.aoshimall.com";

	@Autowired
	private AsShopMapper asShopMapper;
	
	@Autowired
	private AsYpBaseCategoryMapper ypBaseCategoryMapper;
	
	@Autowired
	private AsProvinceMapper provinceMapper;
	
	@Autowired
	private AsCityMapper asCityMapper;

	@Autowired
	private AsAreaMapper asAreaMapper;
	
	@Autowired
	private AsStoreMapper asStoreMapperr;
	
	@Autowired
	private AsYpShopAreaMapper ypShopAreaMapper;
	
	@Autowired
	private AsShopStaffInfoMapper shopStaffInfoMapper;
	
	@Autowired
	private AsShopOwnerInfoMapper asShopOwnerInfoMapper;
	
	@Autowired
	private AsYpScreenInfoMapper ypScreenInfoMapper;
	
	@Autowired
	private SysUserMapper sysUserMapper;
	
	@Autowired
	private AsUserMapper asUserMapper;
	
	@Autowired
	private AsYpScreenDomainMapper asYpScreenDomainMapper;
	
	@Autowired
	private AsDictParamMapper asDictParamMapper;
	
	public AsShop findByShopId(String shopId) {
		return asShopMapper.selectByPrimaryKey(shopId);
	}
	
	/**
	 * 查询企业列表
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	public Object listAll(BaseController c) {

		initialized(c);
		
		addField("type", baseTypeEnum.INDUSTRY.getId());
		addViewData("types", ypBaseCategoryMapper.queryListAll(pd));
		addViewData("provinces", provinceMapper.selectByAttr(pd));
		pageQueryModule(asShopMapper, "listAllYp",
				true);
		addViewData("screenNum", asShopMapper.getScreenNum(pd));//总安装屏数量
		addField("pd", pd);
		return renderView(PAGE_PATH + "listAll");
	}


	/**
	 * 页面中转控制
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @return c
	 */
	public Object page(BaseController c) {

		initialized(c);

		OperaEnum action = OperaEnum.get(pd.getInt("action") == 0 ? 1 : pd
				.getInt("action"));
		switch(action){
		case ADD:
		List<AsProvince> provinceList = provinceMapper.selectByAttr(pd);
		List<AsCity> cityList = asCityMapper.selectByAttr(null);
		JSONArray cityListJson = JSONArray.fromObject(cityList);
		List<AsArea> areaList = asAreaMapper.selectByAttr(null);
		JSONArray areaListJson = JSONArray.fromObject(areaList);
		List<AsStore> storList = asStoreMapperr.getStorList(null);
		JSONArray storListJson = JSONArray.fromObject(storList);
		addField("type", baseTypeEnum.INDUSTRY.getId());
		List<Conditions> baseTypes = ypBaseCategoryMapper.queryListAll(pd);
		addViewData("provinceList", provinceList);
		addViewData("cityList", cityListJson);
		addViewData("areaList", areaListJson);
		addViewData("storList", storListJson);
		addViewData("baseTypes", baseTypes);
		addViewData("pd", pd);
		addViewData("msg", "opera");
		Object floorList = asDictParamMapper
				.findByKeyCode(DictParam.PARAM_SHOP_FLOOR_OPT);
		if (floorList != null) {
			floorList = JSONArray.fromObject(floorList);
		}
		addViewData("floorList", floorList);
		break;
	case EDIT:
		provinceList = provinceMapper.selectByAttr(null);
		cityList = asCityMapper.selectByAttr(null);
		cityListJson = JSONArray.fromObject(cityList);
		areaList = asAreaMapper.selectByAttr(null);
		areaListJson = JSONArray.fromObject(areaList);
		storList = asStoreMapperr.getStorList(null);
		storListJson = JSONArray.fromObject(storList);
		addField("type", baseTypeEnum.INDUSTRY.getId());
		baseTypes = ypBaseCategoryMapper.queryListAll(pd);
		addViewData("provinceList", provinceList);
		addViewData("cityList", cityListJson);
		addViewData("areaList", areaListJson);
		addViewData("storList", storListJson);
		addViewData("baseTypes", baseTypes);
		Object shopOwner = asShopMapper.getShop(pd);
		AsYpShopArea asypshoparea = ypShopAreaMapper.selectByShopId(pd);
		addViewData("shopOwner", shopOwner);
		addViewData("areaId", asypshoparea.getAreaId());
		addViewData("provinceId", asypshoparea.getProvinceId());
		addViewData("cityId", asypshoparea.getCityId());
		floorList = asDictParamMapper
				.findByKeyCode(DictParam.PARAM_SHOP_FLOOR_OPT);
		if (floorList != null) {
			floorList = JSONArray.fromObject(floorList);
		}
		addViewData("msg", "opera");
		addViewData("floorList", floorList);
		break;
	case QUERY:
		shopOwner = asShopMapper.getShop(pd);
		asypshoparea = ypShopAreaMapper.selectByShopId(pd);
		provinceList = provinceMapper.selectByAttr(null);
		cityList = asCityMapper.selectByAttr(null);
		cityListJson = JSONArray.fromObject(cityList);
		areaList = asAreaMapper.selectByAttr(null);
		areaListJson = JSONArray.fromObject(areaList);
		storList = asStoreMapperr.getStorList(null);
		storListJson = JSONArray.fromObject(storList);
		addField("type", baseTypeEnum.INDUSTRY.getId());
		baseTypes = ypBaseCategoryMapper.queryListAll(pd);
		addViewData("provinceList", provinceList);
		addViewData("cityList", cityListJson);
		addViewData("areaList", areaListJson);
		addViewData("storList", storListJson);
		addViewData("baseTypes", baseTypes);
		addViewData("shopOwner", shopOwner);
		addViewData("areaId", asypshoparea.getAreaId());
		addViewData("provinceId", asypshoparea.getProvinceId());
		addViewData("cityId", asypshoparea.getCityId());
		floorList = asDictParamMapper
				.findByKeyCode(DictParam.PARAM_SHOP_FLOOR_OPT);
		if (floorList != null) {
			floorList = JSONArray.fromObject(floorList);
		}
		addViewData("msg", "opera");
		addViewData("floorList", floorList);
		addViewData("pd", shopOwner);
		break;
		default:
			ValidatorBreakException.NOT_NULL(null);
		}
		addViewData("action", action.getId());
		return renderView(PAGE_PATH + "save");
	}
	/**
	 *操作
	 * 
	 * @author huangxw
	 * @date 2016年10月20日
	 * @return c
	 */
	public Object opera(BaseController c) {
		
		initialized(c);
		
		OperaEnum action = OperaEnum.get(pd.getInt("action"));

		switch (action) {

		case ADD:
        String name = pd.getStringRequired("name");
		String tradeCategoryId = pd.getString("tradeCategoryId");
		
		String provinceId = pd.getStringRequired("provinceId");
		String cityId = pd.getStringRequired("cityId");
		String areaId =pd.getStringRequired("areaId");
		String storId =pd.getString("storId")==null||pd.getString("storId").equals("")?null:pd.getString("storId");
		String address = pd.getStringRequired("address");
		String contact = pd.getStringRequired("contact");
		String tel =pd.getStringRequired("tel");
		String contactMail = pd.getStringRequired("contactMail");
		String logoUrl = pd.get("logoUrl") == null ? "" : pd.get("logoUrl")
				.toString();
		int floor = pd.getInt("floor");
		Conditions  cd = Conditions.newInstance()
		.putData("name", name)
		.putData("provinceId", provinceId)
		.putData("cityId", cityId)
		.putData("areaId", areaId)
		.putData("address", address)
		.putData("storeId", storId)
		.putData("contact", contact)
		.putData("tel", tel)
		.putData("tradeCategoryId", tradeCategoryId)
		.putData("contactMail", contactMail)
		.putData("floor", floor)
		.putData("createTime", CommonUtils.getCurDate());
		// 添加商铺
		uploadModule(UploadPathEnum.SHOP, "img");
		logoUrl = pd.getString("img");
		ValidatorBreakException.NOT_TRUE(!(logoUrl == null || logoUrl
				.trim().length() == 0), "请上传商家LOGO");

		logoUrl = pd.getString("img");
		cd.put("logoUrl", logoUrl);		
		
		operaFlag = asShopMapper.isAccountExists(Conditions.newInstance()
				.putData("name", name)) > 0;
		ValidatorBreakException.NOT_TRUE(!operaFlag, "企业名称已被注册！");
				
		operaFlag = asShopMapper.insertSelective(cd)==1;	
		ValidatorBreakException.NOT_TRUE(operaFlag);
		Conditions  ypAdd = Conditions.newInstance()
		.putData("provinceId", provinceId)
		.putData("cityId", cityId)
		.putData("areaId", areaId)
		.putData("shopId", cd.getInt("shopId"));
		ypShopAreaMapper.insertSelective(ypAdd);
		//生成企业站点信息
		 AsYpScreenDomain  sc = new AsYpScreenDomain();
		 sc.setCreateTime(CommonUtils.getCurDate());
		 sc.setIsMain(1);
		 sc.setUrl(DomainUtils.getDOMAIN_URL()+"_"+cd.getInt("shopId"));
		 sc.setShopId(cd.getInt("shopId"));
		 sc.setStatus(1);
		 sc.setUserId(Integer.parseInt(getUser().getUSER_ID()));
		 operaFlag = asYpScreenDomainMapper.insertSelective(sc)==1;	
		 ValidatorBreakException.NOT_TRUE(operaFlag);
		break;

		case EDIT:
	     name = pd.getStringRequired("name");
		 tradeCategoryId = pd.getString("tradeCategoryId");
		 int shopId= pd.getInt("shopId");
		 provinceId = pd.getStringRequired("provinceId");
		 cityId = pd.getStringRequired("cityId");
		 areaId =pd.getStringRequired("areaId");
		 address = pd.getStringRequired("address");
		 contact = pd.getStringRequired("contact");
		 tel =pd.getStringRequired("tel");
		 contactMail = pd.getStringRequired("contactMail");
		Conditions  cdShop = Conditions.newInstance()
		.putData("name", name)
		.putData("provinceId", provinceId)
		.putData("cityId", cityId)
		.putData("areaId", areaId)
		.putData("address", address)
		.putData("contact", contact)
		.putData("tel", tel)
		.putData("shopId", shopId)
		.putData("tradeCategoryId", tradeCategoryId)
		.putData("contactMail", contactMail);
		operaFlag = asShopMapper.updateByPrimaryKeySelective(cdShop)==1;	
		ValidatorBreakException.NOT_TRUE(operaFlag);
		Conditions addShop = Conditions.newInstance()
				.putData("provinceId", provinceId)
				.putData("cityId", cityId)
				.putData("areaId", areaId)
				.putData("shopId", shopId);
		operaFlag = ypShopAreaMapper.updateByPrimaryKeySelective(addShop)==1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		break;
		case DELETE:
		operaFlag = asShopMapper.isCouponExists(pd)>0;
		ValidatorBreakException.NOT_TRUE(!operaFlag,"该商家有优惠券正参与活动不能删除！");
			
		operaFlag = asShopMapper.isPrizeExists(pd)>0;
		ValidatorBreakException.NOT_TRUE(!operaFlag,"该商家有礼品券正参与活动不能删除！");
		
		operaFlag=sysUserMapper.deleteData(pd)==1;//删除系统用户
		ValidatorBreakException.NOT_NULL(operaFlag, "数据信息已过期，请刷新后重试");
		//查询员工管理员账号
	    List<String> staList = shopStaffInfoMapper.findData(pd);
        if(Tools.listIsEmpty(staList)){
	    String[] array =new String[staList.size()];
	    staList.toArray(array);
		operaFlag=asUserMapper.deleteAll(array)==1;
		ValidatorBreakException.NOT_NULL(operaFlag, "数据信息已过期，请刷新后重试");
        }
        List<String> shopList =asShopOwnerInfoMapper.findData(pd);
		if(Tools.listIsEmpty(staList)){
		//查询商场管理员账号
		String[] arr =new String[shopList.size()];
		shopList.toArray(arr);
	    asUserMapper.deleteAll(arr);
		}
		operaFlag=shopStaffInfoMapper.deleteAlls(pd)==1;
		ValidatorBreakException.NOT_NULL(operaFlag, "数据信息已过期，请刷新后重试");
		
		operaFlag=asShopOwnerInfoMapper.deleteAlls(pd)==1;
		ValidatorBreakException.NOT_NULL(operaFlag, "数据信息已过期，请刷新后重试");
		
		operaFlag=asShopMapper.deleteByIds(pd)==1;
		ValidatorBreakException.NOT_NULL(operaFlag, "数据信息已过期，请刷新后重试");
		break;
		default:
			ValidatorBreakException.NOT_TRUE(false);
		}

		return renderSuccess();
	}
   
	/**
	 * 查看账户
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @return c
	 */
	public Object getAccountList(BaseController c) {
		initialized(c);
		List<?> users = shopStaffInfoMapper.getAccountList(pd);
		addViewData("users", users);
		return renderView(PAGE_PATH + "userlistAll");
	
	}
	/**
	 * 更新企业账号状态
	 * 
	 * @author huangxw
	 * @date 2016年9月2日
	 * @return
	 */
	public Object  updateUserStatus(BaseController c) {
	  initialized(c);
	  if(UserTypeEnum.STAFF.getId()==pd.getInt("type")){
	  operaFlag = shopStaffInfoMapper.updateStatus(pd) == 1;
	  ValidatorBreakException.NOT_TRUE(operaFlag, "数据已过期，请刷新后重试");
	  }
	  if(UserTypeEnum.SELLER.getId()==pd.getInt("type")){
	  operaFlag = asShopOwnerInfoMapper.updateStatus(pd) == 1;
	  ValidatorBreakException.NOT_TRUE(operaFlag, "数据已过期，请刷新后重试");
	  }
	 return renderSuccess();
	}
	
	/**
	 * 查看云屏
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @return c
	 */
	public Object listScreenPage(BaseController shopYpController) {
		initialized(c);
		pageQueryModule(ypScreenInfoMapper, "listScreenAll",
				true);
		return renderView(PAGE_PATH + "listScreenAll");
	}
}
