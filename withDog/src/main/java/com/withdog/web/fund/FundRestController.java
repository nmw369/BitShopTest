package com.withdog.web.fund;

import java.net.URI;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.client.RestClientException;

import com.withdog.common.Search;
import com.withdog.service.domain.Fund;
import com.withdog.service.fund.FundService;

@RestController
@RequestMapping("/fund/*")
public class FundRestController {
	
	@Autowired
	@Qualifier("fundServiceImpl")
	private FundService fundService;

	public FundRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="json/kakaoPay")
	private String kakaoPay(@ModelAttribute("Fund") Fund fund,HttpSession session,HttpServletRequest req) throws Exception{
		
		System.out.println("kakaoPay Start==================================");
		System.out.println(req.getParameter("usePoint"));
		System.out.println(fund.toString());
		
		String HOST = "https://kapi.kakao.com";
	    RestTemplate restTemplate = new RestTemplate();
	    
	    // 서버로 요청할 내용 (Body)
	    MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	    params.add("cid", "TC0ONETIME");
	    params.add("partner_order_id","admin");
	    params.add("partner_user_id","user01");
	    params.add("item_name",fund.getFundTitle());
	    params.add("quantity", "1");//수량
	    params.add("total_amount", new String(fund.getFundMyPrice()+"").trim());
	    params.add("tax_free_amount", "0");//세금
	    params.add("approval_url", "http://localhost:8080/fund/getFundList");
	    params.add("cancel_url", "http://localhost:8080/purchase/json/paycancel");
	    params.add("fail_url", "http://localhost:8080/purchase/json/fail");
	
	    // 서버로 요청할 Header
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Authorization", "KakaoAK " + "e429428556e2835e02b9dcd4f7f55174");
	    //headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
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
	    String url = (String)jobj.get("next_redirect_pc_url");
	    System.out.println(url);
	    session.setAttribute("url", url);
	    params.add("cid", "TC0ONETIME");
	    params.add("tid", (String)jobj.get("tid"));
	    params.add("partner_order_id", "1001");
	    params.add("partner_user_id", "test@koitt.com");
	    params.add("item_name", "갤럭시S9");
	    
	    
	    ///addPurchase.jsp로 callback 되는지
	    session.setAttribute("fund", fund);
	    
	    //구매완료 되면 add시키고 이동시키기
	    
	    //fundService.addFund(fund);
	    
	    
	  return "forward:/sns/kakaoPay.jsp";
	    
    }
	
	@RequestMapping(value = "json/getFundSearch")
	public JSONArray getFundSearch(@RequestBody Search search) throws Exception {
		System.out.println("/fund/json/getFundSearch!!!!!!!!!!!!11");
		List<Fund> list = fundService.getFundSearch(search);
				
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < list.size(); i++) {
			if(list.get(i).getFundTitle()!=null) {
			jsonArray.add(list.get(i).getFundTitle());
			}else if(list.get(i).getFundNo()!=0) {
				String temp=list.get(i).getFundNo()+"";
				jsonArray.add(temp.trim());
			}else if(list.get(i).getFundRaising()!=0) {
				String temp=list.get(i).getFundCenter();
			jsonArray.add(temp);
			}
		}
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>"+jsonArray);
		
		return jsonArray;
	}
	
	

}
