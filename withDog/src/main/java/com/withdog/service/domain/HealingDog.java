package com.withdog.service.domain;

public class HealingDog {
	private int healingDogNo;
	private DogBreedDic healingDogBreed;
	private String healingDogName;
	private String healingDogBirth;
	private String healingDogGender;
	private String healingDogChar;
	private String healingDogimage;
	private String healingDogHealer;
	private String healingDogReservCount;

	public int getHealingDogNo() {
		return healingDogNo;
	}

	public void setHealingDogNo(int healingDogNo) {
		this.healingDogNo = healingDogNo;
	}

	public DogBreedDic getHealingDogBreed() {
		return healingDogBreed;
	}

	public void setHealingDogBreed(DogBreedDic healingDogBreed) {
		this.healingDogBreed = healingDogBreed;
	}

	public String getHealingDogName() {
		return healingDogName;
	}

	public void setHealingDogName(String healingDogName) {
		this.healingDogName = healingDogName;
	}

	public String getHealingDogBirth() {
		return healingDogBirth;
	}

	public void setHealingDogBirth(String healingDogBirth) {
		this.healingDogBirth = healingDogBirth;
	}

	public String getHealingDogGender() {
		return healingDogGender;
	}

	public void setHealingDogGender(String healingDogGender) {
		this.healingDogGender = healingDogGender;
	}

	public String getHealingDogChar() {
		return healingDogChar;
	}

	public void setHealingDogChar(String healingDogChar) {
		this.healingDogChar = healingDogChar;
	}

	public String getHealingDogimage() {
		return healingDogimage;
	}

	public void setHealingDogimage(String healingDogimage) {
		this.healingDogimage = healingDogimage;
	}

	public String getHealingDogHealer() {
		return healingDogHealer;
	}

	public void setHealingDogHealer(String healingDogHealer) {
		this.healingDogHealer = healingDogHealer;
	}

	public String getHealingDogReservCount() {
		return healingDogReservCount;
	}

	public void setHealingDogReservCount(String healingDogReservCount) {
		this.healingDogReservCount = healingDogReservCount;
	}

	@Override
	public String toString() {
		return "HealingDog [healingDogNo=" + healingDogNo + ", healingDogBreed=" + healingDogBreed + ", healingDogName="
				+ healingDogName + ", healingDogBirth=" + healingDogBirth + ", healingDogGender=" + healingDogGender
				+ ", healingDogChar=" + healingDogChar + ", healingDogimage=" + healingDogimage + ", healingDogHealer="
				+ healingDogHealer + ", healingDogReservCount=" + healingDogReservCount + "]";
	}

}