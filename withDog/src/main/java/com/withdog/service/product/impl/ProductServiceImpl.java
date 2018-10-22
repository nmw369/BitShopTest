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

//==> 상품관리 서비스 구현
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
		System.out.println("프러덕트 서비스 임플 생성자 호출");
	}
	
	//상품등록
	public void addProductAdmin(Product product) throws Exception{
		productDAO.addProductAdmin(product);
	}

	//상품상세조회
	public Product getProduct(int prodNo) throws Exception{      
		return productDAO.getProduct(prodNo); //상품조회  getProduct(int prodNo) 는 리턴값이 protuctVO
	}
	
	//상품수정
	public void updateProductAdmin(Product product) throws Exception{
		productDAO.updateProductAdmin(product);
	}
	
	//상품수정
	public void updateDeleteFlag(Product product) throws Exception{
		productDAO.updateDeleteFlag(product);
	}
	

	//상품리스트조회
	public Map<String, Object> getProductList(Search search) throws Exception{  
		
		List<Product> list = productDAO.getProductList(search);
		int totalCount = productDAO.getTotalCount(search);
		//return productDao.getProductList(search); //상품목록은 리턴값이맵 //기존의 서비스 임플에서 바로 dao.~~() 호출
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}


}//end of class
