package com.aoshi.common.asenum;

/**
 * 订单操作文案枚举
 * 
 * @author yangyanchao
 * @date 2016年8月3日
 */
public enum OrderActionEnum {

	// 退款消息文案
	AGREE_REFUND_BUYER(2, "退款提醒: 您的%s元退款进度有更新!",
			"亲爱的\"%s\",退款售后编号: %s,已经同意申请退款,客服正在与买家取得联系!"), AGREE_REFUND_SELLER(
			1, "退款提醒: 您的%s元退款进度有更新!", "退款售后编号: %s,已经同意申请退款,客服正在与买家取得联系!")

	;

	private int msgType;
	private String msgTitle;
	private String msgContent;

	public int getMsgType() {
		return msgType;
	}

	public void setMsgType(int msgType) {
		this.msgType = msgType;
	}

	public String getMsgTitle() {
		return msgTitle;
	}

	public void setMsgTitle(String msgTitle) {
		this.msgTitle = msgTitle;
	}

	public String getMsgContent() {
		return msgContent;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

	private OrderActionEnum(int msgType, String msgTitle, String msgContent) {
		this.msgType = msgType;
		this.msgTitle = msgTitle;
		this.msgContent = msgContent;
	}
}
