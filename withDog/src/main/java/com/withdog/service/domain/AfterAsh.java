package com.withdog.service.domain;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class AfterAsh {
	private HealingDog healingDog;
	private User user;
	private int afterASHNo;
	private String afterASHTitle;
	private String afterASHContent;
	private String afterASHImage;
	private String afterASHVideo;
	private String afterASHDate;
	private String afterASHTime;
	private String viewCount;
	private Date regDate;
	private String deleteFlag;
	private List<String> afterASHImageList = new ArrayList<String>();

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

	public int getAfterASHNo() {
		return afterASHNo;
	}

	public void setAfterASHNo(int afterASHNo) {
		this.afterASHNo = afterASHNo;
	}

	public String getAfterASHTitle() {
		return afterASHTitle;
	}

	public void setAfterASHTitle(String afterASHTitle) {
		this.afterASHTitle = afterASHTitle;
	}

	public String getAfterASHContent() {
		return afterASHContent;
	}

	public void setAfterASHContent(String afterASHContent) {
		this.afterASHContent = afterASHContent;
	}

	public String getAfterASHImage() {
		return afterASHImage;
	}

	public void setAfterASHImage(String afterASHImage) {
		this.afterASHImage = afterASHImage;
		if (afterASHImage.contains(",")) {
			String[] file = afterASHImage.split(",");
			for (String string : file) {
				afterASHImageList.add(string);
			}
		} else {
			afterASHImageList.add(afterASHImage);
		}
	}

	public String getAfterASHVideo() {
		return afterASHVideo;
	}

	public void setAfterASHVideo(String afterASHVideo) {
		this.afterASHVideo = afterASHVideo;
	}

	public String getAfterASHDate() {
		return afterASHDate;
	}

	public void setAfterASHDate(String afterASHDate) {
		this.afterASHDate = afterASHDate;
	}

	public String getAfterASHTime() {
		return afterASHTime;
	}

	public void setAfterASHTime(String afterASHTime) {
		this.afterASHTime = afterASHTime;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	
	public List<String> getAfterASHImageList() {
		return afterASHImageList;
	}

	public String getViewCount() {
		return viewCount;
	}

	public void setViewCount(String viewCount) {
		this.viewCount = viewCount;
	}

	@Override
	public String toString() {
		return "AfterAsh [healingDog=" + healingDog + ", user=" + user + ", afterASHNo=" + afterASHNo
				+ ", afterASHTitle=" + afterASHTitle + ", afterASHContent=" + afterASHContent + ", afterASHImage="
				+ afterASHImage + ", afterASHVideo=" + afterASHVideo + ", afterASHDate=" + afterASHDate
				+ ", afterASHTime=" + afterASHTime + ", viewCount=" + viewCount + ", regDate=" + regDate
				+ ", deleteFlag=" + deleteFlag + ", afterASHImageList=" + afterASHImageList + "]";
	}




}
