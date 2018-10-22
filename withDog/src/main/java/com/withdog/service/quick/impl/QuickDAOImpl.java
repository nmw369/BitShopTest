package com.withdog.service.quick.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.withdog.service.domain.ChatBot;
import com.withdog.service.domain.User;
import com.withdog.service.quick.QuickDAO;

@Repository("quickDAOImpl")
public class QuickDAOImpl implements QuickDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	@Override
	public List<ChatBot> getChatBotList(User user) throws Exception {
		return sqlSession.selectList("QuickMapper.getChatBotList", user);
	}

	@Override
	public ChatBot getChatBot(int questionNo) throws Exception {
		return sqlSession.selectOne("QuickMapper.getChatBot",questionNo);
	}

	@Override
	public void addChatBot(ChatBot chatBot) throws Exception {
		sqlSession.insert("QuickMapper.addChatBot",chatBot);
		
	}

	@Override
	public void updateChatBot(ChatBot chatBot) throws Exception {
		sqlSession.update("QuickMapper.updateChatBot",chatBot);
		
	}

	@Override
	public void deleteChatBot(int questionNo) throws Exception {
		sqlSession.delete("QuickMapper.deleteChatBot",questionNo);
		
	}

	@Override
	public void updateQuestionCount(ChatBot chatBot) throws Exception {
		sqlSession.update("QuickMapper.updateQuestionCount",chatBot);
	}

	@Override
	public ChatBot getCurrentChatBot() throws Exception {
		return sqlSession.selectOne("QuickMapper.getCurrentChatBot");
	}

	@Override
	public void updateConnect(ChatBot chatBot) throws Exception {
		System.out.println(".................../////////////////////////////////////////////");
		System.out.println(chatBot);
		sqlSession.update("QuickMapper.updateConnect",chatBot);
		
	}
}