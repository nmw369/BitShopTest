package com.withdog.service.doginfo;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.DogInfo;
import com.withdog.service.domain.RecommendInfo;
import com.withdog.service.domain.User;

public interface DogInfoService {
	public void addDogInfo(DogInfo dogInfo) throws Exception;

	public DogInfo getDogInfo(int dogInfoNo,User user) throws Exception;
	
	public void deleteRecommendInfo(int dogInfoNo, User user) throws Exception;

	public void updateDogInfo(DogInfo dogInfo) throws Exception;

	public Map<String,Object> getDogInfoList(Search search,User user) throws Exception;

	public void deleteDogInfo(DogInfo dogInfo) throws Exception;

	public void updateRecommend(DogInfo dogInfo) throws Exception;
	
	public void updateViewCount(DogInfo dogInfo) throws Exception;
	
	public void addRecommendInfo(RecommendInfo recommendInfo) throws Exception;
	
}
