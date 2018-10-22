package com.withdog.web.quick;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.withdog.service.domain.ChatBot;
import com.withdog.service.domain.User;
import com.withdog.service.quick.QuickService;

@RestController
@RequestMapping("/quick/*")
public class QuickRestController {
	
	@Autowired
	@Qualifier("quickServiceImpl")
	private QuickService quickService;
	
	public QuickRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value = "json/GoogleMap")
		
		public JSONObject googleMap(@RequestBody JSONObject jobjp,HttpServletRequest request) throws Exception {
	     
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
	            JSONObject jsonObject = (JSONObject)JSONValue.parse(response.toString());
	            System.out.println("완료");
	          
	            
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
	     
	               	jsonObject =(JSONObject)JSONValue.parse(jsonArray.get(i).toString());
	               	
	     
	               	placeinfo.add(jsonObject.get("name").toString());
	               	placeinfo.add(jsonObject.get("vicinity").toString());
	               	               	               	
	               	jsonObject =(JSONObject)JSONValue.parse(jsonObject.get("geometry").toString());
	           
	               	System.out.println("===================좌표만========================");
	               	location = (JSONObject)JSONValue.parse(jsonObject.get("location").toString());
	               	
	               	placeinfo.add(location.get("lng").toString());
	               	placeinfo.add(location.get("lat").toString());
	               	
	               	System.out.println(location.get("lng"));
	               	System.out.println(location.get("lat"));
	               	System.out.println("===================좌표만========================");
	               	
	               	
	           
	               	
	               	jobj.put("name", placeinfo.get(0));
	               	jobj.put("place", placeinfo.get(1));
	               	jobj.put("lng", placeinfo.get(2));
	               	jobj.put("lat", placeinfo.get(3));
	               	
	               	jobjlast.put("placeinfo", jobj);
	               	
	               	System.out.println(jobjlast.toString());
	               	System.out.println("==================================1");
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
		
		@RequestMapping(value = "json/GoogleDistance")
		public JSONObject GoogleDistance(HttpServletRequest request) throws Exception{
			
			System.out.println("////////////////googleDistance Start /////////////////////////////");
			System.out.println(request.getParameter("lng"));
			System.out.println(request.getParameter("lat"));
			if(request.getParameter("lng")!=null) {
			String clat=request.getParameter("lat");
			String clng=request.getParameter("lng");
			}else {
			String clat="37.494541";
			String clng="127.027969";	
			}
			
			
			String apiURL = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=37.494541,127.027969&destinations=37.497942,127.027621&mode=transit&language=ko-ko&key=AIzaSyAyJUiL4ifUuucPRfc1SDXbO1kv-ci_CtE"; //json
	        
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
	        
	        
	        JSONObject jobj = new JSONObject();
	        jobj = (JSONObject)JSONValue.parse(response.toString());
	        System.out.println(jobj.get("rows"));
	        String temp1=((JSONArray)jobj.get("destination_addresses")).get(0).toString();
	        String temp2 = ((JSONObject)((JSONObject)((JSONArray)((JSONObject)((JSONArray)jobj.get("rows")).get(0)).get("elements")).get(0)).get("duration")).get("text").toString();
	        String temp3 = ((JSONObject)((JSONObject)((JSONArray)((JSONObject)((JSONArray)jobj.get("rows")).get(0)).get("elements")).get(0)).get("distance")).get("text").toString();
	        System.out.println(((JSONObject)((JSONObject)((JSONArray)((JSONObject)((JSONArray)jobj.get("rows")).get(0)).get("elements")).get(0)).get("duration")).get("text"));
	        System.out.println(((JSONObject)((JSONObject)((JSONArray)((JSONObject)((JSONArray)jobj.get("rows")).get(0)).get("elements")).get(0)).get("distance")).get("text"));
			
	        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	        //파파고번역시작
	        
	        
			/*String clientId = "37IP7FFKbpA4kS36dnmL";// 애플리케이션 클라이언트 아이디값";
			String clientSecret = "zpU9ZiuBPR";// 애플리케이션 클라이언트 시크릿값";
			
			List<String> list = new ArrayList<String>();
			list.add(temp1);
			list.add(temp2);
			JSONObject jtran = new JSONObject();
			JSONArray ja = new JSONArray();
			
			for(int i=0; i<list.size();i++) {		
					String apiURL2 = "https://openapi.naver.com/v1/papago/n2mt";
					URL url2 = new URL(apiURL2);
					HttpURLConnection con2 = (HttpURLConnection) url2.openConnection();
					con2.setRequestMethod("POST");
					con2.setRequestProperty("X-Naver-Client-Id", clientId);
					con2.setRequestProperty("X-Naver-Client-Secret", clientSecret);
					// post request
					String postParams = "source=en&target=ko&text=" +list.get(i);
					con2.setDoOutput(true);
					DataOutputStream wr2 = new DataOutputStream(con2.getOutputStream());
					wr2.writeBytes(postParams);
					wr2.flush();
					wr2.close();
					int responseCode2 = con2.getResponseCode();
					BufferedReader br2;
					if (responseCode2 == 200) { // 정상 호출
						br2 = new BufferedReader(new InputStreamReader(con2.getInputStream(), "UTF-8"));
					} else { // 에러 발생
						br2 = new BufferedReader(new InputStreamReader(con2.getErrorStream()));
					}
					String inputLine2;
					StringBuffer response2 = new StringBuffer();
					while ((inputLine2 = br2.readLine()) != null) {
						response2.append(inputLine2);
					}
					br2.close();
					System.out.println(response2.toString());
					jtran = (JSONObject)JSONValue.parse(response2.toString());
					
					//System.out.println(((JSONObject)((JSONObject)jtran.get("message")).get("result")).get("translatedText"));
					
					String stj =((JSONObject)((JSONObject)jtran.get("message")).get("result")).get("translatedText").toString();
					
					ja.add(stj);
					
			}
			System.out.println(ja.toString());*/
			//System.out.println(ja.get(0));
			//System.out.println(ja.get(1));
	               
	        ////////////////////////////////////////////////
			//전송
	                
	        JSONObject resjobj = new JSONObject();
	   
	        System.out.println(1);
	        resjobj.put("address", temp1);
	        System.out.println(2);
	        resjobj.put("mins", temp2);
	        System.out.println(3);
	        resjobj.put("distance", temp3);
	        System.out.println(4);
			
	        System.out.println(resjobj.toString());
	        
			return resjobj;
		}
		
		
	@RequestMapping(value = "json/GoogleMapSearch")
		
		public JSONObject googleMapSearch(@RequestBody JSONObject jlt) throws Exception {
	       		
				System.out.println("GoogleMapSearch Start========================================================");
				System.out.println(jlt.toString());
				
				JSONObject jnt = new JSONObject();
				jnt = (JSONObject)JSONValue.parse(jlt.toString());
				
				System.out.println(((JSONObject)jnt.get("place")).get("lat"));
				System.out.println(((JSONObject)jnt.get("place")).get("lng"));
				String lat=((JSONObject)jnt.get("place")).get("lat").toString();
				String lng=((JSONObject)jnt.get("place")).get("lng").toString();
				String type=((JSONObject)jnt.get("place")).get("type").toString();
	
				System.out.println("변환완료:"+lat+":::"+lng+"::"+type);
			
	            String apiURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+lat+","+lng+"&radius=1000&type="+type+"&keyword=&key=AIzaSyDtz18kZbobsZXEZs7SyXN_2XBgP9kB39k&language=ko-ko"; //json
	           
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
	       
	            
	            JSONObject jsonObject = (JSONObject)JSONValue.parse(response.toString());
	            System.out.println("완료");
	            
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
	            if(jsonArray.size()>7) {
	            	//a=jsonArray.size();//전부받기
	            	a=7;
	            }else {
	            	a=jsonArray.size();
	            }
	            for(int i=0;i<a;i++) {
	            	List<String> placeinfo = new ArrayList<String>();
	               	
	               	jsonObject =(JSONObject)JSONValue.parse(jsonArray.get(i).toString());
	               	
	               	
	               	placeinfo.add(jsonObject.get("name").toString());
	               	placeinfo.add(jsonObject.get("vicinity").toString());
	               	               	               	
	               	jsonObject =(JSONObject)JSONValue.parse(jsonObject.get("geometry").toString());
	               	
	               	System.out.println("===================좌표만========================");
	               	location = (JSONObject)JSONValue.parse(jsonObject.get("location").toString());
	               	
	               	placeinfo.add(location.get("lng").toString());
	               	placeinfo.add(location.get("lat").toString());
	               	
	               	System.out.println(location.get("lng"));
	               	System.out.println(location.get("lat"));
	               	System.out.println("===================좌표만========================");
	               	
	               	
	             
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
	
	
	@RequestMapping(value = "json/ARPlaceSearch")
	
	public JSONObject ARPlaceSearch(HttpServletRequest request) throws Exception {
	    
			System.out.println("들어왔나?========================");
			System.out.println(request.getParameter("lng"));
			System.out.println(request.getParameter("lat"));
			System.out.println(request.getParameter("type"));
			System.out.println("들어왔나?========================111");
			
			String lat = request.getParameter("lat");
			String lng = request.getParameter("lng");
			String type = request.getParameter("type");
			
			System.out.println("변환완료:"+lat+":::"+lng+"::"+type);
		
	        String apiURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+lat+","+lng+"&radius=1000&type="+type+"&keyword=&key=AIzaSyDtz18kZbobsZXEZs7SyXN_2XBgP9kB39k&language=ko-ko"; //json
	       
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
	   
	        
	        JSONObject jsonObject = (JSONObject)JSONValue.parse(response.toString());
	        System.out.println("완료");
	 
	        
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
	        /*if(jsonArray.size()>=5) {
	        	a=jsonArray.size();
	        }else {
	        	a=jsonArray.size();
	        }*/
	        if(jsonArray.size()>7) {
            	//a=jsonArray.size();//전부받기
            	a=7;
            }else {
            	a=jsonArray.size();
            }
	        
	        for(int i=0;i<a;i++) {
	        	List<String> placeinfo = new ArrayList<String>();
	      
	           	jsonObject =(JSONObject)JSONValue.parse(jsonArray.get(i).toString());
	      
	           	placeinfo.add(jsonObject.get("name").toString());
	           	placeinfo.add(jsonObject.get("vicinity").toString());
	           	               	               	
	           	jsonObject =(JSONObject)JSONValue.parse(jsonObject.get("geometry").toString());
	    
	           	
	           	System.out.println("===================좌표만========================");
	           	location = (JSONObject)JSONValue.parse(jsonObject.get("location").toString());
	           	
	           	placeinfo.add(location.get("lng").toString());
	           	placeinfo.add(location.get("lat").toString());
	           	
	           	System.out.println(location.get("lng"));
	           	System.out.println(location.get("lat"));
	           	System.out.println("===================좌표만========================");
	           	
	  
	           	jobj.put("name", placeinfo.get(0));
	           	jobj.put("place", placeinfo.get(1));
	           	jobj.put("lng", placeinfo.get(2));
	           	jobj.put("lat", placeinfo.get(3));
	           	
	           	jobjlast.put("placeinfo", jobj);
	           	
	           	System.out.println(jobjlast.toString());
	           	System.out.println("==================================1");
	
	           	location = (JSONObject)JSONValue.parse(jobjlast.toString());
	           	jsoninfo.add(location);
	            
	        	}
	        
	        System.out.println(jsoninfo.toString());
	        System.out.println("==================================end");
	        pinfolast.put("all", jsoninfo);
	        System.out.println(pinfolast.toString());
	        System.out.println("총 :"+a+" 개전송");
	        System.out.println("==================================endlast");
	         
	               
	        return pinfolast;
	    
	}
	
	@RequestMapping(value = "json/ARDistance")
	public JSONObject ARDistance(HttpServletRequest request) throws Exception{
		
		System.out.println("////////////////googleDistance Start /////////////////////////////");
		System.out.println(request.getParameter("lng"));
		System.out.println(request.getParameter("lat"));
		if(request.getParameter("lng")!=null) {
		String clat=request.getParameter("lat");
		String clng=request.getParameter("lng");
		}else {
		String clat="37.494541";
		String clng="127.027969";	
		}
		
		
		String apiURL = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=37.4945297241211,127.028060913086&destinations=37.49026070000001,127.0203404&mode=transit&language=ko-ko&key=AIzaSyAyJUiL4ifUuucPRfc1SDXbO1kv-ci_CtE"; //json
		
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
        
        
        JSONObject jobj = new JSONObject();
        jobj = (JSONObject)JSONValue.parse(response.toString());
        System.out.println(jobj.get("rows"));
        String temp1=((JSONArray)jobj.get("destination_addresses")).get(0).toString();
        String temp2 = ((JSONObject)((JSONObject)((JSONArray)((JSONObject)((JSONArray)jobj.get("rows")).get(0)).get("elements")).get(0)).get("duration")).get("text").toString();
        String temp3 = ((JSONObject)((JSONObject)((JSONArray)((JSONObject)((JSONArray)jobj.get("rows")).get(0)).get("elements")).get(0)).get("distance")).get("value").toString();
        System.out.println(((JSONObject)((JSONObject)((JSONArray)((JSONObject)((JSONArray)jobj.get("rows")).get(0)).get("elements")).get(0)).get("duration")).get("text"));
        System.out.println(((JSONObject)((JSONObject)((JSONArray)((JSONObject)((JSONArray)jobj.get("rows")).get(0)).get("elements")).get(0)).get("distance")).get("text"));
		
      
                
        JSONObject resjobj = new JSONObject();
   
        System.out.println(1);
        resjobj.put("address", temp1);
        System.out.println(2);
        resjobj.put("mins", temp2);
        System.out.println(3);
        resjobj.put("distance", temp3);
        System.out.println(4);
		
        System.out.println(resjobj.toString());
        
		return resjobj;
	}
	
	
	@RequestMapping(value = "json/addChatbot")
	public JSONObject addChatbot(@RequestBody ChatBot chatBot) throws Exception{
		
		System.out.println(chatBot);
		quickService.addChatBot(chatBot);
		System.out.println("add 완료");
		
		
		ChatBot chatBot2 = quickService.getCurrentChatBot();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("chatBot", chatBot2);
		return jsonObject;
	}
	
	@RequestMapping(value = "json/getChatbot/{questionNo}")
	public JSONObject getChatbot(@PathVariable int questionNo) throws Exception{
		
		System.out.println(questionNo);
		ChatBot chatBot = quickService.getChatBot(questionNo);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("chatBot", chatBot);
		
		return jsonObject;
	}
	
	@RequestMapping(value = "json/getCurrentChatBot")
	public JSONObject getChatbot() throws Exception{
		
		ChatBot chatBot = quickService.getCurrentChatBot();
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("chatBot", chatBot);
		return jsonObject;
	}
	
	@RequestMapping(value = "json/updateChatbot")
	public JSONObject updateChatbot(@RequestBody ChatBot chatBot) throws Exception{
		
		System.out.println(chatBot);
		quickService.updateChatBot(chatBot);
		System.out.println("update 완료");
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("chatBot", chatBot);
		return jsonObject;
	}
	
	@RequestMapping(value = "json/updateConnect/{state}")
	public JSONObject updateConnect(@PathVariable int state) throws Exception{
		String answer = "";
		
		ChatBot chatBot = new ChatBot();
		

		if(state==1 || state==0) { //상담사가 부재중으로 설정했다면
			answer = "현재 상담사가 부재중입니다. 상담 가능시간은 14:00~16:00시 입니다.";
			chatBot = quickService.getCurrentChatBot();
			chatBot.setAnswer(answer);
			chatBot.setDeleteFlag("1");
			chatBot.setConnectAble("1");
		}
		if(state==2 || state==4) { //상담사 연결 가능상태라면
			answer = "아래 링크를 통해 접속해 주십시요. 응답시간은 10분 내외입니다.<button class=\"sty\" id=\"start\">상담시작</button>";
			chatBot = quickService.getCurrentChatBot();
			chatBot.setAnswer(answer);
			chatBot.setDeleteFlag("0");
			chatBot.setConnectAble("2");
		}
		if(state==3) { //상담사가 상담중이라면
			answer = "현재 상담사가 상담중입니다. 잠시후에 다시 신청해주세요";
			chatBot = quickService.getCurrentChatBot();
			chatBot.setAnswer(answer);
			chatBot.setConnectAble("2");
		}
		
		System.out.println("업데이트된 챗봇 ; " + chatBot);
		quickService.updateConnect(chatBot);
		System.out.println("update 완료");
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("chatBot", chatBot);
		return jsonObject;
	}
	
	@RequestMapping(value = "json/deleteChatbot")
	public JSONObject deleteChatbot(@RequestBody ChatBot chatBot) throws Exception{
		
		System.out.println(chatBot);
		quickService.deleteChatBot(chatBot.getQuestionNo());
		System.out.println("delete 완료");
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("chatBot", chatBot);
		return jsonObject;
	}
	
	@RequestMapping(value = "json/getChatBotList")
	public JSONObject getChatBotList(HttpSession session) throws Exception {
		System.out.println("json/getChatBotList");
		
		User user = new User();
		if (session.getAttribute("user")==null) {
			user.setRole("user");
		}else {
			user = (User)session.getAttribute("user");
		}
		
		List<ChatBot> list = quickService.getChatBotList(user);
		System.out.println("list확인 : " + list);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("list", list);
		
		return jsonObject;
	}
	
	@RequestMapping(value = "json/getRateChatBot")
	public JSONObject getRateChatBot(HttpSession session) throws Exception {
		System.out.println("json/getRateChatBot");
		
		User user = new User();
		if (session.getAttribute("user")==null) {
			user.setRole("admin");
		}else {
			user = (User)session.getAttribute("user");
		}
		
		List<ChatBot> list = quickService.getChatBotList(user);
		System.out.println("list확인 : " + list);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("list", list);
		
		return jsonObject;
	}
}
