package com.withdog.web.purchase;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.cart.CartService;
import com.withdog.service.common.CommonService;
import com.withdog.service.domain.Ash;
import com.withdog.service.domain.Cart;
import com.withdog.service.domain.Fund;
import com.withdog.service.domain.Point;
import com.withdog.service.domain.Product;
import com.withdog.service.domain.Purchase;
import com.withdog.service.domain.User;
import com.withdog.service.product.ProductService;
import com.withdog.service.purchase.PurchaseService;
import com.withdog.service.sns.SnsService;
import com.withdog.service.user.UserService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	@Autowired
	@Qualifier("commonServiceImpl")
	private CommonService commonService;
	
	@Autowired
	@Qualifier("snsServiceImpl")
	private SnsService snsService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;


	public PurchaseController() {
		System.out.println(this.getClass());
	}
	
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
//	//�ϳ��� ���Ž� ���� 
//	@RequestMapping(value="addPurchaseView", method=RequestMethod.POST)
//	public String addPurchaseView(@RequestParam("prodNo") int prodNo, @ModelAttribute Purchase purchase, HttpServletRequest request, Model model, HttpSession session) throws Exception{
//		
//		System.out.println("/purchase/addPurchaseView : POST");
//		
//		System.out.println(purchase);
//		
//		//���δ�Ʈ ��ü�� ��ü�̽� �ʵ忡 ���
//		Product product = productService.getProduct(prodNo);
//		purchase.setProduct(product);
//		
//		System.out.println("���δ�Ʈ��ü======================="+product);
//		
//		if(session.getAttribute("user")!=null) {
//			System.out.println("������");
//			//���ǿ��� user���� ������ user��ü�� ��� purchase �ʵ忡 �ɱ�
//			User user = (User)session.getAttribute("user");
//			purchase.setUser(user);
//			System.out.println(user.getUserId());
//			
//			//�ӽ�
//			Point point = new Point();
//			point.setUser(user);
//			
//			int currentPoint=commonService.getCurrentPoint(point);
//			
//			model.addAttribute("currentPoint", currentPoint);
//		}
//		
//		System.out.println("��ü�̽���ü=========================" +purchase);
//		model.addAttribute("purchase", purchase);
//		
//		return "forward:/store/addPurchase.jsp";
//	}
	
	//��ٱ��Ͽ��� ����Ʈ������ �Ѿ������ ����
	@RequestMapping(value="addPurchaseView")
	public String addPurchaseView(@RequestParam(value="prodNo", required=false) String prodNo, 
									@ModelAttribute Purchase purchase, 
									@RequestParam(value="cartList", required=false) String cartList, 
									Model model, 
									HttpSession session) throws Exception{
		
		System.out.println("/purchase/addPurchaseView : ����ȭ��");
		
		//��ٱ��Ͽ��� ���ŷ� �Ѿ�ö��� cartNo�� �Ѿ����, �ٷα��ſ��� �Ѿ�ö��� prodNo�� �Ѿ���⶧����  
		//prodNo�� 0�� �ƴҶ� (�ٷα��Ž�)
		if(prodNo != null) {
			
			System.out.println("/purchase/addPurchaseView : �ٷα���" + prodNo);
			Product product = productService.getProduct(Integer.parseInt(prodNo));
			
			Cart cart = new Cart();
			cart.setProduct(product);
			cart.setCartQuantity(purchase.getPurchaseQuantity());
			
			List<Cart> list = new ArrayList<Cart>();
			
			list.add(cart);
			User user = (User)session.getAttribute("user");
			
			//��������Ʈ
			Point point = new Point();
			point.setUser(user);
			int currentPoint=commonService.getCurrentPoint(point);
			
			model.addAttribute("currentPoint", currentPoint);
			model.addAttribute("list", list);
			
		}else {
			
			System.out.println("/purchase/addPurchaseView : ��ٱ��Ͽ��� ����");
			
			Map<String, Object> map = cartService.getSelectCartList(cartList);
			
			//��������Ʈ
			Point point = new Point();
			User user = (User)session.getAttribute("user");
			point.setUser(user);
			
			int currentPoint=commonService.getCurrentPoint(point);
			
			model.addAttribute("currentPoint", currentPoint);
			model.addAttribute("list", map.get("list"));
		}
		
		
		return "forward:/store/addPurchase.jsp";
	}
	
	
	/*@RequestMapping(value="addPurchase")
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase, @RequestParam("prodNo") int prodNo, HttpSession session, HttpServletRequest req,  Model model) throws Exception{
		
		System.out.println("/purchase/addPurchase : POST");
		
		System.out.println(purchase);
		
		
		//���ǿ��� user���� ������ user��ü�� ��� purchase �ʵ忡 �ɱ�
		User user = (User)session.getAttribute("user");
		purchase.setUser(user);
		
		//���δ�Ʈ ��ü�� ��ü�̽� �ʵ忡 ���
		Product product = productService.getProduct(prodNo);
		purchase.setProduct(product);
		
		System.out.println("��������" + purchase);
		purchaseService.addPurchase(purchase);		
		
		System.out.println("��񰫴ٿӴ�" + purchase);
		//��ǰ����
		int prodQuantity = product.getProdQuantity();
		
		//���ż���
		int purchaseQuantity = purchase.getPurchaseQuantity();
		//��ǰ����-���ż��� = ��ǰ����
		prodQuantity = prodQuantity - purchaseQuantity;
		//����� ��ǰ������ ���δ�Ʈ ��ü�� ���
		product.setProdQuantity(prodQuantity);
		
		//���δ�Ʈ����������Ʈ
		productService.updateProductAdmin(product);
		
		//snsKakaoPay�� ���� ����
		Point pointPurchase = new Point();
		pointPurchase.setPurchase(purchase);
		
		int price =0;
		int usePoint =0;
		
		if(pointPurchase.getPurchase().getPurchasePrice()!=0) {
			price=pointPurchase.getPurchase().getPurchasePrice();
		}
		if(Integer.parseInt(req.getParameter("usePoint"))!=0) {
			pointPurchase.setUsePoint(Integer.parseInt(req.getParameter("usePoint")));
			usePoint=Integer.parseInt(req.getParameter("usePoint"));
		}
		
		//����Ʈ
		Point point = new Point();
		
		//���ǿ� �ִ� ���������� ������ ĳ�����ؼ� ����Ʈ�� �ִ� �����ʵ忡 ���
		point.setUser((User) session.getAttribute("user"));
		
		//��� ������ ������ �ִ� ��������Ʈ�� currentPoint�� ����
		int currentPoint = commonService.getCurrentPoint(point);
		
		point.setUsePoint(pointPurchase.getUsePoint());
		
		model.addAttribute("currentPoint", currentPoint);
		model.addAttribute("purchase", purchase);
		model.addAttribute("usePoint", point.getUsePoint());
		
		return "forward:/store/addPurchaseConfirm.jsp";
	}*/
	
	
	@RequestMapping(value = "kakaoPay")
	private String kakaoPay(@ModelAttribute Purchase purchase, @RequestParam("prodNo") String prodNo,
							@RequestParam("cartQuantity") String cartQuantity, 
							//@RequestParam("price") String price, 
							@RequestParam("cartNo") String cartNo, @RequestParam("usePoint") String usePoint,
							HttpSession session, HttpServletRequest request, Model model) throws Exception {
		
		System.out.println("/purchase/kakaoPay Start==================================");
		System.out.println("�Ѿ�� �������Ʈ" +usePoint);
		System.out.println("�Ѿ�� ��ü" + purchase);
		System.out.println("cartNo" + cartNo);
		//System.out.println("price" + price);
		System.out.println("cartQuantity" + cartQuantity);
		
		//,,�� ���� ������ �Ľ�
		String[] parseProdNo = prodNo.split(",");
		String[] parseCartQuantity = cartQuantity.split(",");
		//String[] parsePrice = price.split(",");
		String[] parseCartNo = cartNo.split(",");
		
		for(int i=0; i<parseProdNo.length; i++) {
			System.out.println(parseProdNo[i] + "," + parseCartQuantity[i] + "," + parseCartNo[i]);
		}
		
		List<Purchase> list = new ArrayList<Purchase>();
		for(int i=0; i<parseProdNo.length; i++) {
			Purchase pur = new Purchase();
			
			Product pro = productService.getProduct(Integer.parseInt(parseProdNo[i]));
			pur.setProduct(pro);
			
			User user = (User)session.getAttribute("user");
			pur.setUser(user);
			
			pur.setReceiverName(purchase.getReceiverName());
			pur.setReceiverPhone(purchase.getReceiverPhone());
			pur.setReceiverAddr1(purchase.getReceiverAddr1());
			pur.setReceiverAddr2(purchase.getReceiverAddr2());
			pur.setDivyRequest(purchase.getDivyRequest());
			pur.setPurchaseQuantity(Integer.parseInt(parseCartQuantity[i]));
			pur.setPurchasePrice(purchase.getPurchasePrice());		
			if(Integer.parseInt(parseCartNo[i]) == 0) {
				pur.setCartNo(purchaseService.addCartSeq());
			}else {
				pur.setCartNo(Integer.parseInt(parseCartNo[i]));
			}
			
			list.add(pur);
		}
		
		for(int i = 0; i<list.size(); i++) {
			System.out.println(list.get(i));
		}
		
		
		
		//���ǿ��� user���� ������ user��ü�� ��� purchase �ʵ忡 �ɱ�
		User user = (User)session.getAttribute("user");
		
		int kakaoUsePoint = 0;

		/// ������.jsp�� ī�� ������ callback �Ǵ���
		String forwardUri = "forward:/sns/kakaoPay.jsp";
		// snsKakaoPay�� ���� ����
		Point pointPurchase = new Point();
		pointPurchase.setUser(user);
		pointPurchase.setPurchaseList(list);
		
		System.out.println(usePoint + "111");
		if (Integer.parseInt(usePoint) != 0) { // ����� ����Ʈ�� 0�� �ƴ϶��
			pointPurchase.setUsePoint(Integer.parseInt(usePoint));
			kakaoUsePoint = Integer.parseInt(usePoint);
		}
		
		if (pointPurchase.getPurchaseList().get(0).getPurchasePrice() != 0) { // ���� �� ���ݾ��� 0�� �ƴ϶��?
			String uri = "http://localhost:8080/purchase/addPurchaseDone?state=";
			MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();

			JSONObject jobj = snsService.PurchaseKakaoPay(pointPurchase, uri); // īī������ �ٳ�ͼ� �����͸� �޴� ��ü

			System.out.println(jobj.get("tid"));
			String url = (String) jobj.get("next_redirect_pc_url");
			System.out.println("next_redirect_pc_url ? " + url); // ����â
			session.setAttribute("url", url);
			
		} else { // ����Ʈ�θ� ������ īī�����̳Ѿ���ʰ� �ٷ� �����Ϸ�â
			forwardUri = "forward:/purchase/addPurchaseDone?state=0";
		}

		// �ӽ�ó��
		Point point = new Point();

		// ����Ʈ �̰͸� �ܱ�
		purchase.setUser(user);
		point.setUser(user);// userid
		point.setPurchaseList(list);
		System.out.println("����� ����Ʈ�� ? : " + pointPurchase.getUsePoint());
		point.setUsePoint(pointPurchase.getUsePoint());

		System.out.println("���Ǵ��������Ʈ" +point);
		session.setAttribute("pointPurchase", point);

		return forwardUri;

	}
	
	
	
	@RequestMapping(value = "addPurchaseDone")//���� ������ �����Ϸ�â
	public String addPurchaseDone(HttpServletRequest request) throws Exception {
		System.out.println("/purchase/addPurchaseDone : ��������");

		Point point = new Point();
		List<Purchase> list = new ArrayList<>();
		Purchase purchase = new Purchase();
		User user = new User();

		HttpSession session = request.getSession(false);

		session.removeAttribute("url");

		String state = request.getParameter("state");

		if(state!=null) {
			if(state.equals("2")) {
				System.out.println("��������");
				request.setAttribute("state", "2");
			
			}
			else if(state.equals("1")) {
				System.out.println("�������");
				request.setAttribute("state", "1");
				
			}
			else if(state.equals("0")) {
				System.out.println("��������");
				request.setAttribute("state", "0");
				
				
				if(session.getAttribute("pointPurchase")!=null) {
					point = (Point)session.getAttribute("pointPurchase");
					list = point.getPurchaseList();
					user = point.getUser();
					
					int nextPurchaseNo = purchaseService.addPurchaseSeq();
					
					for(int i=0; i<list.size(); i++) {
						purchase = list.get(i);
						purchase.setPurchaseNo(nextPurchaseNo);
						purchaseService.addPurchase(purchase);
						list.get(i).setPurchaseNo(nextPurchaseNo);
						
						Product product = new Product();
						product = productService.getProduct(purchase.getProduct().getProdNo());
						
					    //��ǰ����
						int prodQuantity = product.getProdQuantity();
						
						//���ż���
						int purchaseQuantity = purchase.getPurchaseQuantity();
						
						//��ǰ����-���ż��� = ��ǰ����
						prodQuantity = prodQuantity - purchaseQuantity;
						//����� ��ǰ������ ���δ�Ʈ ��ü�� ���
						product.setProdQuantity(prodQuantity);
						
						//���δ�Ʈ����������Ʈ
						productService.updateProductAdmin(product);
						
						int cartNo = purchase.getCartNo();
						cartService.deleteCart(cartNo);
					}
					
				    point.setPurchaseList(list);//�Ŀ�,����,���� ������ ����
				    point.setPurchase(purchase);
				    
				    double savePoint = list.get(0).getPurchasePrice()*0.01;
				    System.out.println("��������Ʈ"+savePoint);
				    int resultpoint = (int)savePoint;
				    point.setPoint(resultpoint);

				   	commonService.addPointinfo(point);
				   	
				   	
					/////////////����Ϸ� �̸��� ������ ����////////////////////
					//�����ּ�
					String userEmail ="withdog0817@naver.com" ;
					
					 //�޷°�������
					 Date today = new Date();   
					 
					 //����
					 SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd"); 
					 String toDay = date.format(today);
					
					// ���� ���� �ۼ� ::  �̸����ּ�, �������� , ����
					String title ="[�Բ��Ұ�]��ǰ���Ű� �Ϸ�Ǿ����ϴ�.";    
					String url ="http://localhost:8080/";
					String htmlText ="<body style=\"box-sizing: border-box; line-height: 24px; font-family: '�������', 'malgun gothic', 'dotum', sans-serif;\">\r\n" + 
							"	<div style=\"margin:0 auto; width: 750px; height:195px; font-size: 16px; background:url(http://localhost:8080/images/icon/mail_bg.jpg) no-repeat;\">\r\n" + 
							"		<div style=\"font-size: 30px; text-align:center; margin-bottom: 60px; margin-top: 44px; color: #fff;\">\r\n" + 
							"			<p style=\"padding-top:78px; margin-bottom: 13px;\">"+purchase.getUser().getUserName()+"����</p> ��ǰ���Ű� �Ϸ�Ǿ����ϴ�. \r\n" + 
							"		</div>\r\n" + 
							"	</div>\r\n" + 
							"	<div style=\"width:640px; padding:20px 0; margin:0 auto; margin-top:50px\">\r\n" + 
							"		<p style=\"border-bottom: 2px solid #000; padding-bottom: 10px; font-size: 18px; font-weight: 700;\">���೻������ </p>\r\n" + 
							"			<ul style=\"font-size:17px;\">\r\n" + 
							"				<li>���Ź�ȣ: "+purchase.getPurchaseNo()+"</li>\r\n" + 
							"				<li>�����Ͻ�:"+ toDay+"</li>\r\n" + 
							"				<li>�����:"+purchase.getReceiverAddr1()+purchase.getReceiverAddr2()+"</li>\r\n" +
							"				<li><a href=\"http://localhost:8080\">�Բ��Ұ� ����Ʈ �ٷΰ���</a></li>\r\n" + 
							"			</ul>\r\n" + 
							"	</div>\r\n" + 
							"	<div style=\"width:640px; padding:20px 0; margin:0 auto;\">\r\n" + 
							"		<p style=\"border-bottom: 2px solid #000; padding-bottom: 10px; font-size: 18px; font-weight: 700;\">��������</p>\r\n" + 
							"			<ul style=\"font-size:17px;\">\r\n" + 
							"				<li>�����ݾ�: "+purchase.getPurchasePrice()+"��</li>\r\n" + 
							"				<li>��������: īī������</li>\r\n" + 
							"			</ul>\r\n" + 
							"	</div>\r\n" + 
							"	<div style=\"background-color: #eee; margin:0 auto; width: 750px\">\r\n" + 
							"		<ul style=\"font-size:13px; padding: 30px 0 30px 36px; color: #868686; list-style: none;\">\r\n" + 
							"			<li>1. �� ������ �Բ��Ұ� ���� � �� ���� �������� �߼۵Ǵ� �߽� ���� �����Դϴ�.</li>\r\n" + 
							"			<li>2. ���ǻ����� �Բ��Ұ� Ȩ������ �� �����͸� �̿����ּ���.</li>\r\n" + 
							"			<li>COPYRIGHT 2018. WITH DOG INC. ALL RIGHTS RESERVED</li>\r\n" + 
							"		</ul>\r\n" + 
							"	</div>\r\n" + 
							"</body>";

					//�̸��� ������ �޼���
					boolean sendOk =userService.sendConfirmEmail(userEmail, htmlText, title);
					/////////////����Ϸ� �̸��� ������ ��////////////////////
				   	
				   	
//					// ��ǰ�� ������ ���� ID�� Token ã��
//					List<String> pushToken = commonService.getPushToken(purchase.getUser().getUserId());
//					System.out.println("Ǫ�� ��ū : "+pushToken);
//					if(pushToken != null) {
//						// token���� push �޼��� ������
//						for(int i=0; i<pushToken.size(); i++) {
//							String result = sendPushNotification(pushToken.get(i), purchase, list.size());
//							System.out.println("Ǫ�� ��� : "+result);
//						}
//					}
					
					// ��ǰ�� ������ ���� ID�� Token ã��
					List<String> pushToken = commonService.getPushToken(purchase.getUser().getUserId());
					System.out.println("Ǫ�� ��ū : "+pushToken);
					if(pushToken != null) {
						
						// token���� push �޼��� ������
						for(int i=0; i<pushToken.size(); i++) {
							String result = sendPushNotification(pushToken.get(i), purchase, list.size());
							System.out.println("Ǫ�� ��� : "+result);
						}
						
						//��ū ����� 0�̶�� ���ڹ߼�
						
							//��ū�� ���ٸ� ���ڹ߼�
							String userPhoneNo  =purchase.getReceiverPhone();
							int a = purchase.getPurchaseNo();
							int b= purchase.getPurchasePrice();
							 //�޷°�������
							 today = new Date();   
							 
							 //����
							 date = new SimpleDateFormat("yyyy-MM-dd"); 
							 toDay = date.format(today);
							 
							 System.out.println("���� ��������!!!!!!!!!!");
							 System.out.println("���� ������ ��ȣ"+userPhoneNo);
							 
							String conText ="[�Բ��Ұ�]���� ���Ű� �Ϸ�Ǿ����ϴ�. ���Ź�ȣ:"+a+" �����ݾ�:"+b+"�� "+"�����Ͻ�:"+toDay;
							 Boolean ok = userService.sendText(userPhoneNo, conText);
								
					}
					
					
				}
				
			}else {
				request.setAttribute("state", "3");
				
				if(session.getAttribute("pointPurchase")!=null) {
					point = (Point)session.getAttribute("pointPurchase");
					list = point.getPurchaseList();
					user = point.getUser();
					
					
				    //���� ��ȣ ��������
				    point.setPurchaseList(list);//�Ŀ�,����,���� ������ ����
				    
				    double savePoint = list.get(0).getPurchasePrice()*0.01;
				    System.out.println("��������Ʈ"+savePoint);
				    int resultpoint = (int)savePoint;
				    point.setPoint(resultpoint);
				    
				}
				
			}
	}
		System.out.println("������Ʈ���������Ʈ" +point);
		request.setAttribute("pointPurchase", point);
		System.out.println("ȭ��ѷ�������" + purchase);
		return "forward:/store/addPurchaseConfirm.jsp";
}
	
	
	@RequestMapping(value="/getMyPurchaseList")
	public String getMyPurchaseList(@ModelAttribute("search") Search search, HttpServletRequest request,HttpSession session) throws Exception {

		System.out.println("/purchase/getMyPurchaseList : ���Ǳ��ų�������Ʈ");
		//Business Logic
		User user = new User();
		if(session.getAttribute("user")!=null) {
		user = (User)session.getAttribute("user");
		}
	 	if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println(search);
		Map<String,Object> map = purchaseService.getPurchaseList(search, user); 	
		
		System.out.println("MAP üũ ===========================");
		System.out.println(map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		request.setAttribute("list", map.get("list"));
		request.setAttribute("resultPage", resultPage);
		request.setAttribute("search", search);
		
		return "forward:/mypage/listMyPurchase.jsp";
	}
	
	
	@RequestMapping(value = "getMyPurchase")
	public String getMyPurchase(@RequestParam("purchaseNo") int purchaseNo, HttpServletRequest request, HttpSession session, Model model) throws Exception{ 
		
		System.out.println("/purchase/getMyPurchase : ���Ǳ��Ż�����");

		List<Purchase> purchaselist = purchaseService.getPurchase(purchaseNo);
		
		System.out.println(purchaselist + "���񽺰��ٿ���ü�̽�");
		
		model.addAttribute("purchaselist", purchaselist);
		
		
		return "forward:/mypage/getMyPurchase.jsp";
	}
	
	
	@RequestMapping(value = "updateMyPurchase", method=RequestMethod.GET)
	public String updateMyPurchase(@RequestParam("purchaseNo") int purchaseNo, HttpServletRequest request, HttpSession session, Model model) throws Exception{ 
		
		System.out.println("/purchase/updateMyPurchase : GET ���Ǳ��Ż����� ����");

		List<Purchase> purchaselist = purchaseService.getPurchase(purchaseNo);
		
		System.out.println(purchaselist + "���񽺰��ٿ���ü�̽�");
		
		model.addAttribute("purchaselist", purchaselist);
		
		return "forward:/mypage/updateMyPurchase.jsp";
	}
	
	
	@RequestMapping(value = "updateMyPurchaseConfirm", method=RequestMethod.POST)
	public String updateMyPurchaseConfirm(@ModelAttribute("purchase") Purchase purchase, @RequestParam("purchaseNo") int purchaseNo, HttpServletRequest request, HttpSession session, Model model) throws Exception{ 
		
		System.out.println("/purchase/updateMyPurchaseConfirm : POST ���Ǳ��Ż����� ����");
		
		purchase.setPurchaseNo(purchaseNo);
		purchaseService.updatePurchase(purchase);
		
		System.out.println(purchaseNo);
		List<Purchase> purchaselist = purchaseService.getPurchase(purchaseNo);
		model.addAttribute("purchaselist", purchaselist);
		
		return "forward:/mypage/getMyPurchase.jsp";
	}
	
	
	@RequestMapping(value="/getSalesListAdmin")
	public String getPurchaseListAdmin(@ModelAttribute("search") Search search, HttpServletRequest request,HttpSession session) throws Exception {

		System.out.println("/purchase/getPurchaseListAdmin : �ǸŰ�������Ʈ");
		//�󲮵������� (�η� �ѱ������)
		User user = new User();

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		Map<String,Object> map = purchaseService.getPurchaseList(search, user); 	
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		request.setAttribute("list", map.get("list"));
		request.setAttribute("resultPage", resultPage);
		request.setAttribute("search", search);
		
		return "forward:/admin/listSalesAdmin.jsp";
	}
	
	
	@RequestMapping(value = "getSalesAdmin")
	public String getSalesAdmin(@RequestParam("purchaseNo") int purchaseNo, HttpServletRequest request, HttpSession session, Model model) throws Exception{ 
		
		System.out.println("/purchase/getSalesAdmin : �ǸŻ�����");
		
		System.out.println(purchaseNo + "�Ѿ�³ѹ�");

		List<Purchase> purchaselist = purchaseService.getPurchase(purchaseNo);
		
		System.out.println(purchaselist + "���񽺰��ٿ���ü�̽�");
		
		model.addAttribute("purchaselist", purchaselist);
		
		
		return "forward:/admin/getSalesAdmin.jsp";
	}
	
	
	
	public static String sendPushNotification(String deviceToken, Purchase purchase, int count) throws IOException {
	    String result = "";
	    String prodName = "";
	    
	    URL url = new URL("https://fcm.googleapis.com/fcm/send");
	    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	    conn.setUseCaches(false);
	    conn.setDoInput(true);
	    conn.setDoOutput(true);
	    conn.setRequestMethod("POST");
	    //���� key
	    //conn.setRequestProperty("Authorization", "key=" + "AAAAACPOgHc:APA91bHv8U4d1eyHPoNZ5u2NYk2yMGa7pGxzH3SHliJ7zvh5cWx3imP762AsGaJjL-etFKcmX6e6G4EUMpn5hum7Rqvcfm7BzN0ouPnItSbcEnUoA06BUYeIEyYGzIztrjYGYyDgD9RA");
	    
	    //�ȵ���̵�� key
	    conn.setRequestProperty("Authorization", "key=" + "AAAA5Zv1uAs:APA91bFhlAPwe5c_i9XKK1zk8mNC1IvfQtliUwGvm1h_DrcJ4R0qGmHQDtkgkugretCkuTyOu18WWsOxmKdF8r51eaKtJTQ0nsUIrkHtisopyWqJt4EdV1GNTgVuR94pQJnmGi1D6YSn1opw1UBznULPQ9wBFQa7TA");
	    conn.setRequestProperty("Content-Type", "application/json");


    	JSONObject json = new JSONObject();
	    //json.put("to", deviceToken.trim());
	    
	    json.put("to", deviceToken.trim());
	    
	    if(count == 1) {
	    	prodName = purchase.getProduct().getProdName();
	    }else {
	    	prodName = purchase.getProduct().getProdName() + " �� " + (count-1) + "��";
	    }

		 //�޷°�������
		 Date today = new Date();   
		 
	    //����
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd"); 
		String toDay = date.format(today);
	    
	    JSONObject info = new JSONObject();
	    info.put("title", "��ǰ ���Ű� �Ϸ�Ǿ����ϴ�."); // Notification title
	    info.put("body", " - ������ : "+toDay+"\n - ��ǰ�� : "+prodName+"\n - �ݾ� : "+purchase.getPurchasePrice()+"��"); // Notification
	                                                            // body
	    info.put("icon", "http://localhost:8080/images/icon/ic_launcher_round.png");

	    json.put("notification", info);
	    try {
	        OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
	        wr.write(json.toString());
	        wr.flush();
	        BufferedReader br = new BufferedReader(new InputStreamReader(
	                (conn.getInputStream())));
	        String output;
	        System.out.println("Output from Server .... \n");
	        while ((output = br.readLine()) != null) {
	            System.out.println(output);
	        }
	        result = "����";
	    } catch (Exception e) {
	        e.printStackTrace();
	        result = "����";
	    }
	    
	    System.out.println("GCM Notification is sent successfully : "+result);
	    return result;
	}

}
