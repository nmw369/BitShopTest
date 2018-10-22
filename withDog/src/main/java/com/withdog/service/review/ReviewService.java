package com.withdog.service.review;

import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Review;

public interface ReviewService {
	
	// �ı���
	public void addReview(Review  review) throws Exception;
	
	// �ı⸮��Ʈ
	public Map<String,Object> getReviewList(Search search, int prodNo) throws Exception;
		
}