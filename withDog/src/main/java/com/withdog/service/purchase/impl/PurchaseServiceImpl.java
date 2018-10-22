package com.withdog.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.withdog.common.Search;
import com.withdog.service.domain.Ash;
import com.withdog.service.domain.Fund;
import com.withdog.service.domain.Purchase;
import com.withdog.service.domain.User;
import com.withdog.service.purchase.PurchaseDAO;
import com.withdog.service.purchase.PurchaseService;


//==> 구매관리 서비스 구현
@Service("purchaseServiceImpl")

public class PurchaseServiceImpl implements PurchaseService  {
		
	///Field
		@Autowired
		@Qualifier("purchaseDAOImpl")
		 PurchaseDAO  purchaseDAO;
		
		public void setPurchaseDAO(PurchaseDAO purchaseDAO){
			this.purchaseDAO=purchaseDAO;
		}

		///Constructor
		public PurchaseServiceImpl() {
			System.out.println(" purchase service impl 생성자 호출");
		}
		
		///Method
		//구매요청
		public int addPurchase(Purchase purchase) throws Exception{
			System.out.println(" purchase service impl 시작");
			
			return purchaseDAO.addPurchase(purchase);
		}
		
		// 다음 purchaseNo
		public int addPurchaseSeq() throws Exception {
			return purchaseDAO.addPurchaseSeq();
		}
		
		// 다음 cartNo
		@Override
		public int addCartSeq() throws Exception {
			return purchaseDAO.addCartSeq();
		}
		
		
		
		//나의구매내역
		@Override
		public Map<String,Object> getPurchaseList(Search search, User user) throws Exception {
			System.out.println("나의구매내역서비스유저" + user);
			Map<String,Object> map = new HashMap<String,Object>();
			List<Purchase> list = purchaseDAO.getPurchaseList(search, user);
			
			int totalCount = purchaseDAO.getTotalCount(user);
			map.put("list", list);
			map.put("totalCount",totalCount);
			
			return map;
		}
		
		//나의구매상세정보
		@Override
		public List<Purchase> getPurchase(int purchaseNo) throws Exception {
			return purchaseDAO.getPurchase(purchaseNo);
		}
		
		@Override
		public void updatePurchaseCondition(Purchase purchase) throws Exception {
			purchaseDAO.updatePurchaseCondition(purchase);
		}
		
		@Override
		public void updatePurchase(Purchase purchase) throws Exception {
			purchaseDAO.updatePurchase(purchase);
		}

		@Override
		public Purchase getProdNo(int cartNo) throws Exception {
			return purchaseDAO.getProdNo(cartNo);
		}

		@Override
		public void updateCartNoPurchaseCondition(int cartNo) throws Exception {
			purchaseDAO.updateCartNoPurchaseCondition(cartNo);
		}

		@Override
		public List<Purchase> getPurchaseCondition(int purchaseNo) throws Exception {
			return purchaseDAO.getPurchaseCondition(purchaseNo);
		}
		
}//end of class
