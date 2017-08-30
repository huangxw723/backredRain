package com.aoshi.service.business;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsActivityReceivedRecordMapper;
import com.aoshi.dao.AsPrizeMapper;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.domain.AsShop;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;

@Service
public class ShopService extends AsBaseService {

	private final static String PAGE_PATH = "business/shop/";

	@Autowired
	private AsActivityReceivedRecordMapper asActivityReceivedRecordMapper;

	@Autowired
	private AsPrizeMapper asPrizeMapper;
	
	@Autowired
	private AsShopMapper asShopMapper;
	
	/**
	 * 店铺礼品记录
	 * 
	 * @author yangyanchao
	 * @date 2016年9月6日
	 * @param c
	 * @return
	 */
	public Object receivedHistoryByShop(BaseController c) {

		initialized(c);
		
		addField("shopId", getUser().getAs_shop_id());
		pageQueryModule(asActivityReceivedRecordMapper, "receivedHistoryByShop", true);
		
		addViewData("type", pd.getInt("type"));
		return renderView(PAGE_PATH + "receivedHistoryByShop");
	}

	/**
	 * 查看礼品详情
	 * 
	 * @author yangyanchao
	 * @date 2016年9月7日
	 * @param c
	 * @return
	 */
	public Object prizeDetail(BaseController c) {

		initialized(c);

		Object prize = asPrizeMapper.findById(pd);
		ValidatorBreakException.NOT_NULL(prize, 1001, "数据异常,请刷新后重试", 1);
		addViewData("pd", prize);

		return renderView(PAGE_PATH + "prizeDetail");
	}
	
	public AsShop findByShopId(String shopId) {
		return asShopMapper.selectByPrimaryKey(shopId);
	}
}
