package com.withdog.service.review.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.withdog.common.Search;
import com.withdog.service.domain.Inquiry;
import com.withdog.service.domain.Review;
import com.withdog.service.review.ReviewDAO;

@Repository("reviewDAOImpl")
public class ReviewDAOImpl implements ReviewDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession; 
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public ReviewDAOImpl() {
		System.out.println("ReviewDAOImpl 생성자 호출");
	}
	
	// INSERT 후기등록
	@Override
	public void addReview(Review  review) throws Exception{
		System.out.println("reviewDAOImpl : addReview"  + review.getProduct().getProdNo() + "//////" + review.getPurchase().getCartNo());
		System.out.println(review.getUser().getUserId());
		System.out.println(review.toString());
		sqlSession.insert("ReviewMapper.addReview", review);
	}

	@Override
	public Map<String, Object> getReviewList(Search search, int prodNo) throws Exception {
		System.out.println("getReviewList 시작");
		Map<String, Object> mapIn = new HashMap<String, Object>();
		mapIn.put("search", search);
		mapIn.put("prodNo", prodNo);	
		
		int totalCount = sqlSession.selectOne("ReviewMapper.getReviewListCount", prodNo);
		List<Review> list = sqlSession.selectList("ReviewMapper.getReviewList", mapIn);
		
		System.out.println("222222222222222222222222222");

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("totalCount", totalCount);
		map.put("list", list);

		return map;
	}

}
