package com.model2.mvc.web.user;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Place;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET!!");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	@RequestMapping(value = "json/getUserSearch")
	public JSONArray getUserSearch(@RequestBody Search search) throws Exception {
		System.out.println("user/json/getProdSearch!!!!!!!!!!!!11");
		List<User> list = userService.getUserSearch(search);
				
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < list.size(); i++) {
			if(list.get(i).getUserId()!=null) {
			jsonArray.add(list.get(i).getUserId());
			}else if(list.get(i).getUserName()!=null) {
			jsonArray.add(list.get(i).getUserName());
			}
		}
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>"+jsonArray);
		
		return jsonArray;
	}
	
	@RequestMapping(value = "json/kakao")

	public User kakaoLogin(@RequestBody User user,HttpSession session) throws Exception{
		
		System.out.println("json/kakao!!!!!!!!!!!!!!start");
		System.out.println("mmmmmmmm,mmmmmmm"+user);
		if(!userService.checkDuplication(user.getUserId())){
			System.out.println("kakao이게 실행됨");
			session.setAttribute("user", userService.getUser(user.getUserId()));
			return userService.getUser(user.getUserId());
		}else {
			System.out.println("이것도 실행됨");
			System.out.println(user);
			session.setAttribute("user", user);
			return user;
		}
		
	}
	
	@RequestMapping(value = "json/GoogleMap")
	
	public JSONObject googleMap(@RequestBody JSONObject jobjp,HttpServletRequest request) throws Exception {
        //String clientId = "R6scw7nmGLqAnHi_vcj3";//애플리케이션 클라이언트 아이디값";
        //String clientSecret = "SFqKnM6OyE";//애플리케이션 클라이언트 시크릿값";
        
        //String addr = URLEncoder.encode("경상남도 밀양시 삼랑진읍 천태로 472", "UTF-8");
			System.out.println("들어왔나?========================");
			System.out.println(jobjp.get("place").toString());
			System.out.println("들어왔나?========================111");
			
			ObjectMapper obj = new ObjectMapper();
			System.out.println(jobjp.get("place").toString().substring(jobjp.get("place").toString().indexOf("lat=")+4,jobjp.get("place").toString().lastIndexOf(",")));
			System.out.println(jobjp.get("place").toString().substring(jobjp.get("place").toString().indexOf("lng=")+4,jobjp.get("place").toString().lastIndexOf("}")));
			
			String lat=jobjp.get("place").toString().substring(jobjp.get("place").toString().indexOf("lat=")+4,jobjp.get("place").toString().lastIndexOf(","));
			String lng=jobjp.get("place").toString().substring(jobjp.get("place").toString().indexOf("lng=")+4,jobjp.get("place").toString().lastIndexOf("}"));

			System.out.println("변환완료:"+lat+":::"+lng);
		
            String apiURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+lat+","+lng+"&radius=1000&type=veterinary_care&keyword=&key=AIzaSyDtz18kZbobsZXEZs7SyXN_2XBgP9kB39k&language=ko-ko"; //json
           
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Accept", "application/json");
            con.setRequestProperty("Content-Type", "application/json");
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"UTF-8"));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            //System.out.println(response.toString());
            
            JSONObject jsonObject = (JSONObject)JSONValue.parse(response.toString());
            System.out.println("완료");
            //System.out.println(jsonObject.toString());
            //System.out.println("=============================");
            
            JSONParser parser = new JSONParser();
            JSONArray jsonArray = (JSONArray)jsonObject.get("results");
            JSONArray jsoninfo = new JSONArray();
            List<JSONObject> jsonlist = new ArrayList<JSONObject>();
            JSONObject jobj = new JSONObject();
            JSONObject jobjlast = new JSONObject();
            JSONObject pinfolast = new JSONObject();
            JSONObject location = new JSONObject();
            
            String temp="";
            int a=0;
            if(jsonArray.size()>=5) {
            	a=jsonArray.size();
            }else {
            	a=jsonArray.size();
            }
            for(int i=0;i<a;i++) {
            	List<String> placeinfo = new ArrayList<String>();
               	//System.out.println(jsonArray.get(i).toString());
               	jsonObject =(JSONObject)JSONValue.parse(jsonArray.get(i).toString());
               	
               	//System.out.println("==================================");
               	/*System.out.println(jsonObject.get("geometry"));*/
               	//System.out.println(jsonObject.get("name"));
               	//System.out.println(jsonObject.get("vicinity"));
               	placeinfo.add(jsonObject.get("name").toString());
               	placeinfo.add(jsonObject.get("vicinity").toString());
               	               	               	
               	jsonObject =(JSONObject)JSONValue.parse(jsonObject.get("geometry").toString());
               //	System.out.println("==================================JSON{{{}}}접근방법");
               	
                //System.out.println((JSONObject)((JSONObject)(jsonObject.get("viewport"))).get("southwest"));
               	
               	//jsonObject =(JSONObject)((JSONObject)(jsonObject.get("viewport"))).get("southwest");
               	
               	System.out.println("===================좌표만========================");
               	location = (JSONObject)JSONValue.parse(jsonObject.get("location").toString());
               	
               	placeinfo.add(location.get("lng").toString());
               	placeinfo.add(location.get("lat").toString());
               	
               	System.out.println(location.get("lng"));
               	System.out.println(location.get("lat"));
               	System.out.println("===================좌표만========================");
               	
               	
               	
               	//placeinfo.add(jsonObject.get("location").toString());
               	
              	//System.out.println("==================================");
               	//if(placeinfo.get(0)!=null) {
               	//temp = "{\"name\":"+placeinfo.get(0)+"},"+"{\"place\":"+placeinfo.get(1)+"}"+","+placeinfo.get(2);
               	//System.out.println(temp);
               	//jobj =(JSONObject)((JSONObject)(jsonObject.get("location"))).get("lng");
               	//System.out.println(jobj.toString());
               	
               	jobj.put("name", placeinfo.get(0));
               	jobj.put("place", placeinfo.get(1));
               	jobj.put("lng", placeinfo.get(2));
               	jobj.put("lat", placeinfo.get(3));
               	
               	jobjlast.put("placeinfo", jobj);
               	
               	System.out.println(jobjlast.toString());
               	System.out.println("==================================1");
               //	}
                 //jsoninfo.add(jobjlast);
               	location = (JSONObject)JSONValue.parse(jobjlast.toString());
               	jsoninfo.add(location);
                
            	}
            
            System.out.println(jsoninfo.toString());
            System.out.println("==================================end");
            pinfolast.put("all", jsoninfo);
            System.out.println(pinfolast.toString());
            System.out.println("==================================endlast");
             
                   
            return pinfolast;
        
	}
}