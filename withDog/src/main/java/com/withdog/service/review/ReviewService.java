package com.withdog.service.review;

import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Review;

public interface ReviewService {
	
	// 후기등록
	public void addReview(Review  review) throws Exception;
	
	// 후기리스트
	public Map<String,Object> getReviewList(Search search, int prodNo) throws Exception;
		
}