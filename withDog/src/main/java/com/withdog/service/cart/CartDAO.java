package com.withdog.service.cart;

import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Cart;

public interface CartDAO {
	
	//장바구니 담기
	public void addCart(Cart cart) throws Exception;
	
	//장바구니 중복 체크용 조회
	public Cart getCart(String userId, int prodNo) throws Exception;
	
	//수량 변경
	public void updateCart(Cart cart) throws Exception;
	
	//장바구니 리스트
	public Map<String,Object> getCartList(Search search, String userId) throws Exception;
	
	//장바구니 개별 삭제
	public void deleteCart(int cartNo) throws Exception;
	
	//장바구니 비우기
	public void deleteAllCart(String userId) throws Exception;
	
	//선택한 장바구니 리스트
	public Map<String,Object> getSelectCartList(String cartNo) throws Exception;
	
}
