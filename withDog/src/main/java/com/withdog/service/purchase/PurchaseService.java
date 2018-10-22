package com.withdog.service.purchase;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Purchase;
import com.withdog.service.domain.User;

public interface PurchaseService {
	
	// ����
	public int addPurchase(Purchase purchase) throws Exception;
	
	// ���� purchaseNo
	public int addPurchaseSeq() throws Exception ;

	// ���� cartNo
	public int addCartSeq() throws Exception ;
	
	// prodNo ��ȸ
	public Purchase  getProdNo(int cartNo) throws Exception;
	
	//���Ÿ���Ʈ / �ǸŰ�������Ʈ
	public Map<String,Object> getPurchaseList(Search search,User user) throws Exception;
	
	//���Ż����� / �ǸŻ�����
	public List<Purchase> getPurchase(int purchaseNo) throws Exception;

	//������������
	public void updatePurchase(Purchase purchase) throws Exception;
	
	//���Ż��º��� 
	public void updatePurchaseCondition(Purchase purchase) throws Exception;
	
	//īƮ�ѹ��� �����ڵ� ���� 
	public void updateCartNoPurchaseCondition(int cartNo) throws Exception;
	
	//�ı��ۼ��ȵ� ��ǰ�� ������
	public List<Purchase> getPurchaseCondition(int purchaseNo) throws Exception;
	
	
}