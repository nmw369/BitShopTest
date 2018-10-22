package com.withdog.web.common;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.common.CommonService;
import com.withdog.service.domain.Point;
import com.withdog.service.domain.User;

@Controller
@RequestMapping("/common/*")
public class CommonController {
	
	@Autowired
	@Qualifier("commonServiceImpl")
	private CommonService commonService;
	
	public CommonController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pointpageSize']}")
	int pageSize;
	
	@Value("#{commonProperties['sommernoteFilePath']}")
	String path;
	
	
	@RequestMapping(value="getCoInfo")
	public String getCoInfo() throws Exception { //회사소개
		
		return "forward:/company/getCoInfo.jsp";
	}
	
	@RequestMapping(value="getCoActivity")
	public String getCoActivity() throws Exception { //활동내역
		
		return "forward:/company/getCoActivity.jsp";
	}
	
	@RequestMapping(value="/mainPage")
	public String getMainPage() throws Exception {
		
		return "forward:/common/index.jsp";
	}
	
	@RequestMapping(value="/myPageMain")
	public String getMyPageMain(HttpServletRequest request,HttpSession session) throws Exception {
		
		String uri = "";
		int myPageState;
		User user = (User)session.getAttribute("user");
		
		String myState="";
        System.out.println("111111111111111111");
		System.out.println(request.getParameter("role"));
		if(request.getParameter("role")!=null) {
			myState = request.getParameter("role");
		}
		
		System.out.println(myState);
		
		if(myState.equals("user")) {
			uri="/common/getMyPointList";
		}else {
			uri="/common/getAdminPageMain";
		}
		System.out.println(uri);
		return "forward:"+uri;
	}
	
	@RequestMapping(value="/getAdminPageMain")
	public String getAdminPageMain(HttpServletRequest request,HttpSession session) throws Exception {
		
				
		return "forward:/fund/getFundUserListAdmin";
	}
	
	
	@RequestMapping(value="/getMyPointList")
	public String getMyPointList(@ModelAttribute("search") Search search,HttpServletRequest request,HttpSession session)throws Exception{
		
		System.out.println("MyPointList : Start");
		System.out.println(search.toString());
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		if(search.getSorting()==1) {
			request.setAttribute("sorting", 1);
		}else if(search.getSorting()==2) {
			request.setAttribute("sorting", 2);
		}
		
		search.setPageSize(pageSize);
		
		Point point = new Point();
		User user = (User)session.getAttribute("user");
		
		point.setUser(user);
		
		int currentPoint = commonService.getCurrentPoint(point);
		Map<String,Object> map = commonService.getMyPointList(search,user.getUserId());
		List<Point> list = (List<Point>)map.get("list");
		List<Point> resultList = new ArrayList<Point>(); 
		for (int i = 0; i <list.size(); i++) {
			System.out.println(list.get(i).toString());
			point=list.get(i);
			if(point.getFund().getFundMyPrice()!=0) {
				point.setPointHistory(0);
			}
			else if(point.getAsh().getAshReservationNo()!=0) {
				point.setPointHistory(1);
			}
			else if(point.getPurchase().getPurchaseNo()!=0) {
				point.setPointHistory(2);
			}
			
			resultList.add(point);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		request.setAttribute("currentPoint", currentPoint);
		request.setAttribute("resultList", resultList);
		request.setAttribute("resultPage", resultPage);
		request.setAttribute("search", search);
		
		request.setAttribute("myPageState", "11");
		
		
		return "forward:/mypage/listMyPoint.jsp";
	}
	/*@RequestMapping(value="/imageUpload")
	public ResponseEntity<String>  imageUpload() throws Exception{
		
		String imagePath= "";
		HttpHeaders hearders = new HttpHeaders();
		hearders.setContentType(MediaType.valueOf(imagePath));
		
		
		return new ResponseEntity<String>(imagePath,hearders,HttpStatus.OK);
	}
	 */
	
	/*@RequestMapping(value="/imageUpload")
	public ResponseEntity<String>  imageUpload(MultipartFile file,HttpServletResponse response) throws Exception{
		System.out.println("imageStart");
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		System.out.println(1);
		String fileName= file.getOriginalFilename();
		
		System.out.println(fileName);
		File fileSave = new File(path+fileName);
		file.transferTo(fileSave);
		
		System.out.println(2);
		out.println("../images/sommernote/"+fileName);
		String imagePath ="../images/sommernote/"+fileName;
		System.out.println(3);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
		headers.setContentType(MediaType.valueOf(imagePath));
		
		return new ResponseEntity<String>(imagePath,HttpStatus.OK);
	
	}*/
	
}
