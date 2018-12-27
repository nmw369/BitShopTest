package com.model2.mvc.service.purchase.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	public PurchaseDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void insertPurchase(Purchase purchase) throws Exception {
		System.out.println("�̰���!!!!!!!!!!!!!!!!!!!!!!!!!"+purchase);
		
		sqlSession.insert("PurchaseMapper.addPurchase",purchase);
	}
	@Override
	public int updatePurchase(Purchase purchase) throws Exception {
		return sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}
	@Override
	public int updateTranCode(Purchase purchase) throws Exception {
		return sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}
	@Override
	public Purchase getPurchase(int tranNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchase", tranNo);
	}
	@Override
	public List<Purchase> getPurchaseList(Search search, String buyerId) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("buyerId", buyerId);
		map.put("search", search);
		return sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
	}
	@Override
	public int getTotalCount(Search search, String buyerId) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", buyerId);
	}
	@Override
	public int getallTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getallTotalCount");
	}
	@Override
	public void updateCancelCode(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("PurchaseMapper.updateCancelCode",purchase);
	}
	@Override
	public List<Purchase> cancelList(Search search) throws Exception {
		// TODO Auto-generated method stub
		/*Map<String,Object> map = new HashMap<String,Object>();
		map.put("search", search);*/
		return sqlSession.selectList("PurchaseMapper.cancelList",search);
	}
	
	@Override
	public List<Purchase> saleList(Search search) throws Exception {
		// TODO Auto-generated method stub
		/*Map<String,Object> map = new HashMap<String,Object>();
		map.put("search", search);*/
		return sqlSession.selectList("PurchaseMapper.saleList",search);
	}
	
	
}
