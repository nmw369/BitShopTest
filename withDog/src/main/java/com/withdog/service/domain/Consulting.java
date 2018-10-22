package com.withdog.service.domain;

import java.sql.Date;

public class Consulting {
	private int consultingNo;				// ����û ��ȣ
	private HealingDog healingDog;	// ġ����
	private User user;						// ��û��
	private String consultingState;		// ����û ����
	private String regDate;					// �����
	
	public Consulting(){
	}

	public int getConsultingNo() {
		return consultingNo;
	}

	public void setConsultingNo(int consultingNo) {
		this.consultingNo = consultingNo;
	}

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

	public String getConsultingState() {
		return consultingState;
	}

	public void setConsultingState(String consultingState) {
		this.consultingState = consultingState;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "Consulting [consultingNo=" + consultingNo + ", consultingState=" + consultingState + "]";
	}
	
}