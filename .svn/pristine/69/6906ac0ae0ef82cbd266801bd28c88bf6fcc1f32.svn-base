package com.aoshi.common.asenum;

/**
 * 提现申请状态枚举
 *
 * @author yangyanchao
 * @date 2017-02-20
 */
public enum CapitalStatusEnum {

    APPLYING(0,"申请中"),
    PROCESSING(1,"处理中"),
    SUCCESS(2,"已提现"),
    REJECT(3,"已驳回"),
    FAIL(4,"已失败");

    /** 状态 */
    private int status;

    /** 状态描述 */
    private String descp;

    CapitalStatusEnum(int status, String descp){
        this.status = status;
        this.descp = descp;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getDescp() {
        return descp;
    }

    public void setDescp(String descp) {
        this.descp = descp;
    }

    public static CapitalStatusEnum get(int status) {

        CapitalStatusEnum object = null;
        CapitalStatusEnum[] objects = CapitalStatusEnum.values();
        for (CapitalStatusEnum curObject : objects) {

            if (curObject.getStatus() == status) {
                object = curObject;
                break;
            }
        }

        return object;
    }
}
