package com.withdog.service.fund.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.withdog.common.Search;
import com.withdog.service.domain.Fund;
import com.withdog.service.domain.User;
import com.withdog.service.fund.FundDAO;
import com.withdog.service.fund.FundService;




@Service("fundServiceImpl")
public class FundServiceImpl implements FundService{
	
	
	
	@Autowired
	@Qualifier("fundDAOImpl")
	private FundDAO fundDAO;

	
	
	
	@Override
	public Fund getFund(int fundNo) throws Exception {
		// TODO Auto-generated method stub
		return fundDAO.getFund(fundNo);
	}

	@Override
	public int addFund(Fund fund) throws Exception {
		// TODO Auto-generated method stub
		return fundDAO.addFund(fund);
	}

	@Override
	public void updateFund(Fund fund) throws Exception {
		// TODO Auto-generated method stub
	    fundDAO.updateFund(fund);
		
	}

	@Override
	public void deleteFund(Fund fund) throws Exception {
		// TODO Auto-generated method stub
		fundDAO.deleteFund(fund);
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
		return fundDAO.getFundList(user);
	}

	
	
	
	@Override
	public Fund getMyFundNo(Fund fund, User user) throws Exception {
		// TODO Auto-generated method stub
		return fundDAO.getMyFundNo(fund, user);
	}

	@Override
	public void addFundRaising(Fund fund) throws Exception {
		// TODO Auto-generated method stub
		
		fundDAO.addFundRaising(fund);
	}

	@Override
	public Fund getMinFund() throws Exception {
		// TODO Auto-generated method stub
		return fundDAO.getMinFund();
	}

	@Override
	public Map<String,Object> getFundResultList(Search search,User user) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		List<Fund> list = fundDAO.getFundResultList(search,user);
		int totalCount = fundDAO.getResultTotalCount(search,user);
		map.put("list", list);
		map.put("totalCount",totalCount);
				
		return map;
	}

	
	
	@Override
	public Map<String, Object> getMyFundList(Search search, User user) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String,Object> map = new HashMap<String,Object>();
		List<Fund> list = fundDAO.getMyFundList(search,user);
		
		System.out.println("MyFundlist 받음"+list.size());
		
		int totalCount = fundDAO.getMyTotalCount(search,user);
		System.out.println("MyFundlist Count 받음"+totalCount);
		map.put("list", list);
		map.put("totalCount",totalCount);
		
		
		return map;
	}

	@Override
	public Map<String, Object> getFundUserList(Search search, User user) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		List<Fund> list = fundDAO.getFundUserList(search,user);
		
		System.out.println("MyFundlist 받음"+list.size());
		
		int totalCount = fundDAO.getFundUserTotalCount(search,user);
		System.out.println("MyFundlist Count 받음"+totalCount);
		map.put("list", list);
		map.put("totalCount",totalCount);
		
		
		return map;
	}

	@Override
	public int getFundPersonnel(Fund fund) throws Exception {
		// TODO Auto-generated method stub
		return fundDAO.getFundPersonnel(fund);
	}
	
	@Override
	public void updateFundState(int fundNo) throws Exception {
		// TODO Auto-generated method stub
		
		fundDAO.updateFundState(fundNo);
	}

	@Override
	public List<Fund> getFundSearch(Search search) throws Exception {
		// TODO Auto-generated method stub
		return fundDAO.getFundSearch(search);
	}

	
	

}
