package com.withdog.service.inquiry;

import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Inquiry;

public interface InquiryService {
	
	// INSERT 문의등록
	public void addInquiry(Inquiry  inquiry) throws Exception ;
	
	// UPDATE 문의수정
	public void updateInquiry(Inquiry inquiry) throws Exception ;
	
	// UPDATE 문의삭제
	public void deleteInquiry(int inquiryNo) throws Exception ;
	
	// SELECT ONE 문의조회 
	public Inquiry  getInquiry(int inquiryNo) throws Exception ;

	// SELECT LIST 문의리스트
	public Map<String,Object> getInquiryList(Search search, int prodNo) throws Exception ;
	
	// SELECT LIST 내문의리스트
	public Map<String,Object> getMyInquiryList(Search search, String userId) throws Exception;
	
	//UPDATE 상품문의답변등록
	public void updateInquiryReplyAdmin(Inquiry inquiry) throws Exception;
	
	// SELECT LIST 상품문의관리리스트
	public Map<String,Object> getInquiryListAdmin(Search search) throws Exception;
		
}