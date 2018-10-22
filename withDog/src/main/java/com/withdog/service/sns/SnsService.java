package com.withdog.service.sns;

import org.json.simple.JSONObject;

import com.withdog.service.domain.Point;

public interface SnsService {
	
	public JSONObject FundkakaoPay(Point point,String uri) throws Exception;
	public JSONObject AshKakaoPay(Point point,String uri) throws Exception;
	public JSONObject PurchaseKakaoPay(Point point,String uri) throws Exception;
		
}