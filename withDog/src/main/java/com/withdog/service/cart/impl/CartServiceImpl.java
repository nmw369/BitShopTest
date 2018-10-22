package com.withdog.service.cart.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.withdog.common.Search;
import com.withdog.service.cart.CartDAO;
import com.withdog.service.cart.CartService;
import com.withdog.service.domain.Cart;

@Service("cartServiceImpl")
public class CartServiceImpl implements CartService {
	
	@Autowired
	@Qualifier("cartDAOImpl")
	private CartDAO cartDAO;
	
	public void setCartDAO(CartDAO cartDAO) {
		this.cartDAO = cartDAO;
	}

	//장바구니 담기
	@Override
	public void addCart(Cart cart) throws Exception {
		cartDAO.addCart(cart);
	}
	
	//장바구니 중복체크용
	@Override
	public Cart getCart(String userId, int prodNo) throws Exception {
		return cartDAO.getCart(userId, prodNo);
	}
	
	//수량변경
	@Override
	public void updateCart(Cart cart) throws Exception {
		cartDAO.updateCart(cart);
	}
	
	//장바구니리스트
	@Override
	public Map<String, Object> getCartList(Search search, String userId) throws Exception {
		return cartDAO.getCartList(search, userId);
	}
	
	//장바구니 개별 삭제
	@Override
	public void deleteCart(int cartNo) throws Exception {
		cartDAO.deleteCart(cartNo);
	}
	
	//장바구니 비우기
	@Override
	public void deleteAllCart(String userId) throws Exception {
		cartDAO.deleteAllCart(userId);
	}
	
	//선택한 장바구니 리스트
	@Override
	public Map<String, Object> getSelectCartList(String cartNo) throws Exception {
		return cartDAO.getSelectCartList(cartNo);
	}
}
