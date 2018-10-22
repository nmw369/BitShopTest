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
	
	//장바구니 담기
	public void addCart(Cart cart) throws Exception{
		sqlSession.insert("CartMapper.addCart", cart);
	}
	
	//장바구니 중복체크용
	@Override
	public Cart getCart(String userId, int prodNo) throws Exception {
		Map<String, Object> mapIn = new HashMap<String, Object>();
		mapIn.put("userId", userId);
		mapIn.put("prodNo", prodNo);
		System.out.println(mapIn);
		return sqlSession.selectOne("CartMapper.getCart", mapIn);
	}
	
	//수량변경
	@Override
	public void updateCart(Cart cart) throws Exception {
		sqlSession.update("CartMapper.updateCart", cart);
	}
	
	//장바구니 리스트
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
	
	//장바구니 개별 삭제
	@Override
	public void deleteCart(int cartNo) throws Exception {
		sqlSession.update("CartMapper.deleteCart", cartNo);
	}
	
	//장바구니 비우기
	public void deleteAllCart(String userId) throws Exception{
		sqlSession.update("CartMapper.deleteAllCart", userId);
	}
	
	//선택한 장바구니 리스트
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
