package com.withdog.service.domain;

public class PushToken {
	private String deviceId;
	private String token;
	private User user;
	
	public String getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	@Override
	public String toString() {
		return "PushToken [deviceId=" + deviceId + ", token=" + token + ", user=" + user + "]";
	}	
}
