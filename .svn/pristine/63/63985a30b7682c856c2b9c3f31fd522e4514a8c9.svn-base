package com.aoshi.service.manage.integration.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.common.asenum.OrderActionEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsMessageConfigMapper;
import com.aoshi.dao.AsMessageRecordMapper;
import com.aoshi.dao.AsOrderActionMapper;
import com.aoshi.dao.AsOrderGoodsMapper;
import com.aoshi.dao.AsOrderMapper;
import com.aoshi.dao.AsOrderMergeMapper;
import com.aoshi.dao.AsUserMapper;
import com.aoshi.domain.AsMessageBean;
import com.aoshi.domain.AsMessageConfig;
import com.aoshi.domain.AsMessageRecord;
import com.aoshi.domain.AsOrder;
import com.aoshi.domain.AsOrderAction;
import com.aoshi.domain.AsOrderGoods;
import com.aoshi.domain.AsUser;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.DateUtil;

import net.sf.json.JSONObject;

/**
 * 同意退款模块Service
 * 
 * @author yangyanchao
 * @date 2016年8月3日
 */
@Service
public class AsAgreeRefundService extends AsBaseService {

	@Autowired
	private AsOrderGoodsMapper asOrderGoodsMapperDao;

	@Autowired
	private AsOrderActionMapper actionMapper;

	@Autowired
	private AsOrderMapper asOrderMapperDao;

	@Autowired
	private AsOrderMergeMapper asOrderMergeMapperDao;

	@Autowired
	private AsOrderActionMapper asOrderActionMapperDao;

	@Autowired
	private AsMessageConfigMapper asMessageConfigMapperDao;

	@Autowired
	private AsMessageRecordMapper asMessageRecordMapperDao;

	@Autowired
	private AsUserMapper asUserMapperDao;

	private AsOrderAction action;

	private AsOrderGoods asOrderGoods;

	private AsOrder asOrder;

	/**
	 * 同意退款
	 * 
	 * @author yangyanchao
	 * @date 2016年8月1日
	 * @param c
	 * @return
	 */
	public Object agreeRefund_Tx(BaseController c) {

		initialized(c);

		// 更新商品订单状态
		updateOrderGoods();

		// 添加订单动态
		addOrderAction();

		// 添加店铺交易信息
		addSellerMessage();

		// 添加用户交易信息
		addBuyerMessage();

		return renderSuccess();
	}

	/**
	 * 添加买家交易消息
	 * 
	 * @author yangyanchao
	 * @date 2016年8月3日
	 */
	private void addBuyerMessage() {

		try {
			AsUser asUser = (AsUser) asUserMapperDao.selectByPrimaryKey(asOrder
					.getUserId());
			ValidatorBreakException.NOT_NULL(asUser);
			AsMessageConfig buyerMsgConfig = (AsMessageConfig) asMessageConfigMapperDao
					.findByUserId(asUser.getUserId());

			if (buyerMsgConfig != null
					&& buyerMsgConfig.getTradeMessageOpen() == 1) {
				AsMessageRecord asMessageRecord = new AsMessageRecord();
				asMessageRecord.setUserId(asUser.getUserId());
				asMessageRecord.setCreateTime(CommonUtils.getCurDate());
				asMessageRecord
						.setMessageType(OrderActionEnum.AGREE_REFUND_BUYER
								.getMsgType());
				AsMessageBean asMessageBean = new AsMessageBean();
				asMessageBean.setMsgType(OrderActionEnum.AGREE_REFUND_BUYER
						.getMsgType());
				asMessageBean.setMsgTime(CommonUtils.getCurDate());
				asMessageBean
						.setMsgTitle(String.format(
								OrderActionEnum.AGREE_REFUND_BUYER
										.getMsgTitle(), CommonUtils
										.priceFormat(asOrderGoods
												.getActualPrice())));
				asMessageBean.setMsgContent(String.format(
						OrderActionEnum.AGREE_REFUND_BUYER.getMsgContent(),
						getUserName(asUser), asOrder.getOrderSn()));
				asMessageBean.setRefId(asOrder.getOrderId());
				asMessageRecord.setMessage(JSONObject.fromObject(asMessageBean)
						.toString());
				operaFlag = asMessageRecordMapperDao
						.insertSelective(asMessageRecord) == 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 添加卖家交易消息
	 * 
	 * @author yangyanchao
	 * @date 2016年8月3日
	 */
	private void addSellerMessage() {

		asOrder = asOrderMapperDao
				.selectByPrimaryKeys(asOrderGoods.getOrderId());
		ValidatorBreakException.NOT_NULL(asOrder);

		try {

			AsUser asUser = (AsUser) asUserMapperDao.selectByShopId(asOrder
					.getShopId());
			ValidatorBreakException.NOT_NULL(asUser);
			AsMessageConfig shopMsgConfig = (AsMessageConfig) asMessageConfigMapperDao
					.findByUserId(asUser.getUserId());

			if (shopMsgConfig != null
					&& shopMsgConfig.getShopMessageOpen() == 1) {
				AsMessageRecord asMessageRecord = new AsMessageRecord();
				asMessageRecord.setUserId(asUser.getUserId());
				asMessageRecord.setCreateTime(CommonUtils.getCurDate());
				asMessageRecord
						.setMessageType(OrderActionEnum.AGREE_REFUND_SELLER
								.getMsgType());
				AsMessageBean asMessageBean = new AsMessageBean();
				asMessageBean.setMsgType(OrderActionEnum.AGREE_REFUND_SELLER
						.getMsgType());
				asMessageBean.setMsgTime(CommonUtils.getCurDate());
				asMessageBean
						.setMsgTitle(String.format(
								OrderActionEnum.AGREE_REFUND_SELLER
										.getMsgTitle(), CommonUtils
										.priceFormat(asOrderGoods
												.getActualPrice())));
				asMessageBean.setMsgContent(String.format(
						OrderActionEnum.AGREE_REFUND_SELLER.getMsgContent(),
						asOrder.getOrderSn()));
				asMessageBean.setRefId(asOrder.getOrderId());
				asMessageRecord.setMessage(JSONObject.fromObject(asMessageBean)
						.toString());
				operaFlag = asMessageRecordMapperDao
						.insertSelective(asMessageRecord) == 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 更新商品订单状态
	 * 
	 * @author yangyanchao
	 * @date 2016年8月3日
	 */
	private void updateOrderGoods() {
		asOrderGoods = (AsOrderGoods) asOrderGoodsMapperDao
				.selectByPrimaryKeyWithLock(pd.getInt("orderGoodsId"));
		ValidatorBreakException.NOT_NULL(asOrderGoods);
		ValidatorBreakException.NOT_TRUE(asOrderGoods.getStatus() == 2);
		asOrderGoods.setStatus(3);
		operaFlag = asOrderGoodsMapperDao.updateByPrimaryKey(asOrderGoods) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
	}

	/**
	 * 添加订单操作记录
	 * 
	 * @author yangyanchao
	 * @date 2016年8月3日
	 */
	private void addOrderAction() {
		action = new AsOrderAction();
		action.setActionAdmin(getUser().getUSER_ID());
		action.setActionNote(6);
		action.setOrderId(asOrderGoods.getOrderId());
		action.setOrderGoodsId(asOrderGoods.getOrderGoodsId());
		action.setStatus(3);
		action.setActionRemark("同意退款/退货");
		action.setActionTime(DateUtil.getTime());
		operaFlag = asOrderActionMapperDao.insertSelective(action) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
	}
}
