package com.model2.mvc.web.purchase;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

//==> 회원관리 RestController
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {

	/// Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	// setter Method 구현 않음

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	public PurchaseRestController() {
		System.out.println(this.getClass());
	}

	/*@RequestMapping(value = "json/addPurchase")
	public Purchase addPurchase(@RequestBody Purchase purchase) throws Exception {
		System.out.println("/purchase/json/addPurchase");
		System.out.println("::" + purchase);
		purchaseService.addPurchase(purchase);

		Purchase dbPurchase = purchaseService.getPurchase(10095);
		System.out.println("리턴되는 purchase : " + dbPurchase);
		return dbPurchase;

	}*/

	@RequestMapping(value = "json/getPurchase/{tranNo}")
	public Purchase getPurchase(@PathVariable int tranNo) throws Exception {
		Purchase purchase = purchaseService.getPurchase(10089);
		System.out.println("getPurchase :: " + purchase);
		
		
		return purchase;
	}

	@RequestMapping(value = "json/updatePurchase")
	public Purchase updatePurchase(@RequestBody Purchase purchase) throws Exception {
		System.out.println("purchase/json/updatePurchase");
		purchaseService.updatePurcahse(purchase);

		return purchase;
	}

	/*@RequestMapping(value = "json/getListPurchase")
	public Map<String, Object> getListPurchase(@RequestBody JSONObject map1) throws Exception {
		System.out.println("purchase/json/getListPurchase");
		System.out.println(map1);
		System.out.println(1);
		
		ObjectMapper obj = new ObjectMapper();
		JSONObject json = (JSONObject)JSONValue.parse(map1.toString());
		
		System.out.println(json.get("search"));
		
		Search search = obj.readValue(json.get("search").toString(), Search.class);
		System.out.println(search);
		System.out.println(2);
		
		
		
		User user = obj.readValue(json.get("user").toString(), User.class);
		Purchase purchase = obj.readValue(json.get("purchase").toString(), Purchase.class);
		System.out.println(purchase);
		System.out.println(3);
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, purchase.getBuyer().getUserId());
		Map<String, Object> map = purchaseService.getPurchaseList(search, user.getUserId());
		
		System.out.println(map.toString()+"aaaaaa");
		System.out.println("-=================");
		
		return map;
	}*/
	
	@RequestMapping(value = "json/getListPurchase")
	public Map<String, Object> getListPurchase(@RequestBody JSONObject map1) throws Exception {
		System.out.println("purchase/json/getListPurchase");
		System.out.println(map1);
		System.out.println(1);
		
		ObjectMapper obj = new ObjectMapper();
		JSONObject json = (JSONObject)JSONValue.parse(map1.toString());
		
		System.out.println(json.get("search"));
		
		Search search = obj.readValue(json.get("search").toString(), Search.class);
		System.out.println(search);
		System.out.println(2);
		
		
		
		User user = obj.readValue(json.get("user").toString(), User.class);
		/*Purchase purchase = obj.readValue(json.get("purchase").toString(), Purchase.class);
		System.out.println(purchase);
		System.out.println(3);*/
		
		/*Map<String, Object> map = purchaseService.getPurchaseList(search, purchase.getBuyer().getUserId());*/
		Map<String, Object> map = purchaseService.getPurchaseList(search, user.getUserId());
		
		System.out.println(map.toString()+"aaaaaa");
		System.out.println("-=================");
		
		return map;
	}

	
	@RequestMapping(value="json/approval")
	public void approval() {
		System.out.println("approval/////////////");
		
	}
	@RequestMapping(value="json/paycancel")
	public void paycancel() {
		System.out.println("paycancel/////////////");
	}
	@RequestMapping(value="json/fail")
	public void fail() {
		System.out.println("fail/////////////");
	}
	
	
	@RequestMapping(value="json/mainView")
	public JSONObject MainAction(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
		
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
		
		
		request.setAttribute("lookuplist", map.get("lookuplist"));
		//임시
		session.setAttribute("lookuplist", map.get("lookuplist"));
		
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
			
			
			request.setAttribute("lookuplist", map.get("lookuplist"));
			//임시
			session.setAttribute("lookuplist", map.get("lookuplist"));
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
  		
  	      BufferedWriter bw = new BufferedWriter(new FileWriter("C:\\workspace\\10.Model2MVCShop(Ajax)\\IPlog\\"+ipday+"IpLog.txt",true));
  	      //true 쓰면 기존 파일내용에 뒤에 추가되는 내용이 append된다. default가 false이므로 써준것
  	      
  	      String logday = date.format(today)+"-"+time.format(today);
  	      
  	      String ipLog = ip+"날짜-시간:"+logday+"//접속ID:"+user.getUserId();
  	      
  	      bw.write(ipLog);
  	      bw.newLine();
  	      bw.flush();
  	      
  	      bw.close();
		
		System.out.println("main End====================================");
		
		JSONObject jobj = new JSONObject();
		jobj.put("abc", "aaaaaaa");
		
		/*return "forward:main/mainView.jsp";*/
		return jobj;
	}
	
	@RequestMapping(value="json/addPurchase")
	public JSONObject addPurchase(HttpSession session) throws Exception {
		
		System.out.println("/json/addPurchase.do!!");
		
		ObjectMapper obj = new ObjectMapper();
		
		Purchase purchase = (Purchase)session.getAttribute("purchase");
		
		System.out.println("/addPurchase.do!!");
		//Business Logic
		
		//수량 조절 로직
		Product product = productService.getProduct(purchase.getPurchaseProd().getProdNo());
		productService.updateEA(purchase.getsEA(), product);
		
		System.out.println("여기까지 실행 완료0");
		purchaseService.addPurchase(purchase);
		
		String jsonCh = obj.writeValueAsString(purchase);
				
		JSONObject jobj = (JSONObject)JSONValue.parse(jsonCh);
			
		session.removeAttribute("purchase");
		return jobj;
	}
	
}