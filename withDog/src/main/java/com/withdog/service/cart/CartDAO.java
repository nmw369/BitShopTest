package com.withdog.service.cart;

import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Cart;

public interface CartDAO {
	
	//��ٱ��� ���
	public void addCart(Cart cart) throws Exception;
	
	//��ٱ��� �ߺ� üũ�� ��ȸ
	public Cart getCart(String userId, int prodNo) throws Exception;
	
	//���� ����
	public void updateCart(Cart cart) throws Exception;
	
	//��ٱ��� ����Ʈ
	public Map<String,Object> getCartList(Search search, String userId) throws Exception;
	
	//��ٱ��� ���� ����
	public void deleteCart(int cartNo) throws Exception;
	
	//��ٱ��� ����
	public void deleteAllCart(String userId) throws Exception;
	
	//������ ��ٱ��� ����Ʈ
	public Map<String,Object> getSelectCartList(String cartNo) throws Exception;
	
}
