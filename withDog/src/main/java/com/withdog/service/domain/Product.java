package com.withdog.service.domain;

import java.sql.Date;


public class Product {
	
	private int prodNo;
	private String prodType;
	private String prodName;
	private String prodContent;
	private String prodImage;
	private int price;
	private int prodQuantity;
	private Date regDate;
	private String deleteFlag;
	private int inquiryCnt;
	private int reviewCnt;
	private int avgScore;
	
	
	public Product(){
	}
	
	public int getAvgScore() {
		return avgScore;
	}

	public void setAvgScore(int avgScore) {
		this.avgScore = avgScore;
	}

	public int getReviewCnt() {
		return reviewCnt;
	}

	public void setReviewCnt(int reviewCnt) {
		this.reviewCnt = reviewCnt;
	}

	public String getProdType() {
		return prodType;
	}

	public void setProdType(String prodType) {
		this.prodType = prodType;
	}

	public String getProdContent() {
		return prodContent;
	}

	public void setProdContent(String prodContent) {
		this.prodContent = prodContent;
	}

	public String getProdImage() {
		return prodImage;
	}

	public void setProdImage(String prodImage) {
		this.prodImage = prodImage;
	}

	public int getProdQuantity() {
		return prodQuantity;
	}

	public void setProdQuantity(int prodQuantity) {
		this.prodQuantity = prodQuantity;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getProdNo() {
		return prodNo;
	}
	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getInquiryCnt() {
		return inquiryCnt;
	}

	public void setInquiryCnt(int inquiryCnt) {
		this.inquiryCnt = inquiryCnt;
	}

	@Override
	public String toString() {
		return "Product [prodNo=" + prodNo + ", prodType=" + prodType + ", prodName=" + prodName + ", prodContent="
				+ prodContent + ", prodImage=" + prodImage + ", price=" + price + ", prodQuantity=" + prodQuantity
				+ ", regDate=" + regDate + ", deleteFlag=" + deleteFlag + ", inquiryCnt=" + inquiryCnt + ", reviewCnt="
				+ reviewCnt + ", avgScore=" + avgScore + "]";
	}

	 

	
	
	
}