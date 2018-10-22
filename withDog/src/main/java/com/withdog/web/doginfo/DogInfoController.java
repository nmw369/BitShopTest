package com.withdog.web.doginfo;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.doginfo.DogInfoService;
import com.withdog.service.domain.DogInfo;
import com.withdog.service.domain.User;

@Controller
@RequestMapping("/dogInfo/*")
public class DogInfoController {

	@Autowired
	@Qualifier("dogInfoServiceImpl")
	private DogInfoService dogInfoService;

	public DogInfoController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['dogInfoPageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	@Value("#{commonProperties['dogInfofilePath']}")
	String dogInfofilePath;
	

	@RequestMapping(value = "addDogInfo", method = RequestMethod.GET)
	public String addDogInfo() throws Exception {
		System.out.println("/addDogInfo : GET");
		return "forward:/community/addDogInfo.jsp";
	}

	@RequestMapping(value = "addDogInfo", method = RequestMethod.POST)
	public String addDogInfo(@ModelAttribute("dogInfo") DogInfo dogInfo, @RequestParam("file") MultipartFile file, HttpSession session) throws Exception{
		System.out.println("/addDogInfo : POST");
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = new Date();
		System.out.println(dateFormat.format(date));
		/*if(file[0].getSize()==0) {
			System.out.println("파일비었음");
			dogInfo.setDogInfoImage("이미지없음");
		}else {
			for (MultipartFile multipartFile : file) {
				if (multipartFile.getOriginalFilename().equals("") || multipartFile == null) {
					break;
				}
				a += (dateFormat.format(date)+multipartFile.getOriginalFilename()) + (multipartFile.getOriginalFilename().equals("") ? "" : ",");
			
				System.out.println("저장된 파일들 : " + multipartFile.getOriginalFilename());
				File f = new File(dogInfofilePath + (dateFormat.format(date)+multipartFile.getOriginalFilename()).toString());
				System.out.println(dogInfofilePath);
					
				multipartFile.transferTo(f); // 위의 경로에 파일 저장
			}
			dogInfo.setDogInfoImage(a.substring(0, a.length()-1));
		}
		Thread.sleep(2500);*/
		System.out.println("저장된 파일 : " + file.getOriginalFilename());
		File f = new File(dogInfofilePath + (dateFormat.format(date)+file.getOriginalFilename()).toString());
		System.out.println(dogInfofilePath);
		file.transferTo(f); // 위의 경로에 파일 저장
		dogInfo.setDogInfoImage(dateFormat.format(date)+file.getOriginalFilename());
	
		System.out.println(dogInfo);
		User user = (User)session.getAttribute("user");
		dogInfo.setUser(user);
		
		dogInfoService.addDogInfo(dogInfo);
		System.out.println("add 완료");
		
		return "forward:/community/addDogInfoView.jsp";
	}
	
	@RequestMapping(value = "listDogInfo")
	public String getDogInfoList(@ModelAttribute("search") Search search, Model model, HttpSession session) throws Exception {
		System.out.println("/listDogInfo");
		
		User user = new User();
		
		if(session.getAttribute("user")==null) {
			user.setRole("user");
		}else {
			user = (User)session.getAttribute("user");
		}

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println("유저 : " + user);
		Map<String, Object> map = dogInfoService.getDogInfoList(search,user);
		System.out.println("맵확인 : " + map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);
		System.out.println("리스트 넘기기전 리스트 확인 : " + map.get("list"));

		model.addAttribute("list", map.get("list"));
		model.addAttribute("sessionUser", user);
		model.addAttribute("topicCount", map.get("topicCount"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search); // 생략가능
		
		
		return "forward:/community/listDogInfo.jsp";
	}
	
	@RequestMapping(value = "getDogInfo", method = RequestMethod.GET)
	public String getDogInfo(@RequestParam("dogInfoNo") int dogInfoNo, Model model, HttpServletResponse response,
			HttpSession session) throws Exception {
		System.out.println("/getDogInfo : GET");
		// Business Logic
		User sessionUser = (User)session.getAttribute("user");
		DogInfo dogInfo = dogInfoService.getDogInfo(dogInfoNo,sessionUser);
		System.out.println("조회 시 도그인포 : " + dogInfoNo);
		////조회수 증가
		int viewCount = Integer.parseInt(dogInfo.getViewCount());
		viewCount++;
		String viewCount2 = Integer.toString(viewCount);
		dogInfo.setViewCount(viewCount2);
		dogInfoService.updateViewCount(dogInfo);
		////// end 조회수 증가

		model.addAttribute("dogInfo", dogInfo);
		System.out.println("get하기전 도메인확인 : " + dogInfo);

		return "forward:/community/getDogInfo.jsp";
	}
	
	@RequestMapping(value = "updateDogInfo", method = RequestMethod.GET)
	public String updateDogInfo(@RequestParam("dogInfoNo") int dogInfoNo, Model model,HttpSession session) throws Exception {

		System.out.println("/updateDogInfoView : GET");
		// Business Logic
		User sessionUser = (User)session.getAttribute("user");
		DogInfo dogInfo = dogInfoService.getDogInfo(dogInfoNo,sessionUser);
		// Model 과 View 연결
		model.addAttribute("dogInfo", dogInfo);

		return "forward:/community/updateDogInfo.jsp";
	}
	
	@RequestMapping(value = "deleteDogInfo", method = RequestMethod.GET)
	public String deleteDogInfo(HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("/deleteDogInfo : GET");
		// Business Logic
		int dogInfoNo = Integer.parseInt(request.getParameter("dogInfoNo"));
		User sessionUser = (User)session.getAttribute("user");
		DogInfo dogInfo = dogInfoService.getDogInfo(dogInfoNo,sessionUser);
		dogInfo.setDeleteFlag("1");
		dogInfoService.deleteDogInfo(dogInfo);
		
		// Model 과 View 연결
		
		return "forward:/dogInfo/listDogInfo";
	}

	@RequestMapping(value = "updateDogInfo", method = RequestMethod.POST)
	public String updateDogInfo(@ModelAttribute("dogInfo") DogInfo dogInfo,HttpSession session, Model model, @RequestParam("file") MultipartFile file) throws Exception {
		System.out.println("/updateDogInfo : POST");
		System.out.println("업데이트 도그인포 : " + dogInfo);
		User sessionUser = (User)session.getAttribute("user");
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = new Date();
		System.out.println(dateFormat.format(date));
		
		if (file.getSize()!=0) {
			System.out.println("업데이트 시 이미지 수정 함");
				System.out.println("저장된 파일들 : " + file.getOriginalFilename());
				File f = new File(dogInfofilePath + (dateFormat.format(date)+file.getOriginalFilename()).toString());
				System.out.println(dogInfofilePath);
				
				file.transferTo(f); // 위의 경로에 파일 저장
				dogInfo.setDogInfoImage(dateFormat.format(date)+file.getOriginalFilename());
		}else {
			System.out.println("업데이트 시 이미지 수정 안함");
			dogInfo.setDogInfoImage((dogInfoService.getDogInfo(dogInfo.getDogInfoNo(),sessionUser)).getDogInfoImage());
		}
		Thread.sleep(2500);
		System.out.println("업데이트 전 dog Info : " + dogInfo);
		
		dogInfoService.updateDogInfo(dogInfo);

		return "redirect:/dogInfo/getDogInfo?dogInfoNo=" + dogInfo.getDogInfoNo();
	}

}
