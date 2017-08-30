package com.aoshi.service.manage.yp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.common.asenum.baseTypeEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsAreaMapper;
import com.aoshi.dao.AsCityMapper;
import com.aoshi.dao.AsProvinceMapper;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.dao.AsYpScreenDomainMapper;
import com.aoshi.dao.AsYpScreenInfoMapper;
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsProvince;
import com.aoshi.domain.AsYpScreenDomain;
import com.aoshi.domain.AsYpScreenInfo;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.Conditions;

import net.sf.json.JSONArray;

@Service
public class YpScreenService extends AsBaseService {

	private final static String PAGE_PATH = "manage/yp/ypScreenShop/";

	@Autowired
	private AsYpScreenInfoMapper ypScreenInfoMapper;
	
	@Autowired
	private AsYpScreenDomainMapper  ypScreenDomainMapper;
	
	@Autowired
	private AsProvinceMapper provinceMapper;
	
	@Autowired
	private AsCityMapper asCityMapper;

	@Autowired
	private AsAreaMapper asAreaMapper;
	
	@Autowired
	private AsShopMapper asShopMapper;
	
	/**
	 * 查询云屏终端列表
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	public Object listAll(BaseController c) {

		initialized(c);
		pageQueryModule(ypScreenInfoMapper, "listScreenAll",
				true);
		addViewData("screenNum",ypScreenInfoMapper.SrceenNumCount(pd));
		return renderView(PAGE_PATH + "screenListAll");
	}

	
	/**
	 * 终端审核
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	public Object operaSumbmit(BaseController c) {
		initialized(c);
		operaFlag = ypScreenInfoMapper.updateScreenStatus(pd)==1;
		ValidatorBreakException.NOT_TRUE(operaFlag,"操作成功!");
		return renderSuccess();
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
		addField("type", baseTypeEnum.INDUSTRY.getId());
		List<AsYpScreenDomain> domainList = ypScreenDomainMapper.getDomains(pd);//站点
		JSONArray domains = JSONArray.fromObject(domainList);
		List<Conditions> shops = asShopMapper.getShopALL(null);//站点
		addViewData("opearTime", CommonUtils.getCurDate());
		addViewData("provinceList", provinceList);
		addViewData("cityList", cityListJson);
		addViewData("areaList", areaListJson);
		addViewData("domains", domains);
		addViewData("shops", shops);
		addViewData("pd", pd);
		addViewData("msg", "opera");
		break;
	case EDIT:
		domainList = ypScreenDomainMapper.getDomains(pd);//站点
		domains = JSONArray.fromObject(domainList);
		 provinceList = provinceMapper.selectByAttr(null);
		 cityList = asCityMapper.selectByAttr(null);
		 areaList = asAreaMapper.selectByAttr(null);
		 shops = asShopMapper.getShopALL(null);//站点
		addViewData("shops", shops);
		addField("type", baseTypeEnum.INDUSTRY.getId());
		addViewData("opearTime", CommonUtils.getCurDate());
		addViewData("provinceList", provinceList);
		addViewData("cityList", cityList);
		addViewData("areaList", areaList);
		addViewData("domains", domains);
		AsYpScreenInfo sc = (AsYpScreenInfo)ypScreenInfoMapper.selectByPrimaryKey(pd);//域名和详细地址
	    addViewData("sc", sc);
	    addViewData("pd", pd);
		addViewData("msg", "opera");
		break;
	case QUERY:
		
		break;
		default:
			ValidatorBreakException.NOT_NULL(null);
		}
		addViewData("action", action.getId());
		return renderView(PAGE_PATH + "screenSave");
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
			String sn = pd.getStringRequired("sn");
			int screenDomainId = pd.getIntRequired("screenDomainId");
			int provinceId = pd.getIntRequired("provinceId");
			int cityId = pd.getIntRequired("cityId");
			int areaId =pd.getIntRequired("areaId");
			String address = pd.getStringRequired("address");
			int shopId =pd.getIntRequired("shopId");
			
			AsYpScreenInfo sc = new AsYpScreenInfo();//域名和详细地址
			sc.setSn(sn);
			sc.setShopId(shopId);
			sc.setScreenDomainId(screenDomainId);
			sc.setProvinceId(provinceId);
			sc.setCityId(cityId);
			sc.setAreaId(areaId);
			sc.setAddress(address);
			sc.setCreateTime(CommonUtils.getCurDate());
			sc.setStatus(0);
			sc.setClickCount(0);
			sc.setShopId(shopId);
			sc.setOperaTime(CommonUtils.getCurDate());
			operaFlag =ypScreenInfoMapper.insertSelective(sc)==1;
			ValidatorBreakException.NOT_TRUE(operaFlag);
	
		break;
		case EDIT:
			sc = (AsYpScreenInfo)ypScreenInfoMapper.selectByPrimaryKey(pd);//域名和详细地址
			Conditions  doma = Conditions.newInstance()
			.putData("screenInfoId",sc.getScreenInfoId())
			.putData("screenDomainId", pd.get("screenDomainId"))
			.putData("address", pd.get("address"))
			.putData("operaTime", CommonUtils.getCurDate());
			operaFlag =ypScreenInfoMapper.updateByPrimaryKeySelective(doma)==1;
			ValidatorBreakException.NOT_TRUE(operaFlag);
			break;
		case DELETE:
			operaFlag =ypScreenInfoMapper.deleteByPrimaryKey(pd.get("screenInfoId"))==1;
			ValidatorBreakException.NOT_TRUE(operaFlag, "数据信息已过期，请刷新后重试");

		default:
			ValidatorBreakException.NOT_TRUE(false);
		}

		return renderSuccess();
	}

	public Object subMmitpage(BaseController c) {
		initialized(c);
		addViewData("pd", pd);
		return renderView(PAGE_PATH + "submmitList");
	}
   
}
