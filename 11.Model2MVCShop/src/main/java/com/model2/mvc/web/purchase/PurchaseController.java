package com.model2.mvc.web.purchase;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.NaverUser;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Response;
import com.model2.mvc.service.domain.ResponseCode;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.user.UserService;




//==> 회원관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	//setter Method 구현 않음
		
	public PurchaseController(){
		System.out.println(this.getClass());
		System.out.println("purchase::::agsadg");
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value="/addPurchaseView", method=RequestMethod.GET)
	public ModelAndView addPurchaseView(@RequestParam("prodNo") int prodNo) throws Exception {

		System.out.println("/addPurchaseView.do");
		
		Product prod = productService.getProduct(prodNo);
		
		/*model.addAttribute("prodVO",prod);*/
		
		String viewName = "/purchase/addPurchaseView.jsp";
		
		
		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName(viewName);
		modelAndView.addObject("prodVO",prod);
		
		return modelAndView;
	}
	
	@RequestMapping(value="/addPurchase")
	public ModelAndView addPurchase( @ModelAttribute("purchase") Purchase purchase) throws Exception {

		System.out.println("/addPurchase.do");
		//Business Logic
		
		//수량 조절 로직
		Product product = productService.getProduct(purchase.getPurchaseProd().getProdNo());
		productService.updateEA(purchase.getsEA(), product);
		
		System.out.println("여기까지 실행 완료0");
		purchaseService.addPurchase(purchase);
		
		/*request.setAttribute("purchase", purchase);*/
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("/purchase/addPurchase.jsp");
		modelAndView.addObject(purchase);
		
		return modelAndView;
	}
	@RequestMapping(value="/listPurchase")
	public ModelAndView GetPurchaseListAll(@ModelAttribute("search") Search search,HttpServletRequest request) throws Exception{
		 
	 	
	 	System.out.println("/listPurchase.do");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
	 	
		HttpSession session = request.getSession(false);
		
		/*if(session.isNew()) {
			
		}*/
		User user = (User)session.getAttribute("user");
	 	
	 	Map<String,Object> map = purchaseService.getPurchaseList(search,user.getUserId());
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	for (int i = 0; i < list.size(); i++) {
			System.out.println("===========");
	 		System.out.println(list.get(i));
	 		System.out.println("===========");
		}
	 	
	 	Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
	 	
	 	
	 	ModelAndView modelAndView = new ModelAndView();
	 	modelAndView.setViewName("/purchase/listPurchase.jsp");
	 	modelAndView.addObject("list",list);
	 	modelAndView.addObject("resultPage",resultPage);
	 	modelAndView.addObject("search",search);
	 	
	 	
	 	
	 	return modelAndView;
	 }
	
	@RequestMapping(value="/getPurchase", method=RequestMethod.GET)
	public ModelAndView getPurchase( @RequestParam("tranNo")int tranNo) throws Exception {
		
		System.out.println(tranNo+"getPurchase들어온값!!!!!");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		
				
		System.out.println(purchase+"이건 들어왔어!");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("pur",purchase);
		
		return modelAndView;
	}	
	
	@RequestMapping(value="/updatePurchaseView")
	public ModelAndView UpdatePurchaseView(@RequestParam("tranNo")int tranNo) throws Exception{
		
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/updatePurchaseView.jsp");
		modelAndView.addObject("purchaseVO",purchase);
		
		return modelAndView;
	}
	
	@RequestMapping(value="/updatePurchase")
	public ModelAndView UpdatePurchase(@ModelAttribute("purchase") Purchase purchase ,@RequestParam("tranNo")int tranNo) throws Exception{
		
		purchaseService.updatePurcahse(purchase);
		
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("pur",purchase);
		
		return modelAndView;
	}
		
	
	
	/*@RequestMapping("/updateTranCode.do")	
	public ModelAndView UpdateTranCode(@RequestParam("tranCode") int tranCode,HttpServletRequest request) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
				
		String role = "";
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("user");

		if (user != null) {
			role = user.getRole();
		}
		
		System.out.println(":::UPcode------"+user);
		
		String uri="";
		
		int tranNo = Integer.parseInt(request.getParameter("tranNo"));
		
		Purchase purchase = new PurchaseServiceImpl().getPurchase(tranNo);
		if (role.equals("admin")) {
			//admin으로 접속했을때 상품정보를 얻기위해 사용
			uri += "/listSale.do";
			
		} else if (role.equals("user")) {
			uri += "/listPurchase.do";
		}
		System.out.println("들어온코드::" + tranCode);
		tranCode++;
		System.out.println("변경된코드::" + tranCode);

		String tran = tranCode+"";
		System.out.println(tran+"=====tran값!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		purchase.setTranCode(tran);
		purchaseService.updateTranCode(purchase);
		
		modelAndView.setViewName(uri);
		
		
		return modelAndView;
	}*/
	
	
	@RequestMapping(value="/updateTranCodeByProd")	
	public ModelAndView updateTranCodeByProd(@RequestParam("tranCode") int tranCode,@RequestParam("tranNo") int tranNo,HttpServletRequest request) throws Exception{
		
		
		System.out.println("updateTranCode=====================");
		
		ModelAndView modelAndView = new ModelAndView();
				
		String role = "";
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("user");

		if (user != null) {
			role = user.getRole();
		}
		
		System.out.println(":::UPcode------"+user);
		String uri="";
		System.out.println(tranCode+"::::::::::::::::::::::::::::");
		System.out.println("=====================1");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		System.out.println("=====================3");
		if (role.equals("admin")) {
			//admin으로 접속했을때 상품정보를 얻기위해 사용
			uri += "/purchase/listSale";
			
		} else if (role.equals("user")) {
			uri += "/purchase/listPurchase";
		}
		System.out.println("들어온코드::" + tranCode);
		tranCode++;
		System.out.println("변경된코드::" + tranCode);

		String tran = tranCode+"";
		
		purchase.setTranCode(tran);
		
	
		purchaseService.updateTranCode(purchase);
		System.out.println("실행됨???");
		modelAndView.setViewName(uri);
		
		
		return modelAndView;
	}
	
	
	
	@RequestMapping(value="/cancel")
	public String updateCancelCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		int cancelCode = Integer.parseInt(request.getParameter("cancelCode"));
		int tranNo = Integer.parseInt(request.getParameter("tranNo"));
		//구매취소시 다시 취소수량만큼 상품수량증가하는 로직
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		System.out.println(purchase.getPurchaseProd().toString()+"111111111111111111111111111111111111");
		
		productService.updateNEA(purchase.getsEA(), purchase.getPurchaseProd());
				
		System.out.println("cancelCode value::"+cancelCode);
		cancelCode++;
		System.out.println("cancelCode value::"+cancelCode);
				
		purchase.setCancelCode(cancelCode);
		
		purchaseService.updateCancelCode(purchase);
		
		HttpSession session = request.getSession(false);
		
		User user = (User)session.getAttribute("user");
		String uri="";
		if(user.getRole()!=null&&user.getRole().equals("admin")) {
			uri="/purchase/cancelList";
		}else {
			uri="/purchase/listPurchase";
		}
		
		
		return "forward:/"+uri;
	}
	
	@RequestMapping(value="/cancelList")
	public String cancelList(@ModelAttribute("search") Search search,HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("/CancellistPurchase.do");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		search.setCancelCode(Integer.parseInt(request.getParameter("cancelCode")));
		
		
		Map<String, Object> map = purchaseService.cancelList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		System.out.println(map.get("list")+"::cancel 확인");
		/*System.out.println(map.get("totalCount")+"::page total 확인");*/
		
		request.setAttribute("resultPage", resultPage);		
		request.setAttribute("search", search);		
		request.setAttribute("list", map.get("list"));
		/*request.setAttribute("totalCount", map.get("totalCount"));	*/	
		
		return "forward:/purchase/cancelList.jsp";
	}
	
	@RequestMapping(value="/listSale")
	public String salelList(@ModelAttribute("search") Search search,HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("/saleListPurchase");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		search.setCancelCode(Integer.parseInt(request.getParameter("cancelCode")));
		
		Map<String, Object> map = purchaseService.saleList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		
		
		System.out.println("============================================");
		System.out.println(map.get("list")+"::cancel 확인");
		System.out.println("============================================");
		
		request.setAttribute("resultPage", resultPage);		
		request.setAttribute("search", search);		
		request.setAttribute("list", map.get("list"));
		/*request.setAttribute("totalCount", map.get("totalCount"));	*/	
		
		return "forward:/purchase/listSale.jsp";
	}
	
	@RequestMapping(value="/mainView")
	public String MainAction(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
		
		session.removeAttribute("list");
		
		Map<String,Object> map = productService.getMainList();
		
		request.setAttribute("list", map.get("list"));
		//index에 넣기 위한 임시 session
		session.setAttribute("list", map.get("list"));
		//날짜별 조회수 리스트를 위한 로직
		
		System.out.println(map.get("list")+"sdflkjsdfljk");
		
		//날짜 체크해서 현재 날짜와 다르면 그전에 저장된 조회수를 lookup table 에 옮긴후 다시 1부터 시작
		
		Date today = new Date();
	    System.out.println(today);
	        
	    SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
	    SimpleDateFormat time = new SimpleDateFormat("hh:mm:ss a");
	        
	    
	    String currentday = date.format(today);


	    
	    List<Object> list = (List<Object>)map.get("list");
	    
	    System.out.println(map.get("list")+"::::::::::::::::::::::::::::");
	 	for (int i = 0; i < list.size(); i++) {
			Product product = (Product)list.get(i);
			if(product.getToday()!=null && !product.getToday().equals(currentday)) {
				//insert 와 update 둘다 실행함 service에서 나눠서 보냄
				productService.daycheck(currentday, product);
			}else {
				
			}
			 		
		}
		/////////////////////////////////
	 	
		if(request.getParameter("manuDate")!=null) {
		//조회수리스트 제목용 날짜
		request.setAttribute("day", request.getParameter("manuDate"));
		//임시
		session.setAttribute("day", request.getParameter("manuDate"));
		
		
		
		String day = request.getParameter("manuDate").replaceAll("-", "");
		//달력값 날짜
		request.setAttribute("pday", day);
		//임시	
		session.setAttribute("pday", day);
		
		
		
		map = productService.getLookupList(day);
		
		
		/*request.setAttribute("lookuplist", map.get("lookuplist"));*/
		//임시
		session.setAttribute("lookuplist", map.get("lookuplist"));
		session.setAttribute("totalLookup", map.get("totalLookup"));
		
		System.out.println();
		
		System.out.println(day+"=====::parsing한 날짜1");
		System.out.println("====="+map.get("lookuplist"));
		
		//Calender
		
		}else {
			today = new Date();
			date = new SimpleDateFormat("yyyyMMdd");
			
			String day = date.format(today);
			//달력값 날짜
			
				
			request.setAttribute("pday", day);
			//임시
			session.setAttribute("pday", day);
			
			
			map = productService.getLookupList(day);
			
			
			/*request.setAttribute("lookuplist", map.get("lookuplist"));
			request.setAttribute("totallookup", map.get("totalLookup"));*/
			//임시
			session.setAttribute("lookuplist", map.get("lookuplist"));
			session.setAttribute("totalLookup", map.get("totalLookup"));
			System.out.println(day+"=====::parsing한 날짜2");
		}
		
	    /*HttpSession session = request.getSession(false);*/
	    User user = (User)session.getAttribute("user");
	    
	    if(user== null) {
	    	user = new User();
	    	user.setRole("user");
	    }
	    
	    System.out.println(user.getRole()+"::::adminCheck");
	    //차트랑 조회수 구분
	    String start = request.getParameter("start");
	    
	    System.out.println(start+":::start체크");
	    
	    if(start!=null && start.equals("yes")) {
	    request.setAttribute("start", start);
	    }else {
	    request.setAttribute("start", start);
	    }
	    
	    System.out.println(request.getAttribute("start")+":::start체크2");
	    
	    
	    ///차트랑 리스트 날짜 별 조회
	    System.out.println(request.getParameter("manuDate")+"::::날짜 체크!!!");
	    request.setAttribute("manuDate", request.getParameter(date.format(today)));
	    String ipday = date.format(today);
	    //임시
	    session.setAttribute("manuDate", request.getParameter(date.format(today)));
	    
	    
	    
	    //접속한 client ip systemlog io로 txt에 입력하기
	      System.out.println(request.getRemoteAddr()+"::접속한 클라이언트 IP 정보");
  	      String ip = request.getRemoteAddr();
  		
  	      BufferedWriter bw = new BufferedWriter(new FileWriter("C:\\workspace\\11.Model2MVCShop\\"+ipday+"IpLog.txt",true));
  	      //true 쓰면 기존 파일내용에 뒤에 추가되는 내용이 append된다. default가 false이므로 써준것
  	      
  	      String logday = date.format(today)+"-"+time.format(today);
  	      
  	      String ipLog = ip+"날짜-시간:"+logday+"//접속ID:"+user.getUserId();
  	      
  	      bw.write(ipLog);
  	      bw.newLine();
  	      bw.flush();
  	      
  	      bw.close();
		
		System.out.println("main End====================================");
		return "forward:/main/mainView.jsp";
	}
	
	////////////////////////////////////////////////////////////////
	
	@RequestMapping(value="kakaoPay")
	private String paymentReady(@ModelAttribute("Purchase") Purchase purchase,HttpSession session) throws RestClientException, URISyntaxException,Exception {
		
		System.out.println("kakaoPay Start==================================");
		System.out.println(purchase);
		
		String HOST = "https://kapi.kakao.com";
	    RestTemplate restTemplate = new RestTemplate();
	    
	    // 서버로 요청할 내용 (Body)
	    MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	    params.add("cid", "TC0ONETIME");
	    params.add("partner_order_id", purchase.getPurchaseProd().getProdNo()+"");
	    params.add("partner_user_id", purchase.getBuyer().getUserId());
	    params.add("item_name", purchase.getPurchaseProd().getProdName());
	    params.add("quantity", purchase.getsEA()+"");//수량
	    params.add("total_amount", purchase.getPurchaseProd().getPrice()+"");
	    params.add("tax_free_amount", "0");//세금
	    params.add("approval_url", "http://127.0.0.1:8080/purchase/addPurchase.jsp");
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
	    String url = (String)jobj.get("next_redirect_pc_url");
	    System.out.println(url);
	    session.setAttribute("url", url);
	    /*params.add("cid", "TC0ONETIME");
	    params.add("tid", (String)jobj.get("tid"));
	    params.add("partner_order_id", "1001");
	    params.add("partner_user_id", "test@koitt.com");
	    params.add("item_name", "갤럭시S9");
	    */
	    
	    ///addPurchase.jsp로 callback 되는지
	    session.setAttribute("purchase", purchase);
	    
	    //구매완료 되면 add시키고 이동시키기
	    
	    /*purchaseService.addPurchase(purchase);*/
	    
	    
	  return "forward:/sns/kakaoPayDemo.jsp";
	    
    }
	
	@RequestMapping(value="kakaoPay2")
	private String paymentReady2(@ModelAttribute("Purchase") Purchase purchase,HttpSession session) throws RestClientException, URISyntaxException,Exception {
		
		System.out.println("kakaoPay Start==================================");
		System.out.println(purchase);
		
		String HOST = "https://kapi.kakao.com";
	    RestTemplate restTemplate = new RestTemplate();
	    
	    // 서버로 요청할 내용 (Body)
	    MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	    params.add("cid", "TC0ONETIME");
	    params.add("partner_order_id", "1007");
	    params.add("partner_user_id", "user01");
	    params.add("item_name", "꽃개펀딩");
	    params.add("quantity", "0");//수량
	    params.add("total_amount", purchase.getPurchaseProd().getPrice()+"");
	    params.add("tax_free_amount", "0");//세금
	    //params.add("approval_url", "http://127.0.0.1:8080/withdog/addPurchasedog.jsp");
	    params.add("approval_url", "http://192.168.0.42:8080/withdog/addPurchasedog.jsp");
	    //params.add("approval_url", "http://192.168.0.35:8080/withdog/addPurchasedog.jsp");
	    params.add("cancel_url", "http://127.0.0.1:8080/withdog/json/paycancel");
	    params.add("fail_url", "http://127.0.0.1:8080/withdog/json/fail");
	
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
	    String url = (String)jobj.get("next_redirect_pc_url");
	    System.out.println(url);
	    session.setAttribute("url", url);
	    /*params.add("cid", "TC0ONETIME");
	    params.add("tid", (String)jobj.get("tid"));
	    params.add("partner_order_id", "1001");
	    params.add("partner_user_id", "test@koitt.com");
	    params.add("item_name", "갤럭시S9");
	    */
	    
	    ///addPurchase.jsp로 callback 되는지
	    session.setAttribute("purchase", purchase);
	    
	    //구매완료 되면 add시키고 이동시키기
	    
	    /*purchaseService.addPurchase(purchase);*/
	    
	    
	  return "forward:/sns/kakaoPayDemo.jsp";
	    
    }
	
		
	
}