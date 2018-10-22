package com.withdog.service.product;

import java.util.List;

import com.withdog.common.Search;
import com.withdog.service.domain.Product;

public interface ProductDAO{
	
	// INSERT 상품등록
	public void addProductAdmin(Product  product) throws Exception;
	
	// UPDATE 상품수정
	public void updateProductAdmin(Product  product) throws Exception;
	
	// UPDATE 상품삭제
	public void updateDeleteFlag(Product  product) throws Exception;
	
	// SELECT ONE 상품조회 
	public Product  getProduct(int prodNo) throws Exception;

	// SELECT LIST 상품목록조회
	public List<Product> getProductList(Search search) throws Exception;

	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception;

}//end of class


