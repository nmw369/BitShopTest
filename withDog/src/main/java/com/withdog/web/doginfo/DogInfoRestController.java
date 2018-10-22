package com.withdog.web.doginfo;

import java.nio.file.Path;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.multipart.MultipartFile;

import com.withdog.service.doginfo.DogInfoService;
import com.withdog.service.domain.DogInfo;
import com.withdog.service.domain.RecommendInfo;
import com.withdog.service.domain.User;

@RestController
@RequestMapping("/dogInfo/*")
public class DogInfoRestController {
	
	@Autowired
	@Qualifier("dogInfoServiceImpl")
	private DogInfoService dogInfoService;
	
	public DogInfoRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value = "json/updateRecommended/{dogInfoNo}")
	public JSONObject updateRecommended(@PathVariable int dogInfoNo, @RequestParam("kind") String kind, HttpSession session) throws Exception{
		System.out.println("json/updateRecommended");
		System.out.println("kind는? " + kind);
		User sessionUser = (User)session.getAttribute("user");
		
//		if((dogInfo.getRecommendCondition().getRecommendCondition()).equals("0")) {
//		
//		
//	}
		if(sessionUser==null) {
		}else {
		
		DogInfo dogInfo = dogInfoService.getDogInfo(dogInfoNo,sessionUser);
		RecommendInfo recommendInfo = new RecommendInfo();
		if(dogInfo.getRecommendCondition()==null) { //추천이고 비추천이고 아무것도 안돼있는 상태.
			if(kind.equals("0")) { // 추천버튼을 눌렀을 시
				System.out.println("추천수 증가시킵니다.");
				int recom = (Integer.parseInt(dogInfo.getRecommended()))+1;
				System.out.println("추천 수 : " + recom);
				dogInfo.setRecommended(Integer.toString(recom));
				dogInfoService.updateRecommend(dogInfo);
				//===================================Start 추천 정보에 등록
				recommendInfo.setUser(sessionUser);
				recommendInfo.setDogInfo(dogInfo);
				recommendInfo.setRecommendCondition("0");//추천
				dogInfoService.addRecommendInfo(recommendInfo);
				//===================================end 추천 정보에 등록
			}else { //비추천 버튼을 눌렀을 시
				System.out.println("비추천수 증가시킵니다.");
				int notRecom = (Integer.parseInt(dogInfo.getNotRecommended()))+1;
				System.out.println("비추천 수 : " + notRecom);
				dogInfo.setNotRecommended(Integer.toString(notRecom));
				dogInfoService.updateRecommend(dogInfo);
				//===================================Start 추천 정보에 등록
				recommendInfo.setUser(sessionUser);
				recommendInfo.setDogInfo(dogInfo);
				recommendInfo.setRecommendCondition("1");//비추천
				dogInfoService.addRecommendInfo(recommendInfo);
				//===================================end 추천 정보에 등록
			}
		}else if((dogInfo.getRecommendCondition().getRecommendCondition()).equals("0")){ // 추천눌렀던 상태
			if(kind.equals("0")) { // 추천버튼을 눌렀을 시
				System.out.println("추천 눌렀던 상태니깐 추천을 취소");
				dogInfoService.deleteRecommendInfo(dogInfoNo, sessionUser); // 추천정보 삭제
				int recom = (Integer.parseInt(dogInfo.getRecommended()))-1;
				System.out.println("추천 수 : " + recom);
				dogInfo.setRecommended(Integer.toString(recom));
				dogInfoService.updateRecommend(dogInfo);
			}else { //비추천 버튼 눌렀을 시
				System.out.println("추천 눌렀는데 비추천도 눌렀음");
			}
		}else if((dogInfo.getRecommendCondition().getRecommendCondition()).equals("1")){ // 비추천눌렀던 상태
			if(kind.equals("0")) { // 추천버튼을 눌렀을 시
				System.out.println("비추천 눌렀는데 추천도 눌렀음");
			}else { //비추천 버튼 눌렀을 시
				System.out.println("비추천 눌렀던 상태니깐 비추천을 취소");
				dogInfoService.deleteRecommendInfo(dogInfoNo, sessionUser); // 추천정보 삭제
				int notRecom = (Integer.parseInt(dogInfo.getNotRecommended()))-1;
				System.out.println("비추천 수 : " + notRecom);
				dogInfo.setNotRecommended(Integer.toString(notRecom));
				dogInfoService.updateRecommend(dogInfo);
			}
		}
	}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("dogInfo", dogInfoService.getDogInfo(dogInfoNo,sessionUser));
		
		return jsonObject;
	}
	
	
	@RequestMapping(value = "json/fileEncoding")
	public String fileEncoding(MultipartFile file) throws Exception {
		System.out.println(file);
		System.out.println(file.getOriginalFilename());
		return null;
		
		
	}

}
