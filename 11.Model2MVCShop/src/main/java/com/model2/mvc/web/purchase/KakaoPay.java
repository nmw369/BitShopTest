package com.model2.mvc.web.purchase;

import java.net.URI;
import java.net.URISyntaxException;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

public class KakaoPay {

	public KakaoPay() {
		// TODO Auto-generated constructor stub
	}
    private static final String HOST = "https://kapi.kakao.com";

    public static void main(String[] args) throws RestClientException, URISyntaxException {
	    paymentReady();
    }

    private static void paymentReady() throws RestClientException, URISyntaxException {

	    RestTemplate restTemplate = new RestTemplate();

	    // 서버로 요청할 Body
	    MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	    params.add("cid", "TC0ONETIME");
	    params.add("partner_order_id", "1001");
	    params.add("partner_user_id", "test@koitt.com");
	    params.add("item_name", "갤럭시S9");
	    params.add("quantity", "1");
	    params.add("total_amount", "11550");
	    params.add("tax_free_amount", "0");
	    params.add("approval_url", "http://127.0.0.1:8080/sns/kakaoPayDemo.jsp");
	    params.add("cancel_url", "http://127.0.0.1:8080/purchase/json/paycancel");
	    params.add("fail_url", "http://127.0.0.1:8080/purchase/json/fail");
	
	    // 서버로 요청할 Header
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Authorization", "KakaoAK " + "e429428556e2835e02b9dcd4f7f55174");
	    /*headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);*/
	    headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
	    headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");

	    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(params, headers);
	    String response = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), request, String.class);
	    System.out.println("여기까지");
	    System.out.println(response);
	    System.out.println("여기부터다시");
	    ObjectMapper obj = new ObjectMapper();
	    JSONObject jobj = (JSONObject)JSONValue.parse(response);
	    System.out.println(jobj.get("tid"));
	    
	    
	    /*params.add("cid", "TC0ONETIME");
	    params.add("tid", (String)jobj.get("tid"));
	    params.add("partner_order_id", "1001");
	    params.add("partner_user_id", "test@koitt.com");
	    params.add("item_name", "갤럭시S9");
	    params.add("quantity", "1");
	    params.add("total_amount", "11550");
	    params.add("tax_free_amount", "0");*/
	    
	  
	    
    }
}

