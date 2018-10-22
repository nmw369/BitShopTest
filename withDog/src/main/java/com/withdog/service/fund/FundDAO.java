package com.withdog.service.fund;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Fund;
import com.withdog.service.domain.User;



//==> 회원관리에서 서비스할 내용 추상화/캡슐화한 Service  Interface Definition  
public interface FundDAO {
	
	public List<Fund> getFundList(User user) throws Exception;
	
	public Fund getFund(int fundNo) throws Exception;
		
	public List<Fund> getFundResultList(Search search,User user) throws Exception;
	
	public int getResultTotalCount(Search search,User user) throws Exception;
	
	public int getMyTotalCount(Search search,User user) throws Exception;
	
	public int getFundUserTotalCount(Search search,User user) throws Exception;
	
	public List<Fund> getFundUserList(Search search,User user) throws Exception;
	
	public int addFund(Fund fund) throws Exception;
	
	public void updateFund(Fund fund) throws Exception;
	
	public Fund getMinFund() throws Exception;//최저 후원금액 펀딩 추출
	
	public void deleteFund(Fund fund) throws Exception;
	
	public Fund getMyFundNo(Fund fund,User user)throws Exception;//후원번호추출
	
	public void updateFundRaising() throws Exception;
	
	public List<Fund> getMyFundList(Search search,User user) throws Exception;
	
	public void kakaoPay() throws Exception;
	
	public void addFundRaising(Fund fund) throws Exception;
	
	public int getFundPersonnel(Fund fund) throws Exception;
	
	public void updateFundState(int fundNo) throws Exception;
	
	public List<Fund> getFundSearch(Search search) throws Exception;
		
}