package com.withdog.web.fund;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.common.CommonService;
import com.withdog.service.domain.Fund;
import com.withdog.service.domain.Point;
import com.withdog.service.domain.Purchase;
import com.withdog.service.domain.User;
import com.withdog.service.fund.FundService;
import com.withdog.service.sns.SnsService;
import com.withdog.service.user.UserService;







//==> ȸ������ Controller

@Controller
@RequestMapping("/fund/*")
public class FundController {
	
	///Field
	@Autowired
	@Qualifier("fundServiceImpl")
	private FundService fundService;
		
	
	@Autowired
	@Qualifier("commonServiceImpl")
	private CommonService commonService;
	
	@Autowired
	@Qualifier("snsServiceImpl")
	private SnsService snsService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	//setter Method ���� ����
		
	public FundController(){
		System.out.println("FundController ����"+this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['fundpageSize']}")
	int pageSize;
	
	@Value("#{commonProperties['fundfilePath']}")
	String path;
	
	@RequestMapping(value="/addFundView", method=RequestMethod.GET)
	public String addFundView() throws Exception {

		System.out.println("/addFundView :GET Start");
		
					
		return "forward:/fund/addFund.jsp";
	}
	
	@RequestMapping(value="/addFund",method=RequestMethod.POST)
	public String addFund(@ModelAttribute("fund") Fund fund,HttpServletRequest request,@RequestParam("fundImagePath") MultipartFile fileName ) throws Exception {

		System.out.println("/addFund : POST Start");
		//Business Logic
		
		/*Properties properties = new Properties();
		properties.load(new FileInputStream("C:/common.properties"));*/
		
		/*String path = properties.getProperty("filepath");*/
		String filetemp = fileName.getOriginalFilename();
		
		File file = new File(path+filetemp);
		fileName.transferTo(file);
		
		
		fund.setFundImage(filetemp);
		
		System.out.println(fund.toString());
		

		Thread.sleep(2500);
		
				
		fundService.addFund(fund);
						
		
		return "forward:/fund/getFundList";
		
	}
	
	@RequestMapping(value="/updateFund", method=RequestMethod.GET)
	public String updateFundView(@RequestParam("fundNo") int fundNo,HttpServletRequest request) throws Exception {

		System.out.println("/updateFundView :GET Start");
		
	    Fund fund = fundService.getFund(fundNo);
	    
	    request.setAttribute("fund", fund);
	    
	    String Term = fund.getFundTerm();
	    String[] temp = new String[2]; 
	    temp = Term.split("~");
	    
	    request.setAttribute("temp", temp);
		
		
		
					
		return "forward:/fund/updateFund.jsp";
	}
	
	@RequestMapping(value="/updateFund",method=RequestMethod.POST)
	public String updateFund(@ModelAttribute("fund") Fund fund,HttpServletRequest request,@RequestParam("fundImagePath") MultipartFile fileName ) throws Exception {

		System.out.println("/updateFund : POST Start");
		//Business Logic
		
		/*Properties properties = new Properties();
		properties.load(new FileInputStream("C:/common.properties"));*/
		
		
		String filetemp="";
		System.out.println(1);
		
		if(fileName.getSize() != 0) {
		System.out.println(2);
		filetemp = fileName.getOriginalFilename();
		
		
		File file = new File(path+filetemp);
		fileName.transferTo(file);
		}
		else {
		System.out.println(3);
		Fund before=fundService.getFund(fund.getFundNo());
			
		filetemp = before.getFundImage();	
		}
		
		fund.setFundImage(filetemp);
		
		System.out.println(fund.toString());
		

				
		fundService.updateFund(fund);
						
		System.out.println("updateFundEnd");
		
		return "forward:/fund/getFund?fundNo="+fund.getFundNo();
		
	}
	
	
	
	@RequestMapping(value="/getFund")
	public String getFund(@RequestParam("fundNo")  int fundNo,HttpServletRequest request) throws Exception {

		System.out.println("/getFund : Start");
		//Business Logic
		
		
		
		HttpSession session = request.getSession(false);
		User user = new User();
		
		Fund fund = fundService.getFund(fundNo);
		fund.setFundPersonnel(fundService.getFundPersonnel(fund));
		System.out.println(session.getAttribute("user"));
		if(session.getAttribute("user")!=null) {
			user = (User)session.getAttribute("user");
			System.out.println(user.getUserId());
			
			//�ӽ�
			Point point = new Point();
			point.setUser(user);
			
			int currentPoint=commonService.getCurrentPoint(point);
			
			
			request.setAttribute("currentPoint", currentPoint);
		}
		
		
		
		request.setAttribute("fund", fund);
		
		return "forward:/fund/getFund.jsp";
	}
	
	
	@RequestMapping(value="/getFundList")
	public String getFundList(HttpServletRequest request,HttpSession session) throws Exception{
		 
	 	
	 	System.out.println("/FundList : Start");
	 	
	 	User user = new User();
	 	if(session.getAttribute("user")!=null) {
	 	  user = (User)session.getAttribute("user");
	 	}else {
	 		user.setRole("user");
	 	}
	 			
		
	 	List<Fund> list = fundService.getFundList(user); 	
		
		for (int i = 0; i < list.size(); i++) {
		
			System.out.println(list.get(i).toString());
		}
				
		request.setAttribute("list", list);
		
		Fund fund = new Fund();
		fund=fundService.getMinFund();
		System.out.println(fund.toString());
		
		request.setAttribute("Bastfund", fund);
		
		System.out.println("FundList End=================================");
		
		return "forward:/fund/listFund.jsp";
		
		
	 }
	
	@RequestMapping(value="/getMyFundList")
	public String getMyFundList(@ModelAttribute("search") Search search,HttpServletRequest request,HttpSession session) throws Exception {

		System.out.println("/getMyFundList : Start");
		//Business Logic
		User user = new User();
		if(session.getAttribute("user")!=null) {
		user = (User)session.getAttribute("user");
		}
	 	if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
	 	System.out.println(1);	 	
		Map<String,Object> map = fundService.getMyFundList(search, user); 	
		
		System.out.println("MAP üũ ===========================");
		System.out.println(map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		
		request.setAttribute("list", map.get("list"));
		
		System.out.println(map.get("list"));
		
		request.setAttribute("resultPage", resultPage);
		request.setAttribute("search", search);
		request.setAttribute("myPageState", 5);
		
		return "forward:/mypage/listMyFund.jsp";
	}
	
	
	
	@RequestMapping(value="/getFundResultList")
	public String getFundResultList(@ModelAttribute("search") Search search,HttpServletRequest request,HttpSession session) throws Exception{
		 
	 	
	 	System.out.println("/FundResultList : Start");
		System.out.println(search.toString());
		User user = new User();
		if(session.getAttribute("user")!=null) {
		user = (User)session.getAttribute("user");
		}else {
		user.setRole("user");
		}
	 	if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
	 		 	
		Map<String,Object> map = fundService.getFundResultList(search,user); 	
		
		System.out.println("MAP üũ ===========================");
		System.out.println(map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		
		request.setAttribute("list", map.get("list"));
		request.setAttribute("resultPage", resultPage);
		request.setAttribute("search", search);
				
		
		return "forward:/fund/listFundResult.jsp";
		
		
	 }
	
	
	@RequestMapping(value="kakaoPay")
	private String kakaoPay(@ModelAttribute("fund") Fund fund,HttpServletRequest req) throws Exception{
		
		System.out.println("kakaoPay Start==================================");
		System.out.println(fund);
		if(req.getParameter("usePoint")==null) {
			req.setAttribute("usePoint", 0);
				
		}else {
			System.out.println(req.getParameter("usePoint"));
		}
		
		HttpSession session = req.getSession(false);
		User user = new User();
		if(session.getAttribute("user")!=null) {
		user = (User)session.getAttribute("user");
		System.out.println(user.getUserId());
		}else {
		user.setUserId("temp");
		user.setRole("temp");
		}
		
		int price=0;
		int usePoint=0;
		
		System.out.println(req.getParameter("usePoint"));
		
		///������.jsp�� ī�� ������ callback �Ǵ���
	    String forwardUri="forward:/sns/kakaoPay.jsp";
	    //snsKakaoPay�� ���� ����
		Point pointfund = new Point();
		pointfund.setUser(user);
		pointfund.setFund(fund);
		System.out.println(1);
		
		if(pointfund.getFund().getFundMyPrice()!=0) {
			System.out.println(2);
			price=pointfund.getFund().getFundMyPrice();
		}
		if(Integer.parseInt(req.getParameter("usePoint"))!=0) {
			pointfund.setUsePoint(Integer.parseInt(req.getParameter("usePoint")));
			usePoint=Integer.parseInt(req.getParameter("usePoint"));
		}
		price = price-usePoint;
		
		
	
		System.out.println(price+"::"+usePoint);
		
		
		
		if(pointfund.getFund().getFundMyPrice()!=0) {
		pointfund.getFund().setFundMyPrice(price);
		System.out.println(123);
		String uri ="http://localhost:8080/fund/fundReceipt?state=";
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	    JSONObject jobj = snsService.FundkakaoPay(pointfund, uri);
	    System.out.println(jobj.get("tid"));
	    String url = (String)jobj.get("next_redirect_pc_url");
	    System.out.println(url);
	    session.setAttribute("url", url);
	   	    	    
		}
		else {
			//����Ʈ������
		/*forwardUri="forward:/fund/fundReceipt?state=0"+pointfund.getFund().getFundTitle()+"&price="+pointfund.getFund().getFundMyPrice()+"&usePoint="+pointfund.getUsePoint();*/
			forwardUri="forward:/fund/fundReceipt?state=0"+pointfund.getFund().getFundTitle()+"&price="+price+"&usePoint="+pointfund.getUsePoint();
		}
	    
	
	    //�ӽ�ó��
	    
	    Point point = new Point();
	        
	    //����Ʈ �̰͸� �ܱ�
	    fund.setUser(user);
	    point.setUsePoint(pointfund.getUsePoint());
	    point.setUser(user);//userid
	    point.setFund(fund);
	    
	    //�Ŀ��Ϸ� �Ǹ� add��Ű�� �̵���Ű��
	    //fund���̺� �Ŀ��ݾ� �߰�
	    int raising = price+usePoint;
	    fund.setFundRaising(raising);
	    System.out.println("�Ŀ��ݾ� : "+raising);
	    
	    session.setAttribute("fundpurchase", point);
	    /*session.setMaxInactiveInterval(1*60);*/
	    
	    System.out.println(session.getAttribute("fundpurchase"));
	        
	    
	    	    
	 
	  return forwardUri;
	    
    }
	
	@RequestMapping(value="/fundReceipt")
	public String getfundReceipt(HttpServletRequest request) throws Exception {
		
		System.out.println("fundReceipt Start");
		
		Point point = new Point();
		Fund fund = new Fund();
		User user = new User();
		
		
		HttpSession session = request.getSession(false);
		
		
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
			else {
				System.out.println("��������");
				
				if(session.getAttribute("fundpurchase")!=null) {
					point = (Point)session.getAttribute("fundpurchase");
					fund = point.getFund();
					user = point.getUser();
					
					fundService.addFundRaising(fund);
				    
				    //�ݵ� ���� ��ȣ ��������
				    Fund resultFund = fundService.getMyFundNo(fund,user);
				    
				    fund.setFundMyPriceNo(resultFund.getFundMyPriceNo());
				    
				    point.setFund(fund);//�Ŀ�,����,���� ������ ����
				    
				    double savePoint = fund.getFundMyPrice()*0.01;
				    System.out.println("��������Ʈ"+savePoint);
				    int resultpoint = (int)savePoint;
				    point.setPoint(resultpoint);
				    
				   	commonService.addPointinfo(point);

					// �Ŀ��� ���� ID�� Token ã��
					List<String> pushToken = commonService.getPushToken(fund.getUser().getUserId());
					System.out.println("Ǫ�� ��ū : "+pushToken);
					if(pushToken != null) {
						// token���� push �޼��� ������						
						for(int i=0; i<pushToken.size(); i++) {
							String result = sendPushNotification(pushToken.get(i), fund);
							System.out.println("Ǫ�� ��� : "+result);
						}
						
						//��ū ����� 0�̶�� ���ڹ߼�
						 //�޷°�������
						 Date today = new Date();   
						 
						 //����
						 SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd"); 
						 String toDay = date.format(today);
						
						//��ū�� ���ٸ� ���ڹ߼�
						String userPhoneNo  = point.getUser().getPhone();
						int a = point.getFund().getFundNo();
						int b= point.getFund().getFundMyPrice();
						 //�޷°�������
						 today = new Date();   
						 
						 //����
						 date = new SimpleDateFormat("yyyy-MM-dd"); 
						 toDay = date.format(today);
						 
						 System.out.println("���� ��������!!!!!!!!!!");
						 System.out.println("���� ������ ��ȣ"+userPhoneNo);
						 
						String conText ="[�Բ��Ұ�]���� ũ���� �ݵ��� �Ϸ�Ǿ����ϴ�. ������ȣ:"+a+" �Ŀ��ݾ�:"+b+"�� "+"�����Ͻ�:"+toDay;
						 Boolean ok = userService.sendText(userPhoneNo, conText);
						
					}
				}
				
					
				request.setAttribute("state", "0");
				
				request.setAttribute("title",fund.getFundTitle());
				request.setAttribute("price",fund.getFundMyPrice());
				request.setAttribute("usePoint",point.getUsePoint());
				
			}
		}
		
		session.removeAttribute("fundpurchase");
		
		request.setAttribute("fundpurchase", point);
		
		/////////////�ݵ��Ϸ� �̸��� ������ ����////////////////////
		//�����ּ�
		String userEmail ="withdog0817@naver.com" ;
		
		 //�޷°�������
		 Date today = new Date();   
		 
		 //����
		 SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd"); 
		 String toDay = date.format(today);
		
		// ���� ���� �ۼ� ::  �̸����ּ�, �������� , ����
		String title ="[�Բ��Ұ�]ũ���� �ݵ��� �Ϸ�Ǿ����ϴ�.";    
		String url ="http://localhost:8080/";
		String htmlText ="<body style=\"box-sizing: border-box; line-height: 24px; font-family: '�������', 'malgun gothic', 'dotum', sans-serif;\">\r\n" + 
				"	<div style=\"margin:0 auto; width: 750px; height:195px; font-size: 16px; background:url(http://localhost:8080/images/icon/mail_bg.jpg) no-repeat;\">\r\n" + 
				"		<div style=\"font-size: 30px; text-align:center; margin-bottom: 60px; margin-top: 44px; color: #fff;\">\r\n" + 
				"			<p style=\"padding-top:78px; margin-bottom: 13px;\">"+point.getUser().getUserName()+"����</p> ũ���� �ݵ��� �Ϸ�Ǿ����ϴ�. \r\n" + 
				"		</div>\r\n" + 
				"	</div>\r\n" + 
				"	<div style=\"width:640px; padding:20px 0; margin:0 auto; margin-top:50px\">\r\n" + 
				"		<p style=\"border-bottom: 2px solid #000; padding-bottom: 10px; font-size: 18px; font-weight: 700;\">���೻������ </p>\r\n" + 
				"			<ul style=\"font-size:17px;\">\r\n" + 
				"				<li>���� ��ȣ: "+point.getFund().getFundMyPriceNo()+"</li>\r\n" + 
				"				<li>���� �Ͻ�:"+ today+"</li>\r\n" + 
				"				<li>�Ŀ��� �ݵ� :"+point.getFund().getFundTitle()+"</li>\r\n" +
				"				<li><a href=\"http://localhost:8080\">�Բ��Ұ� ����Ʈ �ٷΰ���</a></li>\r\n" + 
				"			</ul>\r\n" + 
				"	</div>\r\n" + 
				"	<div style=\"width:640px; padding:20px 0; margin:0 auto;\">\r\n" + 
				"		<p style=\"border-bottom: 2px solid #000; padding-bottom: 10px; font-size: 18px; font-weight: 700;\">��������</p>\r\n" + 
				"			<ul style=\"font-size:17px;\">\r\n" + 
				"				<li>�Ŀ��ݾ�: "+point.getFund().getFundMyPrice()+"��</li>\r\n" + 
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
		
		
		
		return "forward:/fund/fundReceipt.jsp";
	}
	
	@RequestMapping(value="/deleteFund")
	public String deleteFund(@ModelAttribute("fund") Fund fund) throws Exception {

		System.out.println("/deleteFUnd : Start");
	
		/*Fund ofund = fundService.getFund(fund.getFundNo());*/
		
		fundService.deleteFund(fund);
					
		return "forward:/fund/getFundList";
	}
	
	
	
	@RequestMapping(value="/getFundUserListAdmin")
	public String getFundUserListAdmin(@ModelAttribute("search") Search search,HttpServletRequest request,HttpSession session) throws Exception {

		System.out.println("/getFundUserListAdmin : Start");
		//Business Logic
		User user = new User();
		if(session.getAttribute("user")!=null) {
		user = (User)session.getAttribute("user");
		}
	 	if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
	 	System.out.println(111111111+user.getUserId());	 	
		Map<String,Object> map = fundService.getFundUserList(search, user); 	
		
		System.out.println("MAP üũ ===========================");
		System.out.println(map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		
		request.setAttribute("list", map.get("list"));
		System.out.println("�̰�Ȯ��========================================");
		List<Fund> list =(List<Fund>) map.get("list");
		System.out.println(list.size());
		System.out.println(resultPage.getTotalCount());
		
				
		
		request.setAttribute("resultPage", resultPage);
		request.setAttribute("search", search);
		request.setAttribute("myPageState", 11);
		
		return "forward:/admin/listFundUserAdmin.jsp";
	}
	
	
	
	
	
	
	@RequestMapping(value="/fundGuid")
	public String getFundGuid() throws Exception {

		System.out.println("/getFundGuid : Start");
		
					
		return "forward:/fund/fundGuid.jsp";
	}
	
	@RequestMapping(value="/fundReqFile")
	public String getfundReqFile(HttpServletRequest request,HttpServletResponse response) throws Exception {

		System.out.println("/getFundReqFileDownLoad : Start");
		
		String path = "C:\\Users\\Bit\\git\\withDog\\withDog\\WebContent\\fund\\fundreq\\";
		
		String sendfileName = "FundRequset.";
		String sendfileExe=request.getParameter("sendfileExe");
		String sendfile= sendfileName+sendfileExe;
		String client = "";
		
		InputStream in = null;
		OutputStream out = null;
		File file = null;
		boolean skip = false;
		String revUser = "";
		
		if(sendfile!=null) {
			file = new File(path+sendfile);
			in = new FileInputStream(file);
		}else {
			skip=true;
		}
		
		//�������� Ȯ��
		revUser = request.getHeader("User-Agent");
		
		System.out.println(revUser);
		
		response.reset();
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Description", "JSP Generated Data");
		
		if(!skip) {
			
			if(revUser.indexOf("MSIE")!=-1) {
				response.setHeader("Content-Description","attachment; filename=\""+new String(sendfile.getBytes("KSC5601"),"ISO8859_1"));
				
						
			}else{
                // �ѱ� ���ϸ� ó��
				sendfile = new String(sendfile.getBytes("utf-8"),"iso-8859-1");
 
                response.setHeader("Content-Disposition", "attachment; filename=\"" + sendfile + "\"");
                response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
            }
			
			response.setHeader ("Content-Length", ""+file.length() );
			 
			 
		       
            out = response.getOutputStream();
            byte b[] = new byte[(int)file.length()];
            int leng = 0;
             
            while( (leng = in.read(b)) > 0 ){
                out.write(b,0,leng);
            }
 
        }else{
            response.setContentType("text/html;charset=UTF-8");
            System.out.println("<script language='javascript'>alert('������ ã�� �� �����ϴ�');history.back();</script>");
 
        }
			return "forward:/fund/fundReq.jsp";
	}
	
	@RequestMapping(value="/fundReqSend")
	public String SendfundReq(@RequestParam("fundReq")MultipartFile file,HttpServletRequest request) throws Exception {

		System.out.println("/SednFundReqMail : Start");
		
		System.out.println(file.getOriginalFilename());
		
		String path2 = "C:\\Users\\Bit\\git\\withDog\\withDog\\WebContent\\fund\\newReq\\";
		//String path2 = "C:\\Users\\Bit\\Desktop\\";
		File fileSave = new File(path2+file.getOriginalFilename());
		file.transferTo(fileSave);
		/*BufferedWriter fw = new BufferedWriter(new FileWriter(path2+file.getOriginalFilename(),true));*/
		
		
		String host = "smtp.naver.com";
		String adminMail = "withdog0817";
		String password = "0817withdog!";
		
		String to ="withdog0817@naver.com";
		
		String emailHtml="<HTML>" +
			    "<HEAD><TITLE></TITLE></HEAD>" +
			    "<BODY>" +
			    "<h3>ũ���� �ݵ� ��û�� </h3>" +
			        			     " <br>"+
			     "<img src=\"https://bit.ly/2Nbd1nf\">"+
			     "<br>"+
			     "</BODY>" +
			    "</HTML>";
		  Properties props = new Properties();
		  props.put("mail.smtp.host", host);
		  props.put("mail.smtp.port", 587);
		  props.put("mail.smtp.auth", "true");
		
		  
		  System.out.println(1);
		  
		  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			  protected PasswordAuthentication getPasswordAuthentication() {
				   return new PasswordAuthentication(adminMail, password);
				}  
		  });
		  
		  //session.setDebug(true); //session �����
		  
		  
		  MimeMessage message = new MimeMessage(session);
		  		  
		   message.setFrom(new InternetAddress(adminMail+"@naver.com"));
		   message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		  
		   
		   // Subject
		   message.setSubject("ũ�����ݵ� ��û���� �����߽��ϴ�.");
		  		  
		   //String path="C:\\Users\\Bit\\git\\withDog\\withDog\\WebContent\\fund\\fundreq\\";
		   String fileName=file.getOriginalFilename();
		   System.out.println(fileName);
		   
		   
			  MimeBodyPart mdp = new MimeBodyPart();
			  FileDataSource fds = new FileDataSource(path2+fileName);
			  System.out.println(1);  
			  mdp.setDataHandler(new DataHandler(fds));
			  System.out.println(2);
			  mdp.setFileName(MimeUtility.encodeText(fds.getName(),"KSC5601","B"));
			  System.out.println(3);
			  
			  Multipart mp = new MimeMultipart();
			  mp.addBodyPart(mdp);
			  System.out.println(4);
		   
		   message.setContent(mp);
		   System.out.println(5);
		   		   
		   /*message.setContent(emailHtml	, "text/html; charset=euc-kr");*/
		  
		   

		   // send the message
		   Transport.send(message);
		   
		   System.out.println("message sent successfully...");
		
		   
					
		return "forward:/fund/fundReq?req=yes";
	}
	
	@RequestMapping(value="/fundReq")
	public String getfundReq(HttpServletRequest request) throws Exception {

		System.out.println("/getFundReq : Start");
				
		String uri="";
		
		if(request.getParameter("req")!=null&&request.getParameter("req").equals("yes")) {
			request.setAttribute("req", "yes");
		}else {
			request.setAttribute("req", "no");
		}
					
		return "forward:/fund/fundReq.jsp";
	}
	
	
	public static String sendPushNotification(String deviceToken, Fund fund) throws IOException {
	    String result = "";
	    
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
	    
		 //�޷°�������
		 Date today = new Date();   
		 
	    //����
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd"); 
		String toDay = date.format(today);
	    
	    JSONObject info = new JSONObject();
	    info.put("title", "�Ŀ��� �Ϸ�Ǿ����ϴ�."); // Notification title
	    info.put("body", " - ������ : "+toDay+"\n - "+fund.getFundTitle()+"\n - �ݾ� : "+fund.getFundMyPrice()+"��"); // Notification
	                                                            // body

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
	
	@RequestMapping(value="/updateFundState")
	public String updateFundState(HttpServletRequest request) throws Exception {

		System.out.println("/updateFundState : Start");
				
		String uri="";
		
		if(request.getParameter("fundNo")!=null) {
			int fundNo = Integer.parseInt(request.getParameter("fundNo"));
			fundService.updateFundState(fundNo);
			
			
		}
					
		return "forward:/fund/getFundResultList";
	}
	
}