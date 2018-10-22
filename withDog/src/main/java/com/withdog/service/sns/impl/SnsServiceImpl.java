package com.withdog.service.sns.impl;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.withdog.service.domain.Point;
import com.withdog.service.sns.SnsDAO;
import com.withdog.service.sns.SnsService;
import com.withdog.service.user.UserDAO;

@Service("snsServiceImpl")
public class SnsServiceImpl implements SnsService{

	@Autowired
	@Qualifier("snsServiceDAOImpl")
	private SnsDAO snsDAO;
	
	@Override
	public JSONObject FundkakaoPay(Point point,String uri) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("sns KakaoPay Start service");
		
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	    params.add("cid", "TC0ONETIME");
	    params.add("partner_order_id","admin");
	    params.add("partner_user_id",point.getUser().getUserId());
	    params.add("item_name",point.getFund().getFundTitle());
	    params.add("quantity", "1");//수량
	    params.add("total_amount", new String(point.getFund().getFundMyPrice()+"").trim());
	    params.add("tax_free_amount", "0");//세금
	    params.add("approval_url", uri+"0");
	    params.add("cancel_url", uri+"1");
	    params.add("fail_url", uri+"2");
		
		return snsDAO.kakaoPay(point,params);
	}

	public JSONObject AshKakaoPay(Point point, String uri) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("sns KakaoPay Start service");
		
		System.out.println("uri는? " + uri);
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	    params.add("cid", "TC0ONETIME");
	    params.add("partner_order_id","admin");
	    params.add("partner_user_id",point.getUser().getUserId());
	    params.add("item_name","동물교감치유 예약");
	    params.add("quantity", "1");//수량
	    params.add("total_amount", new String(point.getAsh().getAshReservationPrice()+"").trim());
	    params.add("tax_free_amount", "0");//세금
	    params.add("approval_url", uri+"0");
	    /*params.add("cancel_url", "http://192.168.0.34:8080/ash/addReservationASHViewAndroid?state=1");
	    params.add("fail_url", "http://192.168.0.34:8080/ash/addReservationASHViewAndroid?state=2");*/
	    params.add("cancel_url", "http://localhost:8080/ash/addReservationASHViewAndroid?state=1");
	    params.add("fail_url", "http://localhost:8080/ash/addReservationASHViewAndroid?state=2");
		
		return snsDAO.kakaoPay(point,params);
	}

	@Override
	public JSONObject PurchaseKakaoPay(Point point, String uri) throws Exception {
		
		System.out.println("sns PurchaseKakaoPay Start service");
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	    params.add("cid", "TC0ONETIME");
	    params.add("partner_order_id","admin");
	    params.add("partner_user_id",point.getUser().getUserId());
	    if(point.getPurchaseList().size() == 1) {
	    	params.add("item_name",point.getPurchaseList().get(0).getProduct().getProdName());
	    }else {
	    	params.add("item_name",point.getPurchaseList().get(0).getProduct().getProdName() + " 외 " + (point.getPurchaseList().size()-1) + "건");
	    }
	    params.add("quantity", "1");//수량
	    params.add("total_amount", new String(point.getPurchaseList().get(0).getPurchasePrice()+"").trim());
	    params.add("tax_free_amount", "0");//세금
	    params.add("approval_url", uri+"0");
	    params.add("cancel_url", uri+"1");
	    params.add("fail_url", uri+"2");
	    System.out.println("서비스완료");
	    
		return snsDAO.kakaoPay(point, params);
	}

	
	
	
		
}