
package com.withdog.web.common;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.withdog.service.common.CommonService;
import com.withdog.service.domain.DogBreedDic;
import com.withdog.service.domain.PushToken;
import com.withdog.service.domain.User;

@RestController
@RequestMapping("/common/*")
public class CommonRestController {
	
	@Autowired
	@Qualifier("commonServiceImpl")
	private CommonService commonService;
	
	public CommonRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pointpageSize']}")
	int pageSize;
	
	@Value("#{commonProperties['sommernoteFilePath']}")
	String path;
	
	@RequestMapping(value="json/imageUpload")
	public void  imageUpload(MultipartFile file,HttpServletResponse response) throws Exception{
		System.out.println("jsonimageStart");
		
		/*response.setContentType("text/html;charset=utf-8");*/
		PrintWriter out = response.getWriter();
		System.out.println(1);
		String fileName= file.getOriginalFilename();
		
		System.out.println(fileName);
		File fileSave = new File(path+fileName);
		file.transferTo(fileSave);
		
		Thread.sleep(3000);
		
		System.out.println(2);
		response.setContentType("application/json");
		/*out.println("../images/sommernote/"+fileName);*/
		String imagePath ="../images/sommernote/"+fileName;
		System.out.println(3);
			
		JSONObject jobj = new JSONObject();
		jobj.put("url", imagePath);
		
		System.out.println(jobj);
		
		
		
		out.print(jobj.toJSONString());
		
		/*return jobj;*/
	
	}
	
	@RequestMapping(value = "json/addTokenAndroid")
	public void addTokenAndroid(HttpServletRequest req) throws Exception{
		String deviceId = req.getParameter("deviceId");
		String token = req.getParameter("token");
		String userId = req.getParameter("userId");
		
		System.out.println("deviceId : "+deviceId);
		System.out.println("token : "+token);
		System.out.println("userId : "+userId);
		
		User user = new User();
		user.setUserId(userId);
		
		PushToken pushToken = new PushToken();
		pushToken.setDeviceId(deviceId);
		pushToken.setToken(token);
		pushToken.setUser(user);
		
		commonService.deletePushToken(deviceId);
		commonService.addPushToken(pushToken);
		
		//return null;
	}
	
	@RequestMapping(value = "json/deleteTokenAndroid")
	public void deleteTokenAndroid(HttpServletRequest req) throws Exception{
		String deviceId = req.getParameter("deviceId");
		
		System.out.println("deviceId : "+deviceId);
		
		commonService.deletePushToken(deviceId);
		//return null;
	}

}
