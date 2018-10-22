package com.withdog.service.product;

import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Product;

public interface ProductService {
	
	public void addProductAdmin(Product product) throws Exception;

	public void updateProductAdmin(Product product) throws Exception;
	
	public void updateDeleteFlag(Product  product) throws Exception;
	
	public Product getProduct(int prodNo) throws Exception;

	public Map<String,Object> getProductList(Search search) throws Exception;

	
}