package com.withdog.service.domain;

import java.sql.Date;

public class Ash {
	private HealingDog healingDog;
	private User user;
	private int ashReservationNo;
	private String ashReservationCondition;
	private String ashReservationName;
	private String ashReservationDate;
	private String ashReservationTime;
	private String ashReservationAddress1;
	private String ashReservationAddress2;
	private String ashReservationPhone;
	private String ashReservationEtc;
	private int ashReservationPrice;
//	private String ashReservationColor;
	private String paymentOption;
	private Date purchaseDate;

	public HealingDog getHealingDog() {
		return healingDog;
	}

	public void setHealingDog(HealingDog healingDog) {
		this.healingDog = healingDog;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getAshReservationNo() {
		return ashReservationNo;
	}

	public void setAshReservationNo(int ashReservationNo) {
		this.ashReservationNo = ashReservationNo;
	}

	public String getAshReservationCondition() {
		return ashReservationCondition;
	}

	public void setAshReservationCondition(String ashReservationCondition) {
		this.ashReservationCondition = ashReservationCondition;
	}

	public String getAshReservationName() {
		return ashReservationName;
	}

	public void setAshReservationName(String ashReservationName) {
		this.ashReservationName = ashReservationName;
	}

	public String getAshReservationDate() {
		return ashReservationDate;
	}

	public void setAshReservationDate(String ashReservationDate) {
		this.ashReservationDate = ashReservationDate;
	}

	public String getAshReservationTime() {
		return ashReservationTime;
	}

	public void setAshReservationTime(String ashReservationTime) {
		this.ashReservationTime = ashReservationTime;
	}

	public String getAshReservationAddress1() {
		return ashReservationAddress1;
	}

	public void setAshReservationAddress1(String ashReservationAddress1) {
		this.ashReservationAddress1 = ashReservationAddress1;
	}
	
	public String getAshReservationAddress2() {
		return ashReservationAddress2;
	}
	
	public void setAshReservationAddress2(String ashReservationAddress2) {
		this.ashReservationAddress2 = ashReservationAddress2;
	}

	public String getAshReservationPhone() {
		return ashReservationPhone;
	}

	public void setAshReservationPhone(String ashReservationPhone) {
		this.ashReservationPhone = ashReservationPhone;
	}

	public String getAshReservationEtc() {
		return ashReservationEtc;
	}

	public void setAshReservationEtc(String ashReservationEtc) {
		this.ashReservationEtc = ashReservationEtc;
	}

	public int getAshReservationPrice() {
		return ashReservationPrice;
	}

	public void setAshReservationPrice(int ashReservationPrice) {
		this.ashReservationPrice = ashReservationPrice;
	}

	public String getPaymentOption() {
		return paymentOption;
	}

	public void setPaymentOption(String paymentOption) {
		this.paymentOption = paymentOption;
	}

	public Date getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}

//	public String getAshReservationColor() {
//		return ashReservationColor;
//	}
//
//	public void setAshReservationColor(String ashReservationColor) {
//		this.ashReservationColor = ashReservationColor;
//	}

	@Override
	public String toString() {
		return "Ash [healingDog=" + healingDog + ", user=" + user + ", ashReservationNo=" + ashReservationNo
				+ ", ashReservationCondition=" + ashReservationCondition + ", ashReservationName=" + ashReservationName
				+ ", ashReservationDate=" + ashReservationDate + ", ashReservationTime=" + ashReservationTime
				+ ", ashReservationAddress1=" + ashReservationAddress1 + ", ashReservationAddress2="
				+ ashReservationAddress2 + ", ashReservationPhone=" + ashReservationPhone + ", ashReservationEtc="
				+ ashReservationEtc + ", ashReservationPrice=" + ashReservationPrice + ", "
				 + ", paymentOption=" + paymentOption + ", purchaseDate=" + purchaseDate + "]";
	}


}
