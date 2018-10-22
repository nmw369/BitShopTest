package com.withdog.service.domain;

public class AbandDog {
	private String desertionNo;				// 유기견번호
	private String noticeNo;				// 공고번호
	private String abandDogBreed;		// 견종
	private String abandDogGender;	// 성별
	private String abandDogFeature;	// 특징
	private String abandDogState;		// 상태
	private String abandDogImage;		// 이미지
	private String happenPlace;			// 발견장소
	private String abandDogAge;		// 나이
	private String abandDogWeight;	// 체중
	private String abandDogColor;		// 유기견 색
	private String abandDogNeuter;	// 중성화 여부
	private String noticeSdt;				// 공고시작일
	private String noticeEdt;				// 공고종료일
	private String happenDt;				// 접수일
	private String careNm;					// 보호소이름
	private String careTel;					// 보호소전화번호
	private String orgNm;					// 관할기관
	private String chargeNm;				// 담당자
	private String officeTel;				// 담당자연락처
	private String careAddr;				// 보호장소

	public AbandDog() {
		
	}

	public String getDesertionNo() {
		return desertionNo;
	}

	public void setDesertionNo(String desertionNo) {
		this.desertionNo = desertionNo;
	}

	public String getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(String noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getAbandDogBreed() {
		return abandDogBreed;
	}

	public void setAbandDogBreed(String abandDogBreed) {
		this.abandDogBreed = abandDogBreed;
	}

	public String getAbandDogGender() {
		return abandDogGender;
	}

	public void setAbandDogGender(String abandDogGender) {
		this.abandDogGender = abandDogGender;
	}

	public String getAbandDogFeature() {
		return abandDogFeature;
	}

	public void setAbandDogFeature(String abandDogFeature) {
		this.abandDogFeature = abandDogFeature;
	}

	public String getAbandDogState() {
		return abandDogState;
	}

	public void setAbandDogState(String abandDogState) {
		this.abandDogState = abandDogState;
	}

	public String getAbandDogImage() {
		return abandDogImage;
	}

	public void setAbandDogImage(String abandDogImage) {
		this.abandDogImage = abandDogImage;
	}

	public String getHappenPlace() {
		return happenPlace;
	}

	public void setHappenPlace(String happenPlace) {
		this.happenPlace = happenPlace;
	}

	public String getAbandDogAge() {
		return abandDogAge;
	}

	public void setAbandDogAge(String abandDogAge) {
		this.abandDogAge = abandDogAge;
	}

	public String getAbandDogWeight() {
		return abandDogWeight;
	}

	public void setAbandDogWeight(String abandDogWeight) {
		this.abandDogWeight = abandDogWeight;
	}

	public String getAbandDogColor() {
		return abandDogColor;
	}

	public void setAbandDogColor(String abandDogColor) {
		this.abandDogColor = abandDogColor;
	}

	public String getAbandDogNeuter() {
		return abandDogNeuter;
	}

	public void setAbandDogNeuter(String abandDogNeuter) {
		this.abandDogNeuter = abandDogNeuter;
	}

	public String getNoticeSdt() {
		return noticeSdt;
	}

	public void setNoticeSdt(String noticeSdt) {
		this.noticeSdt = noticeSdt;
	}

	public String getNoticeEdt() {
		return noticeEdt;
	}

	public void setNoticeEdt(String noticeEdt) {
		this.noticeEdt = noticeEdt;
	}

	public String getHappenDt() {
		return happenDt;
	}

	public void setHappenDt(String happenDt) {
		this.happenDt = happenDt;
	}

	public String getCareNm() {
		return careNm;
	}

	public void setCareNm(String careNm) {
		this.careNm = careNm;
	}

	public String getCareTel() {
		return careTel;
	}

	public void setCareTel(String careTel) {
		this.careTel = careTel;
	}

	public String getOrgNm() {
		return orgNm;
	}

	public void setOrgNm(String orgNm) {
		this.orgNm = orgNm;
	}

	public String getChargeNm() {
		return chargeNm;
	}

	public void setChargeNm(String chargeNm) {
		this.chargeNm = chargeNm;
	}

	public String getOfficeTel() {
		return officeTel;
	}

	public void setOfficeTel(String officeTel) {
		this.officeTel = officeTel;
	}

	public String getCareAddr() {
		return careAddr;
	}

	public void setCareAddr(String careAddr) {
		this.careAddr = careAddr;
	}

	@Override
	public String toString() {
		return "AbandDog [desertionNo=" + desertionNo + ", noticeNo=" + noticeNo + ", abandDogBreed=" + abandDogBreed
				+ ", abandDogGender=" + abandDogGender + ", abandDogFeature=" + abandDogFeature + ", abandDogState="
				+ abandDogState + ", abandDogImage=" + abandDogImage + ", happenPlace=" + happenPlace + ", abandDogAge="
				+ abandDogAge + ", abandDogWeight=" + abandDogWeight + ", abandDogColor=" + abandDogColor
				+ ", abandDogNeuter=" + abandDogNeuter + ", noticeSdt=" + noticeSdt + ", noticeEdt=" + noticeEdt
				+ ", happenDt=" + happenDt + ", careNm=" + careNm + ", careTel=" + careTel + ", orgNm=" + orgNm
				+ ", chargeNm=" + chargeNm + ", officeTel=" + officeTel + ", careAddr=" + careAddr + "]";
	}

}