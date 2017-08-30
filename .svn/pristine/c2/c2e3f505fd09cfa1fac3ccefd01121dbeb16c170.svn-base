package com.aoshi.common.asenum;

public enum OrderPayType {

	ALIPAY("alipay"), UNIONPAY("unionpay"), TENPAY("tenpay"), WECHATPAY(
			"wechatpay");

	private String id; // 支付类型标识符

	private OrderPayType(String id) {
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public static OrderPayType get(String id) {

		OrderPayType object = null;
		OrderPayType[] objects = OrderPayType.values();
		for (OrderPayType curObject : objects) {

			if (curObject.getId().equals(id)) {
				object = curObject;
				break;
			}
		}

		return object;
	}
}
