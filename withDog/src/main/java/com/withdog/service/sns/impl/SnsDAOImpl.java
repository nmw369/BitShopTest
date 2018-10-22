package com.withdog.service.sns.impl;

import java.net.URI;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.withdog.service.domain.Point;
import com.withdog.service.sns.SnsDAO;

@Service("snsServiceDAOImpl")
public class SnsDAOImpl implements SnsDAO {

	@Override
	public JSONObject kakaoPay(Point point,MultiValueMap<String, String> params) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("=========================SNSDAO Start=========================");
		
		JSONObject jobj = new JSONObject();
		
		
			System.out.println("Sns purchase Start");
			
			String HOST = "https://kapi.kakao.com";
		    RestTemplate restTemplate = new RestTemplate();
		    
		    // 서버로 요청할 Header
		    HttpHeaders headers = new HttpHeaders();
		    headers.add("Authorization", "KakaoAK " + "e429428556e2835e02b9dcd4f7f55174");
		    //headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
		    headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
		    headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
		    
		    System.out.println("여깍진오냐?");
		    	
		    System.out.println(params.toString());
		    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(params, headers);
		    System.out.println("여깍진오냐2222?");
		    String response = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), request, String.class);
		    System.out.println("여기까지");
		    System.out.println(response);
		    System.out.println("여기부터다시");
		    ObjectMapper obj = new ObjectMapper();
		   jobj = (JSONObject)JSONValue.parse(response);
		    System.out.println(jobj.get("tid"));
		
			
		return jobj;
	}
	
	
}