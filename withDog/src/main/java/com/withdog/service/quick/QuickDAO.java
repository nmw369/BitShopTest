package com.withdog.service.quick;

import java.util.List;

import com.withdog.service.domain.ChatBot;
import com.withdog.service.domain.User;

public interface QuickDAO {

	public void addChatBot(ChatBot chatBot) throws Exception;
	
	public void updateChatBot(ChatBot chatBot) throws Exception;
	
	public List<ChatBot> getChatBotList(User user) throws Exception;

	public ChatBot getChatBot(int questionNo) throws Exception;
	
	public ChatBot getCurrentChatBot() throws Exception;
	
	public void deleteChatBot(int questionNo) throws Exception;
	
	public void updateQuestionCount(ChatBot chatBot) throws Exception;
	
	public void updateConnect(ChatBot chatBot) throws Exception;
	

}