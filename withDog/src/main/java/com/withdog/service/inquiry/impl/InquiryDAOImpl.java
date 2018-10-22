package com.withdog.service.inquiry.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.withdog.common.Search;
import com.withdog.service.domain.Inquiry;
import com.withdog.service.inquiry.InquiryDAO;

//==> 문의 DAO CRUD 구현
@Repository("inquiryDAOImpl")
public class InquiryDAOImpl implements InquiryDAO {

	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession; 
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public InquiryDAOImpl() {
		System.out.println("product dao impl생성자 호출");
	}
	
	@Override
	public void addInquiry(Inquiry inquiry) throws Exception {
		sqlSession.insert("InquiryMapper.addInquiry", inquiry);
	}

	@Override
	public void updateInquiry(Inquiry inquiry) throws Exception {
		sqlSession.update("InquiryMapper.updateInquiry", inquiry);
	}
	
	@Override
	public void deleteInquiry(int inquiryNo) throws Exception {
		sqlSession.update("InquiryMapper.deleteInquiry", inquiryNo);
		
	}

	@Override
	public Inquiry getInquiry(int inquiryNo) throws Exception {
		return sqlSession.selectOne("InquiryMapper.getInquiry",inquiryNo);
	}

	@Override
	public Map<String,Object> getInquiryList(Search search, int prodNo) throws Exception {
		
			
		System.out.println("getInquiryList 시작");
		Map<String, Object> mapIn = new HashMap<String, Object>();
		mapIn.put("search", search);
		mapIn.put("prodNo", prodNo);	
		
		int totalCount = sqlSession.selectOne("InquiryMapper.getInquiryListCount", mapIn);
		List<Inquiry> list = sqlSession.selectList("InquiryMapper.getInquiryList", mapIn);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("totalCount", totalCount);
		map.put("list", list);
		

		return map;
	}
	
	@Override
	public Map<String,Object> getMyInquiryList(Search search, String userId) throws Exception {
		
			
		System.out.println("getMyInquiryList 시작");
		Map<String, Object> mapIn = new HashMap<String, Object>();
		mapIn.put("search", search);
		mapIn.put("userId", userId);	
		
		int totalCount = sqlSession.selectOne("InquiryMapper.getMyInquiryListCount", mapIn);
		List<Inquiry> list = sqlSession.selectList("InquiryMapper.getMyInquiryList", mapIn);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("totalCount", totalCount);
		map.put("list", list);
		

		return map;
	}
	
	@Override
	public Map<String,Object> getInquiryListAdmin(Search search) throws Exception {
			
			System.out.println("getInquiryListAdmin 시작");
			Map<String, Object> mapIn = new HashMap<String, Object>();
			mapIn.put("search", search);
			
			int totalCount = sqlSession.selectOne("InquiryMapper.getInquiryListAdminCount", mapIn);
			List<Inquiry> list = sqlSession.selectList("InquiryMapper.getInquiryListAdmin", mapIn);

			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("totalCount", totalCount);
			map.put("list", list);
			
		return map;
	}
	
	

	@Override
	public void updateInquiryReplyAdmin(Inquiry inquiry) throws Exception {
		sqlSession.update("InquiryMapper.updateInquiryReplyAdmin", inquiry);
	}
	
	


}
