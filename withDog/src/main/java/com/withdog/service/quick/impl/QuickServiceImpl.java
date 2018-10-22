package com.withdog.service.quick.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.withdog.service.domain.ChatBot;
import com.withdog.service.domain.User;
import com.withdog.service.quick.QuickDAO;
import com.withdog.service.quick.QuickService;

@Service("quickServiceImpl")
public class QuickServiceImpl implements QuickService{
	
	@Autowired
	@Qualifier("quickDAOImpl")
	private QuickDAO quickDAO;

	@Override
	public List<ChatBot> getChatBotList(User user) throws Exception {
		return quickDAO.getChatBotList(user);
	}

	@Override
	public ChatBot getChatBot(int questionNo) throws Exception {
		ChatBot chatBot = quickDAO.getChatBot(questionNo);
		chatBot.setQuestionCount((chatBot.getQuestionCount()+1));   
		quickDAO.updateQuestionCount(chatBot);
		return quickDAO.getChatBot(questionNo);
	}

	@Override
	public void addChatBot(ChatBot chatBot) throws Exception {
		quickDAO.addChatBot(chatBot);
		
	}

	@Override
	public void updateChatBot(ChatBot chatBot) throws Exception {
		quickDAO.updateChatBot(chatBot);
		
	}

	@Override
	public void deleteChatBot(int questionNo) throws Exception {
		quickDAO.deleteChatBot(questionNo);
		
	}

	@Override
	public ChatBot getCurrentChatBot() throws Exception {
		return quickDAO.getCurrentChatBot();
	}

	@Override
	public void updateConnect(ChatBot chatBot) throws Exception {
		quickDAO.updateConnect(chatBot);
		
	}
}