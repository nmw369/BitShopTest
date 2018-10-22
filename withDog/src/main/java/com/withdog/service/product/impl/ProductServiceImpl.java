package com.withdog.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.withdog.common.Search;
import com.withdog.service.domain.Product;
import com.withdog.service.product.ProductDAO;
import com.withdog.service.product.ProductService;

//==> ��ǰ���� ���� ����
@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService  {
	
	///Field
	@Autowired
	@Qualifier("productDAOImpl")
	
	ProductDAO productDAO;
	
	public void setProductDAO(ProductDAO productDAO){
		this.productDAO=productDAO;
	}
	
	///Constructor
	public ProductServiceImpl() {
		System.out.println("������Ʈ ���� ���� ������ ȣ��");
	}
	
	//��ǰ���
	public void addProductAdmin(Product product) throws Exception{
		productDAO.addProductAdmin(product);
	}

	//��ǰ����ȸ
	public Product getProduct(int prodNo) throws Exception{      
		return productDAO.getProduct(prodNo); //��ǰ��ȸ  getProduct(int prodNo) �� ���ϰ��� protuctVO
	}
	
	//��ǰ����
	public void updateProductAdmin(Product product) throws Exception{
		productDAO.updateProductAdmin(product);
	}
	
	//��ǰ����
	public void updateDeleteFlag(Product product) throws Exception{
		productDAO.updateDeleteFlag(product);
	}
	

	//��ǰ����Ʈ��ȸ
	public Map<String, Object> getProductList(Search search) throws Exception{  
		
		List<Product> list = productDAO.getProductList(search);
		int totalCount = productDAO.getTotalCount(search);
		//return productDao.getProductList(search); //��ǰ����� ���ϰ��̸� //������ ���� ���ÿ��� �ٷ� dao.~~() ȣ��
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}


}//end of class
