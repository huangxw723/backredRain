package com.aoshi.service.pay.notify;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.aoshi.common.asenum.OrderActionEnum;
import com.aoshi.common.asenum.OrderPayType;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsMessageConfigMapper;
import com.aoshi.dao.AsMessageRecordMapper;
import com.aoshi.dao.AsOrderActionMapper;
import com.aoshi.dao.AsOrderGoodsMapper;
import com.aoshi.dao.AsOrderMapper;
import com.aoshi.dao.AsOrderRefundMapper;
import com.aoshi.dao.AsShopCapitalMapper;
import com.aoshi.dao.AsUserAccountMapper;
import com.aoshi.dao.AsUserMapper;
import com.aoshi.domain.AsMessageBean;
import com.aoshi.domain.AsMessageConfig;
import com.aoshi.domain.AsMessageRecord;
import com.aoshi.domain.AsOrder;
import com.aoshi.domain.AsOrderAction;
import com.aoshi.domain.AsOrderGoods;
import com.aoshi.domain.AsOrderRefund;
import com.aoshi.domain.AsShopCapital;
import com.aoshi.domain.AsUser;
import com.aoshi.domain.AsUserAccount;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.Conditions;

/**
 * 支付宝退款回调
 * 
 * @author yangyanchao
 * @date 2016年7月27日
 */
@Service
public class AsAlipayNotifyService extends AsBaseService {

	@Autowired
	private AsOrderMapper asOrderMapperDao;

	@Autowired
	private AsOrderActionMapper asOrderActionMapperDao;

	@Autowired
	private AsOrderGoodsMapper orderGoodsMapper;

	@Autowired
	private AsOrderActionMapper orderActionMapper;

	@Autowired
	private AsOrderRefundMapper orderRefundMapper;

	@Autowired
	private AsUserMapper asUserMapperDao;

	@Autowired
	private AsUserAccountMapper asUserAccountMapperDao;

	@Autowired
	private AsMessageConfigMapper asMessageConfigMapperDao;

	@Autowired
	private AsShopCapitalMapper asShopCapitalMapperDao;

	@Autowired
	private AsMessageRecordMapper asMessageRecordMapperDao;

	@Autowired
	DataSourceTransactionManager txManager;

	private String batchNo;
	private Conditions conditions = CommonUtils.getConditions();

	private AsOrderGoods asOrderGoods;

	private String resultDetails;

	private boolean isSuccess;

	private String price;

	private AsOrder asOrder;

	/**
	 * 业务入口
	 * 
	 * @author yangyanchao
	 * @date 2016年7月27日
	 * @param c
	 * @return
	 */
	public Object refundAlipayComplete(BaseController c) {

		initialized(c);

		// TODO 支付宝校验注释
		/*
		 * if (!AlipayNotify.verify(pd)) { logger.error("退款回调参数验证错误"); return
		 * "fail"; }
		 */

		new Thread(new Runnable() {

			@Override
			public void run() {

				checkTrade();

				if (!isSuccess)
					return;

				// 开启事务
				DefaultTransactionDefinition def = new DefaultTransactionDefinition();
				def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
				TransactionStatus status = txManager.getTransaction(def);

				// 更新商品订单状态
				updateOrderGoods();

				// 检测订单是否需要回写关闭(该订单所有商品都被退款)
				checkOrderClose();

				// 更新订单操作流水
				updateOrderActoin();

				// 添加退款记录
				addOrderRefund();

				// 减去商家钱包相应的金额
				updateShopCapital();

				// 添加资金流水
				addAcountFlow();

				// 发 买家和卖家消息
				message();

				txManager.commit(status);
			}
		}).start();

		return "success";
	}

	/**
	 * 消息推送
	 * 
	 * @author yangyanchao
	 * @date 2016年8月29日
	 */
	private void message() {

		// 添加卖家消息
		addSellerMessage();

		// 添加买家消息
		addBuyerMessage();
	}

	/**
	 * 更新商家提现订单金额
	 * 
	 * @author yangyanchao
	 * @date 2016年8月9日
	 */
	private void updateShopCapital() {
		AsShopCapital asShopCapital = (AsShopCapital) asShopCapitalMapperDao
				.findByOrderId(asOrder.getOrderId());
		BigDecimal orderPrice = asShopCapital.getCapitalAmount();
		BigDecimal refundPrice = asOrderGoods.getActualPrice();
		asShopCapital.setCapitalAmount(orderPrice.min(refundPrice));
		asShopCapital.setUpdateTime(CommonUtils.getCurDate());
		operaFlag = asShopCapitalMapperDao
				.updateByPrimaryKeySelective(asShopCapital) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
	}

	/**
	 * 添加买家消息
	 * 
	 * @author yangyanchao
	 * @date 2016年8月9日
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
	 * 添加卖家消息
	 * 
	 * @author yangyanchao
	 * @date 2016年8月9日
	 */
	private void addSellerMessage() {

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
	 * 检测订单是否需要回写关闭(该订单所有商品都被退款)
	 * 
	 * @author yangyanchao
	 * @date 2016年7月28日
	 */
	private void checkOrderClose() {
		asOrder = asOrderMapperDao
				.selectByPrimaryKey(asOrderGoods.getOrderId());
		ValidatorBreakException.NOT_NULL(asOrder);
		boolean isNeedClose = orderGoodsMapper
				.selectNotRefundCounts(asOrderGoods.getOrderId()) == 0;
		if (isNeedClose) {
			conditions.cleanConditions()
					.putData("orderId", asOrderGoods.getOrderId())
					.putData("orderStatus", 8);
			operaFlag = asOrderMapperDao
					.updateByPrimaryKeySelective(conditions) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);
		}
	}

	/**
	 * 添加账户资金流水
	 * 
	 * @author yangyanchao
	 * @date 2016年7月27日
	 */
	private void addAcountFlow() {

		// 用户退款流水
		AsUserAccount customAccount = new AsUserAccount();
		customAccount.setAccountType(4);
		customAccount.setAmount(new BigDecimal(price));
		customAccount.setCreateTime(CommonUtils.getCurDate());
		customAccount.setItemId(asOrderGoods.getOrderGoodsId());
		customAccount.setUserId(asOrder.getUserId());
		operaFlag = asUserAccountMapperDao.insertSelective(customAccount) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);

		// 卖家退款流水
		AsUser shop = (AsUser) asUserMapperDao.selectByShopId(asOrder
				.getShopId());
		ValidatorBreakException.NOT_NULL(shop);
		AsUserAccount shopAccount = new AsUserAccount();
		shopAccount.setAccountType(4);
		shopAccount.setAmount(new BigDecimal(price));
		shopAccount.setCreateTime(CommonUtils.getCurDate());
		shopAccount.setItemId(asOrderGoods.getOrderGoodsId());
		shopAccount.setUserId(shop.getUserId());
		operaFlag = asUserAccountMapperDao.insertSelective(shopAccount) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
	}

	/**
	 * 添加退款记录
	 * 
	 * @author yangyanchao
	 * @date 2016年7月27日
	 */
	private void addOrderRefund() {
		AsOrderRefund asOrderRefund = new AsOrderRefund();
		asOrderRefund.setOrderId(asOrderGoods.getOrderId());
		asOrderRefund.setOrderGoodsId(asOrderGoods.getOrderGoodsId());
		asOrderRefund.setRefundPrice(new BigDecimal(price));
		asOrderRefund.setRefundResult(resultDetails);
		asOrderRefund.setRefundType(OrderPayType.ALIPAY.getId());
		asOrderRefund.setRefundTime(CommonUtils.getCurDate());
		asOrderRefund.setRefundNo(asOrderGoods.getRefundNo());
		operaFlag = orderRefundMapper.insertSelective(asOrderRefund) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
	}

	/**
	 * 更新订单动态
	 * 
	 * @author yangyanchao
	 * @date 2016年7月27日
	 */
	private void updateOrderActoin() {
		AsOrderAction asOrderAction = new AsOrderAction();
		asOrderAction.setOrderId(asOrderGoods.getOrderId());
		asOrderAction.setOrderGoodsId(asOrderGoods.getOrderGoodsId());
		asOrderAction.setStatus(4);
		asOrderAction.setActionNote(8);
		asOrderAction.setActionTime(CommonUtils.getCurDate());
		operaFlag = asOrderActionMapperDao.insertSelective(asOrderAction) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
	}

	/**
	 * 解析回调数据
	 * 
	 * @author yangyanchao
	 * @date 2016年7月27日
	 */
	private void checkTrade() {

		batchNo = pd.getStringRequired("batch_no");
		resultDetails = pd.getStringRequired("result_details");
		List<String> params = Arrays.asList(resultDetails.split("\\^"));
		price = params.get(1);
		String tradeStatus = params.get(2);
		int tradeSuccessNum = pd.getIntRequired("success_num");
		if (StringUtils.equals(tradeStatus, "SUCCESS") && tradeSuccessNum == 1) {
			isSuccess = true;
		}
	}

	/**
	 * 更新商品订单状态
	 * 
	 * @author yangyanchao
	 * @date 2016年7月27日
	 */
	private void updateOrderGoods() {
		asOrderGoods = (AsOrderGoods) orderGoodsMapper
				.selectByRefundNoWithLock(batchNo);
		ValidatorBreakException.NOT_NULL(asOrderGoods, "商品不存在");
		ValidatorBreakException
				.NOT_TRUE(asOrderGoods.getStatus() != 4, "订单已支付");
		conditions.cleanConditions()
				.putData("orderGoodsId", asOrderGoods.getOrderGoodsId())
				.putData("status", 4);
		operaFlag = orderGoodsMapper.updateByPrimaryKeySelective(conditions) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
	}
}
