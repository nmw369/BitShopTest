package com.withdog.service.purchase;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Purchase;
import com.withdog.service.domain.User;



public interface PurchaseDAO {

	// 상품구매
	public int addPurchase(Purchase  purchase) throws Exception;
	
	// 다음 purchaseNo
	public int addPurchaseSeq() throws Exception;
	
	// 다음 cartNo
	public int addCartSeq() throws Exception ;
	
	// prodNo 조회
	public Purchase  getProdNo(int cartNo) throws Exception;

	// 나의구매내역 상세조회 / 판매관리 상세조회
	public List<Purchase> getPurchase(int purchaseNo) throws Exception;

	// 구매내역리스트 / 판매관리리스트
	public  List<Purchase> getPurchaseList(Search search, User user) throws Exception;

	// 구매정보 수정
	public void updatePurchase(Purchase purchase) throws Exception;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(User user) throws Exception ;

	//구매코드 변경 
	public void updatePurchaseCondition(Purchase purchase) throws Exception;
	
	//카트넘버로 구매코드 변경 
	public void updateCartNoPurchaseCondition(int cartNo) throws Exception;

	//후기작성안된 상품만 들고오는
	public List<Purchase> getPurchaseCondition(int purchaseNo) throws Exception;
	
}
