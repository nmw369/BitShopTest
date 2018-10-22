package com.withdog.service.domain;

import java.sql.Date;
import java.util.List;

public class Point {

	private User user;
	private List<Purchase> purchaseList;
	private Purchase purchase;
	private Ash ash;
	private Fund fund;
	private int pointNo;
	private Date pointDate;
	private int usePoint;
	private int point;
	private int currentPoint;
	private int pointHistory;
	
	public Point() {
		// TODO Auto-generated constructor stub
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Purchase> getPurchaseList() {
		return purchaseList;
	}

	public void setPurchaseList(List<Purchase> purchaseList) {
		this.purchaseList = purchaseList;
	}

	public Purchase getPurchase() {
		return purchase;
	}

	public void setPurchase(Purchase purchase) {
		this.purchase = purchase;
	}

	public Ash getAsh() {
		return ash;
	}

	public void setAsh(Ash ash) {
		this.ash = ash;
	}

	public Fund getFund() {
		return fund;
	}

	public void setFund(Fund fund) {
		this.fund = fund;
	}

	public int getPointNo() {
		return pointNo;
	}

	public void setPointNo(int pointNo) {
		this.pointNo = pointNo;
	}

	public Date getPointDate() {
		return pointDate;
	}

	public void setPointDate(Date pointDate) {
		this.pointDate = pointDate;
	}

	public int getUsePoint() {
		return usePoint;
	}

	public void setUsePoint(int usePoint) {
		this.usePoint = usePoint;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getCurrentPoint() {
		return currentPoint;
	}

	public void setCurrentPoint(int currentPoint) {
		this.currentPoint = currentPoint;
	}

	public int getPointHistory() {
		return pointHistory;
	}

	public void setPointHistory(int pointHistory) {
		this.pointHistory = pointHistory;
	}

	@Override
	public String toString() {
		return "Point [user=" + user + ", purchaseList=" + purchaseList + ", purchase=" + purchase + ", ash=" + ash
				+ ", fund=" + fund + ", pointNo=" + pointNo + ", pointDate=" + pointDate + ", usePoint=" + usePoint
				+ ", point=" + point + ", currentPoint=" + currentPoint + ", pointHistory=" + pointHistory + "]";
	}


		
	
}
