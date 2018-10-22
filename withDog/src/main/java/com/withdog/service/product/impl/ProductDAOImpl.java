package com.withdog.service.product.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.withdog.common.Search;
import com.withdog.service.domain.Product;
import com.withdog.service.domain.User;
import com.withdog.service.product.ProductDAO;


//==> 상품관리 DAO CRUD 구현
@Repository("productDAOImpl")
public class ProductDAOImpl implements ProductDAO {
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession; 
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public ProductDAOImpl() {
		System.out.println("product dao impl생성자 호출");
	}

	///Method
	@Override
	public void addProductAdmin(Product product) throws Exception {
		System.out.println("확인용 : "+product);
		sqlSession.insert("ProductMapper.addProductAdmin", product);
		System.out.println("확인용 : "+product);
	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		return sqlSession.selectOne("ProductMapper.getProduct",prodNo);
	}


	@Override
	public void updateProductAdmin(Product product) throws Exception {
		sqlSession.update("ProductMapper.updateProductAdmin", product);
	}
	
	
	@Override
	public void updateDeleteFlag(Product product) throws Exception {
		sqlSession.update("ProductMapper.updateDeleteFlag", product);
	}

	@Override
	public List<Product> getProductList(Search search) throws Exception {
		System.out.println("매퍼들어가기전 서치" + search);
		return sqlSession.selectList("ProductMapper.getProductList",search);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}
//	
}//end of class
