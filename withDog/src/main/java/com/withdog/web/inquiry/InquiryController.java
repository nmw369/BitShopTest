package com.withdog.web.inquiry;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.servlet.ModelAndView;

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.domain.Inquiry;
import com.withdog.service.domain.Product;
import com.withdog.service.domain.User;
import com.withdog.service.inquiry.InquiryService;

@Controller
@RequestMapping("/inquiry/*")
public class InquiryController {
	
	@Autowired
	@Qualifier("inquiryServiceImpl")
	private InquiryService inquiryService;
	
	public InquiryController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping(value="updateInquiry", method=RequestMethod.GET)
	public String updateInquiry(@RequestParam("inquiryNo")int inquiryNo, Inquiry inquiry, @RequestParam("inquiryContent") String inquiryContent) throws Exception{ 
		
		System.out.println("/inquiry/updateInquiry : GET");
		
		inquiry.setInquiryNo(inquiryNo);
		inquiry.setInquiryContent(inquiryContent);
		
		inquiryService.updateInquiry(inquiry);
		
		return "forward:/inquiry/getMyInquiryList";
	}

	@RequestMapping(value="deleteInquiry", method=RequestMethod.GET)
	public String deleteInquiry(@RequestParam("inquiryNo") int inquiryNo) throws Exception{ 
		
		System.out.println("/inquiry/deleteInquiry : GET");

		System.out.println("������ ���ǹ�ȣ : "+inquiryNo);
		//inquiryService.deleteInquiry(inquiryNo);
		
		return "forward:/inquiry/getMyInquiryList";
	}
	
	@RequestMapping(value="updateInquiryReplyAdmin")
	public String updateInquiryReplyAdmin(@RequestParam("inquiryNo") int inquiryNo,Model model, Inquiry inquiry, @RequestParam("inquiryReply") String inquiryReply) throws Exception{ 
		
		System.out.println("/inquiry/updateInquiryReplyAdmin : POST");
		
		 System.out.println("��Ʈ�ѷ����� Ȯ��" + inquiry);
		 inquiry.setInquiryNo(inquiryNo);
		 inquiry.setInquiryReply(inquiryReply);
		
		inquiryService.updateInquiryReplyAdmin(inquiry);
		
		// Model �� View ����
//		model.addAttribute("inquiry", inquiry);
		
		return "forward:/inquiry/getInquiryListAdmin";
	}
	
	//����Ʈ��Ʈ�ѷ���
	@RequestMapping(value="getInquiryList", method=RequestMethod.GET)
	public String getInquiryList(@ModelAttribute("search") Search search, @RequestParam("prodNo") int prodNo, Model model) throws Exception{ 
		
		System.out.println("/inquiry/getInquiryList : GET");
		System.out.println("���Ǹ���Ʈ ��� ��ǰ��ȣ : "+prodNo);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = inquiryService.getInquiryList(search, prodNo);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		
		return "forward:/inquiry/getMyInquiryList";
	}
	
	
	@RequestMapping(value="getMyInquiryList", method=RequestMethod.GET)
	public String getMyInquiryList(@ModelAttribute("search") Search search, HttpSession session, Model model) throws Exception{ 
		
		System.out.println("/inquiry/getMyInquiryList : GET");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		User user = (User)session.getAttribute("user");
		String userId = user.getUserId();
		
		System.out.println("�����Ǹ���Ʈ �������̵� : "+ userId);

		Map<String, Object> map = inquiryService.getMyInquiryList(search, userId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		
		return "forward:/mypage/listMyInquiry.jsp";
	}
	
	
	
	@RequestMapping(value="getInquiryListAdmin", method=RequestMethod.GET)
	public String getInquiryListAdmin(@ModelAttribute("search") Search search, Model model) throws Exception{ 
		
		System.out.println("/inquiry/getInquiryListAdmin : GET");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = inquiryService.getInquiryListAdmin(search);
		
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		
		return "forward:/admin/listInquiryAdmin.jsp";
	}
}
