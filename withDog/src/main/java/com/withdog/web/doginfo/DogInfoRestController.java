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
		System.out.println("kind��? " + kind);
		User sessionUser = (User)session.getAttribute("user");
		
//		if((dogInfo.getRecommendCondition().getRecommendCondition()).equals("0")) {
//		
//		
//	}
		if(sessionUser==null) {
		}else {
		
		DogInfo dogInfo = dogInfoService.getDogInfo(dogInfoNo,sessionUser);
		RecommendInfo recommendInfo = new RecommendInfo();
		if(dogInfo.getRecommendCondition()==null) { //��õ�̰� ����õ�̰� �ƹ��͵� �ȵ��ִ� ����.
			if(kind.equals("0")) { // ��õ��ư�� ������ ��
				System.out.println("��õ�� ������ŵ�ϴ�.");
				int recom = (Integer.parseInt(dogInfo.getRecommended()))+1;
				System.out.println("��õ �� : " + recom);
				dogInfo.setRecommended(Integer.toString(recom));
				dogInfoService.updateRecommend(dogInfo);
				//===================================Start ��õ ������ ���
				recommendInfo.setUser(sessionUser);
				recommendInfo.setDogInfo(dogInfo);
				recommendInfo.setRecommendCondition("0");//��õ
				dogInfoService.addRecommendInfo(recommendInfo);
				//===================================end ��õ ������ ���
			}else { //����õ ��ư�� ������ ��
				System.out.println("����õ�� ������ŵ�ϴ�.");
				int notRecom = (Integer.parseInt(dogInfo.getNotRecommended()))+1;
				System.out.println("����õ �� : " + notRecom);
				dogInfo.setNotRecommended(Integer.toString(notRecom));
				dogInfoService.updateRecommend(dogInfo);
				//===================================Start ��õ ������ ���
				recommendInfo.setUser(sessionUser);
				recommendInfo.setDogInfo(dogInfo);
				recommendInfo.setRecommendCondition("1");//����õ
				dogInfoService.addRecommendInfo(recommendInfo);
				//===================================end ��õ ������ ���
			}
		}else if((dogInfo.getRecommendCondition().getRecommendCondition()).equals("0")){ // ��õ������ ����
			if(kind.equals("0")) { // ��õ��ư�� ������ ��
				System.out.println("��õ ������ ���´ϱ� ��õ�� ���");
				dogInfoService.deleteRecommendInfo(dogInfoNo, sessionUser); // ��õ���� ����
				int recom = (Integer.parseInt(dogInfo.getRecommended()))-1;
				System.out.println("��õ �� : " + recom);
				dogInfo.setRecommended(Integer.toString(recom));
				dogInfoService.updateRecommend(dogInfo);
			}else { //����õ ��ư ������ ��
				System.out.println("��õ �����µ� ����õ�� ������");
			}
		}else if((dogInfo.getRecommendCondition().getRecommendCondition()).equals("1")){ // ����õ������ ����
			if(kind.equals("0")) { // ��õ��ư�� ������ ��
				System.out.println("����õ �����µ� ��õ�� ������");
			}else { //����õ ��ư ������ ��
				System.out.println("����õ ������ ���´ϱ� ����õ�� ���");
				dogInfoService.deleteRecommendInfo(dogInfoNo, sessionUser); // ��õ���� ����
				int notRecom = (Integer.parseInt(dogInfo.getNotRecommended()))-1;
				System.out.println("����õ �� : " + notRecom);
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
