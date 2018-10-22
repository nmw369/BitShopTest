package com.withdog.service.fund.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.withdog.common.Search;
import com.withdog.service.domain.Fund;
import com.withdog.service.domain.User;
import com.withdog.service.fund.FundDAO;


@Repository("fundDAOImpl")
public class FundDAOImpl implements FundDAO{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public FundDAOImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	@Override
	public Fund getFund(int fundNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FundMapper.getFund", fundNo);
	}

	@Override
	public int addFund(Fund fund) throws Exception {
		// TODO Auto-generated method stub
		
		int temp =sqlSession.insert("FundMapper.addFund",fund);
		return temp;
	}

	@Override
	public void updateFund(Fund fund) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSession.update("FundMapper.updateFund",fund);
	}

	@Override
	public void deleteFund(Fund fund) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("delete Start=======================");
		System.out.println(fund.getFundNo());
		sqlSession.update("FundMapper.deleteFund",fund);
		
	}

	@Override
	public void updateFundRaising() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void kakaoPay() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Fund> getFundList(User user) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("check");
		return sqlSession.selectList("FundMapper.getFundList",user);
	}
	
	

	@Override
	public Fund getMyFundNo(Fund fund, User user) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("fund", fund);
		map.put("user", user);
		
		return sqlSession.selectOne("FundMapper.getMyFundNo",map);
	}

	@Override
	public void addFundRaising(Fund fund) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("펀딩에 정보넣기"+fund.toString());
		sqlSession.update("FundMapper.updateRaising",fund);
		System.out.println("펀딩에 정보넣기 성공?");
		sqlSession.insert("FundMapper.addFundRaising",fund);
	}

	@Override
	public Fund getMinFund() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FundMapper.getMinFund");
	}

	@Override
	public List<Fund> getFundResultList(Search search,User user) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("search",search);
		map.put("user", user);
		
		System.out.println(user.getRole());
		
		return sqlSession.selectList("FundMapper.getFundResultList",map);
	}

	@Override
	public int getResultTotalCount(Search search,User user) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("user", user);
		map.put("search", search);
		
		return sqlSession.selectOne("FundMapper.getResultTotalCount",map);
	}
	
	
	

	@Override
	public int getMyTotalCount(Search search,User user) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(123);
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("user", user);
		map.put("search", search);
				
		return sqlSession.selectOne("FundMapper.getMyTotalCount",map);
	}
	
	

	@Override
	public int getFundUserTotalCount(Search search,User user) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("user", user);
		map.put("search", search);
		
		return sqlSession.selectOne("FundMapper.getFundUserTotalCount",map);
	}

	@Override
	public List<Fund> getMyFundList(Search search, User user) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("search",search);
		map.put("user", user);
		System.out.println(map.toString());		
		return sqlSession.selectList("FundMapper.getMyFundList",map);
	}

	@Override
	public List<Fund> getFundUserList(Search search, User user) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("search",search);
		map.put("user", user);
		System.out.println(789);		
		return sqlSession.selectList("FundMapper.getFundUserList",map);
	}

	@Override
	public int getFundPersonnel(Fund fund) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FundMapper.getFundPersonnel",fund);
	}
	
	@Override
	public void updateFundState(int fundNo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("FundMapper.updateFundState",fundNo);
	}
	
	@Override
	public List<Fund> getFundSearch(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FundMapper.getFundSearch",search);
	}
	
	
	
	
		
}
