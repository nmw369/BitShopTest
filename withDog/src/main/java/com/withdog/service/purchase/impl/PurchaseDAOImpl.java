package com.withdog.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.withdog.common.Search;
import com.withdog.service.domain.Ash;
import com.withdog.service.domain.Fund;
import com.withdog.service.domain.Purchase;
import com.withdog.service.domain.User;
import com.withdog.service.purchase.PurchaseDAO;


@Repository("purchaseDAOImpl")
public class PurchaseDAOImpl implements PurchaseDAO{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public PurchaseDAOImpl() {
		System.out.println(this.getClass());
	}
	
	//����
	@Override
	public int addPurchase(Purchase purchase) throws Exception {
		System.out.println("��ü�̽� �ٿ� ����");
	
		return sqlSession.insert("PurchaseMapper.addPurchase", purchase);
	}
	
	// ���� purchaseNo
	public int addPurchaseSeq() throws Exception {
		return sqlSession.selectOne("PurchaseMapper.addPurchaseSeq");
	}

	// ���� cartNo
	@Override
	public int addCartSeq() throws Exception {
		return sqlSession.selectOne("PurchaseMapper.addCartSeq");
	}
	
	//���Ǳ��ų�������Ʈ / �ǸŰ�������Ʈ
	@Override
	public  List<Purchase> getPurchaseList(Search search, User user) throws Exception{
		System.out.println("purchaseDAOImpl : getPurchaseList Start");
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("search",search);
		map.put("user", user);
		
		System.out.println(map);
		return sqlSession.selectList("PurchaseMapper.getPurchaseList",map);
	}
	
	//���Ǳ��Ż����� / �ǸŰ���������
	@Override
	public List<Purchase> getPurchase(int purchaseNo) throws Exception {
		System.out.println("��ü�̽��ѹ�"+purchaseNo);
		return sqlSession.selectList("PurchaseMapper.getPurchase", purchaseNo);
	}
	
	@Override
	public void updatePurchaseCondition(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updatePurchaseCondition", purchase);
	}
	
	@Override
	public int getTotalCount(User user) throws Exception {
		Map<String , Object>  map = new HashMap<String, Object>();
		map.put("user", user);
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", map);
	}
	
	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		System.out.println("purchaseDAOImpl : updatePurchase Start");
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}
	
	@Override
	public Purchase getProdNo(int cartNo) throws Exception {
		System.out.println("purchaseDAOImpl : getProdNo Start");
		return sqlSession.selectOne("PurchaseMapper.getProdNo", cartNo);
	}

	@Override
	public void updateCartNoPurchaseCondition(int cartNo) throws Exception {
		sqlSession.update("PurchaseMapper.updateCartNoPurchaseCondition", cartNo);
		
	}

	@Override
	public List<Purchase> getPurchaseCondition(int purchaseNo) throws Exception {
		return sqlSession.selectList("PurchaseMapper.getPurchaseCondition", purchaseNo);
	}
	
	
	
	
}
