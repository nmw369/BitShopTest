package com.withdog.web.afterash;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.withdog.service.afterash.AfterAshService;
import com.withdog.service.domain.AfterAsh;
import com.withdog.service.domain.DogInfo;
import com.withdog.service.domain.User;

@Controller
@RequestMapping("/afterAsh/*")
public class AfterAshController {
	
	@Autowired
	@Qualifier("afterAshServiceImpl")
	private AfterAshService afterAshService;
	
	public AfterAshController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	@Value("#{commonProperties['dogInfofilePath']}")
	String dogInfofilePath;
	
	@RequestMapping(value = "addAfterAsh", method = RequestMethod.GET)
	public String addAfterAsh() throws Exception {
		System.out.println("/addAfterAsh : GET");

		return "forward:/community/addAfterASH.jsp";
	}

	@RequestMapping(value = "addAfterAsh", method = RequestMethod.POST)
	public String addAfterAsh(@ModelAttribute("afterAsh") AfterAsh afterAsh,@RequestParam("file") MultipartFile[] file, HttpSession session) throws Exception{
		System.out.println("/addAfterAsh : POST");
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = new Date();
		System.out.println(dateFormat.format(date));
		
		String a = "";
		
		if(file[0].getSize()==0) {
			System.out.println("파일비었음");
			afterAsh.setAfterASHImage("");
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
			afterAsh.setAfterASHImage(a.substring(0, a.length()-1));
		}
		Thread.sleep(3000);
	
		System.out.println(afterAsh);
		User user = (User)session.getAttribute("user");
		afterAsh.setUser(user);
		
		afterAshService.addAfterAsh(afterAsh);
		
		return "forward:/community/addAfterASHView.jsp";
	}
	
	
	@RequestMapping(value = "listAfterAsh")
	public String getAfterAshList(@ModelAttribute("search") Search search, Model model, HttpSession session) throws Exception {
		System.out.println("/listAfterAsh");
		
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

		Map<String, Object> map = afterAshService.getAfterAshList(search,user);
		System.out.println("맵확인 : " + map);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);
		System.out.println("리스트 넘기기전 리스트 확인 : " + map.get("list"));
		
		List<AfterAsh> listByViewCount = afterAshService.getAfterAshListByViewCount(); //조회수 순으로 가져온 리스트

		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search); // 생략가능
		model.addAttribute("listByViewCount", listByViewCount); // 생략가능
		
		
		return "forward:/community/listAfterASH.jsp";
	}
	
	@RequestMapping(value = "getAfterAsh", method = RequestMethod.GET)
	public String getAfterAsh(@RequestParam("afterASHNo") int afterASHNo, Model model, HttpServletResponse response,
			HttpSession session) throws Exception {
		System.out.println("/getAfterAsh : GET");
		// Business Logic
		AfterAsh afterAsh = afterAshService.getAfterAsh(afterASHNo);
		model.addAttribute("afterAsh", afterAsh);
		System.out.println("get하기전 도메인확인 : " + afterAsh);

		return "forward:/community/getAfterASH.jsp";
	}
	
	@RequestMapping(value = "updateAfterAsh", method = RequestMethod.GET)
	public String updateAfterAsh(@RequestParam("afterASHNo") int afterASHNo, Model model,HttpSession session) throws Exception {

		System.out.println("/updateAfterAsh : GET");
		// Business Logic
		AfterAsh afterAsh = afterAshService.getAfterAsh(afterASHNo);
		// Model 과 View 연결
		model.addAttribute("afterAsh", afterAsh);

		return "forward:/community/updateAfterASH.jsp";
	}
	
	@RequestMapping(value = "updateAfterAsh", method = RequestMethod.POST)
	public String updateAfterAsh(@ModelAttribute("afterAsh") AfterAsh afterAsh,@RequestParam("file") MultipartFile[] file, HttpSession session) throws Exception{
		System.out.println("/updateAfterAsh : POST");
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = new Date();
		System.out.println(dateFormat.format(date));
		
		String a = "";
		
		if (file[0].getSize()!=0) {
			System.out.println("업데이트 시 이미지 수정 함");
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
			afterAsh.setAfterASHImage(a.substring(0, a.length()-1));
		}else {
			String image = afterAshService.getAfterAsh(afterAsh.getAfterASHNo()).getAfterASHImage();
			System.out.println("업데이트 시 이미지 수정 안함");
			afterAsh.setAfterASHImage(image!=null?image:"noImage");
		}
		Thread.sleep(3000);
	
		System.out.println(afterAsh);
		if (afterAsh.getAfterASHVideo()==null) {
			afterAsh.setAfterASHVideo("notVideo");
		}
		afterAshService.updateAfterAsh(afterAsh);
		
		System.out.println("여까진?");
		return "redirect:/afterAsh/getAfterAsh?afterASHNo=" + afterAsh.getAfterASHNo();
	}
	
	@RequestMapping(value = "deleteAfterAsh", method = RequestMethod.GET)
	public String deleteAfterAsh(HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("/deleteAfterAsh : GET");
		// Business Logic
		int afterAshNo = Integer.parseInt(request.getParameter("afterAshNo"));
		AfterAsh afterAsh = afterAshService.getAfterAsh(afterAshNo);
		afterAsh.setDeleteFlag("1");
		afterAshService.deleteAfterAsh(afterAsh);
		
		
		return "forward:/afterAsh/listAfterAsh";
	}

}
