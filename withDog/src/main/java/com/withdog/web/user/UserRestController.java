package com.withdog.web.user;

import java.io.PrintWriter;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.codehaus.jackson.JsonNode;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.withdog.common.Search;
import com.withdog.service.common.CommonService;
import com.withdog.service.domain.Point;
import com.withdog.service.domain.User;
import com.withdog.service.user.UserService;
import com.withdog.service.user.impl.UserServiceImpl;

//==> ȸ������ RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {

	/// Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	@Autowired
	@Qualifier("commonServiceImpl")
	private CommonService commonService;

	// �̸��� html ���߿� ������ ������
	// @Value("#{commonProperties['emailHtml']}")
	// String emailHtml;

	/// Constructor
	public UserRestController() {
		System.out.println(this.getClass());
	}

	///////////////////////////////////////////////////
	//Android//
	@RequestMapping(value = "json/loginUserAndroid")
	public User getUser(HttpServletRequest request, HttpSession session) throws Exception {

		System.out.println();
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		if (userService.getUser2(userId) == null) {
			System.out.println("��񿡾��� ����0");
			return null;
		} else {
			User user = userService.getUser2(userId);
			if (user.getPassword().equals(password)) {
				session.setAttribute("user", user);
				System.out.println("���ǻ���");
				return user;
			} else {
				System.out.println("���ǻ���X");
				return null;
			}
		}
	}

	@RequestMapping(value = "json/logoutUserAndroid")
	public int logOutUser(HttpSession session) throws Exception {
		System.out.println("�������췯���");
		if (session != null) {
			session.removeAttribute("user");
			System.out.println("������");
			return 0;
		} else {
			System.out.println("���� null�ƴ϶� ��������");
			return 1;
		}
	}
	@RequestMapping(value = "json/getUser/{userId}")
	public User getUser(@PathVariable String userId) throws Exception {
		
		User user = userService.getUser(userId);
		
		return user;
	}

	////////////////////////////////////////////
	
	
	/// Method
	// �α��� POST
	@RequestMapping(value = "json/loginUser", method = RequestMethod.POST)
	public JSONObject loginUser(@RequestBody User user, HttpSession session, HttpServletResponse response)
			throws Exception {

		System.out.println("���̽� �α��� /user/loginUser : POST");

		System.out.println("�Է���user���� Ȯ��" + user);

		// Business Logic

		User dbUser = userService.getUser(user.getUserId());
		System.out.println("dbUser���� Ȯ��" + dbUser);

		// jsp���� Ȯ���ϴ� ��������� ��
		String userConCheck = "3";

		if (dbUser != null) {

			// �޸�, Ż�� ���� üũ :: ����� �ڵ� 0�޸� 1 ���� 2 Ż�� 3���̵� ��� ����ġ
			String userCondition = dbUser.getUserCondition();

			if (userCondition.equals("0")) {

				// �޸�ȸ���� ��� ��������� ��
				userConCheck = "0";

				// �޸�ȸ���� ��� ���ǿ� ���̵𰪸� �ֱ�
				String userId = user.getUserId();
				session.setAttribute("userCon0", userId);

			} else if (userCondition.equals("2")) {

				// Ż��ȸ���ϰ�� ��������� ��
				userConCheck = "2";

			} else {

				// ��й�ȣ ��ġ ����
				if (user.getPassword().equals(dbUser.getPassword())) {

					// ����ȸ���ϰ�� ��������� ��
					userConCheck = "1";

					// ����ȸ���� ��� ���ǿ� ���� ������ �ֱ�
					session.setAttribute("user", dbUser);
					User user33 = (User) session.getAttribute("user");
					System.out.println("����Ȯ��" + user33);

					// ����ȸ���� ��� �ֱ������� ������Ʈ
					userService.updateRecentlyDate(dbUser.getUserId());

				} // end of if :: userPassword üũ

				// userCondition ="4"; ȸ������� 1�ε� ���Ʋ�� ���

			} // end of if :: userCondition üũ

		} // end of if :: dbUser null üũ

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("userConCheck", userConCheck);

		System.out.println("�α��� �ٽ� ����������" + jsonObject.toString());

		return jsonObject;

	}// end �α���

	// ��й�ȣ ���� ���������� ���� ��й�ȣ Ȯ��
	@RequestMapping(value = "json/checkPassword", method = RequestMethod.POST)
	public boolean checkPassword(@RequestBody User user, HttpSession session) throws Exception {

		System.out.println("���̽����� /user/json/checkPassword");
		// Business Logic
		User dbUser = userService.getUser(user.getUserId());
		boolean check = false;
		if (user.getPassword().equals(dbUser.getPassword())) {
			check = true;
		}
		return check;
	}// end of checkPassword

	// ��й�ȣ ���� POST
	@RequestMapping(value = "json/updatePassword", method = RequestMethod.POST)
	public boolean updatePassword(@RequestBody User user) throws Exception {

		System.out.println("��й�ȣ ���� /user/updatePassword : POST");
		System.out.println(" ������ ����Ȯ��" + user);

		// Business Logic
		userService.updateUser(user);

		return true;
	}

	// ID �ߺ�Ȯ��
	// ȸ�����Խ� id �ߺ�üũ
	@RequestMapping(value = "json/checkUserId/{userId}", method = RequestMethod.GET)
	public boolean duplicationUser(@PathVariable String userId) throws Exception {

		System.out.println(userId);
		// üũ���� true�̸� DB�� �������� ���°�
		boolean check = false;
		if (!userId.equals("")) {
			check = userService.checkUserId(userId);
		}

		return check;
	}

	// ID ã��
	// ���̵�/��й�ȣ ã�⿡�� id ã��
	@RequestMapping(value = "json/findUserId", method = RequestMethod.POST)
	public User findUserId(@RequestBody User user) throws Exception {

		System.out.println("���̵� ã�� ���̽� ");
		// �̸�,���� ��ġ�Ұ�
		user = userService.findUserId(user);
		if (user == null) {
			user = new User();
		}
		return user;
	}

	// PW ã��
	// ���̵�/��й�ȣ ã�⿡�� PWã��
	@RequestMapping(value = "json/findUserPW", method = RequestMethod.POST)
	public boolean findUserPW(@RequestBody User user) throws Exception {

		System.out.println("��� ã�� ���̽� ");
		boolean check = false;

		// ID�� ���� ��ġ�Ұ�
		// email : ����ڰ� �Է��� �̸��� �ּ� emilDB : �Է��� ���̵�� ��� �ٳ�� �̸����ּ�
		String email = user.getEmail();

		user = userService.getUser(user.getUserId());
		String emilDB = user.getEmail();

		/// ���� �Է��� �̸��ϰ� DB�̸����� ���ٸ�
		if (email.equals(emilDB)) {

			// �ӽ� ��й�ȣ ����, ��� �ӽ� ��й�ȣ�� �ٲٱ�
			int tempNo = createTempNo();
			user.setPassword(tempNo + "");

			// ��� �ٲٱ��� user üũ
			System.out.println("����������������������� " + user);

			userService.updateUser(user);

			System.out.println("�ٲ� �н����� üũ");

			User user2 = userService.getUser(user.getUserId());

			System.out.println("�ٲ� �н����� üũ" + user2);

			// �̸��� ������ �ż��忡 ���� �̸��� �ּҿ� , �ӽ� ��й�ȣ ������
			// String htmlText = " <h2>�ȳ��ϼ���</h2><img src=\\\"cid:my-image\\\">";
			// String htmlText = " <h2>�ȳ��ϼ���</h2><img src=\"cid:my-image\"> ";
			String url = "http://localhost:8080/user/loginUser";
			String htmlText = " <h2>�ȳ��ϼ���</h2><img src=\"cid:my-image\"><h3>������ ��û����  <span style=\"color:red;\">�ӽú�й�ȣ</span>�� �߱޵Ǿ����ϴ�.<br> �ӽú�й�ȣ &nbsp;"
					+ tempNo + " �Դϴ�. </h3>" + "<br><h3>�α��� �� ��й�ȣ�� �������ּ���. </h3>" + "<br><a href=" + url
					+ " target=\"_blank\"><img src=\"http://localhost:8080/images/icon/withdog.jpg\" /></a>";

			String userEmail = emilDB;

			boolean sendOk = userService.sendEmail(userEmail, htmlText);
			String title = "[�Բ��Ұ�]���༭�񽺰� �Ϸ�Ǿ����ϴ�.";

			if (sendOk) {
				check = true;
			}
		}
		return check;

	}// end PWã��

	// ��й�ȣ �ӽ� �����
	public int createTempNo() {

		Random random = new Random();

		int tempNo = random.nextInt();
		// ���밪���� �����
		tempNo = Math.abs(tempNo);

		String temp = tempNo + "";
		temp = temp.substring(3);

		tempNo = Integer.parseInt(temp);

		System.out.println("�ӽú�й�ȣpwNoȮ��" + tempNo);
		return tempNo;
	}

	// �޸� > �Ϲ� ���� :: �̸��� ��ȭ��ȣ�� �˻� �� ��ġ�ϸ� ������ȣ ����
	@RequestMapping(value = "json/changeUserCon", method = RequestMethod.POST)
	public JSONObject changeUserCon(@RequestBody User user) throws Exception {

		System.out.println("�޸���� ����Ʈ ��Ʈ�ѷ�");
		JSONObject jsonObject = new JSONObject();

		// 1. �̸��� ��ȭ��ȣ�� �˻�
		User dbUser = userService.checkPhone(user);

		// 2. �޴������� ������ȣ �߼�

		if (dbUser != null) {

			// 2.1 ������ȣ ������ȣ�� ���� �� ���� ���� �ۼ�
			int tempNo = createTempNo();
			String conText = "[�Բ��Ұ�] ����Ȯ�� ������ȣ[" + tempNo + "]�� ȭ�鿡 �Է����ּ���";

			// 2.2 ���� ��ȭ��ȣ
			String userPhoneNo = dbUser.getPhone();

			// 2.3 ���ں����� �޼���
			userService.sendText(userPhoneNo, conText);

			jsonObject.put("tempNo", tempNo);
			jsonObject.put("check", true);

			/*
			 * //���ڷ� ������ String api_key = "NCSKQ1ATROR9MMJC"; String api_secret =
			 * "HBXDI5ETRJMCRCDKAZHV1CWVF0L6DOKI"; //import �ߺ����� ��Ű�������
			 * net.nurigo.java_sdk.api.Message coolsms = new
			 * net.nurigo.java_sdk.api.Message(api_key, api_secret);
			 * 
			 * // 4 params(to, from, type, text) are mandatory. must be filled
			 * HashMap<String, String> params = new HashMap<String, String>();
			 * params.put("to", userPhone); // ���Ź�ȣ params.put("from", "01095885027"); //
			 * �߽Ź�ȣ params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
			 * params.put("text", "[�Բ��Ұ�] ����Ȯ�� ������ȣ["+textNum+"]�� ȭ�鿡 �Է����ּ���"); // ���ڳ���
			 * params.put("app_version", "JAVA SDK v1.2"); // application name and version
			 * 
			 * try { JSONObject obj = (JSONObject) coolsms.send(params);
			 * System.out.println(obj.toString()); } catch (CoolsmsException e) {
			 * System.out.println(e.getMessage()); System.out.println(e.getCode()); }
			 * 
			 */
		} else {
			jsonObject.put("check", false);
		}

		System.out.println("������ȣ �߼�" + jsonObject.toJSONString());
		return jsonObject;

	}

	// ���ڷ� ���� ������ȣ ��ġ �� �޸� > �������� ��ȯ /user/json/changeUserCondition
	@RequestMapping(value = "json/changeUserCondition", method = RequestMethod.POST)
	public boolean checkTextNum(@RequestParam("userId") String userId) throws Exception {

		System.out.println("�޸������ ����");

		userService.updateUserCon(userId);
		boolean check = true;
		return check;
	}

	// ���ڷ� ���� ������ȣ ��ġ �� �޸� > �������� ��ȯ /user/json/changeUserCondition
	@RequestMapping(value = "json/changeUserConditionTest/{userId}", method = RequestMethod.GET)
	public boolean changeUserConditionTest(@PathVariable String userId) throws Exception {

		System.out.println("�޸������ ����");

		userService.updateUserCon(userId);
		boolean check = true;
		return check;
	}

	/// ȸ��Ż�� POST
	@RequestMapping(value = "json/deleteUser", method = RequestMethod.POST)
	public Boolean deleteUser(@RequestBody User user, HttpSession session) throws Exception {

		System.out.println("ȸ��Ż�� /json/user/deleteUser : POST");

		userService.deleteUser(user);
		session.invalidate();

		return true;
	}

	/*
	 * @RequestMapping( value="/json/checkUserMail", method=RequestMethod.GET )
	 * public String checkMail(@RequestParam("user") String userId,
	 * 
	 * @RequestParam("code") String emailCode , Model model) throws Exception{
	 * System.out.println(userId + "/" + emailCode); User user = new User(); user =
	 * userService.getUser(userId);
	 * 
	 * if(user != null && user.getEmailCode() != null) {
	 * if(user.getEmailCode().equals(emailCode) &&
	 * user.getUserStatusCode().equals("3")) { user.setUserStatusCode("1");
	 * userService.updateStatusCode(user); model.addAttribute("checkUserMail",
	 * true);
	 * 
	 * return "forward:/index.jsp"; } }
	 * 
	 * return "redirect:/index.jsp"; }
	 * 
	 */

	// SNS�����Խ� �ش� ���̵� ���� üũ :: 0 īī�� 1 ���̹� 2 ���� 3 ���̽���
	@RequestMapping(value = "json/checkSnsUserId", method = RequestMethod.POST)
	public Boolean checkUser(@RequestBody User user, HttpSession session) throws Exception {

		// �������̵� �̱�
		String userId = user.getUserId();

		// snsType
		System.out.println("Ȯ��+++++++++++++++++++++" + user);
		int snsType = user.getSnsType();

		// ::userId >> sns~~Id :: snsType�� �µ��� �ش� snsId�� set
		user = setSnsId(snsType, user, userId);

		// true = ��� �����Ƿ� �α��� ������ false = sns ����ȸ������ �ؾ���
		Boolean check = false;
		// User dbuser = userService.getUser(userId);
		System.out.println("find������" + user);

		User dbUser = userService.findSnsId(user);

		System.out.println("db����Ȯ��" + dbUser);

		if (dbUser != null) {

			// db������ ���� �ƴ϶�� �������� üũ ** ���Ŀ� �Ұ�
			System.out.println("������ ���� �ƴ�");
			// ��) k864371031 ���̵� �ִٸ� true�� ����, ���ǿ� ���� �ֱ�(�α��� ����)
			session.setAttribute("user", dbUser);
			check = true;
			// �α��ν� ������ ������Ʈ
			userService.updateRecentlyDate(userId);

		} else {

			// ��) k864371031 ���̵� ���ٸ� false�� ����, ���ǿ� īī�� ID �ֱ�
			System.out.println("������ ���̴�");
			check = false;
			session.setAttribute("tempUser", user);
		}

		return check;
	}

	// Sns ���� ȸ������ ȭ�� POST
	@RequestMapping(value = "json/addSnsUser", method = RequestMethod.POST)
	public Boolean addSnsUser(@RequestBody User user, HttpSession session) throws Exception {

		System.out.println("ȸ������ �Է�â :: /user/json/addSnsUser : POST");

		System.out.println("ȸ���������� " + user);

		// userId
		String userId = user.getUserId();
		// snsType
		int snsType = user.getSnsType();

		// ::userId >> sns~~Id :: snsType�� �µ��� �ش� snsId�� set
		user = setSnsId(snsType, user, userId);

		// Business Logic
		userService.addUser(user);

		user = userService.getUser(user.getUserId());
		session.setAttribute("user", user);

		System.out.println("���ǿ� ���� ����" + user);
		return true;

	}

	// SNS���� :: ���� DB��ȸ�ϰ� ���ٸ� sns�÷�������Ʈ ���ֱ�
	@RequestMapping(value = "json/connectSnsId", method = RequestMethod.POST)
	public Boolean connectSnsId(@RequestBody User user, HttpSession session) throws Exception {

		System.out.println("sns ���� : POST");
		// �������̵� �̱�
		String userId = user.getUserId();

		// snsType
		System.out.println("+" + user);
		int snsType = user.getSnsType();

		// ::userId >> sns~~Id :: snsType�� �µ��� �ش� snsId�� set
		user = setSnsId(snsType, user, userId);

		// DB��ȸ �� �ش� ���̵� �ִٸ� �����Ұ� false / ���̵� ���ٸ� true �ش� snsId�ξ�����Ʈ��
		Boolean check = false;

		// User dbuser = userService.getUser(userId);

		User dbUser = userService.findSnsId(user);

		if (dbUser != null) {

			System.out.println("������ ���� �ƴ�");
			// �ش� ���̵�δ� ������ �ȵ�

		} else {

			// int snsType =Integer.parseInt(snsType2);
			user = setSnsId(snsType, user, userId);

			// ���ǿ��� ���� userId�߰�
			User user2 = (User) session.getAttribute("user");
			String userId2 = user2.getUserId();
			user.setUserId(userId2);
			System.out.println("DB������" + user);
			userService.updateSnsId(user);

			check = true;

		}

		return check;
	}

	// snType�� ���� setSns~Id �Է� :: 0 īī�� 1 ���̹� 2 ���� 3 ���̽���
	public User setSnsId(int snsType, User user, String userId) {

		if (snsType == 0) {

			user.setSnsKakaoId(userId);

		} else if (snsType == 1) {

			user.setSnsNaverId(userId);

		} else if (snsType == 2) {

			user.setSnsGoogleId(userId);

		} else {
			user.setSnsFacebookId(userId);
		}

		return user;

	}

	// ���̹� �α���
	@RequestMapping(value = "json/loginWithNaver", method = RequestMethod.GET)
	public JSONObject loginWithNaver() throws Exception {
		String clientId = "FCLaJ11V_c1179DGKDU1";// ���ø����̼� Ŭ���̾�Ʈ ���̵�";
		String redirectURI = URLEncoder.encode("http://localhost:8080/user/loginWithNaver", "UTF-8");
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString();
		String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		apiURL += "&client_id=" + clientId;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&state=" + state;
		// session.setAttribute("state", state);
		JSONObject jsonobj = new JSONObject();
		jsonobj.put("apiURL", apiURL);
		System.out.println("jsonobj : " + jsonobj);

		return jsonobj;
	}

	// ȸ������ ��������
	@RequestMapping(value = "json/getRateUserCon", method = RequestMethod.GET)

	public JSONObject getRateUserCon(Map map) throws Exception {

		map = userService.getUserConRate();
		// ��üȸ��
		int allUser = (int) map.get("allUser");
		// ����ȸ��
		int userCon0int = (int) map.get("userCon0");
		// �޸�ȸ��
		int userCon1int = (int) map.get("userCon1");
		// Ż��ȸ��
		int userCon2int = (int) map.get("userCon2");

		double userCon0d = (double) ((double) userCon0int / (double) allUser) * 100;
		double userCon1d = (double) userCon1int / (double) allUser * 100;
		double userCon2d = (double) userCon2int / (double) allUser * 100;

		String pattern = "0.##";
		DecimalFormat format = new DecimalFormat(pattern);

		String userCon0 = format.format(userCon0d);
		String userCon1 = format.format(userCon1d);
		String userCon2 = format.format(userCon2d);

		// ���� �ϼ��� JSONObject ����(��ü)
		JSONObject jsonObject = new JSONObject();

		// JSON������ ���� Array ����
		JSONArray userConRateArray = new JSONArray();

		// person�� �Ѹ� ������ �� JSONObject ����
		JSONObject userConInfo = new JSONObject();

		// ���� �Է� :: 0 �޸�ȸ��
		userConInfo.put("language", "�޸�ȸ��");
		userConInfo.put("percent", userCon0);
		userConRateArray.add(userConInfo);

		// person�� �Ѹ� ������ �� JSONObject ����
		userConInfo = new JSONObject();

		// ���� �Է� :: 1 �޸�ȸ��
		userConInfo.put("language", "����ȸ��");
		userConInfo.put("percent", userCon1);
		userConRateArray.add(userConInfo);

		// person�� �Ѹ� ������ �� JSONObject ����
		userConInfo = new JSONObject();

		// ���� �Է�
		userConInfo.put("language", "Ż��ȸ��");
		userConInfo.put("percent", userCon2);
		userConRateArray.add(userConInfo);

		// ��ü�� JSONObject�� ����̶� name���� JSON�� ������ ������ Array�� value�� �Է�
		jsonObject.put("key", userConRateArray);

		System.out.println("jsonObject>>>>>>>>>>>>>> : " + jsonObject);
		return jsonObject;
	}

	// ȸ����� ��������
	// https://js.devexpress.com/Demos/WidgetsGallery/Demo/Charts/SideBySideBar/jQuery/Light/
	@RequestMapping(value = "json/getCountUserCon", method = RequestMethod.GET)
	public JSONObject getCountUserCon(Map map, Search search) throws Exception {

		// search.setSearchCondition("2");
		map = userService.getUserCount5day(search);

		/// map���� ������
		// �޸�ȸ�� 5�ϰ�
		double userConZeroToday = (int) map.get("userConZeroToday");
		double userConZeroCheck1 = (int) map.get("userConZeroCheck1");
		double userConZeroCheck2 = (int) map.get("userConZeroCheck2");
		double userConZeroCheck3 = (int) map.get("userConZeroCheck3");
		double userConZeroCheck4 = (int) map.get("userConZeroCheck4");

		// ����ȸ�� 5�ϰ�
		double userConOneToday = (int) map.get("userConOneToday");
		double userConOneCheck1 = (int) map.get("userConOneCheck1");
		double userConOneCheck2 = (int) map.get("userConOneCheck2");
		double userConOneCheck3 = (int) map.get("userConOneCheck3");
		double userConOneCheck4 = (int) map.get("userConOneCheck4");

		// Ż��ȸ�� 5�ϰ�
		double userConTwoToday = (int) map.get("userConTwoToday");
		double userConTwoCheck1 = (int) map.get("userConTwoCheck1");
		double userConTwoCheck2 = (int) map.get("userConTwoCheck2");
		double userConTwoCheck3 = (int) map.get("userConTwoCheck3");
		double userConTwoCheck4 = (int) map.get("userConTwoCheck4");

		// �޷°�������
		Date today = new Date();

		// ����
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
		String toDay = date.format(today);

		// 1����
		Calendar day = Calendar.getInstance();
		day.add(Calendar.DATE, -1);
		String dayCheck1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(day.getTime());

		// 2����
		day = Calendar.getInstance();
		day.add(Calendar.DATE, -2);
		String dayCheck2 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(day.getTime());

		// 3����
		day = Calendar.getInstance();
		day.add(Calendar.DATE, -3);
		String dayCheck3 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(day.getTime());

		// 4����
		day = Calendar.getInstance();
		day.add(Calendar.DATE, -4);
		String dayCheck4 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(day.getTime());

		////////////////////////////////////////////////////////////////////////

		// ���� �ϼ��� JSONObject ����(��ü)
		JSONObject jsonObject = new JSONObject();

		// JSON������ ���� Array ����
		JSONArray userConRateArray = new JSONArray();

		// JSONObject ����
		JSONObject userCon = new JSONObject();

		// ���ñ���
		userCon.put("state", toDay);
		userCon.put("zero", userConZeroToday);
		userCon.put("one", userConOneToday + 0.02);
		userCon.put("two", userConTwoToday);

		userConRateArray.add(userCon);

		// 1���� ����
		userCon = new JSONObject();
		userCon.put("state", dayCheck1);
		userCon.put("zero", userConZeroCheck1);
		userCon.put("one", userConOneCheck1);
		userCon.put("two", userConTwoCheck1);

		userConRateArray.add(userCon);

		// 2���� ����
		userCon = new JSONObject();
		userCon.put("state", dayCheck2);
		userCon.put("zero", userConZeroCheck2);
		userCon.put("one", userConOneCheck2);
		userCon.put("two", userConTwoCheck2);

		userConRateArray.add(userCon);

		// 3���� ����
		userCon = new JSONObject();
		userCon.put("state", dayCheck3);
		userCon.put("zero", userConZeroCheck3);
		userCon.put("one", userConOneCheck3);
		userCon.put("two", userConTwoCheck3);

		userConRateArray.add(userCon);

		// 4���� ����
		userCon = new JSONObject();
		userCon.put("state", dayCheck4);
		userCon.put("zero", userConZeroCheck4);
		userCon.put("one", userConOneCheck4);
		userCon.put("two", userConTwoCheck4);

		userConRateArray.add(userCon);

		// ������
		jsonObject.put("key", userConRateArray);

		System.out.println("jsonObject>>>>>>>>>>>>>> : " + jsonObject);

		return jsonObject;
	}

	/// ����////////////////////////////////////////////////////////////////////////////////////////////////

	// �̸��� ����
	@RequestMapping(value = "json/checkEmail")
	public JSONObject checkEmail(@RequestBody User user) throws Exception {

		System.out.println("�̸��� üũcheckEmail ");

		// ���� �ּ� �ߺ�Ȯ��
		String userEmail = user.getEmail();
		User dbUser = userService.checkUserEmail(userEmail);

		JSONObject jsonObject = new JSONObject();

		if (dbUser != null) {

			boolean check = false;
			jsonObject.put("check", check);
		} else {

			// 1.1 ������ȣ ������ȣ�� ����, ���ó�¥
			int tempNo = createTempNo();

			// �޷°�������
			Date today = new Date();

			// ����
			SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
			String toDay = date.format(today);

			// 1.2 ���� ���� �ۼ� :: �̸����ּ�, �������� , ����
			String title = "[�Բ��Ұ�]���� ������ ���� �����ڵ带 �ȳ��ص帳�ϴ�.";
			String url = "http://localhost:8080/";
			String htmlText = "<body style=\"box-sizing: border-box; line-height: 24px; font-family: '�������', 'malgun gothic', 'dotum', sans-serif;\">\r\n"
					+ "	<div style=\"margin:0 auto; width: 750px; height:195px; font-size: 16px; background:url(http://localhost:8080/images/icon/mail_bg.jpg) no-repeat;\">\r\n"
					+ "		<div style=\"font-size: 30px; text-align:center; margin-bottom: 60px; margin-top: 44px; color: #fff;\">\r\n"
					+ "			<p style=\"padding-top:78px; margin-bottom: 13px;\">�̸��� ���� �ڵ带 �˷������!</p> \r\n"
					+ "		</div>\r\n" + "	</div>\r\n"
					+ "	<div style=\"width:640px; padding:20px 0; margin:0 auto; margin-top:50px\">\r\n"
					+ "		<p style=\"border-bottom: 2px solid #000; padding-bottom: 10px; font-size: 18px; font-weight: 700;\">�����ڵ� �Է¶��� �Ʒ� �����ڵ带 �Է��ϼ���!  </p>\r\n"
					+ "			<ul style=\"font-size:17px;\">\r\n" + "				<li>�����ڵ�: " + tempNo + "</li>\r\n"
					+ "				<li>�߼��Ͻ�:" + toDay + "</li>\r\n"
					+ "				<li><a href=\"http://localhost:8080\">�Բ��Ұ� ����Ʈ �ٷΰ���</a></li>\r\n"
					+ "			</ul>\r\n" + "	</div>\r\n"
					+ "	<div style=\"width:640px; padding:20px 0; margin:0 auto;\">\r\n"
					+ "		<p style=\"border-bottom: 2px solid #000; padding-bottom: 10px; font-size: 18px; font-weight: 700;\">���������� �� �ʿ��Ѱ���?</p>\r\n"
					+ "			<ul style=\"font-size:17px;\">\r\n"
					+ "				<li>������ �������� ��ȣ�Ͽ� ���� �����ϰ� ����Ʈ�� �̿��Ͻõ��� �ϱ����� �Բ��Ұ��� ����Դϴ�.</li>\r\n"
					+ "				<li>���� �Ǵ� Ÿ���� �����ּҸ� �����Ͽ� ����/Ȱ���ϴ� ��츦 �����ϰ���</br>\r\n"
					+ "				���������� ���� ȸ������ �ش� ���� �ּ��� ���������� Ȯ���ϰ� �ֽ��ϴ�.</li>\r\n" + "			</ul>\r\n"
					+ "	</div>\r\n" + "	<div style=\"background-color: #eee; margin:0 auto; width: 750px\">\r\n"
					+ "		<ul style=\"font-size:13px; padding: 30px 0 30px 36px; color: #868686; list-style: none;\">\r\n"
					+ "			<li>1. �� ������ �Բ��Ұ� ���� � �� ���� �������� �߼۵Ǵ� �߽� ���� �����Դϴ�.</li>\r\n"
					+ "			<li>2. ���ǻ����� �Բ��Ұ� Ȩ������ �� �����͸� �̿����ּ���.</li>\r\n"
					+ "			<li>COPYRIGHT 2018. WITH DOG INC. ALL RIGHTS RESERVED</li>\r\n" + "		</ul>\r\n"
					+ "	</div>\r\n" + "</body>";

			// 1.3 ���ں����� �޼���
			boolean sendOk = userService.sendConfirmEmail(userEmail, htmlText, title);

			jsonObject.put("tempNo", tempNo);
			jsonObject.put("check", sendOk);

		}

		System.out.println("Ȯ��" + jsonObject.toJSONString());
		return jsonObject;

	}

}// end of class
