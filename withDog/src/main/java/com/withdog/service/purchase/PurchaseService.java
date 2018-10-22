package com.withdog.service.purchase;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Purchase;
import com.withdog.service.domain.User;

public interface PurchaseService {
	
	// 구매
	public int addPurchase(Purchase purchase) throws Exception;
	
	// 다음 purchaseNo
	public int addPurchaseSeq() throws Exception ;

	// 다음 cartNo
	public int addCartSeq() throws Exception ;
	
	// prodNo 조회
	public Purchase  getProdNo(int cartNo) throws Exception;
	
	//구매리스트 / 판매관리리스트
	public Map<String,Object> getPurchaseList(Search search,User user) throws Exception;
	
	//구매상세정보 / 판매상세정보
	public List<Purchase> getPurchase(int purchaseNo) throws Exception;

	//구매정보수정
	public void updatePurchase(Purchase purchase) throws Exception;
	
	//구매상태변경 
	public void updatePurchaseCondition(Purchase purchase) throws Exception;
	
	//카트넘버로 구매코드 변경 
	public void updateCartNoPurchaseCondition(int cartNo) throws Exception;
	
	//후기작성안된 상품만 들고오는
	public List<Purchase> getPurchaseCondition(int purchaseNo) throws Exception;
	
	
}