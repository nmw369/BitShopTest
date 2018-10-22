package com.withdog.web.user;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.spi.LoggerFactory;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.portlet.ModelAndView;

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.common.CommonService;
import com.withdog.service.dogbreeddic.DogBreedDicService;
import com.withdog.service.domain.Point;
import com.withdog.service.domain.User;
import com.withdog.service.user.UserService;
import com.withdog.service.user.impl.UserServiceImpl;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("dogBreedDicServiceImpl")
	private DogBreedDicService dogBreedDicService;
	
	@Autowired
	@Qualifier("commonServiceImpl")
	private CommonService commonService;
	
	
	///Page 
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	
	///Constructor
	public UserController(){
		System.out.println(this.getClass());
	}
	
	///Method
	//�α��� ȭ�� GET  (�α��� Ŭ������ �� �ܼ��׺���̼�)
	@RequestMapping( value="loginUser", method=RequestMethod.GET )
	public String loginUser ()  throws Exception {

		System.out.println("�α��� ȭ������ /user/loginUser : GET");
		
		return "forward:/user/loginUser.jsp";
	} 
	
	/* ����Ʈ�� �ű�
	//�α��� POST
	@RequestMapping( value="loginUser", method=RequestMethod.POST )
	public String loginUser (@ModelAttribute("user") User user , HttpSession session, HttpServletResponse response)  throws Exception {

		System.out.println("�α��� /user/loginUser : POST");
		
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());
		System.out.println("���̵� üũ"+user.getUserId());
		if(dbUser==null){
			
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('���̵� Ȥ�� ��й�ȣ�� �߸� �Է��ϼ̽��ϴ�.'); </script>");
			out.flush();
			return "/user/loginUser.jsp";
			
		}else {
			
			if( user.getPassword().equals(dbUser.getPassword())){
				session.setAttribute("user", dbUser);
				userService.updateRecentlyDate(dbUser.getUserId());
			}
			
		}
		
		return "forward:/common/index.jsp";

	}
	*/
	
	//�α׾ƿ� GET changeUserCon
	@RequestMapping( value="logoutUser", method=RequestMethod.GET )
	public String logoutUser(HttpSession session ) throws Exception{
		
		System.out.println("�α׾ƿ� /user/logout : GET");
		
		session.invalidate();
		
		return "forward:/user/loginUser.jsp";
	}
	
	//ȸ������ ȭ�� GET (ȸ������ Ŭ������ �� �ܼ��׺���̼�)
	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser() throws Exception {

		System.out.println("ȸ������ �Է�â :: /user/addUser : GET");
		
		return "forward:/user/addUser.jsp";
	}
	
	//ȸ������ POST (ȸ������â���� �����ϱ� ������ ����)
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser(@ModelAttribute("user") User user, HttpSession session)
														throws Exception {

		System.out.println("ȸ������ :: /user/addUser : POST");
		System.out.println("��Ư�ѷ� Ȯ��"+user.getEmail());
		//Business Logic
		userService.addUser(user);
		
		user = userService.getUser(user.getUserId());
		session.setAttribute("user", user);
		
		return "forward:/mypage/getUser.jsp";
	}

	//ȸ������ ��ȸ GET  :: 
	/* ȸ������ �� ��������Ʈ�� serviceImpl���� ó�� ( �ٸ������� userService.getUser(userId) �θ��� ����Ʈ ����� ������)
	 * ���� ȸ�������� ���ǿ��� ���̵� Ȯ�� / �����ڴ� �ٹ������ ���� */
	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser (HttpSession session, Model model,Point point)  throws Exception {

		System.out.println("ȸ������ ��ȸ :: /user/getUser : GET");
	
		User user =  (User) session.getAttribute("user");
		String userId  = user.getUserId();
		
		//Business Logic
		 user = userService.getUser(userId);

		 // Model �� View ����
		model.addAttribute("user", user);
		System.out.println("���� ���� ��ȸ"+user);
		
		return "forward:/mypage/getUser.jsp";
	}
	
	//ȸ������ ����ȭ�� GET  (�α��� Ŭ������ �� �ܼ��׺���̼�)
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser (HttpSession session, Model model, User user)  throws Exception {

		System.out.println("ȸ������ ����ȭ�� :: /user/updateUser : GET");
		
		//Business Logic
		user = (User)session.getAttribute("user");
		user  = userService.getUser(user.getUserId());
		
		 // Model �� View ����
		model.addAttribute("user", user);
	
		return "forward:/mypage/updateUser.jsp";
		}	
	
	//ȸ������ ����ȭ�� POST 
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser (@ModelAttribute("user") User user, Model model,HttpServletResponse response)  throws Exception {

		System.out.println("ȸ������ ����ȭ�� :: /user/updateUser : POST");
		
		//Business Logic
		userService.updateUser(user);
		user = userService.getUser(user.getUserId());
		/*response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('���������� �Ϸ� �Ǿ����ϴ�'); </script>");
		out.flush();
		*/
		return "redirect:/user/getUser";
	}
	
	//��й�ȣ ���� ȭ�� GET
	@RequestMapping( value="updatePassword", method=RequestMethod.GET )
	public String updatePassword (Model model)  throws Exception {

		System.out.println("��й�ȣ ���� ȭ������ �ܼ��׺���̼� /user/updatePassword : GET");
		
		return "forward:/mypage/updatePassword.jsp";
	} 
	

	
	///ȸ��Ż�� GET
	@RequestMapping( value="deleteUser", method=RequestMethod.GET )
	public String deleteUser(HttpServletRequest request,HttpSession session,User user,Point point,Model model) throws Exception{
		
		System.out.println("ȸ��Ż�� ȭ������ /user/deleteUser : GET");
		
		user =(User)session.getAttribute("user");
		
		//Business Logic
		user  = userService.getUser(user.getUserId());
		
		 // Model �� View ����
		model.addAttribute("user", user);
		
		return "forward:/mypage/deleteUser.jsp";
	}
	
	/*����Ʈ�� �ű�
	///ȸ��Ż�� POST
	@RequestMapping( value="deleteUser", method=RequestMethod.POST )
	public String deleteUser(User user, HttpSession session,HttpServletResponse response ) throws Exception{
		
		System.out.println("ȸ��Ż�� /user/deleteUser : POST");
			
		userService.deleteUser(user);
		session.invalidate();
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('ȸ��Ż�� �Ϸ� �Ǿ����ϴ�'); </script>");
		out.flush();
		
		return "forward:/common/mainPage";
	}
	*/
	
	//ID ã�� GET (�α��� Ŭ������ �� �ܼ��׺���̼�)
		@RequestMapping( value="findUser", method=RequestMethod.GET )
		public String findUser() throws Exception{
			
			System.out.println("���̵�ã�� ȭ������ /user/findUser : GET");
			
			return "forward:/user/findUser.jsp";
		}
		
		//ȸ������ ����Ʈ Admin 
		@RequestMapping( value="getUserListAdmin" )
		public String getUserListAdmin(@ModelAttribute("search") Search search,HttpSession session,Model model) throws Exception{
			
			System.out.println("ȸ������ ����Ʈ���� /user/getUserListAdmin ");
			
			
			if(search.getCurrentPage() ==0 ){
				search.setCurrentPage(1);
			}
			search.setPageSize(pageSize);
			
			// Business logic ����
			Map<String , Object> map=userService.getUserListAdmin(search);
			Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
			
			// Model �� View ����
			model.addAttribute("list", map.get("list"));
			model.addAttribute("resultPage", resultPage);
			model.addAttribute("search", search);
			
			return "forward:/admin/listUserAdmin.jsp";
		}
	
		//ȸ����������Ʈ_�� ::  ���̵� �ٹ�� 
		@RequestMapping( value="getUserAdmin", method=RequestMethod.GET )
		public String getUserAdmin (@RequestParam("userId") String userId,Model model,User user)  throws Exception {

			System.out.println("ȸ������ ��ȸ :: /user/getUserAdmin : GET");
		
			System.out.println("���� ����Ʈ �� Ȯ����"+userId);
			
			//Business Logic
			 user = userService.getUser(userId);
			 
			 // Model �� View ����
			model.addAttribute("user", user);
			
			return "forward:/mypage/getUser.jsp";
		}
		
			//ȸ������ _���� :: ���̵� �ٹ��
			@RequestMapping( value="updateUserAdmin", method=RequestMethod.GET )
			public String updateUserAdmin (@RequestParam("userId") String userId,Model model,User user)  throws Exception {

				System.out.println("ȸ������ ��ȸ :: /user/updateUserAdmin : GET");
			
				System.out.println("Ȯ����"+userId);
				//Business Logic
				 user = userService.getUser(userId);
				 
				 // Model �� View ����
				model.addAttribute("user", user);
				
				return "forward:/mypage/updateUser.jsp";
			
		}
		
		//�޸����� �������� �ܼ� �׺���̼�
			@RequestMapping( value="changeUserCon", method=RequestMethod.GET )
			public String changeUserCon( ) throws Exception{
				
				System.out.println("�޸����� �ܼ� �׺���̼�");
					
					return "forward:/user/changeUserCon.jsp";
			}	
		
											
			
			//ȸ����������Ʈ_���� :: �޸�ȸ�� ����:: 1 �� �α��� ���� ���� ��� �޸�ȸ������ (user_condition ='2')
			@RequestMapping( value="updateUserList", method=RequestMethod.GET )
			public String updateUserList( ) throws Exception{
				
				System.out.println("�޸鼳�� :: updateUserList");
				
				userService.updateUserList();
				
				return "forward:/user/getUserListAdmin";
			}	

			//Sns ���� ȸ������ ȭ�� GET 
			@RequestMapping( value="addSnsUser", method=RequestMethod.GET )
			public String addSnsUser() throws Exception {

				System.out.println("ȸ������ �Է�â :: /user/addSnsUser : GET");
				
				return "forward:/user/addSnsUser.jsp";
			}
			
			
			//���̹� �α��� ���� ��������
			@RequestMapping( value="loginWithNaver", method=RequestMethod.GET)
			public String loginWithNaver(HttpServletRequest request, Model model) throws Exception{ 
				
			    String clientId = "FCLaJ11V_c1179DGKDU1";//���ø����̼� Ŭ���̾�Ʈ ���̵�";
			    String clientSecret = "o3_uYtuKnA";//���ø����̼� Ŭ���̾�Ʈ ��ũ����";
			    String code = request.getParameter("code");
			    String state = request.getParameter("state");
			    String redirectURI = URLEncoder.encode("http://localhost:8080/user/loginWithNaver", "UTF-8");
			    String apiURL;
			    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&;";
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
			        System.out.println(res.toString());
			        JSONObject jsonobj = (JSONObject)JSONValue.parse(res.toString());
			        access_token = jsonobj.get("access_token").toString();
			      }
			    } catch (Exception e) {
			      System.out.println(e);
			    }
			    
			    
			    Map<String, Object> map = new HashMap<>();
			    String data = "";
		        String token = access_token;// ���̹� �α��� ���� ��ū; ���⿡ ������ ��ū���� �־��ݴϴ�.
		        String header = "Bearer " + token; // Bearer ������ ���� �߰�
		        try {
		            apiURL = "https://openapi.naver.com/v1/nid/me";
		            URL url = new URL(apiURL);
		            HttpURLConnection con = (HttpURLConnection)url.openConnection();
		            con.setRequestMethod("GET");
		            con.setRequestProperty("Authorization", header);
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
		            System.out.println(response.toString());
			        JSONObject jsonobj = (JSONObject)JSONValue.parse(response.toString());
		            System.out.println(jsonobj);
		            ObjectMapper objectMapper = new ObjectMapper();
		            map = objectMapper.readValue(jsonobj.get("response").toString(), new TypeReference<Map<String, Object>>() {});
		            System.out.println(map);
		        } catch (Exception e) {
		            System.out.println(e);
		        }
		        
				model.addAttribute("map", map);
				
			    System.out.println("���̹� ����� ����");
			    
			    return "loginWithNaver.jsp";
			}


			//ȸ����ü��� ������ �ܼ��׺���̼�_����
			@RequestMapping( value="getRateAllUserCon", method=RequestMethod.GET )
			public String getRateAllUserCon() throws Exception {

				System.out.println("ȸ������ �Է�â :: /admin/getRateAllUserCon : GET");
				
				return "forward:/admin/listAllUserRateAdmin.jsp";
			}
			
			
			

			//ȸ���������¿� ���� ����Ʈ_����_���ñ��� ��������	
			@RequestMapping( value="getUserConListAdmin" )
			public String getUserConListAdmin(@ModelAttribute("search") Search search,HttpSession session,Model model) throws Exception{
				
				System.out.println("ȸ���������°��� ����Ʈ���� /user/getUserListAdmin ");
				
				if(search.getCurrentPage() ==0 ){
					search.setCurrentPage(1);
				}
				search.setPageSize(pageSize);
				
				search.setSearchCondition("2");
				
				System.out.println(">>>>>>>>>>>>>>>>>>Ȯ����"+search);
				// Business logic ����
				Map<String , Object> map=userService.getUserConListAdmin(search);
				
				System.out.println(">>>>>>>>>>>>>>>>>>�ٳ�°Ŵ�"+map);
				
				Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
				
				// Model �� View ����
				model.addAttribute("list", map.get("list"));
				model.addAttribute("resultPage", resultPage);
				model.addAttribute("search", search);
				
				return "forward:/admin/listUserConAdmin.jsp";
			}
			
			
			
			//ȸ���������¿� ���� ����Ʈ_����_���ñ��� ��������	
			@RequestMapping( value="getUserConListAdminOne")
			public String getUserConListAdminOne(Search search, HttpSession session,Model model) throws Exception{
				
				System.out.println("ȸ���������°��� ����Ʈ���� /user/getUserListAdminOne ");
				
				if(search.getCurrentPage() ==0 ){
					search.setCurrentPage(1);
				}
				search.setPageSize(pageSize);
				
				System.out.println(">>>>>>>>>>>>>>>>>>Ȯ����"+search);
				// Business logic ����
				Map<String , Object> map=userService.getUserConListAdmin(search);
				
				System.out.println(">>>>>>>>>>>>>>>>>>�ٳ�°Ŵ�"+map);
				
				Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
				
				// Model �� View ����
				model.addAttribute("list", map.get("list"));
				model.addAttribute("resultPage", resultPage);
				model.addAttribute("search", search);
				
				return "forward:/admin/listUserConAdmin.jsp";
			}
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		///////īī�� �α���//////
			@RequestMapping(value = "/kakaoLogin" , produces = "application/json", method = {RequestMethod.GET, RequestMethod.POST})
			public String kakaoLogin(@RequestParam("code") String code , HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{

				 JsonNode token = UserServiceImpl.getAccessToken(code);

				  JsonNode profile = UserServiceImpl.getKakaoUserInfo(token.path("access_token").toString());
				  System.out.println("īī������ ������"+profile);
				  User user = UserServiceImpl.changeData(profile);
				 // user.setUserId(userId);
				  //vo.setUser_snsId("ka"+vo.getUser_snsId());
				  
				  
				  ////////////////////////////////////////
				  String userId = "ka"+user.getUserId();
				  Boolean check = false; 
				  
				  System.out.println("�츮��񰡱��� userId"+userId);
				  
				  //����� userId�� �츮 DB�� ��ϵǾ��ִ��� Ȯ��
				  User dbUser =  userService.getUser(userId);
				  
				  System.out.println("�������"+dbUser);
				  
				  //db������ null�̶�� ������ �ȵ� ���� >> ȸ������â����
				  if(dbUser.getUserId()!=null) {

					  System.out.println("��� ���������� �̰��� Ÿ����");
					  session.setAttribute("user", dbUser);
					  check = true;
					  
				  }else {

					  //"ka"������ ���̵� ����
					  user.setUserId(userId);
					  session.setAttribute("user", user);
					  System.out.println("īī�� ���̵� ��� ������"+user);
				  }
				  
				  
				  session.setAttribute("user", user);
				  System.out.println("������ִ°�Ȯ��"+user.toString());

				 //user = service.kakaoLogin(vo);  
					return "forward:/user/addSnsUser.jsp";
			}
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			/////////////////////////////////////////////////////////
		
		//����� �׽�Ʈ 2
		@RequestMapping( value="test", method=RequestMethod.GET )
		public String test() throws Exception{
			
			System.out.println("ddddd");
			
			return "forward:/user/test.jsp";
		}
		
		//html �ޱ�
		@RequestMapping( value="test2", method=RequestMethod.POST )
		public String  html (String testa, ModelMap model) throws Exception{
			
			System.out.println("html �׽�Ʈ >> "+testa);
//			ModelAndView mav = new ModelAndView();
//			mav.addObject("testa", testa);
//			mav.setViewName("forward:/user/test3.jsp");
			model.addAttribute("testa", testa);

			return "forward:/user/test2.jsp";
		}

}//end of class
