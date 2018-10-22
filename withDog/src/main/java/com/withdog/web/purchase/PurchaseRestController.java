package com.withdog.web.purchase;

import java.net.URI;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.withdog.service.domain.Product;
import com.withdog.service.domain.Purchase;
import com.withdog.service.product.ProductService;
import com.withdog.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	
	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	//관리자가 배송하기버튼 클릭시 컨디션 변경
	@RequestMapping( value="json/updatePurchaseConditionAdmin/{purchaseCondition}/{purchaseNo}")
	public String updatePurchaseConditionAdmin(@PathVariable String purchaseNo, @PathVariable String purchaseCondition) throws Exception{
		
		System.out.println("json/updatePurchaseConditionAdmin : 배송하기");
		
		Purchase purchase = new Purchase();
		purchase.setPurchaseNo(Integer.parseInt(purchaseNo));
		purchase.setPurchaseCondition(purchaseCondition);
		
		purchaseService.updatePurchaseCondition(purchase);
		
		return "1";
	}
	
	//회원이 구매취소 시 컨디션변경과 함께 수량 업데이트
	@RequestMapping( value="json/updateCancelPurchaseCondition/{purchaseCondition}/{purchaseNo}")
	public String updateCancelPurchaseCondition(@PathVariable String purchaseNo, @PathVariable String purchaseCondition) throws Exception{
		
		System.out.println("json/updateCancelPurchaseCondition : 구매취소");
		
		System.out.println("구매번호" + purchaseNo+ "구매코드" + purchaseCondition);
		Purchase purchase = new Purchase();
		purchase.setPurchaseNo(Integer.parseInt(purchaseNo));
		purchase.setPurchaseCondition(purchaseCondition);
		purchaseService.updatePurchaseCondition(purchase);
		
		//구매번호기준으로 리스트 담아서
		List<Purchase> purchaseList = purchaseService.getPurchase(Integer.parseInt(purchaseNo));
		
		for(int i=0; i<purchaseList.size(); i++) {
			int purchaseQuantity = purchaseList.get(i).getPurchaseQuantity();
			int prodNo = purchaseList.get(i).getProduct().getProdNo();
			System.out.println("구매수량" + purchaseQuantity);
			System.out.println("상품번호" + prodNo);
			
			Product product = productService.getProduct(prodNo);		// 다시 더해줄 상품의 현재 개수 알아야함, 위에서 꺼낸 상품번호 기준으로 상품 찾아옴
			int prodQuantity = product.getProdQuantity();						//상품번호로 가져온 상품의  현재수량
			System.out.println("상품현재수량" + prodQuantity);
			prodQuantity = prodQuantity + purchaseQuantity;				//상품 현재수량에 + 구매수량(구매취소) 
			product.setProdQuantity(prodQuantity); 									//연산 상품수량 상품도메인에 담기
			productService.updateProductAdmin(product);						//수정서비스 보내기
		}
		
		return "1";
	}
	
	
	//회원이 구매확정버튼 클릭시 컨디션 변경
	@RequestMapping( value="json/updateMyPurchaseCondition/{purchaseCondition}/{purchaseNo}")
	public String updateMyPurchaseCondition(@PathVariable String purchaseNo, @PathVariable String purchaseCondition) throws Exception{
		
		System.out.println("json/updateMyPurchaseCondition : 구매확정");
		
		Purchase purchase = new Purchase();
		purchase.setPurchaseNo(Integer.parseInt(purchaseNo));
		purchase.setPurchaseCondition(purchaseCondition);
		
		purchaseService.updatePurchaseCondition(purchase);
		
		return "1";
	}

	//구매후기쓰기 클릭시 작성폼에 상품리스트 들고 오기 위한 
	@RequestMapping(value = "json/getPurchaseProduct/{purchaseNo}")
	public JSONObject  getPurchaseProduct(@PathVariable("purchaseNo") int purchaseNo, HttpServletRequest request, Model model) throws Exception{ 
		
		System.out.println("/json/getPurchaseProduct : 구매후기쓰기");

		List<Purchase> purchaseReviewProduct = purchaseService.getPurchaseCondition(purchaseNo)	;
		
		System.out.println(purchaseReviewProduct.size());
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("purchaseReviewProduct", purchaseReviewProduct);
		
		return jsonObject;
	}
	
	
}
