package com.withdog.web.cart;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
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

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.cart.CartService;
import com.withdog.service.domain.Cart;
import com.withdog.service.domain.Product;
import com.withdog.service.domain.User;

@RestController
@RequestMapping("/cart/*")
public class CartRestController {
	
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	public CartRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//장바구니담기
	@RequestMapping( value = "json/addCart", method=RequestMethod.POST)
	public String addCart(@RequestBody Map<String, Object> map, HttpSession session) throws Exception{

		String prodNo = map.get("prodNo").toString();
		String purchaseQuantity = map.get("purchaseQuantity").toString();
		
		System.out.println("넘어온 상품번호" + prodNo + "/////넘어온구매수량" + purchaseQuantity);
		//세션유저 객체에 담기
		User user = (User)session.getAttribute("user");
		
		Product product = new Product();
		product.setProdNo(Integer.parseInt(prodNo));
		
		Cart cart = cartService.getCart(user.getUserId(), Integer.parseInt(prodNo));
		
		//카트가 널이면
		if(cart == null) {
			cart = new Cart();
			cart.setCartQuantity(Integer.parseInt(purchaseQuantity));
			cart.setProduct(product);
			cart.setUser(user);
			
			cartService.addCart(cart);
		
		}else {
			cart.setCartQuantity(Integer.parseInt(purchaseQuantity));
			
			cartService.updateCart(cart);
		}
		
		return "1";
	}
	
	
	//장바구니 담긴 상품 삭제
	@RequestMapping( value = "json/deleteCart/{cartNo}")
	public boolean deleteCart(@PathVariable int cartNo) throws Exception{
		
		System.out.println("/json/deleteCart/ : 장바구니개별삭제");
		
		cartService.deleteCart(cartNo);
		
		return true;
	}
	
	
	//장바구니 비우기
	@RequestMapping( value = "json/deleteAllCart/{userId}")
	public boolean deleteAllCart(@PathVariable String userId) throws Exception{
		
		System.out.println("/json/deleteAllCart/ : 장바구니비우기");
		
		cartService.deleteAllCart(userId);
		
		return true;
	}
	
	
	//툴팁용 장바구니 리스트
	@RequestMapping( value = "json/getToolCartList")
	public JSONObject getToolCartList(@ModelAttribute("search") Search search, HttpSession session, Model model) throws Exception{
		
		System.out.println("/cart/json/getToolCartList : GET");
		
		User user = (User)session.getAttribute("user");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = cartService.getCartList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("list", map.get("list"));
		jsonObject.put("resultPage", resultPage);
		
		return jsonObject;
	}

	
	//장바구니에 있는 상품 구매수량변경
	@RequestMapping( value="json/updateCart/{cartNo}/{cartQuantity}", method=RequestMethod.GET )
	public Cart updateCart(@PathVariable int cartNo,
								@PathVariable int cartQuantity) throws Exception{
		
		System.out.println("/cart/json/updateCart : GET");
		
		Cart cart = new Cart();
		cart.setCartNo(cartNo);
		cart.setCartQuantity(cartQuantity);
		
		cartService.updateCart(cart);
		
		return cart;
	}
	
	
	

}
