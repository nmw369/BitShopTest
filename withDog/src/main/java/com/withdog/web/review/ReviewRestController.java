package com.withdog.web.review;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.domain.Product;
import com.withdog.service.domain.Purchase;
import com.withdog.service.domain.Review;
import com.withdog.service.domain.User;
import com.withdog.service.purchase.PurchaseService;
import com.withdog.service.review.ReviewService;

@RestController
@RequestMapping("/review/*")
public class ReviewRestController {
	
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	public ReviewRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['reviewPageSize']}")
	int pageSize;
	
	
	@RequestMapping(value = "json/addReview/{cartNo}")
	public int addReview(@PathVariable  String cartNo, @RequestBody Review review, HttpServletRequest request) throws Exception{
		System.out.println("/review/json/addReview : POST");
		System.out.println("review : "+ review);
		
		HttpSession session = request.getSession(false);
		User user = new User();
		user = (User)session.getAttribute("user");
		
		System.out.println(cartNo);
		
		Purchase purchase = purchaseService.getProdNo(Integer.parseInt(cartNo));
		
		purchaseService.updateCartNoPurchaseCondition(Integer.parseInt(cartNo));
		
		review.setUser(user);
		review.setPurchase(purchase);
		review.setProduct(purchase.getProduct());
		
		System.out.println("후기정보 : "+review);
		reviewService.addReview(review);
		
		System.out.println("서비스갔다온후");
		
		return 1;
	}
	
	
	@RequestMapping(value = "json/getReviewList/{prodNo}/{currentPage}")
	public JSONObject getReviewList(@PathVariable int prodNo, @ModelAttribute("Search") Search search) throws Exception{
		System.out.println("/review/json/getReviewList : GET");
		System.out.println("후기리스트 대상 상품번호 : "+prodNo);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = reviewService.getReviewList(search, prodNo);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("list", map.get("list"));
		jsonObject.put("resultPage", resultPage);
		
		System.out.println(jsonObject);

		return jsonObject;
	}
	

}
