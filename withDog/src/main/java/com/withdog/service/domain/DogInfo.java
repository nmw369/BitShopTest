package com.withdog.service.domain;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class DogInfo {
	private User user;
	private int dogInfoNo;
	private String dogInfoTitle;
	private String dogInfoContent;
	private String dogInfoTopic;
	private String dogInfoImage;
	private String recommended;
	private String notRecommended;
	private String viewCount;
	private RecommendInfo recommendCondition;
	private String regDate;
	private String deleteFlag;
	private List<String> dogInfoImageList = new ArrayList<String>();

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getDogInfoNo() {
		return dogInfoNo;
	}

	public void setDogInfoNo(int dogInfoNo) {
		this.dogInfoNo = dogInfoNo;
	}

	public String getDogInfoTitle() {
		return dogInfoTitle;
	}

	public void setDogInfoTitle(String dogInfoTitle) {
		this.dogInfoTitle = dogInfoTitle;
	}

	public String getDogInfoContent() {
		return dogInfoContent;
	}

	public void setDogInfoContent(String dogInfoContent) {
		this.dogInfoContent = dogInfoContent;
	}

	public String getDogInfoTopic() {
		return dogInfoTopic;
	}

	public void setDogInfoTopic(String dogInfoTopic) {
		this.dogInfoTopic = dogInfoTopic;
	}

	public String getDogInfoImage() {
		return dogInfoImage;
	}

	public void setDogInfoImage(String dogInfoImage) {
		this.dogInfoImage = dogInfoImage;

		if (dogInfoImage.contains(",")) {
			String[] file = dogInfoImage.split(",");
			for (String string : file) {
				dogInfoImageList.add(string);
			}
		} else {
			dogInfoImageList.add(dogInfoImage);
		}
	}

	public String getRecommended() {
		return recommended;
	}

	public void setRecommended(String recommended) {
		this.recommended = recommended;
	}

	public String getNotRecommended() {
		return notRecommended;
	}

	public void setNotRecommended(String notRecommended) {
		this.notRecommended = notRecommended;
	}

	public String getViewCount() {
		return viewCount;
	}

	public void setViewCount(String viewCount) {
		this.viewCount = viewCount;
	}

	public RecommendInfo getRecommendCondition() {
		return recommendCondition;
	}

	public void setRecommendCondition(RecommendInfo recommendCondition) {
		this.recommendCondition = recommendCondition;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String reg_Date) {
		this.regDate = reg_Date;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public List<String> getDogInfoImageList() {
		return dogInfoImageList;
	}

	@Override
	public String toString() {
		return "DogInfo [user=" + user + ", dogInfoNo=" + dogInfoNo + ", dogInfoTitle=" + dogInfoTitle
				+ ", dogInfoContent=" + dogInfoContent + ", dogInfoTopic=" + dogInfoTopic + ", dogInfoImage="
				+ dogInfoImage + ", recommended=" + recommended + ", notRecommended=" + notRecommended + ", viewCount="
				+ viewCount + ", recommendCondition=" + recommendCondition + ", regDate=" + regDate + ", deleteFlag="
				+ deleteFlag + ", dogInfoImageList=" + dogInfoImageList + "]";
	}


}
