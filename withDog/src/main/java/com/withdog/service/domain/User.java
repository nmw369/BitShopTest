package com.withdog.service.domain;



public class User {

	/// Field
	private String userId;
	private String password;
	private String userName;
	private String birth;
	private String email;
	private String phone;
	private String postNo;
	private String address1;
	private String address2;
	private int  dogNo; // 좋아하는 견종
	private String userCondition; // 계정상태 : 정상, 휴면, 탈퇴
	private String recentlyDate;
	private String joinDate;
	private String leaveDate;
	private String leaveReason;
	private String changeDate;
	private String role;
	private int currentPoint; // 현재 포인트
	private String snsNaverId;
	private String snsKakaoId;
	private String snsGoogleId;
	private String snsFacebookId;
	private int snsType; // sns 가입시 타입 ::  0= kakao, 1= naver, 2= google, 3=faceBook

	/// Constructor
	public User() {
	}
	
	/// Method
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPostNo() {
		return postNo;
	}

	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public int getDogNo() {
		return dogNo;
	}

	public void setDogNo(int dogNo) {
		this.dogNo = dogNo;
	}

	public String getUserCondition() {
		return userCondition;
	}

	public void setUserCondition(String userCondition) {
		this.userCondition = userCondition;
	}

	public String getRecentlyDate() {
		return recentlyDate;
	}

	public void setRecentlyDate(String recentlyDate) {
		this.recentlyDate = recentlyDate;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public String getLeaveDate() {
		return leaveDate;
	}

	public void setLeaveDate(String leaveDate) {
		this.leaveDate = leaveDate;
	}

	public String getLeaveReason() {
		return leaveReason;
	}

	public void setLeaveReason(String leaveReason) {
		this.leaveReason = leaveReason;
	}

	public String getChangeDate() {
		return changeDate;
	}

	public void setChangeDate(String changeDate) {
		this.changeDate = changeDate;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public int getCurrentPoint() {
		return currentPoint;
	}

	public void setCurrentPoint(int currentPoint) {
		this.currentPoint = currentPoint;
	}

	public String getSnsNaverId() {
		return snsNaverId;
	}

	public void setSnsNaverId(String snsNaverId) {
		this.snsNaverId = snsNaverId;
	}

	public String getSnsKakaoId() {
		return snsKakaoId;
	}

	public void setSnsKakaoId(String snsKakaoId) {
		this.snsKakaoId = snsKakaoId;
	}

	public String getSnsGoogleId() {
		return snsGoogleId;
	}

	public void setSnsGoogleId(String snsGoogleId) {
		this.snsGoogleId = snsGoogleId;
	}

	public String getSnsFacebookId() {
		return snsFacebookId;
	}

	public void setSnsFacebookId(String snsFacebookId) {
		this.snsFacebookId = snsFacebookId;
	}

	public int getSnsType() {
		return snsType;
	}

	public void setSnsType(int snsType) {
		this.snsType = snsType;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", password=" + password + ", userName=" + userName + ", birth=" + birth
				+ ", email=" + email + ", phone=" + phone + ", postNo=" + postNo + ", address1=" + address1
				+ ", address2=" + address2 + ", dogNo=" + dogNo + ", userCondition=" + userCondition + ", recentlyDate="
				+ recentlyDate + ", joinDate=" + joinDate + ", leaveDate=" + leaveDate + ", leaveReason=" + leaveReason
				+ ", changeDate=" + changeDate + ", role=" + role + ", currentPoint=" + currentPoint + ", snsNaverId="
				+ snsNaverId + ", snsKakaoId=" + snsKakaoId + ", snsGoogleId=" + snsGoogleId + ", snsFacebookId="
				+ snsFacebookId + ", snsType=" + snsType + "]";
	}




}