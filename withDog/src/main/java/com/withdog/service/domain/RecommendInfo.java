package com.withdog.service.domain;

public class RecommendInfo {
	private User user;
	private DogInfo dogInfo;
	private String recommendCondition;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public DogInfo getDogInfo() {
		return dogInfo;
	}

	public void setDogInfo(DogInfo dogInfo) {
		this.dogInfo = dogInfo;
	}

	public String getRecommendCondition() {
		return recommendCondition;
	}

	public void setRecommendCondition(String recommendCondition) {
		this.recommendCondition = recommendCondition;
	}

	@Override
	public String toString() {
		return "RecommendInfo [user=" + user + ", dogInfo=" + dogInfo + ", recommendCondition=" + recommendCondition
				+ "]";
	}

}
