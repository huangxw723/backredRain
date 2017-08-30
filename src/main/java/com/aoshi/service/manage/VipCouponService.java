package com.aoshi.service.manage;

import com.aoshi.common.asenum.BaseCategoryTypeEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsPrizeCategoryMapper;
import com.aoshi.dao.AsPrizeMapper;
import com.aoshi.dao.AsYpBaseCategoryMapper;
import com.aoshi.domain.AsPrize;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class VipCouponService extends AsBaseService{

	private final static String PAGE_PATH_VIPCOUPON="manage/vipCoupon/";
	
	@Autowired
	private AsPrizeCategoryMapper asPrizeCategoryMapper;

	@Autowired
	private AsYpBaseCategoryMapper asYpBaseCategoryMapper;
	
	@Autowired AsPrizeMapper prizeMapper;
		
	/**
	 * 获取所有会员优惠券列表
	 * @return
	 */
	public Object getCouponList(BaseController c){
		initialized(c);
        pageQueryModule(prizeMapper, "listAll", true);
		List<AsYpBaseCategory> prizeTypeList = asYpBaseCategoryMapper
				.queryPrizeListAll(BaseCategoryTypeEnum.REDRAIN_PRIZE_TYPE
						.getId());
		ValidatorBreakException.NOT_NULL(prizeTypeList, "获取礼品分类失败");
		ArrayList<AsYpBaseCategory> newPrizeTypeList = new ArrayList<AsYpBaseCategory>();
			for (AsYpBaseCategory aCategory : prizeTypeList) {
			if (aCategory.getName().equals("折扣券")
					|| aCategory.getName().equals("代金券")
					|| aCategory.getName().equals("礼品券")
					|| aCategory.getName().equals("实物礼品")) {
					newPrizeTypeList.add(aCategory);
				}
			}		
		addViewData("prizeTypeList", newPrizeTypeList);
		pd.put("type", BaseCategoryTypeEnum.REDRAIN_COUPON_TYPE.getId());
		List<Object> tagTypeList = queryModule(asYpBaseCategoryMapper,
				"queryCouponsListAll", false);
		addViewData("tagTypeList", tagTypeList);
		return renderView(PAGE_PATH_VIPCOUPON+"vipCouponList");
	}
	
	/**
	 * 删除操作
	 * @return
	 */
	public int updateCoupon(Integer prizeId){
		AsPrize prize = new AsPrize();
		prize.setPrizeId(prizeId);
		prize.setStatus(3);
		return prizeMapper.updateByPrimaryKeySelective(prize);
	}
}
