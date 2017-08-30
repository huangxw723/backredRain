package com.aoshi.service.manage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.common.asenum.DictParam;
import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.common.asenum.UserTypeEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsActivityMapper;
import com.aoshi.dao.AsBusinessDistrictMapper;
import com.aoshi.dao.AsCouponMapper;
import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.dao.AsPrizeConfigMapper;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.dao.AsShopOwnerInfoMapper;
import com.aoshi.dao.AsShopStaffInfoMapper;
import com.aoshi.dao.AsStoreMapper;
import com.aoshi.dao.AsUserMapper;
import com.aoshi.dao.AsWalletMapper;
import com.aoshi.dao.SysUserMapper;
import com.aoshi.domain.AsEvent;
import com.aoshi.domain.AsShop;
import com.aoshi.domain.AsShopOwnerInfo;
import com.aoshi.domain.AsShopStaffInfo;
import com.aoshi.domain.AsStore;
import com.aoshi.domain.AsUser;
import com.aoshi.domain.AsWallet;
import com.aoshi.domain.SysUser;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.Conditions;
import com.aoshi.util.DateUtil;

/**
 * 商家管理 Service
 * 
 * @author yangyanchao
 * @date 2016年9月1日
 */
@Service
public class ShopOwnerService extends AsBaseService {

	private static final String PAGE_PATH = "manage/shopowner/";

	@Autowired
	private AsShopMapper asShopMapper;

	@Autowired
	private AsDictParamMapper asDictParamMapper;

	@Autowired
	private SysUserMapper sysUserMapper;

	@Autowired
	private AsUserMapper asUserMapper;

	@Autowired
	private AsShopOwnerInfoMapper asShopOwnerInfoMapper;

	@Autowired
	private AsWalletMapper asWalletMapper;

	@Autowired
	private AsPrizeConfigMapper asPrizeConfigMapper;

	@Autowired
	private AsStoreMapper asStoreMapper;

	@Autowired
	private AsBusinessDistrictMapper asBusinessDistrictMapper;

	@Autowired
	private AsActivityMapper asActivityMapper;

	@Autowired
	private AsShopStaffInfoMapper asShopStaffInfoMapper;
	@Autowired
	AsCouponMapper asCouponMapper;

	/**
	 * 商家操作
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @param c
	 * @return
	 */
	public Object opera(BaseController c) {
		
		initialized(c);
		
		OperaEnum action = OperaEnum.get(pd.getInt("action"));

		switch (action) {

		case ADD:

			String account = pd.getString("account"); // 商家帐号
			String password = pd.getStringRequired("password"); // 密码
			String tel = pd.getStringRequired("tel"); // 店铺联系电话
			String logoUrl = pd.get("logoUrl") == null ? "" : pd.get("logoUrl")
					.toString();
			String name = pd.getStringRequired("name"); // 店铺名称
			String descp = pd.getStringRequired("descp"); // 店铺简介
			String contact = pd.getStringRequired("contact"); // 店铺联系人
			int floor = pd.getInt("floor");
			int storeId = pd.getIntRequired("storeId"); // 店铺联系人

			operaFlag = asUserMapper.isAccountExists(Conditions.newInstance()
					.putData("account", account)
					.putData("type", UserTypeEnum.SELLER.getId())) > 0;
			ValidatorBreakException.NOT_TRUE(!operaFlag, "账号已被注册");

			// 添加商铺
			uploadModule(UploadPathEnum.SHOP, "img");
			logoUrl = pd.getString("img");
			ValidatorBreakException.NOT_TRUE(!(logoUrl == null || logoUrl
					.trim().length() == 0), "请上传商家LOGO");

			logoUrl = pd.getString("img");
			int businessDistrictId = 0;
			AsStore store = asStoreMapper.selectByPrimaryKey(storeId);
			if (store != null) {
				businessDistrictId = store.getBusinessDistrictId();
			}
			Conditions shop = Conditions.newInstance().putData("tel", tel)
					.putData("name", name).putData("storeId", storeId)
					.putData("logoUrl", logoUrl).putData("contact", contact)
					.putData("business_district_id", businessDistrictId)
					.putData("floor", floor)
					.putData("descp", descp).putData("createTime", CommonUtils.getCurDate());
			operaFlag = asShopMapper.insertSelective(shop) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);

			// 添加后台用户信息
			String sys_user_id = get32UUID();
			Conditions sysUser = Conditions.newInstance();
			sysUser.putData("username", account)
					.putData("name", account)
					.putData("userId", sys_user_id)
					.putData("createBy", getUser().getUSER_ID())
					.putData("password", CommonUtils.encryptPwd(password, 2))
					.putData("asShopId", shop.getInt("shopId"))
					.putData("status", 0)
					.putData(
							"roleId",
							asDictParamMapper
									.findByKeyCode(DictParam.PARAM_SHOPOWNER_ROLE_ID));
			operaFlag = sysUserMapper.insertSelective(sysUser) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);

			// 添加商家帐号信息
			Conditions user = Conditions.newInstance();
			user.putData("account", account).putData("password",
 CommonUtils.encryptPwd(password))
					.putData("createTime", CommonUtils.getCurDate())
					.putData("type", UserTypeEnum.SELLER.getId())
					.putData("sysUserId", sys_user_id);
			operaFlag = asUserMapper.insertSelective(user) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);

			// 添加商家管理员信息
			Conditions shopOwner = Conditions.newInstance();
			shopOwner.putData("userId", user.getInt("userId")).putData(
					"shopId", shop.getInt("shopId"));
			operaFlag = asShopOwnerInfoMapper.insertSelective(shopOwner) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);

			// 添加用户钱包
			AsWallet wallet = new AsWallet();
			wallet.setUserId(user.getInt("userId"));
			wallet.setCreateTime(CommonUtils.getCurDate());
			operaFlag = asWalletMapper.insertSelective(wallet) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);

			// 添加员工帐号信息
			Conditions staffUser = Conditions.newInstance();
			staffUser.putData("account", account)
					.putData("password", CommonUtils.encryptPwd(password))
					.putData("createTime", CommonUtils.getCurDate())
					.putData("type", UserTypeEnum.STAFF.getId());
			operaFlag = asUserMapper.insertSelective(staffUser) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);

			// 添加员工信息
			AsShopStaffInfo staffInfo = new AsShopStaffInfo();
			staffInfo.setUserId(staffUser.getInt("userId"));
			staffInfo.setShopUserId(shopOwner.getInt("userId"));
			staffInfo.setShopId(shopOwner.getInt("shopId"));
			staffInfo.setDescp(descp);
			staffInfo.setName(name);
			staffInfo.setSn(get32UUID());
			operaFlag = asShopStaffInfoMapper.insertSelective(staffInfo) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);

			// 添加用户钱包
			AsWallet staffWallet = new AsWallet();
			staffWallet.setUserId(staffUser.getInt("userId"));
			staffWallet.setCreateTime(CommonUtils.getCurDate());
			operaFlag = asWalletMapper.insertSelective(staffWallet) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);

			break;

		case EDIT:

			shopOwner = asShopOwnerInfoMapper.findByUserId(pd);
			ValidatorBreakException.NOT_NULL(shopOwner);
			
			// 更新店铺信息
			uploadModule(UploadPathEnum.SHOP, "logoUrl");
			logoUrl = pd.get("logoUrl") == null ? shopOwner.getStr("logoUrl")
					: pd.get("logoUrl")
					.toString();
			ValidatorBreakException.NOT_TRUE(!(logoUrl == null || logoUrl
					.trim().length() == 0), "请上传商家LOGO");

			businessDistrictId = 0;
			store = asStoreMapper.selectByPrimaryKey(pd
					.getIntRequired("storeId"));
			if (store != null) {
				businessDistrictId = store.getBusinessDistrictId();
			}
			shop = Conditions.newInstance().copyFrom(pd);
			shop.keep("name", "logoUrl", "descp", "tel", "contact", "storeId",
					"floor")
					.putData(
"shopId", shopOwner.get("shopId"))
					.putData("business_district_id", businessDistrictId);
			operaFlag = asShopMapper.updateByPrimaryKeySelective(shop) > 0;

			// 更新优惠卷
			asCouponMapper.modifyStoreIdByShopId(Conditions.newInstance()
					.putData("shopId", shop.get("shopId"))
					.putData("storeId", shop.getInt("storeId")));

			break;

		default:
			ValidatorBreakException.NOT_TRUE(false);
		}

		return renderSuccess();
	}

	/**
	 * 查询商家列表
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @param c
	 * @return
	 */
	public Object listAll(BaseController c) {

		initialized(c);
		
		pageQueryModule(asShopOwnerInfoMapper, "listAll",
				true);
		
		return renderView(PAGE_PATH + "listAll");
	}

	/**
	 * 页面中转控制
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @return
	 */
	public Object page(BaseController c) {

		initialized(c);

		OperaEnum action = OperaEnum.get(pd.getInt("action") == 0 ? 1 : pd
				.getInt("action"));
		switch(action){

		case ADD:
			break;

		case EDIT:

			Conditions shopOwner = asShopOwnerInfoMapper.findByUserId(pd
					.getIntRequired("userId"));
			addViewData("pd", shopOwner);
			break;

		case QUERY:

			shopOwner = asShopOwnerInfoMapper.findByUserId(pd
					.getIntRequired("userId"));
			addViewData("pd", shopOwner);
			break;

			default:
				ValidatorBreakException.NOT_NULL(null);
		}

		addViewData("action", action.getId());

		List<Object> storeList = queryModule(asStoreMapper, "listAll", false);
		addViewData("storeList", storeList);

		Object floorList = asDictParamMapper
				.findByKeyCode(DictParam.PARAM_SHOP_FLOOR_OPT);
		if (floorList != null) {
			floorList = JSONArray.fromObject(floorList);
		}
		addViewData("floorList", floorList);

		return renderView(PAGE_PATH + "save");
	}

	/**
	 * 重置商家密码页面
	 * 
	 * @author yangyanchao
	 * @date 2016年9月14日
	 * @param c
	 * @return
	 */
	public Object resetPwdPage(BaseController c) {
		return resetPwdPage(c, null);
	}

	/**
	 * 重置商家密码页面
	 * 
	 * @author yangyanchao
	 * @date 2016年9月14日
	 * @param c
	 * @param operaResult
	 *            操作结果文案
	 * @return
	 */
	public Object resetPwdPage(BaseController c, String operaResult) {
		initialized(c);
		addViewData("pd",
				asShopOwnerInfoMapper.findByUserId(pd.getIntRequired("userId"))
						.keep("account", "userId"));
		addViewData("operaResult", operaResult);
		return renderView("manage/shopowner/resetPwdPage");
	}

	/**
	 * 密码重置 Action
	 * 
	 * @author yangyanchao
	 * @date 2016年9月3日
	 * @param c
	 * @return
	 */
	public Object resetPwd(BaseController c) {

		initialized(c);

		int userId = pd.getIntRequired("userId");

		AsUser user = (AsUser) asUserMapper.selectByPrimaryKey(userId);
		ValidatorBreakException.NOT_NULL(user);

		SysUser sysUser = (SysUser) sysUserMapper.selectByPrimaryKey(user
				.getSysUserId());
		ValidatorBreakException.NOT_NULL(sysUser);

		String password = pd.getStringRequired("password");
		String MD5Password = CommonUtils.encryptPwd(password);
		String SHA1Password = CommonUtils.encryptPwd(password, 2);

		user.setPassword(MD5Password);
		sysUser.setPassword(SHA1Password);

		operaFlag = asUserMapper.updateByPrimaryKeySelective(user) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		operaFlag = sysUserMapper.updateByPrimaryKeySelective(sysUser) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);

		return resetPwdPage(c, "" + "成功");
	}
	
	/*=====================================================================================================*/
	
	 /**
     * 店铺审核列表-业主  
     * @param c
     * @return
     * @author chenwz
     * @date 2017年06月09日
     */
    public Object getShopOwnerListAudit(BaseController c) {

        initialized(c);
        //判断是否商场账号
        if(!isRoomAdmin()){
            AsShop asShop =  asShopMapper.selectByPrimaryKey(getUser().getAs_shop_id());
            addField("storeId", asShop.getStoreId());
        }
        pageQueryModule(asShopOwnerInfoMapper, "getShopOwnerListAudit", true);
        return renderView(PAGE_PATH + "shopOwnerListAudit");
    }
    
    /**
     * 商户审核列表-运营
     * @param c
     * @return
     * @author chenwz
     * @date 2017年06月09日
     */
    public Object getShopOperatListAudit(BaseController c) {

        initialized(c);      
        pageQueryModule(asShopOwnerInfoMapper, "getShopOperatListAudit", true);
        return renderView(PAGE_PATH + "shopOperatListAudit");
    }
    
    
    /**
     * 更新审核状态
     * @param c
     * @return
     * @author chenwz
     * @date 2017年06月12日
     */
    public Object updateStatus(BaseController c) {
        initialized(c);
        int shopOwnerInfoId = pd.getInt("shopOwnerInfoId");
        int auditStatus = pd.getInt("auditStatus");
        int status = pd.getInt("status");
        String reason = pd.getString("reason");
        AsShopOwnerInfo owner = asShopOwnerInfoMapper.findByShopOwnerId(shopOwnerInfoId);
        ValidatorBreakException.NOT_NULL(owner);
        if(status == 3 && auditStatus == 1 ){
        	auditStatus=2;//运营审核
        	owner.setAuditStatus(auditStatus);
            owner.setAuditTime(DateUtil.getTime());            
            owner.setReason(reason);
            operaFlag = asShopOwnerInfoMapper.updateByPrimaryKeySelective(owner) == 1;
            ValidatorBreakException.NOT_TRUE(operaFlag);
        }else if(auditStatus == 1){      	
                owner.setAuditStatus(auditStatus);
                owner.setAuditTime(DateUtil.getTime());              
                owner.setReason(reason);
                operaFlag = asShopOwnerInfoMapper.updateByPrimaryKeySelective(owner) == 1;
                ValidatorBreakException.NOT_TRUE(operaFlag);
        } else if (auditStatus == 3) {
            	owner.setAuditStatus(auditStatus);
            	owner.setAuditTime(DateUtil.getTime());
            	owner.setReason(reason);
                operaFlag = asShopOwnerInfoMapper.updateByPrimaryKeySelective(owner) == 1;
                ValidatorBreakException.NOT_TRUE(operaFlag);
        }
		
        
        return renderSuccess(1);
    }
    
    /**
     * 批量新审核状态
     * @return
     * @author chenwz
     * @date 2017年06月12日
     */
    public Object allAuditStatus(String[] ids, Integer auditStatus) {
        Map<String, Object> data = new HashMap<String, Object>();
        String errIds = "";
        if (ids.length > 0) {
            for (int i = 0; i < ids.length; i++) {
                Integer shopOwnerInfoId = Integer.valueOf(ids[i]);
                AsShopOwnerInfo  owner = new AsShopOwnerInfo(); 
                owner.setShopOwnerInfoId(shopOwnerInfoId);
                if (auditStatus == 1) {               	
                	owner.setAuditStatus(auditStatus);
                	owner.setAuditTime(DateUtil.getTime());               	
                	owner.setReason("业主批量审核通过");
                    operaFlag = asShopOwnerInfoMapper.updateByPrimaryKeySelective(owner) == 1;
                    if (!operaFlag) {
                        errIds = owner.toString() + ",";
                    }
                } else if (auditStatus == 2) {               	
                	owner.setAuditStatus(auditStatus);
                	owner.setAuditTime(DateUtil.getTime());
                	owner.setReason("管理员批量审核通过");
                    operaFlag = asShopOwnerInfoMapper.updateByPrimaryKeySelective(owner) == 1;
                    ValidatorBreakException.NOT_TRUE(operaFlag);
                    if (!operaFlag) {
                        errIds = owner.toString() + ",";
                    }
                }
            }
            data.put("status", "0");
            data.put("errIds", errIds);
        } else {
            data.put("status", "1");
        }
        return data;
    }
    
    

}
