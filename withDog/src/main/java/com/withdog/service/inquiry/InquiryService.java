package com.withdog.service.inquiry;

import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Inquiry;

public interface InquiryService {
	
	// INSERT ���ǵ��
	public void addInquiry(Inquiry  inquiry) throws Exception ;
	
	// UPDATE ���Ǽ���
	public void updateInquiry(Inquiry inquiry) throws Exception ;
	
	// UPDATE ���ǻ���
	public void deleteInquiry(int inquiryNo) throws Exception ;
	
	// SELECT ONE ������ȸ 
	public Inquiry  getInquiry(int inquiryNo) throws Exception ;

	// SELECT LIST ���Ǹ���Ʈ
	public Map<String,Object> getInquiryList(Search search, int prodNo) throws Exception ;
	
	// SELECT LIST �����Ǹ���Ʈ
	public Map<String,Object> getMyInquiryList(Search search, String userId) throws Exception;
	
	//UPDATE ��ǰ���Ǵ亯���
	public void updateInquiryReplyAdmin(Inquiry inquiry) throws Exception;
	
	// SELECT LIST ��ǰ���ǰ�������Ʈ
	public Map<String,Object> getInquiryListAdmin(Search search) throws Exception;
		
}