package com.withdog.service.user.impl;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import javax.mail.internet.MimeUtility;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.withdog.common.Search;
import com.withdog.service.common.CommonService;
import com.withdog.service.domain.Point;
import com.withdog.service.domain.User;
import com.withdog.service.user.UserDAO;
import com.withdog.service.user.UserService;

import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {
	
	///Field
	@Autowired
	@Qualifier("userDAOImpl")
	private UserDAO userDAO;
	
	@Autowired
	@Qualifier("commonServiceImpl")
	private CommonService commonService;
	
	///Constructor
	public UserServiceImpl() {
		System.out.println(this.getClass());
	}
	
	
	/////////////////////////////////////////////////
	//Android//
	@Override
	public User getUser2(String userId) throws Exception{ //��� �ȵ��׽�Ʈ
		return userDAO.getUser2(userId);
	}
	///////////////////////////////////////////////////
	
	
	///Method
	@Override
	public void addUser(User user) throws Exception {
		userDAO.addUser(user);
	}

	//ȸ��������ȸ�� ����Ʈ��ȸ�� ����
	@Override
	public User getUser(String userId) throws Exception {
		
			User user = userDAO.getUser(userId);
			
			 //����Ʈ ��ȸ;

			if(user.getUserId()!=null) {
				
				Point point =new Point();
				user.setUserId(userId);
				point.setUser(user);
			 	int currentPoint=0;
			 	
				if(commonService.getCurrentPoint(point)!=0) 
					{
						currentPoint= commonService.getCurrentPoint(point);	
					}
			 
			 System.out.println("Point ����");
			 user.setCurrentPoint(currentPoint);
			}
			return  user;
	}
	

	@Override
	public void updateUser(User user) throws Exception {
		 userDAO.updateUser(user);
	}

	@Override
	public void updatePassword(User user) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteUser(User user) throws Exception {
		 userDAO.deleteUser(user);

	}

	@Override
	public User loginUser(User user) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void logoutUser(User user) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean checkUserId(String userId) throws Exception {
		
			boolean check=true;
			User user=userDAO.getUser(userId);
			
			//üũ���� true�̸� DB�� �������� ���°�
			if(user.getUserId()!= null) {
				check=false;
			}
			return check;
	}

	@Override
	public User findUserId(User user) throws Exception {
		return 	userDAO.findUserId(user);
	}

	@Override
	public void findUserPassword(User user) throws Exception {
		 

	}

	@Override
	public Map<String, Object> getUserListAdmin(Search search) throws Exception {
		
		List<User> list= userDAO.getUserListAdmin(search);
		int totalCount = userDAO.getTotalCount(search);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public void updateRecentlyDate(String userId) throws Exception {
		userDAO.updateRecentlyDate(userId);
	}

	@Override
	public User checkPhone(User user) throws Exception {
		return userDAO.checkPhone(user);
		
	}

	/////////////////////////////////////////////////////////////
	//���� �����ٷ�
	@Override
	public void updateUserList() throws Exception {
		userDAO.updateUserList();
		 System.out.println("���� ��������");
		 long time = System.currentTimeMillis(); 
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		String str = dayTime.format(new Date(time));
		System.out.println(str);
	}

	@Override
	public void updateUserCon(String userId) throws Exception {
		userDAO.updateUserCon(userId);
		
	}

	@Override

	public boolean sendEmail(String userEmail, String htmlText) throws Exception {
		
			/*���̹��� ������
		  String host     = "smtp.naver.com";
		  String fromEmail   = "hyuny0126@naver.com"; //������ ��� �̸��� �ּ�
		  String password  = ""; //������ ��� ��й�ȣ
		  String toEmail     =   userEmail ;//�޴»�� �̸��� �ּ�
		  */
			//gmail�� ������
		  String host     = "smtp.gmail.com";
		  String fromEmail   = "withdog0817@gmail.com"; //������ ��� �̸��� �ּ�
		  String password  = "0817withdog!"; //������ ��� ��й�ȣ
		  String toEmail     =   userEmail ;//�޴»�� �̸��� �ּ�
		  
		  System.out.println(toEmail);

		  // Get the session object

		  Properties props = new Properties();
		  props.put("mail.smtp.starttls.enable", "true");
		  props.put("mail.smtp.host", host);
		  props.put("mail.smtp.port", 587);
		  props.put("mail.smtp.auth", "true");

		  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
		   protected PasswordAuthentication getPasswordAuthentication() {
			   return new PasswordAuthentication(fromEmail, password);
		   }

		  });

		  // Compose the message
		  try {
		   MimeMessage message = new MimeMessage(session);

		   message.setFrom(new InternetAddress(fromEmail));
		   message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

			  //�̹��� ÷�θ� ���� ����
		   // This HTML mail have to 2 part, the BODY and the embedded image
	       MimeMultipart multipart = new MimeMultipart("related");

	        // first part
	        BodyPart messageBodyPart = new MimeBodyPart();

	        //���� String htmlText ÷��
//	        messageBodyPart.setContent(htmlText, "text/html; charset=euc-kr");
	        messageBodyPart.setContent(htmlText, "text/html; charset=euc-kr");

	        // add it
	        multipart.addBodyPart(messageBodyPart);

	        // second part (the image)
	        messageBodyPart = new MimeBodyPart();

	        DataSource fds = new FileDataSource

	          ("C:\\Users\\Bit\\git\\withDog\\withDog\\WebContent\\images\\icon\\tempPW.jpg");

	        messageBodyPart .setDataHandler(new DataHandler(fds));
	        messageBodyPart .setHeader("Content-ID","<my-image>");

	        // add it
	        multipart.addBodyPart(messageBodyPart );

	        // put everything together
	        message.setContent(multipart);

		   // Subject  ���� ����
		   message.setSubject("[�Բ��Ұ�] �ӽú�й�ȣ�� �߼��Ͽ����ϴ�.");

		   // send the message
		   	Transport.send(message, message.getRecipients(Message.RecipientType.TO)); //��
		   System.out.println("message sent successfully...");

		  } catch (MessagingException e) {

		   e.printStackTrace();

		  }

	return true;

	}

	@Override
	public boolean sendText(String userPhoneNo, String conText) throws Exception {
		
		//���ڷ� ������
	 	String api_key = "NCSKQ1ATROR9MMJC";
	    String api_secret = "HBXDI5ETRJMCRCDKAZHV1CWVF0L6DOKI";
	    //import  �ߺ����� ��Ű������� 
	    net.nurigo.java_sdk.api.Message coolsms = new net.nurigo.java_sdk.api.Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", userPhoneNo); // ���Ź�ȣ
	    params.put("from", "01095885027"); // �߽Ź�ȣ
	    params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
	    params.put("text",conText ); // ���ڳ���    
	    params.put("app_version", "JAVA SDK v1.2"); // application name and version
		
	    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }

	    return true;
	}

	
	
	
	
	/////////////////////////////////////////////////////////////////
	//īī�� �α��� 
	public static JsonNode  getAccessToken(String autorize_code) {
		
		final String RequestUrl = "https://kauth.kakao.com/oauth/token";

		final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
		postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
		postParams.add(new BasicNameValuePair("client_id", "5e75c6292cceb6354253881453146baa")); // REST API KEY
		postParams.add(new BasicNameValuePair("redirect_uri", "http://localhost:8080/user/kakaoLogin")); // �����̷�Ʈ URI
		postParams.add(new BasicNameValuePair("code", autorize_code)); // �α��� ������ ���� code ��

		final HttpClient client = HttpClientBuilder.create().build();
		final HttpPost post = new HttpPost(RequestUrl);
		
		JsonNode returnNode = null;

		try {
			post.setEntity(new UrlEncodedFormEntity(postParams));
			final HttpResponse response = client.execute(post);
			final int responseCode = response.getStatusLine().getStatusCode();

			System.out.println("�پ����ū URL"+"\nSending 'POST' request to URL : " + RequestUrl);
			System.out.println("�پ����ū �Ķ����"+"Post parameters : " + postParams);
			System.out.println("�پ����ū�ȿ� �ڵ�"+"Response Code : " + responseCode);

			// JSON ���� ��ȯ�� ó��
			ObjectMapper mapper = new ObjectMapper();
			returnNode = mapper.readTree(response.getEntity().getContent());
			System.out.println("�پ����ū�ȿ� ���ϰ�"+returnNode.toString());

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// clear resources
		}

		return returnNode;

	}

	public static JsonNode getKakaoUserInfo(String autorize_code) {

		final String RequestUrl = "https://kapi.kakao.com/v1/user/me";

		final HttpClient client = HttpClientBuilder.create().build();
		final HttpPost post = new HttpPost(RequestUrl);

		// add header
		post.addHeader("Authorization", "Bearer " + autorize_code);

		JsonNode returnNode = null;

		try {
			final HttpResponse response = client.execute(post);
			final int responseCode = response.getStatusLine().getStatusCode();

			System.out.println("��īī����������"+ "\nSending 'POST' request to URL : " + RequestUrl);
			System.out.println("Response Code : " + responseCode);

			// JSON ���� ��ȯ�� ó��
			ObjectMapper mapper = new ObjectMapper();
			returnNode = mapper.readTree(response.getEntity().getContent());

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// clear resources
		}
		return returnNode;

	}

	public static User changeData(JsonNode userInfo) {
		
		User user = new User();

		user.setUserId(userInfo.path("id").asText()); // id -> user �ֱ�


		JsonNode properties = userInfo.path("properties"); // �߰����� �޾ƿ���

		return user;
	}

	@Override
	public User findSnsId(User user) throws Exception {
		return userDAO.findSnsId(user);
	}

	@Override
	public void  updateSnsId(User user) throws Exception {
		userDAO.updateSnsId(user);
	}

	@Override
	public Map<String, Object> getUserConRate() throws Exception {
		
		return userDAO.getUserConRate();
	}

	//����ġ������ �Ϸ�, �ݵ� �Ϸ�, ��ǰ���ſϷ�� ��������
	@Override
	public boolean sendConfirmEmail(String userEmail, String htmlText, String title) throws Exception {
		
		  String host     = "smtp.gmail.com";
		  String fromEmail   = "withdog0817@gmail.com"; //������ ��� �̸��� �ּ�
		  String password  = "0817withdog!"; //������ ��� ��й�ȣ
		  String toEmail     =   userEmail ;//�޴»�� �̸��� �ּ�
		  
		  System.out.println(toEmail);

		  // Get the session object

		  Properties props = new Properties();
		  props.put("mail.smtp.starttls.enable", "true");
		  props.put("mail.smtp.host", host);
		  props.put("mail.smtp.port", 587);
		  props.put("mail.smtp.auth", "true");

		  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
		   protected PasswordAuthentication getPasswordAuthentication() {
			   return new PasswordAuthentication(fromEmail, password);
		   }

		  });

		  // Compose the message
		  try {
		   MimeMessage message = new MimeMessage(session);

		   message.setFrom(new InternetAddress(fromEmail));
		   message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
		

            //������ ���ÿ� �������� ������ �������� �迭�� �̸��� �ּҸ� �ۼ��Ѵ�.
          //  InternetAddress[] address1 = { new InternetAddress (to) };

            message.setRecipients (Message. RecipientType.TO , userEmail);

            message.setSubject (title); //����

            message.setSentDate (new java.util.Date());//�����³�¥

          // message.setContent (getMailString(), "text/html;charset=euc-kr" ); //�������� ������
            message.setContent (htmlText, "text/html;charset=euc-kr" ); //�������� ������
            Transport.send (message); //������� �̸��� ���۽���

        } catch (MessagingException ex) {

        	ex.printStackTrace();

        } catch (Exception e) {

        	e.printStackTrace();

        }
		  
		  return true;

     }//end of sendConfirmEmail
	


	@Override
	public Map<String, Object> getUserConListAdmin(Search search) throws Exception {
	
		return 	userDAO.getUserConListAdmin(search);
	}

	@Override
	public Map<String, Object> getUserCount5day(Search search) throws Exception {
		
		return userDAO.getUserCount5day(search);
	}

	@Override
	public User checkUserEmail(String email) throws Exception {
		
		return userDAO.checkUserEmail(email);
	}

	/////////////////////////////////////////////////////////////
	//���� �����ٷ� ���� ������ ��ħ���� ���� �̸��� ����
	//����ġ������ �Ϸ�, �ݵ� �Ϸ�, ��ǰ���ſϷ�� ��������
	@Override
	public void sendAdvEmail( ) throws Exception {
	
	System.out.println("�̸��� �׽�Ʈ �̸��� �׽�Ʈ");
	String host     = "smtp.gmail.com";
	String fromEmail   = "withdog0817@gmail.com"; //������ ��� �̸��� �ּ�
	String password  = "0817withdog!"; //������ ��� ��й�ȣ
	// String toEmail     =   userEmail ;//�޴»�� �̸��� �ּ�
	List<User> usersEmail = userDAO.getUsersEmail();
	
	System.out.println("���� �̸��� Ȯ��"+usersEmail);
	
	String title ="8�� ��°�� �Բ��Ұ� �Ż�ǰ �԰�!! �ȳ������Դϴ�";
	//String htmlText ="<img src=\"http://192.168.0.41:8080/images/email/email8_2.jpg\" />";
	/*String htmlText ="<img src = \"http://192.168.0.34:8080/images/email/email8_2.jpg\" usemap=\"#usermap\"/>\r\n" + 
	"<map name=\"usermap\">\r\n" + 
	"<area  alt=\"\" title=\"\" href=\"http://192.168.0.34:8080/product/getProduct?prodNo=10086\" shape=\"rect\" coords=\"122,849,473,1317\" style=\"outline:none;\" target=\"_self\"     />\r\n" + 
	"<area  alt=\"\" title=\"\" href=\"http://192.168.0.34:8080/product/getProduct?prodNo=10088\" shape=\"rect\" coords=\"488,848,839,1316\" style=\"outline:none;\" target=\"_self\"     />\r\n" + 
	"<area  alt=\"\" title=\"\" href=\"http://192.168.0.34:8080/product/getProduct?prodNo=10085\" shape=\"rect\" coords=\"123,1518,474,1986\" style=\"outline:none;\" target=\"_self\"     />\r\n" + 
	"<area  alt=\"\" title=\"\" href=\"http://192.168.0.34:8080/product/getProduct?prodNo=10084\" shape=\"rect\" coords=\"486,1520,837,1988\" style=\"outline:none;\" target=\"_self\"     />\r\n" + 
	"</map>";*/
	String htmlText ="<img src = \"http://localhost:8080/images/email/email8_2.jpg\" usemap=\"#usermap\"/>\r\n" + 
			"<map name=\"usermap\">\r\n" + 
			"<area  alt=\"\" title=\"\" href=\"http://localhost:8080/product/getProduct?prodNo=10086\" shape=\"rect\" coords=\"122,849,473,1317\" style=\"outline:none;\" target=\"_self\"     />\r\n" + 
			"<area  alt=\"\" title=\"\" href=\"http://localhost:8080/product/getProduct?prodNo=10088\" shape=\"rect\" coords=\"488,848,839,1316\" style=\"outline:none;\" target=\"_self\"     />\r\n" + 
			"<area  alt=\"\" title=\"\" href=\"http://localhost:8080/product/getProduct?prodNo=10085\" shape=\"rect\" coords=\"123,1518,474,1986\" style=\"outline:none;\" target=\"_self\"     />\r\n" + 
			"<area  alt=\"\" title=\"\" href=\"http://localhost:8080/product/getProduct?prodNo=10084\" shape=\"rect\" coords=\"486,1520,837,1988\" style=\"outline:none;\" target=\"_self\"     />\r\n" + 
			"</map>";
	
	// System.out.println(toEmail);
	
	// Get the session object
	
	Properties props = new Properties();
	props.put("mail.smtp.starttls.enable", "true");
	props.put("mail.smtp.host", host);
	props.put("mail.smtp.port", 587);
	props.put("mail.smtp.auth", "true");
	
	Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
	protected PasswordAuthentication getPasswordAuthentication() {
	return new PasswordAuthentication(fromEmail, password);
	}
	
	});
	
	// Compose the message
	try {
	MimeMessage message = new MimeMessage(session);
	
	message.setFrom(new InternetAddress(fromEmail));
	//message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
	
	int emailNo = usersEmail.size();

	//������ ���ÿ� �������� ������ �������� �迭�� �̸��� �ּҸ� �ۼ��Ѵ�.
	InternetAddress[] address1 = new InternetAddress[emailNo];
	System.out.println("Ȯ�� ���� �"+emailNo);
	for(int i=0 ; i<emailNo;i++) {
	String userEmail = usersEmail.get(i).getEmail();
	System.out.println("����Ȯ��"+userEmail);
	address1[i] = new InternetAddress(userEmail);
	
	}
	//
	//{ new InternetAddress (to) };
	
	//�������� Ȯ��
	System.out.println("address1"+address1[0]);
	System.out.println("address1"+address1[1]);
	message.setRecipients (Message. RecipientType.TO , address1);
	
	message.setSubject (title); //����
	
	message.setSentDate (new java.util.Date());//�����³�¥
	
	// message.setContent (getMailString(), "text/html;charset=euc-kr" ); //�������� ������
	message.setContent (htmlText, "text/html;charset=euc-kr" ); //�������� ������
	Transport.send (message); //������� �̸��� ���۽���
	
	} catch (MessagingException ex) {
	
	ex.printStackTrace();
	
	} catch (Exception e) {
	
	e.printStackTrace();
	
	}
	
	

}//end of sendAdvEmail

}//end of class
