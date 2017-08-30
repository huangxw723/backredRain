package com.aoshi.service.manage.integration.order;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsOrderMapper;
import com.aoshi.dao.AsShippingMapper;
import com.aoshi.domain.AsShipping;
import com.aoshi.service.base.AsBaseService;

/**
 * 积分商城订单Service
 * 
 * @author yangyanchao
 * @date 2016年12月7日
 */
@Service
public class IntegrationOrderService extends AsBaseService {

	private static final String PAGE_PATH = "manage/integration/order/";

	@Autowired
	private AsOrderMapper asOrderMapper;

	@Autowired
	private AsShippingMapper asShippingMapper;
	
	public Object getIntegrationOrderList(BaseController c) {

		initialized(c);

		pageQueryModule(asOrderMapper, "getIntegrationOrderList", true);
		
		addViewData("shippingList", getShippingList());
		return renderView(PAGE_PATH + "integration_list");
	}
	
	// 获取配送商列表
	public List<AsShipping> getShippingList(){
		List<AsShipping> shippingList = asShippingMapper.selectAllForAvailable(null);
	    return shippingList;
	}
}
