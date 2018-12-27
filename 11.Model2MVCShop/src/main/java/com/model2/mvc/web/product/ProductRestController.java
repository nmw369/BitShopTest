package com.model2.mvc.web.product;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;

//==> 회원관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {

	/// Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	// setter Method 구현 않음

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	public ProductRestController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "json/addProduct")
	public Product addProduct(@RequestBody Product product) throws Exception {
		System.out.println("/product/json/addProduct");
		System.out.println("::" + product);
		productService.addProduct(product);
		
		String uri = product.getFileName();
		File file = new File(uri);
	    //바이트에 동적할당 FileInputStream에 바이트넣으면 이미지 깨짐 DataInputStream사용할것
	    byte[] bytes = new byte[(int)file.length()];
	    System.out.println(bytes.length+"====================================================파일 용량");
	    
	    DataInputStream dateInput = new DataInputStream(new FileInputStream(file));
	    dateInput.readFully(bytes);
	    dateInput.close();
	    String fileName = uri.substring(uri.lastIndexOf("\\")+1, uri.indexOf(".")+4);
	    System.out.println(fileName+"=============================================이미지 파일 이름 출력");
	    FileOutputStream copyfile = new FileOutputStream("C:\\workspace\\07.Model2MVCShop(URI,pattern)\\WebContent\\images\\uploadFiles\\"+fileName);
	    copyfile.write(bytes);
	    copyfile.close();
				
		product.setFileName(fileName);
		
		
		Product dbProduct = productService.getProduct(product.getProdNo());
		System.out.println("리턴되는 product : " + dbProduct);
		return dbProduct;

	}

	@RequestMapping(value = "json/getProduct/{prodNo}")
	public Product getProduct(@PathVariable int prodNo) throws Exception {
		Product product = productService.getProduct(prodNo);
		System.out.println("getProduct :: " + product);
				
		return product;
	}

	@RequestMapping(value = "json/updateProduct")
	public Product updateProduct(@RequestBody Product product) throws Exception {
		System.out.println("product/json/updateProduct");
		productService.updateProduct(product);

		return product;
	}

	@RequestMapping(value = "json/getListProduct")
	public Map<String, Object> getListProudct(@RequestBody Search search) throws Exception {
		System.out.println("product/json/getListProduct");
		Map<String, Object> map = productService.getProductList(search);
		
		return map;
	}
	@RequestMapping(value = "json/getProdSearch")
	public JSONArray getProdSearch(@RequestBody Search search) throws Exception {
		System.out.println("product/json/getProdSearch!!!!!!!!!!!!11");
		List<Product> list = productService.getProdSearch(search);
				
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < list.size(); i++) {
			if(list.get(i).getProdName()!=null) {
			jsonArray.add(list.get(i).getProdName());
			}else if(list.get(i).getProdNo()!=0) {
				String temp=list.get(i).getProdNo()+"";
				jsonArray.add(temp.trim());
			}else if(list.get(i).getPrice()!=0) {
				String temp=list.get(i).getPrice()+"";
			jsonArray.add(temp.trim());
			}
		}
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>"+jsonArray);
		
		return jsonArray;
	}
	
	@RequestMapping(value = "json/getProductList")
	public Map<String, Object> getProductList() throws Exception {
		System.out.println("product/json/getProductList########");
		Map<String, Object> map = productService.getMainList();
		
		return map;
	}
	
	@RequestMapping(value = "json/getScroll")
	public List<Product> getScroll(@RequestBody Search search) throws Exception {
		System.out.println("product/json/getScroll");
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		List<Product> list = productService.getScroll(search);
		
		return list;
	}
	
	@RequestMapping(value="json/listProduct")
	public List<Product> listProduct( @RequestBody Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("json/listProduct.!!!!!!!!!!!");
		System.out.println(search.getCurrentPage()+"/////////////");
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
	
		
		//추가기능 날짜,가격 Sorting
		String daysorting = "";
		String sorting = "low";
		System.out.println("Daysorting를 위한 parameter!!!!!!!!!!!!!!!!!+++++++:::::"+daysorting);
		
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
		System.out.println("sorting를 위한 parameter!!!!!!!!!!!!!!!!!+++++++:::::"+sorting);
		request.setAttribute("daysorting", daysorting);
		
		// Business logic 수행
		
		//검색시 값입력
		search.setSearchCondition(request.getParameter("searchCondition"));
		search.setSearchKeyword(request.getParameter("searchKeyword"));
		/*search.setStartRowNum();
		search.setEndRowNum();*/
		
		System.out.println(request.getParameter("searchCondition")+":::::::::"+request.getParameter("searchKeyword"));
		
		
				
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		List<Product> sList = new ArrayList<Product>();
		
		sList = (List<Product>)map.get("list");
		
		System.out.println(sList.get(0)+"\n"+sList.get(1));
		System.out.println("json/list end========================================");
		
		return sList;
	}
}