package com.withdog.service.domain;

public class Chat {

	//private User user;
	private int chatRoomNo;
	private int chatInNo;
	private String chatTitle;
	private int chatPersonnel;
	private int chatWar;
	private String chatImage;
    
	
	
	
	
	public int getChatRoomNo() {
		return chatRoomNo;
	}





	public void setChatRoomNo(int chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}





	public int getChatInNo() {
		return chatInNo;
	}





	public void setChatInNo(int chatInNo) {
		this.chatInNo = chatInNo;
	}





	public String getChatTitle() {
		return chatTitle;
	}





	public void setChatTitle(String chatTitle) {
		this.chatTitle = chatTitle;
	}





	public int getChatPersonnel() {
		return chatPersonnel;
	}





	public void setChatPersonnel(int chatPersonnel) {
		this.chatPersonnel = chatPersonnel;
	}





	public int getChatWar() {
		return chatWar;
	}





	public void setChatWar(int chatWar) {
		this.chatWar = chatWar;
	}





	public String getChatImage() {
		return chatImage;
	}





	public void setChatImage(String chatImage) {
		this.chatImage = chatImage;
	}





	public Chat() {
		// TODO Auto-generated constructor stub
		
	}





	@Override
	public String toString() {
		return "Chat [chatRoomNo=" + chatRoomNo + ", chatInNo=" + chatInNo + ", chatTitle=" + chatTitle
				+ ", chatPersonnel=" + chatPersonnel + ", chatWar=" + chatWar + ", chatImage=" + chatImage + "]";
	}

	
}
