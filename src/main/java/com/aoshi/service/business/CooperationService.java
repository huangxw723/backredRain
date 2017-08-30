package com.aoshi.service.business;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsCooperationMapper;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsCooperation;
import com.aoshi.domain.AsProvince;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.service.manage.locality.AsCityService;
import com.aoshi.service.manage.locality.AsProvinceService;
import com.aoshi.util.PageData;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * CooperationService
 *
 * @author zf
 * @date 11/2/16
 */
@Service
public class CooperationService extends AsBaseService {
    @Autowired
    AsCooperationMapper cooperationMapper;
    
    @Autowired
    AsShopMapper shopMapper;

    @Autowired
    private AsProvinceService asProvinceService;

    @Autowired
    private AsCityService asCityService;
    
    /**
     * 批量添加战略合作商户
     *@author tgb
     *创建时间：2017年3月8日 
     *@version 1.0
     * @param ids
     * @param shopId
     */
    public void addByPrimaryKeys(String[] ids, int shopId){
        for (String i : ids){
            AsCooperation asCooperation = new AsCooperation();
            asCooperation.setActiveId(shopId);
            asCooperation.setUnactiveId(Integer.valueOf(i));
            cooperationMapper.insert(asCooperation);
        }
    }

    /**
     * 批量删除已经合作的商户
     *@author tgb
     *创建时间：2017年3月8日 
     *@version 1.0
     * @param businessDistrictIds
     * @return
     */
    public int deleteAll(String[] businessDistrictIds) {
        return cooperationMapper.deleteByPrimaryKeys(businessDistrictIds);
    }
    

	/**
	 * 已合作列表
	 *@author tgb
	 *创建时间：2017年3月8日 
	 *@version 1.0
	 * @return
	 */

    public Object cooperationList(BaseController c) {

        initialized(c);
        addField("shopId",getUser().getAs_shop_id());
        pageQueryModule(cooperationMapper, "selectShopByCooperation", true);

        addViewData("shopId", getUser().getAs_shop_id());
        addViewData("pd", pd);
        PageData attr = new PageData();
        List<AsProvince> provinceList = asProvinceService.list(attr);
        addViewData("provinceList", provinceList);
        List<AsCity> cityList = asCityService.list(attr);
        JSONArray cityListJson = JSONArray.fromObject(cityList);
        addViewData("cityList", cityListJson);
        return renderView("business/cooperation/cooperationSelectList");

    }
	/**
     * 跳转到添加合作伙伴列表(未合作商户列表)
     * @author tgb 创建时间：2017年2月23日
     * @version 1.0
     * @return
     */
    public Object addCooperation(BaseController c) {

        initialized(c);
        addField("shopId",getUser().getAs_shop_id());
        pageQueryModule(shopMapper, "selectByNoAddCooperation", true);

        addViewData("shopId", getUser().getAs_shop_id());
        addViewData("pd", pd);
        PageData attr = new PageData();
        List<AsProvince> provinceList = asProvinceService.list(attr);
        addViewData("provinceList", provinceList);
        List<AsCity> cityList = asCityService.list(attr);
        JSONArray cityListJson = JSONArray.fromObject(cityList);
        addViewData("cityList", cityListJson);
        return renderView("business/cooperation/cooperationList");

    }
}
