package com.withdog.service.purchase;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Purchase;
import com.withdog.service.domain.User;



public interface PurchaseDAO {

	// ��ǰ����
	public int addPurchase(Purchase  purchase) throws Exception;
	
	// ���� purchaseNo
	public int addPurchaseSeq() throws Exception;
	
	// ���� cartNo
	public int addCartSeq() throws Exception ;
	
	// prodNo ��ȸ
	public Purchase  getProdNo(int cartNo) throws Exception;

	// ���Ǳ��ų��� ����ȸ / �ǸŰ��� ����ȸ
	public List<Purchase> getPurchase(int purchaseNo) throws Exception;

	// ���ų�������Ʈ / �ǸŰ�������Ʈ
	public  List<Purchase> getPurchaseList(Search search, User user) throws Exception;

	// �������� ����
	public void updatePurchase(Purchase purchase) throws Exception;
	
	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getTotalCount(User user) throws Exception ;

	//�����ڵ� ���� 
	public void updatePurchaseCondition(Purchase purchase) throws Exception;
	
	//īƮ�ѹ��� �����ڵ� ���� 
	public void updateCartNoPurchaseCondition(int cartNo) throws Exception;

	//�ı��ۼ��ȵ� ��ǰ�� ������
	public List<Purchase> getPurchaseCondition(int purchaseNo) throws Exception;
	
}
