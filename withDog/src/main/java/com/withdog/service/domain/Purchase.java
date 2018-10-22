package com.withdog.service.domain;

import java.sql.Date;

import com.withdog.service.domain.Product;
import com.withdog.service.domain.User;

public class Purchase {
	
	private User user;
	private Product product;
	private int usePoint;
	private int cartNo;
	private int purchaseNo;
	private String receiverName;
	private String receiverPhone;
	private String receiverAddr1;
	private String receiverAddr2;
	private String divyRequest;
	private int purchaseQuantity;
	private int purchasePrice;
	private String purchaseDate;
	private String purchaseCondition;
	private String cancelDate;
	private String divyDate;
	private String paymentOption;
	
	public Purchase(){
	}

	
	public int getUsePoint() {
		return usePoint;
	}


	public void setUsePoint(int usePoint) {
		this.usePoint = usePoint;
	}


	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public int getPurchaseNo() {
		return purchaseNo;
	}

	public void setPurchaseNo(int purchaseNo) {
		this.purchaseNo = purchaseNo;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getReceiverPhone() {
		return receiverPhone;
	}

	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}

	public String getReceiverAddr1() {
		return receiverAddr1;
	}

	public void setReceiverAddr1(String receiverAddr1) {
		this.receiverAddr1 = receiverAddr1;
	}

	public String getReceiverAddr2() {
		return receiverAddr2;
	}

	public void setReceiverAddr2(String receiverAddr2) {
		this.receiverAddr2 = receiverAddr2;
	}

	public String getDivyRequest() {
		return divyRequest;
	}

	public void setDivyRequest(String divyRequest) {
		this.divyRequest = divyRequest;
	}

	public int getPurchaseQuantity() {
		return purchaseQuantity;
	}

	public void setPurchaseQuantity(int purchaseQuantity) {
		this.purchaseQuantity = purchaseQuantity;
	}

	public int getPurchasePrice() {
		return purchasePrice;
	}

	public void setPurchasePrice(int purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public String getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(String purchaseDate) {
		this.purchaseDate = purchaseDate;
	}

	public String getPurchaseCondition() {
		return purchaseCondition;
	}

	public void setPurchaseCondition(String purchaseCondition) {
		this.purchaseCondition = purchaseCondition;
	}

	public String getCancelDate() {
		return cancelDate;
	}

	public void setCancelDate(String cancelDate) {
		this.cancelDate = cancelDate;
	}

	public String getDivyDate() {
		return divyDate;
	}

	public void setDivyDate(String divyDate) {
		this.divyDate = divyDate;
	}

	public String getPaymentOption() {
		return paymentOption;
	}

	public void setPaymentOption(String paymentOption) {
		this.paymentOption = paymentOption;
	}


	@Override
	public String toString() {
		return "Purchase [user=" + user + ", product=" + product + ", usePoint=" + usePoint + ", cartNo=" + cartNo
				+ ", purchaseNo=" + purchaseNo + ", receiverName=" + receiverName + ", receiverPhone=" + receiverPhone
				+ ", receiverAddr1=" + receiverAddr1 + ", receiverAddr2=" + receiverAddr2 + ", divyRequest="
				+ divyRequest + ", purchaseQuantity=" + purchaseQuantity + ", purchasePrice=" + purchasePrice
				+ ", purchaseDate=" + purchaseDate + ", purchaseCondition=" + purchaseCondition + ", cancelDate="
				+ cancelDate + ", divyDate=" + divyDate + ", paymentOption=" + paymentOption + "]";
	}

	
	
}