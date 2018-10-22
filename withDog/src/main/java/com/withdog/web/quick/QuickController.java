package com.withdog.web.quick;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.domain.ChatBot;
import com.withdog.service.domain.DogInfo;
import com.withdog.service.domain.User;
import com.withdog.service.quick.QuickService;

@Controller
@RequestMapping("/quick/*")
public class QuickController {
	
	@Autowired
	@Qualifier("quickServiceImpl")
	private QuickService quickService;
	
	public QuickController() {
		System.out.println(this.getClass());
	}
	@RequestMapping(value="addressSearch")
	public String addressSearch(HttpServletRequest request)throws Exception {
		
		String careAddr = request.getParameter("careAddr");
		request.setAttribute("careAddr", careAddr);
		System.out.println("지도확인");
		System.out.println(careAddr);
			
		return "forward:/test/addressSearch.jsp";
	}
	
	@RequestMapping(value="GeoMap")
	public String GeoNavigation(HttpServletRequest request)throws Exception {
		
		String lat = request.getParameter("lat");
		String lng = request.getParameter("lng");
		request.setAttribute("lat", lat);
		request.setAttribute("lng", lng);
			
		return "forward:/test/GoogleMapGeo.jsp";
	}
	
	
	@RequestMapping(value="ARMap")
	public String ARNavigation()throws Exception {
		
			
		return "forward:/quick/ARMap.jsp";
	}
	
	
	@RequestMapping(value="ARGeo")
	public String ARGeo(HttpServletRequest request)throws Exception {
		
			System.out.println("/////////////////////////////ARGeo Start");
			if(request.toString()!=null) {
			System.out.println(request.toString());
			System.out.println(request.getParameter("lat"));
			System.out.println(request.getParameter("lng"));
			
			
			String lat = request.getParameter("lat");
			String lng = request.getParameter("lng");
			
			
			
			request.setAttribute("lat", lat);
			request.setAttribute("lng", lng);
			
			}
			
			
		return "forward:/quick/GoogleMapGeo.jsp";
	}
	
	
	@RequestMapping(value="ARNavigation")
	public String ARNavigation(HttpServletRequest request)throws Exception {
		
			System.out.println("/////////////////////////////ARNavigation Start");
			if(request.toString()!=null) {
			System.out.println(request.toString());
			System.out.println(request.getParameter("lat"));
			System.out.println(request.getParameter("lng"));
			System.out.println(request.getParameter("type"));
			
			String lat = request.getParameter("lat");
			String lng = request.getParameter("lng");
			String type = request.getParameter("type");
			
			
			request.setAttribute("lat", lat);
			request.setAttribute("lng", lng);
			request.setAttribute("type", type);
			}
			
			
		return "forward:/quick/GoogleMapSearch.jsp";
	}
	
	@RequestMapping(value = "getChatBotList")
	public String getChatBotList(@ModelAttribute("chatBot") ChatBot chatBot, Model model, HttpSession session) throws Exception {
		System.out.println("/getChatBotList");
		
		User user = (User)session.getAttribute("user");
		
		List<ChatBot> list = quickService.getChatBotList(user);
		System.out.println("list확인 : " + list);

		model.addAttribute("list", list);
		
		return "forward:/admin/listChatBot.jsp";
	}
	
	@RequestMapping(value = "addChatbot", method = RequestMethod.POST)
	public String addChatbot(@ModelAttribute("chatBot") ChatBot chatBot, HttpSession session) throws Exception{
		System.out.println("/addChatbot : POST");
	
		System.out.println(chatBot);
		
		quickService.addChatBot(chatBot);
		
		System.out.println("add 완료");
		
		return "forward:/community/addDogInfoView.jsp";
	}
	
	@RequestMapping(value = "getRateChatBot", method = RequestMethod.GET)
	public String getRateChatBot() throws Exception{
		System.out.println("/getRateChatBot : POST");
		
		return "forward:/admin/getRateChatBot.jsp";
	}
	

}
