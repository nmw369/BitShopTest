package com.withdog.web.cart;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.withdog.common.Page;
import com.withdog.common.Search;
import com.withdog.service.cart.CartService;
import com.withdog.service.domain.User;

@Controller
@RequestMapping("/cart/*")
public class CartController {
	
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;

	public CartController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//��ٱ��� ����Ʈ
	@RequestMapping( value = "getCartList")
	public String getCartList(@ModelAttribute("search") Search search, HttpSession session, Model model) throws Exception{
		
		System.out.println("cart/getCartList : ��ٱ��� ����Ʈ");
		User user = (User)session.getAttribute("user");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = cartService.getCartList(search, user.getUserId());
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("user", user);
		
		return "forward:/store/listCart.jsp";
	}
	
	

}
