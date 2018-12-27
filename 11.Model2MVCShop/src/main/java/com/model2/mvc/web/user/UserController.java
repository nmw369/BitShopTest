package com.model2.mvc.web.user;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.NaverUser;
import com.model2.mvc.service.domain.Response;
import com.model2.mvc.service.domain.ResponseCode;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ Controller
@Controller
@RequestMapping("/user/*")
public class UserController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method ���� ����
		
	public UserController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	//@RequestMapping("/addUserView.do")
	//public String addUserView() throws Exception {
	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser() throws Exception{
	
		System.out.println("/user/addUser : GET");
		
		return "redirect:/user/addUserView.jsp";
	}
	
	//@RequestMapping("/addUser.do")
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user ) throws Exception {

		System.out.println("/user/addUser : POST");
		//Business Logic
		userService.addUser(user);
		
		return "redirect:/user/loginView.jsp";
	}
	
	//@RequestMapping("/getUser.do")
	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {
		
		System.out.println("/user/getUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		model.addAttribute("user", user);
		
		return "forward:/user/getUser.jsp";
	}
	
	//@RequestMapping("/updateUserView.do")
	//public String updateUserView( @RequestParam("userId") String userId , Model model ) throws Exception{
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/updateUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		model.addAttribute("user", user);
		
		return "forward:/user/updateUser.jsp";
	}
	
	//@RequestMapping("/updateUser.do")
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user , Model model , HttpSession session) throws Exception{

		System.out.println("/user/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		
		//return "redirect:/getUser.do?userId="+user.getUserId();
		return "redirect:/user/getUser?userId="+user.getUserId();
	}
	
	//@RequestMapping("/loginView.do")
	//public String loginView() throws Exception{
	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login() throws Exception{
		
		System.out.println("/user/logon : GET");

		return "redirect:/user/loginView.jsp";
	}
	
	//@RequestMapping("/login.do")
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session ) throws Exception{
		
		System.out.println("/user/login : POST");
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return "redirect:/index.jsp";
	}
	
	//@RequestMapping("/logout.do")
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/logout : POST");
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	
	//@RequestMapping("/checkDuplication.do")
	@RequestMapping( value="checkDuplication", method=RequestMethod.POST )
	public String checkDuplication( @RequestParam("userId") String userId , Model model ) throws Exception{
		
		System.out.println("/user/checkDuplication : POST");
		//Business Logic
		boolean result=userService.checkDuplication(userId);
		// Model �� View ����
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "forward:/user/checkDuplication.jsp";
	}
	
	//@RequestMapping("/listUser.do")
	@RequestMapping( value="listUser" )
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/user/listUser.jsp";
	}
	/////////////////////////////////////////////
	//���̹� �α��� API
	
	@RequestMapping(value = "NaverLogin")

	public String isComplete(HttpSession session,HttpServletRequest request) throws Exception{
		
		String clientId = "R6scw7nmGLqAnHi_vcj3";//���ø����̼� Ŭ���̾�Ʈ ���̵�";
	    String redirectURI = URLEncoder.encode("http://127.0.0.1:8080/user/callback", "UTF-8");
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	    session.setAttribute("state", state);
		
	    session.setAttribute("apiURL", apiURL);
		
		/*session.setAttribute("move", "/user/loginView.jsp");*/
		

		/*return "forward:/user/login";*/
	    System.out.println("Naver end++++++++++++++++++++++++++++++++++++++++++++++++");
		return "forward:/user/loginView.jsp";

	}
	@RequestMapping(value = "callback")
	public String navLogin(HttpServletRequest request) throws Exception {  
		
		System.out.println("========================================1241235235callback");
		
		String clientId = "R6scw7nmGLqAnHi_vcj3";//���ø����̼� Ŭ���̾�Ʈ ���̵�";
	    String clientSecret = "SFqKnM6OyE";//���ø����̼� Ŭ���̾�Ʈ ��ũ����";
	    String code = request.getParameter("code");
	    String state = request.getParameter("state");
	    String redirectURI = URLEncoder.encode("http://127.0.0.1:8080/user/callback", "UTF-8");
	    String apiURL;
	    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
	    apiURL += "client_id=" + clientId;
	    apiURL += "&client_secret=" + clientSecret;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&code=" + code;
	    apiURL += "&state=" + state;
	    String access_token = "";
	    String refresh_token = "";
	    System.out.println("apiURL="+apiURL);
	    try {
	      URL url = new URL(apiURL);
	      HttpURLConnection con = (HttpURLConnection)url.openConnection();
	      con.setRequestMethod("GET");
	      int responseCode = con.getResponseCode();
	      BufferedReader br;
	      System.out.print("responseCode="+responseCode);
	      
	      
	      
	      if(responseCode==200) { // ���� ȣ��
	        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	      } else {  // ���� �߻�
	        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	      }
	      String inputLine;
	      StringBuffer res = new StringBuffer();
	      while ((inputLine = br.readLine()) != null) {
	        res.append(inputLine);
	      }
	      br.close();
	      if(responseCode==200) {
	        
	        System.out.print("\n"+"responseCodeAll="+res.toString());
			///////////////////////////////access_token �ޱ�
			ObjectMapper objMap = new ObjectMapper();
			System.out.println();
			System.out.println("\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\123");
			ResponseCode allcode = objMap.readValue(res.toString(), ResponseCode.class);
	        
			System.out.println(allcode.getAccess_token()+"///////////////////////////////////!!");
			
			request.setAttribute("accesstoken", allcode.getAccess_token());
	        
						
	      }
	    } catch (Exception e) {
	      System.out.println(e);
	    }
		
		
	    return "/user/Info";
	} 

	@RequestMapping(value = "Info")
	public String personalInfo(HttpServletRequest request) throws Exception {
	      System.out.println(); 
		System.out.println("Info Start=========================================");
			
			HttpSession session = request.getSession(false);
	        
			String temp = (String)session.getAttribute("state");
	        		
			System.out.println(temp);
		
			System.out.println(request.getAttribute("accesstoken")+"----------------------------------!!!");
			
			String access = (String)request.getAttribute("accesstoken");
			
			String token = access;// ���̹� �α��� ���� ��ū; ���⿡ ������ ��ū���� �־��ݴϴ�.
	        				
			String header = "bearer " + token; // Bearer ������ ���� �߰�
	        
	      
            String apiURL = "https://openapi.naver.com/v1/nid/me";
            
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");//���޹��
            con.setRequestProperty("Authorization", header);//������ �� 
            
            int responseCode = con.getResponseCode();
            
            
            BufferedReader br;
            if(responseCode==200) { // ���� ȣ��
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // ���� �߻�
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
           //���۵Ǿ�°� Json ����� ObjectMapper ����ؼ� json �����ο� setting�ϱ�
            System.out.println(response.toString());
            ObjectMapper objMap = new ObjectMapper();
            //���⼭ ���ε��� �ϰ� �Ǵµ� �̶� �����ڵ��� ��� JSON���� �ڵ����� �ѱۺ�ȯ�� ������ �־��ش�.
            NaverUser naverLogin = objMap.readValue(response.toString(), NaverUser.class);
            
            System.out.println(naverLogin.getResponse().getId()+"!!!!!!!!!!!!!!!!!!!!!!!!�̰ź��� ���ÿϷ�");
            
            System.out.println(naverLogin.getResponse().toString());
            
            Response naveruser = userService.getNaverUser(naverLogin.getResponse().getId());
            String uri ="";
            if(naveruser==null) {
            	userService.addNaverUser(naverLogin.getResponse());
            }
            
            System.out.println("==+=========================================1");
            System.out.println(naveruser.getId().trim());
            System.out.println(naverLogin.getResponse().getId());
            System.out.println("==+=========================================2");
            
            String naverdb = naveruser.getId().trim();
            String navernumid = naverLogin.getResponse().getId();
            Response check = userService.getNaverUser(navernumid);
            System.out.println(check+"NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");
            
            User user = null;
            
            if(check!=null) {
            	user = userService.getUser(check.getEmail().substring(0, check.getEmail().indexOf("@")));
            }
            
            
            if(naverdb.equals(check.getId())&&userService.getUser(user.getUserId())==null) {
            	String userId = naveruser.getEmail().substring(0, naveruser.getEmail().indexOf("@"));
            	System.out.println(userId+"+++++++++++++++++");
            	
            	naveruser.setId(userId);
            	
            	request.setAttribute("user", naveruser);
            	uri ="forward:/user/addNaverUserView.jsp";
            }else {
            	user = userService.getUser(naveruser.getEmail().substring(0, naveruser.getEmail().indexOf("@")));
            	session.setAttribute("user", user);
            	
            	System.out.println(user+"MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
            	uri="forward:/index.jsp";
            }
	                
	        
	        return uri;
	        
	}

	
	
	
}