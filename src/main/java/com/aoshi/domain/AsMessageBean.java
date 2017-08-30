package com.aoshi.domain;

/**
 * 消息内容Bean
 * 
 * @author yangyanchao
 * @date 2016年8月3日
 */
public class AsMessageBean {

	// 消息ID
	private int msgId;
	// 动态跳转ID
	private int refId;
	// 消息标题
	private String msgTitle;
	// 消息时间
	private String msgTime;
	// 消息所属板块类型枚举 1卖家动态 2买家动态 3快递动态
	private int msgType;
	// 消息图标
	private String msgImg;
	// 消息内容
	private String msgContent;

	public int getMsgId() {
		return msgId;
	}

	public void setMsgId(int msgId) {
		this.msgId = msgId;
	}

	public int getRefId() {
		return refId;
	}

	public void setRefId(int refId) {
		this.refId = refId;
	}

	public String getMsgTitle() {
		return msgTitle;
	}

	public void setMsgTitle(String msgTitle) {
		this.msgTitle = msgTitle;
	}

	public String getMsgTime() {
		return msgTime;
	}

	public void setMsgTime(String msgTime) {
		this.msgTime = msgTime;
	}

	public int getMsgType() {
		return msgType;
	}

	public void setMsgType(int msgType) {
		this.msgType = msgType;
	}

	public String getMsgImg() {
		return msgImg;
	}

	public void setMsgImg(String msgImg) {
		this.msgImg = msgImg;
	}

	public String getMsgContent() {
		return msgContent;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

}