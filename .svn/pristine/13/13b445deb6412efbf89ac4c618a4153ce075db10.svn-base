package com.aoshi.service.business.yp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.common.asenum.baseTypeEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsAreaMapper;
import com.aoshi.dao.AsCityMapper;
import com.aoshi.dao.AsProvinceMapper;
import com.aoshi.dao.AsYpScreenDomainMapper;
import com.aoshi.dao.AsYpScreenInfoMapper;
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsProvince;
import com.aoshi.domain.AsYpScreenInfo;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.Conditions;

import net.sf.json.JSONArray;

@Service
public class BusinessScreenService extends AsBaseService {

	private final static String PAGE_PATH = "business/yp/screen/";

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
		addField("shopId", getUser().getAs_shop_id());
		addViewData("screenNum", ypScreenInfoMapper.queryScreenNum(pd));
		pageQueryModule(ypScreenInfoMapper, "listScreenAll",
				true);
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
		addField("type", baseTypeEnum.INDUSTRY.getId());
		addField("shopId", getUser().getAs_shop_id());
		List<Conditions> domains = ypScreenDomainMapper.listAll(pd);//站点
		addViewData("opearTime", CommonUtils.getCurDate());
		addViewData("provinceList", provinceList);
		addViewData("cityList", cityListJson);
		addViewData("areaList", areaListJson);
		addViewData("domains", domains);
		addViewData("pd", pd);
		addViewData("msg", "opera");
		break;
	case EDIT:
		addField("shopId", getUser().getAs_shop_id());
		domains = ypScreenDomainMapper.listAll(pd);//站点
		 provinceList = provinceMapper.selectByAttr(null);
		 cityList = asCityMapper.selectByAttr(null);
		 areaList = asAreaMapper.selectByAttr(null);
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
			String sn = pd.getStringRequired("sn");
			int screenDomainId = pd.getIntRequired("screenDomainId");
			int provinceId = pd.getIntRequired("provinceId");
			int cityId = pd.getIntRequired("cityId");
			int areaId =pd.getIntRequired("areaId");
			String address = pd.getStringRequired("address");
			
			AsYpScreenInfo sc = new AsYpScreenInfo();//域名和详细地址
			sc.setSn(sn);
			sc.setScreenDomainId(screenDomainId);
			sc.setProvinceId(provinceId);
			sc.setCityId(cityId);
			sc.setAreaId(areaId);
			sc.setAddress(address);
			sc.setCreateTime(CommonUtils.getCurDate());
			sc.setStatus(0);
			sc.setClickCount(0);
			sc.setShopId(Integer.parseInt(getUser().getAs_shop_id()));
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
