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

	//��ٱ��� ���
	@Override
	public void addCart(Cart cart) throws Exception {
		cartDAO.addCart(cart);
	}
	
	//��ٱ��� �ߺ�üũ��
	@Override
	public Cart getCart(String userId, int prodNo) throws Exception {
		return cartDAO.getCart(userId, prodNo);
	}
	
	//��������
	@Override
	public void updateCart(Cart cart) throws Exception {
		cartDAO.updateCart(cart);
	}
	
	//��ٱ��ϸ���Ʈ
	@Override
	public Map<String, Object> getCartList(Search search, String userId) throws Exception {
		return cartDAO.getCartList(search, userId);
	}
	
	//��ٱ��� ���� ����
	@Override
	public void deleteCart(int cartNo) throws Exception {
		cartDAO.deleteCart(cartNo);
	}
	
	//��ٱ��� ����
	@Override
	public void deleteAllCart(String userId) throws Exception {
		cartDAO.deleteAllCart(userId);
	}
	
	//������ ��ٱ��� ����Ʈ
	@Override
	public Map<String, Object> getSelectCartList(String cartNo) throws Exception {
		return cartDAO.getSelectCartList(cartNo);
	}
}
