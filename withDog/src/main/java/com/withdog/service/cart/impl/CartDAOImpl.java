package com.withdog.service.cart.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.withdog.common.Search;
import com.withdog.service.cart.CartDAO;
import com.withdog.service.domain.Cart;

@Repository("cartDAOImpl")
public class CartDAOImpl implements CartDAO{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public CartDAOImpl() {
		System.out.println(this.getClass());
	}
	
	//��ٱ��� ���
	public void addCart(Cart cart) throws Exception{
		sqlSession.insert("CartMapper.addCart", cart);
	}
	
	//��ٱ��� �ߺ�üũ��
	@Override
	public Cart getCart(String userId, int prodNo) throws Exception {
		Map<String, Object> mapIn = new HashMap<String, Object>();
		mapIn.put("userId", userId);
		mapIn.put("prodNo", prodNo);
		System.out.println(mapIn);
		return sqlSession.selectOne("CartMapper.getCart", mapIn);
	}
	
	//��������
	@Override
	public void updateCart(Cart cart) throws Exception {
		sqlSession.update("CartMapper.updateCart", cart);
	}
	
	//��ٱ��� ����Ʈ
	@Override
	public Map<String, Object> getCartList(Search search, String userId) throws Exception {
		Map<String, Object> mapIn = new HashMap<String, Object>();
		mapIn.put("search", search);
		mapIn.put("userId", userId);	
		
		int totalCount = sqlSession.selectOne("CartMapper.getCartListTotalCount", mapIn);
		List<Cart> list = sqlSession.selectList("CartMapper.getCartList", mapIn);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("totalCount", totalCount);
		map.put("list", list);
		
		return map;
	}
	
	//��ٱ��� ���� ����
	@Override
	public void deleteCart(int cartNo) throws Exception {
		sqlSession.update("CartMapper.deleteCart", cartNo);
	}
	
	//��ٱ��� ����
	public void deleteAllCart(String userId) throws Exception{
		sqlSession.update("CartMapper.deleteAllCart", userId);
	}
	
	//������ ��ٱ��� ����Ʈ
	@Override
	public Map<String, Object> getSelectCartList(String cartNo) throws Exception {
		String[] cartList = cartNo.split(",");

		int totalCount = sqlSession.selectOne("CartMapper.getSelectCartListTotalCount", cartList);
		List<Cart> list = sqlSession.selectList("CartMapper.getSelectCartList", cartList);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("totalCount", totalCount);
		map.put("list", list);
		
		return map;
	}

}
