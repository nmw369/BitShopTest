package com.withdog.service.sns;

import org.json.simple.JSONObject;
import org.springframework.util.MultiValueMap;

import com.withdog.service.domain.Point;

public interface SnsDAO {
	
	public JSONObject kakaoPay(Point point,MultiValueMap<String, String> params) throws Exception;
}