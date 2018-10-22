package com.withdog.service.doginfo;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.DogInfo;
import com.withdog.service.domain.RecommendInfo;
import com.withdog.service.domain.User;

public interface DogInfoDAO {
	public void addDogInfo(DogInfo dogInfo) throws Exception;
	
	public void addRecommendInfo(RecommendInfo recommendInfo) throws Exception;
	
	public void deleteRecommendInfo(int dogInfoNo, User user) throws Exception;

	public DogInfo getDogInfoByRecommend(int dogInfoNo, User user) throws Exception;
	
	public DogInfo getDogInfo(int dogInfoNo) throws Exception;
	
	public int getRecommendInfo(DogInfo dogInfo) throws Exception;

	public void updateDogInfo(DogInfo dogInfo) throws Exception;

	public List<DogInfo> getDogInfoList(Search search,User user) throws Exception;

	public void deleteDogInfo(DogInfo dogInfo) throws Exception;

	public void updateRecommend(DogInfo dogInfo) throws Exception;

	public void updateRecommendInfo(RecommendInfo recommendInfo) throws Exception;
	
	public void updateViewCount(DogInfo dogInfo) throws Exception;
	
	public int getTopicCount(String dogInfoTopic,User user) throws Exception;
	
	public int getTotalCount(Search search,User user) throws Exception;

}
