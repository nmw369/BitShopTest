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


//==> ���Ű��� ���� ����
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
			System.out.println(" purchase service impl ������ ȣ��");
		}
		
		///Method
		//���ſ�û
		public int addPurchase(Purchase purchase) throws Exception{
			System.out.println(" purchase service impl ����");
			
			return purchaseDAO.addPurchase(purchase);
		}
		
		// ���� purchaseNo
		public int addPurchaseSeq() throws Exception {
			return purchaseDAO.addPurchaseSeq();
		}
		
		// ���� cartNo
		@Override
		public int addCartSeq() throws Exception {
			return purchaseDAO.addCartSeq();
		}
		
		
		
		//���Ǳ��ų���
		@Override
		public Map<String,Object> getPurchaseList(Search search, User user) throws Exception {
			System.out.println("���Ǳ��ų�����������" + user);
			Map<String,Object> map = new HashMap<String,Object>();
			List<Purchase> list = purchaseDAO.getPurchaseList(search, user);
			
			int totalCount = purchaseDAO.getTotalCount(user);
			map.put("list", list);
			map.put("totalCount",totalCount);
			
			return map;
		}
		
		//���Ǳ��Ż�����
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
