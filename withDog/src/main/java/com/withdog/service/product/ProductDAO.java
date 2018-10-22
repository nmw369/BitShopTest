package com.withdog.service.product;

import java.util.List;

import com.withdog.common.Search;
import com.withdog.service.domain.Product;

public interface ProductDAO{
	
	// INSERT ��ǰ���
	public void addProductAdmin(Product  product) throws Exception;
	
	// UPDATE ��ǰ����
	public void updateProductAdmin(Product  product) throws Exception;
	
	// UPDATE ��ǰ����
	public void updateDeleteFlag(Product  product) throws Exception;
	
	// SELECT ONE ��ǰ��ȸ 
	public Product  getProduct(int prodNo) throws Exception;

	// SELECT LIST ��ǰ�����ȸ
	public List<Product> getProductList(Search search) throws Exception;

	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getTotalCount(Search search) throws Exception;

}//end of class


