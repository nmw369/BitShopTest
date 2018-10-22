package com.withdog.service.doginfo.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.withdog.common.Search;
import com.withdog.service.dogbreeddic.DogBreedDicDAO;
import com.withdog.service.doginfo.DogInfoDAO;
import com.withdog.service.doginfo.DogInfoService;
import com.withdog.service.domain.DogInfo;
import com.withdog.service.domain.RecommendInfo;
import com.withdog.service.domain.User;

@Service("dogInfoServiceImpl")
public class DogInfoServiceImpl implements DogInfoService {

	@Autowired
	@Qualifier("dogInfoDAOImpl")
	private DogInfoDAO dogInfoDAO;

	public DogInfoServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addDogInfo(DogInfo dogInfo) throws Exception {
		dogInfoDAO.addDogInfo(dogInfo);
	}

	@Override
	public DogInfo getDogInfo(int dogInfoNo,User user) throws Exception {
		if(user==null ||dogInfoDAO.getDogInfoByRecommend(dogInfoNo, user)==null) {
			System.out.println("��õ������ ���� �Խñ۷� ����");
			return dogInfoDAO.getDogInfo(dogInfoNo);
		}else {
			System.out.println("��õ������ �ִ� �Խñ۷� ����");
			return dogInfoDAO.getDogInfoByRecommend(dogInfoNo, user);
		}
	}

	@Override
	public void updateDogInfo(DogInfo dogInfo) throws Exception {
		dogInfoDAO.updateDogInfo(dogInfo);
	}

	@Override
	public Map<String,Object> getDogInfoList(Search search,User user) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		List<DogInfo> list = dogInfoDAO.getDogInfoList(search, user);
		int totalCount = dogInfoDAO.getTotalCount(search,user);
		List<Integer> topicCount = new ArrayList<Integer>();
		
		for(int i = 1; i<9; i++) { // �������� � �� �ִ���
			topicCount.add(dogInfoDAO.getTopicCount(Integer.toString(i),user));	
		}
		
		map.put("list", list);
		map.put("totalCount", totalCount);
		map.put("topicCount", topicCount);
		
		return map;
	}

	@Override
	public void deleteDogInfo(DogInfo dogInfo) throws Exception {
		dogInfoDAO.deleteDogInfo(dogInfo);

	}

	@Override
	public void updateRecommend(DogInfo dogInfo) throws Exception {
		dogInfoDAO.updateRecommend(dogInfo);
		
	}

	@Override
	public void updateViewCount(DogInfo dogInfo) throws Exception {
		dogInfoDAO.updateViewCount(dogInfo);
		
	}
	
	public void addRecommendInfo(RecommendInfo recommendInfo) throws Exception{
		dogInfoDAO.addRecommendInfo(recommendInfo);
	}

	@Override
	public void deleteRecommendInfo(int dogInfoNo, User user) throws Exception {
		dogInfoDAO.deleteRecommendInfo(dogInfoNo, user);
		
	}
	
	
}
