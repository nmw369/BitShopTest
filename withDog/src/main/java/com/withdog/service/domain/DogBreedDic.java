package com.withdog.service.domain;

public class DogBreedDic {
	private int dogNo;
	private String dogBreedEN;
	private String dogBreedKO;
	private String dogHeight;
	private String dogWeight;
	private String dogLifeSpan;
	private String dogPlace;
	private String dogColor;
	private String dogPersonality;
	private String dogLink;

	public int getDogNo() {
		return dogNo;
	}

	public void setDogNo(int dogNo) {
		this.dogNo = dogNo;
	}

	public String getDogBreedEN() {
		return dogBreedEN;
	}

	public void setDogBreedEN(String dogBreedEN) {
		this.dogBreedEN = dogBreedEN;
	}

	public String getDogBreedKO() {
		return dogBreedKO;
	}

	public void setDogBreedKO(String dogBreedKO) {
		this.dogBreedKO = dogBreedKO;
	}

	public String getDogHeight() {
		return dogHeight;
	}

	public void setDogHeight(String dogHeight) {
		this.dogHeight = dogHeight;
	}

	public String getDogWeight() {
		return dogWeight;
	}

	public void setDogWeight(String dogWeight) {
		this.dogWeight = dogWeight;
	}

	public String getDogLifeSpan() {
		return dogLifeSpan;
	}

	public void setDogLifeSpan(String dogLifeSpan) {
		this.dogLifeSpan = dogLifeSpan;
	}

	public String getDogPlace() {
		return dogPlace;
	}

	public void setDogPlace(String dogPlace) {
		this.dogPlace = dogPlace;
	}

	public String getDogColor() {
		return dogColor;
	}

	public void setDogColor(String dogColor) {
		this.dogColor = dogColor;
	}

	public String getDogPersonality() {
		return dogPersonality;
	}

	public void setDogPersonality(String dogPersonality) {
		this.dogPersonality = dogPersonality;
	}

	public String getDogLink() {
		return dogLink;
	}

	public void setDogLink(String dogLink) {
		this.dogLink = dogLink;
	}

	@Override
	public String toString() {
		return "DogBreedDic [dogNo=" + dogNo + ", dogBreedEN=" + dogBreedEN + ", dogBreedKO=" + dogBreedKO
				+ ", dogHeight=" + dogHeight + ", dogWeight=" + dogWeight + ", dogLifeSpan=" + dogLifeSpan
				+ ", dogPlace=" + dogPlace + ", dogColor=" + dogColor + ", dogPersonality=" + dogPersonality
				+ ", dogLink=" + dogLink + "]";
	}
}
