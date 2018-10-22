package com.withdog.service.inquiry.impl;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.withdog.common.Search;
import com.withdog.service.domain.Inquiry;
import com.withdog.service.inquiry.InquiryDAO;
import com.withdog.service.inquiry.InquiryService;

@Service("inquiryServiceImpl")
public class InquiryServiceImpl implements InquiryService {

	@Autowired
	@Qualifier("inquiryDAOImpl")
	private InquiryDAO inquiryDAO;
		
	@Override
	public void addInquiry(Inquiry inquiry) throws Exception {
		inquiryDAO.addInquiry(inquiry);
	}
	
	@Override
	public void updateInquiry(Inquiry inquiry) throws Exception {
		inquiryDAO.updateInquiry(inquiry);
	}
	
	@Override
	public void deleteInquiry(int inquiryNo) throws Exception {
		inquiryDAO.deleteInquiry(inquiryNo);
	}
	
	@Override
	public void updateInquiryReplyAdmin(Inquiry inquiry) throws Exception {
		inquiryDAO.updateInquiryReplyAdmin(inquiry);
	}

	@Override
	public Inquiry getInquiry(int inquiryNo) throws Exception {
		return inquiryDAO.getInquiry(inquiryNo);
	}

	@Override
	public  Map<String,Object> getInquiryList(Search search, int prodNo) throws Exception {
		return inquiryDAO.getInquiryList(search, prodNo);
	}
	
	@Override
	public  Map<String,Object> getMyInquiryList(Search search, String userId) throws Exception {
		return inquiryDAO.getMyInquiryList(search, userId);
	}
	
	@Override
	public  Map<String,Object> getInquiryListAdmin(Search search) throws Exception {
		return inquiryDAO.getInquiryListAdmin(search);
	}


}
