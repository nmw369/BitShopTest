package com.withdog.service.review.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.withdog.common.Search;
import com.withdog.service.domain.Review;
import com.withdog.service.review.ReviewDAO;
import com.withdog.service.review.ReviewService;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	@Qualifier("reviewDAOImpl")
	private ReviewDAO reviewDAO;
	
	// INSERT 후기등록
	@Override
	public void addReview(Review  review) throws Exception{
		reviewDAO.addReview(review);
	}

	@Override
	public Map<String, Object> getReviewList(Search search, int prodNo) throws Exception {
		return reviewDAO.getReviewList(search, prodNo);
	}

}
