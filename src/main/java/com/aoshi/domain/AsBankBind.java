package com.aoshi.domain;

public class AsBankBind {
    private Integer bankBindId;

    private Integer userId;

    private String bankName;

    private String bankAccount;

    private String bankCardholder;

    private String createTime;

    private String cardType;

    private Integer cardLength;

    private String cardPrefixnum;

    private String cardName;

    private Integer bankNum;

    private String identityCard;

    private String bankCode;

    private Integer status;

    public Integer getBankBindId() {
        return bankBindId;
    }

    public void setBankBindId(Integer bankBindId) {
        this.bankBindId = bankBindId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName == null ? null : bankName.trim();
    }

    public String getBankAccount() {
        return bankAccount;
    }

    public void setBankAccount(String bankAccount) {
        this.bankAccount = bankAccount == null ? null : bankAccount.trim();
    }

    public String getBankCardholder() {
        return bankCardholder;
    }

    public void setBankCardholder(String bankCardholder) {
        this.bankCardholder = bankCardholder == null ? null : bankCardholder.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getCardType() {
        return cardType;
    }

    public void setCardType(String cardType) {
        this.cardType = cardType == null ? null : cardType.trim();
    }

    public Integer getCardLength() {
        return cardLength;
    }

    public void setCardLength(Integer cardLength) {
        this.cardLength = cardLength;
    }

    public String getCardPrefixnum() {
        return cardPrefixnum;
    }

    public void setCardPrefixnum(String cardPrefixnum) {
        this.cardPrefixnum = cardPrefixnum == null ? null : cardPrefixnum.trim();
    }

    public String getCardName() {
        return cardName;
    }

    public void setCardName(String cardName) {
        this.cardName = cardName == null ? null : cardName.trim();
    }

    public Integer getBankNum() {
        return bankNum;
    }

    public void setBankNum(Integer bankNum) {
        this.bankNum = bankNum;
    }

    public String getIdentityCard() {
        return identityCard;
    }

    public void setIdentityCard(String identityCard) {
        this.identityCard = identityCard == null ? null : identityCard.trim();
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode == null ? null : bankCode.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}