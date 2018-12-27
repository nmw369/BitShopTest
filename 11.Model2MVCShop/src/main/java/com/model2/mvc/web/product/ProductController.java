package com.model2.mvc.web.product;

import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.Vector;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.server.ServerEndpoint;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
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

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

import com.model2.mvc.service.product.impl.ProductServiceImpl;

import sun.util.locale.StringTokenIterator;




//==> ȸ������ Controller
@Controller
@RequestMapping("/product/*")
public class ProductController extends HttpServlet{
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
	
	@Override
	public void init() throws ServletException{
		super.init();
			
		
	}
	
	public ProductController(){
		System.out.println("2");
		System.out.println(this.getClass());
		System.out.println("agsadg");
		
		try {
		 InetAddress local = InetAddress.getLocalHost();
	     System.out.println("My PC IP :" + local.getHostAddress());
	     String IP = local.getHostAddress();
	     ServletContext application = this.getServletContext();
	     application.setAttribute("serverIP", IP);
		}catch (Exception e) {
			e.getMessage();// TODO: handle exception
		}
		
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	/*@Value("#{commonProperties['filepath']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	String filepath;*/
	
	
	@RequestMapping(value="addProductView", method=RequestMethod.GET)
	public String addProductView() throws Exception {

		System.out.println("/addProductView.do");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	@RequestMapping(value="/addProduct",method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product,HttpServletRequest request,@RequestParam("file") MultipartFile fileName ) throws Exception {

		System.out.println("/addProduct.do");
		
		//Business Logic
		
				
		/*String temp = "";
		String tempName ="";*/
		
		//meta Data ȭ ��
		
		Properties properties = new Properties();
		properties.load(new FileInputStream("C:/common.properties"));
		
		String path = properties.getProperty("filepath");
		String filetemp = fileName.getOriginalFilename();
		product.setFileName(filetemp);
		
		/*for (int i = 0; i < fileName.length; i++) {
			temp =fileName[i].getOriginalFilename();
			tempName = tempName+":"+temp;
			File file = new File(path+temp);
			fileName[i].transferTo(file);
					
		}*/
		/*product.setFileName(tempName);*/
		
		
		////////////////////////
		/*String uri = product.getFileName();
		System.out.println("�Ѿ�� ��� !!!!!!!"+uri);
	    File file = new File(uri);
	    //����Ʈ�� �����Ҵ� FileInputStream�� ����Ʈ������ �̹��� ���� DataInputStream����Ұ�
	    byte[] bytes = new byte[(int)file.length()];
	    System.out.println(bytes.length+"====================================================���� �뷮");
	    
	    DataInputStream dateInput = new DataInputStream(new FileInputStream(file));
	    dateInput.readFully(bytes);
	    dateInput.close();
	    String fileName = uri.substring(uri.lastIndexOf("\\")+1, uri.indexOf(".")+4);
	    System.out.println(fileName+"=============================================�̹��� ���� �̸� ���");
	    FileOutputStream copyfile = new FileOutputStream("C:\\workspace\\07.Model2MVCShop(URI,pattern)\\WebContent\\images\\uploadFiles\\"+fileName);
	    copyfile.write(bytes);
	    copyfile.close();
			
		product.setFileName(fileName);*/
		
		////////////////////////////////////////////////////////�̰� �Ⱦ� 		
		/*if(FileUpload.isMultipartContent(request)) {
			String temDir = "C:\\workspace\\07.Model2MVCShop(URI,pattern)\\WebContent\\images\\uploadFiles\\";
			
			DiskFileUpload fileUpload = new DiskFileUpload();
			fileUpload.setRepositoryPath(temDir);
			fileUpload.setSizeMax(1024 * 1024 * 10);
			fileUpload.setSizeThreshold(1024 * 100);
			
			if(request.getContentLength() < fileUpload.getSizeMax()) {
				StringTokenizer token = null;
				
				List fileItemList = fileUpload.parseRequest(request);
				int size = fileItemList.size();
				for (int i = 0; i < size; i++) {
					FileItem fileItem = (FileItem)fileItemList.get(i);
					if(fileItem.isFormField()) {
						if(fileItem.getFieldName().equals("manuDate")) {
							token = new StringTokenizer(fileItem.getString("euc-kr"),"-");
							String manuDate = token.nextToken() + token.nextToken() + token.nextToken();
							product.setManuDate(manuDate);
						}
						else if(fileItem.getFieldName().equals("prodName")) {
							product.setProdName(fileItem.getString("euc-kr"));
						}
						else if(fileItem.getFieldName().equals("prodDetail")) {
							product.setProdDetail(fileItem.getString("euc-kr"));
						}
						else if(fileItem.getFieldName().equals("price")) {
							product.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));
						}
					}else { //���������̸�
						if(fileItem.getSize()>0){
							int idx = fileItem.getName().lastIndexOf("\\");
							if(idx ==-1) {
								idx = fileItem.getName().lastIndexOf("/");
							}
							String fileName = fileItem.getName().substring(idx+1);
							product.setFileName(fileName);
							try {
								File uploadedFile = new File(temDir,fileName);
								fileItem.write(uploadedFile);
							}catch (IOException e) {
								System.out.println(e);
							}
						}else {
							product.setFileName("../../images/empty.GIF");
						}
					}
				}
					productService.addProduct(product);
					request.setAttribute("product", product);					
			}else {
				int overSize = (request.getContentLength() / 1000000);
				System.out.println("������ ũ��� 1MB���� �Դϴ�. �ø��� ���� �뷮�� + " +overSize + "MB�Դϴ�.");
				System.out.println("history.back();<script>");
			}			
		}else {
			System.out.println("���ڵ� Ÿ���� multipart/form-data�� �ƴմϴ�...");
		}*/
		///////////////////////////////////�Ƚ�
		
		
		
		
		System.out.println("product : "+product);
		
		productService.addProduct(product);
		
		System.out.println("+++++++++++++++++++++++++++++++++++end!!!!");
		
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping(value="/getProduct")
	public String getProduct( @RequestParam("prodNo") int prodNo , Model model , HttpServletRequest request ,HttpServletResponse response) throws Exception {
		
		System.out.println("/getProduct.do");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model �� View ����
		/*List<String> filelist = new ArrayList<String>();*/
		
		
		
		String[] filelist = null;
		
		if(product.getFileName().contains(":")) {
			filelist = product.getFileName().split(":");
			
			for (int i = 0; i < filelist.length-1; i++) {
				filelist[i]=filelist[i+1];
			}
			
			model.addAttribute("filelist",filelist);
			
		}else {
			model.addAttribute("filelist",product.getFileName());
		}
		
		
		
		model.addAttribute("product", product);
		
		String lookup = request.getParameter("lookup");
		System.out.println(lookup+"***********lookupüũ�Ѱ�");
		if(lookup!=null && lookup.equals("yes")) {
		productService.updateLookup(productService.getProduct(prodNo));
		
		System.out.println("updateLookup�޼ҵ����Ϸ�======");
		}
		String menu = request.getParameter("menu");
		//manage ��Ű ����
				if(menu.equals("manage")){
					System.out.println("/////AddProductAction Action class execute end : b4 return/////");
					return "forward:/product/updateProductView";
				}else{
					System.out.println("/////AddProductAction Action class execute end : b4 return/////");
					
					//manage�� ���� �ʿ� ���� : ��Ű����Ʈ? �� ���Ӱ� ������� ��Ű�� �־ history.jsp���� ��θ� ��¿���
					Cookie[] cookies = request.getCookies(); //request ��ü�κ��� ��Ű�� �޾Ƽ� Cookies[] data type�� cookies ��� ���������� ����
					Cookie cookie = null; // Cookie data type�� cookie instance �����ϰ� �ʱⰪ null
					for(int i = 0; i < cookies.length; i++){ //cookies��� list�� �����ϴ� ��� cookie�鿡 ���Ͽ� 
						
						if(cookies[i].getName().equals("history")){ // cookies[]�� ������ cookie �̸��� "history"��� name�� ������ cookie�� �����Ѵٸ�
							cookie = cookies[i];
							cookie.setValue(cookies[i].getValue()+","+prodNo); // �� cookie�� history ��� �̸��� ���� cookie ��ü�� �����Ѵ�.
							cookie.setMaxAge(60*10); //��Ű�� �Ҹ꿹���ð� 10��
							
						}
					}
					/*System.out.println(cookie.getValue()+":::cookie���");*/
					
					if(cookie == null){ //for���� �� ������ ��� cookie�� �˻��ص� history �̸��� ���� cookie�� �������� �ʴ´ٸ�,
						cookie = new Cookie("history", ""+prodNo); //
						cookie.setMaxAge(60*10);
						
					}
					response.addCookie(cookie);
					if(request.getParameter("tranCode")!=null) {
					request.setAttribute("tranCode", request.getParameter("tranCode"));
					}
				}
				System.out.println("========================================getend");
		//������ �������϶�
				
				
				
				
		return "forward:/product/getProduct.jsp";
	}
	
	/*@RequestMapping("/updateProductView.do")
	public String updateProductView( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/updateProductView.do");
		//Business Logic
		Product Product = productService.getProduct(prodNo);
		// Model �� View ����
		model.addAttribute("Product", Product);
		
		return "forward:/product/updateProduct.jsp";
	}*/
	
	@RequestMapping(value="/updateProductView", method=RequestMethod.GET)
	public String updateProductView(@RequestParam("prodNo") int prodNo , Model model , HttpSession session) throws Exception{

		System.out.println("/updateProductView.do");
		//Business Logic
		System.out.println("/updateProduct.do");
		//Business Logic
		Product product = productService.getProduct(prodNo);
				
		model.addAttribute("vo",product);
		System.out.println("���������?");
		
		return "forward:/product/updateProduct.jsp";
		
	}
	
	
	@RequestMapping(value="/updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("Product") Product product , Model model , HttpSession session) throws Exception{

		System.out.println("/updateProduct.do");
		//Business Logic
		productService.updateProduct(product);
		
		String prodNo = product.getProdNo()+"";
		System.out.println(prodNo+"---");
		model.addAttribute("product",productService.getProduct(product.getProdNo()));
		
		return "forward:/product/getProduct.jsp?prodNo="+prodNo.trim()+"&menu=manage";
	}
			
	@RequestMapping(value="/listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/listProduct.!!!!!!!!!!!");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
	
		
		//�߰���� ��¥,���� Sorting
		String daysorting = "";
		String sorting = "low";
		System.out.println("Daysorting�� ���� parameter!!!!!!!!!!!!!!!!!+++++++:::::"+daysorting);
		
		if(request.getParameter("daysorting")!=null && request.getParameter("daysorting").equals("highDay")) {
			search.setDaySorting(request.getParameter("daysorting"));
			search.setSorting("a");
			daysorting = request.getParameter("daysorting");
		}else if(request.getParameter("daysorting")!=null && request.getParameter("daysorting").equals("lowDay")) {
			
			daysorting = request.getParameter("daysorting");
			search.setDaySorting(daysorting);
			search.setSorting("a");
		}else if(search.getSorting()!="a") {
			
			if(request.getParameter("sorting")!=null && request.getParameter("sorting").equals("high")) {
				search.setSorting(request.getParameter("sorting"));
				sorting = request.getParameter("sorting");
			}else {
				search.setSorting(sorting);
			}
			
		}
		
		request.setAttribute("sorting", sorting);
		System.out.println("sorting�� ���� parameter!!!!!!!!!!!!!!!!!+++++++:::::"+sorting);
		request.setAttribute("daysorting", daysorting);
		
		// Business logic ����
		
		//�˻��� ���Է�
		search.setSearchCondition(request.getParameter("searchCondition"));
		search.setSearchKeyword(request.getParameter("searchKeyword"));
		/*search.setStartRowNum();
		search.setEndRowNum();*/
		
		System.out.println(request.getParameter("searchCondition")+":::::::::"+request.getParameter("searchKeyword"));
		
		
				
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		/*HttpSession session = request.getSession(false);
		session.setAttribute("move", "product/listProduct.jsp");*/
		
	
		
		/*return "forward:/product/listProduct.jsp";*/
		return "forward:/product/listProduct.jsp";
	}
	@RequestMapping(value="history")
	public String history() {
	
		return "forward:/history.jsp";
	}
	
	
	@RequestMapping(value="chating")
	public String chating(HttpServletRequest request) {
		System.out.println(request.getRemoteAddr()+"::ä�ÿ� ������ Ŭ���̾�Ʈ IP ����");
	      String ip = request.getRemoteAddr();
	      
	         
	      
	      HttpSession session = request.getSession(false);
	      User user = (User)session.getAttribute("user");
	      
	      //ipcheck 
	  
	      /*.checkIP(ip);*/
	      
	      /*Map<String, Object> map = new UserDao().ip*/
	      
	      request.setAttribute("clientIP", request.getRemoteAddr());
	      
	      
	      
	      
	      return "forward:/webSocket/chating.jsp";
	}
	
	
	
	
}