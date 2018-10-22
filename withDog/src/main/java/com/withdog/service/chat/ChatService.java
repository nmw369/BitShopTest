package com.withdog.service.chat;

import java.util.Map;

import com.withdog.service.domain.Chat;

//==> 회원관리에서 서비스할 내용 추상화/캡슐화한 Service  Interface Definition  
public interface ChatService {
	
	
	public int addChatRoom(Chat chat) throws Exception;
	public Chat getChat(int chatRoomNo) throws Exception;
	public void updateChat(Chat chat) throws Exception;
	public Map<String,Object> getChatRoomList(Chat chat) throws Exception;
	public void deleteFund() throws Exception;
}