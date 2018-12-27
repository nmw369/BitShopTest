package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;



//==> ȸ���������� ������ ���� �߻�ȭ/ĸ��ȭ�� Service  Interface Definition  
public interface ProductService {
	public int addProduct(Product product) throws Exception;
	
	public Product getProduct(int prodNo) throws Exception;
	
	public void updateProduct(Product product) throws Exception;
	
	public Map<String,Object> getProductList(Search search) throws Exception;
	
	public Map<String,Object> getMainList() throws Exception;
	
	public void updateLookup(Product product) throws Exception;
	
	public void daycheck(String today ,Product product) throws Exception;
	
	public Map<String,Object> getLookupList(String today) throws Exception;
	
	public void updateEA(int sEA,Product prod) throws Exception;
	
	public void updateNEA(int sEA,Product prod) throws Exception;
	
	public List<Product> getProdSearch(Search search) throws Exception;
	
	public List<Product> getScroll(Search search) throws Exception;
		
}