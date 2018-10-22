package com.withdog.web.product;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.Cookie;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.CookieGenerator;

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.domain.Product;
import com.withdog.service.domain.User;
import com.withdog.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Value("#{commonProperties['productfilePath']}")
	String productfilePath;

	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['storePageSize']}")
	int storePageSize;
	
	@RequestMapping(value="addProductAdmin", method=RequestMethod.GET)
	public String addProductAdmin() throws Exception{
		
		System.out.println("/product/addProductAdmin : GET");
		
		return "forward:/store/addProductAdmin.jsp";
		
	}
	
	@RequestMapping(value="addProductAdmin", method=RequestMethod.POST)
	public String addProductAdmin(@ModelAttribute("product") Product product, 
																	 @RequestParam("file") MultipartFile[] file) throws Exception{ 
		
		System.out.println("/product/addProductAdmin : POST");
		
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = new Date();
		String fileName = ""; 
		int i=0;
		
		// 파일이 있을경우
		if (file[0].getSize() != 0) {
			// 파일 수 만큼 반복 (prodImage, prodContent)
			for (MultipartFile multipartFile : file) {
				if (multipartFile.getOriginalFilename().equals("") || multipartFile == null) {
					break;
				}
				
				// 저장할 파일이름 (현재 날짜시간+파일이름)
				fileName = (dateFormat.format(date) + multipartFile.getOriginalFilename());
					
				//상품이미지 파일 (commonProperties에서 설정한 경로에 저장)
				File f = new File(
						productfilePath + (dateFormat.format(date) + multipartFile.getOriginalFilename()).toString());
				multipartFile.transferTo(f); // 위의 경로에 파일 저장

				// 첫번째 파일은 Image, 두번째 파일은 Content
				if(i==0) {
					product.setProdImage(fileName);
				}else {
					product.setProdContent(fileName);
				}
				i++;
			}
		}
		
		Thread.sleep(2500);
		
		System.out.println("여긴가");
		productService.addProductAdmin(product);
		
		System.out.println("갔다온프로덕트" + product );
		
		return "forward:/store/addProductConfirmAdmin.jsp";
		
	}
	
	
	@RequestMapping(value="updateProductAdmin", method=RequestMethod.GET)
	public String updateProduct( @RequestParam("prodNo") int prodNo, Model model ) throws Exception{

		System.out.println("/product/updateProductAdmin : GET");
		
		Product product = productService.getProduct(prodNo);
		
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/store/updateProductAdmin.jsp";
	}
	
	
	@RequestMapping( value ="updateProductAdmin", method=RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product, 
															  @RequestParam("file") MultipartFile[] file, HttpServletRequest request) throws Exception{
		
		
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = new Date();
		String fileName = ""; 
		int i=0;
		
		// 파일이 있을경우
		if (file[0].getSize() != 0) {
			// 파일 수 만큼 반복 (prodImage, prodContent)
			for (MultipartFile multipartFile : file) {
				if (multipartFile.getOriginalFilename().equals("") || multipartFile == null) {
					break;
				}
				
				// 저장할 파일이름 (현재 날짜시간+파일이름)
				fileName = (dateFormat.format(date) + multipartFile.getOriginalFilename());
					
				//상품이미지 파일 (commonProperties에서 설정한 경로에 저장)
				File f = new File(
						productfilePath + (dateFormat.format(date) + multipartFile.getOriginalFilename()).toString());
				multipartFile.transferTo(f); // 위의 경로에 파일 저장

				// 첫번째 파일은 Image, 두번째 파일은 Content
				if(i==0) {
					product.setProdImage(fileName);
				}else {
					product.setProdContent(fileName);
				}
				i++;
			}
		}
		
		System.out.println("업데이트전" + product.getProdNo());
		
		productService.updateProductAdmin(product);
		
		System.out.println("업데이트후");
		
		return "redirect:/product/getProduct?prodNo="+ product.getProdNo();
	}
	
	
	@RequestMapping(value="updateDeleteFlag")
	public String updateDeleteFlag(@ModelAttribute("product") Product product, @RequestParam("deleteFlag") String deleteFlag) throws Exception{
		
		System.out.println("/product/updateDeleteFlag : POST");
		
		product.setDeleteFlag(deleteFlag);
		System.out.println("삭제서비스들어가기전");
		productService.updateDeleteFlag(product);
		System.out.println("삭제서비스갔다온후");
		
		
		return "forward:/product/listProduct?prodType=0";
	}
	
	
	//@RequestMapping( value = "historyProduct")
	public String historyProduct() throws Exception{
		
		return "forward:/history.jsp";
	}
	

	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct( @RequestParam("prodNo") int prodNo , Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		Cookie[] c = request.getCookies();
		String ck = null;
		if (c!=null && c.length > 0) {
			for (int i = 0; i<c.length; i++) {
				Cookie cookie = c[i];
				if (cookie.getName().equals("history")) {
					ck  = c[i].getValue();
				}
			}
		}

		CookieGenerator cookieGenerator = new CookieGenerator();
		cookieGenerator.setCookieName("history");
		cookieGenerator.addCookie(response, prodNo + "," + ck);
		
		return "forward:/store/getProduct.jsp";
	}
	
	
	@RequestMapping(value="listProduct")
	public String getProductList( @ModelAttribute("search") Search search , @RequestParam("prodType") String prodType, Model model , User user, HttpServletRequest request, HttpSession session) throws Exception{
		
		System.out.println("/product/listProduct : POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(storePageSize);
		
		
		//서치에 프로드타입 심기
		if(prodType.equals("0")) {
			search.setProdType("0"); 
		}else {
			search.setProdType("1"); 
		}
		
		
		if((User)session.getAttribute("user") != null) {
			
			System.out.println("이프문탓나111111");
			
			user = (User)session.getAttribute("user");
			
			String role = user.getRole();
			
			System.out.println(role);
			
			if(role.equals("admin")){
				search.setRole("admin");
				
				
			}else {
				user.setRole("user");
			}			
			
		}else {
			
				System.out.println("이프문탓나222222");
				user.setRole("user");
		}
		
		
		
		search.setProdType(prodType);
		Map<String , Object> map= productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, storePageSize);
		System.out.println(map);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		String result = "";
		if(prodType.equals("0")) {
			System.out.println("애견용품");
			result = "forward:/store/listProductGoods.jsp";
		}else if(prodType.equals("1")) {
			System.out.println("애견식품");
			result = "forward:/store/listProductFood.jsp";
		}else {
			System.out.println("전체");
			result = "forward:/store/listProductAll.jsp";
		}
		
		return result;
	}

}
