package com.withdog.service.fund;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Fund;
import com.withdog.service.domain.User;



//==> 회원관리에서 서비스할 내용 추상화/캡슐화한 Service  Interface Definition  
public interface FundService {
	
	public List<Fund> getFundList(User user) throws Exception;
	
	public Fund getFund(int fundNo) throws Exception;
		
	public Map<String,Object> getFundResultList(Search search,User user) throws Exception;
	
	public Map<String,Object> getFundUserList(Search search,User user) throws Exception;
	
	public int addFund(Fund fund) throws Exception;
	
	public void updateFund(Fund fund) throws Exception;
	
	public Fund getMinFund() throws Exception;
	
	public void deleteFund(Fund fund) throws Exception;
	
	public Fund getMyFundNo(Fund fund,User user)throws Exception;
	
	public void updateFundRaising() throws Exception;
	
	public Map<String,Object> getMyFundList(Search search,User user) throws Exception;
	
	public void kakaoPay() throws Exception;
	
	public void addFundRaising(Fund fund) throws Exception;
	
	public int getFundPersonnel(Fund fund) throws Exception;
	
	public void updateFundState(int fundNo) throws Exception;
	
	public List<Fund> getFundSearch(Search search) throws Exception;
		
}