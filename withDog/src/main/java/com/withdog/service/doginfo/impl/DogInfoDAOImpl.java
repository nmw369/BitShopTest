package com.withdog.service.doginfo.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.withdog.common.Search;
import com.withdog.service.doginfo.DogInfoDAO;
import com.withdog.service.domain.DogInfo;
import com.withdog.service.domain.RecommendInfo;
import com.withdog.service.domain.User;

@Repository("dogInfoDAOImpl")
public class DogInfoDAOImpl implements DogInfoDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public DogInfoDAOImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addDogInfo(DogInfo dogInfo) throws Exception {
		sqlSession.insert("DogInfoMapper.addDogInfo", dogInfo);
	}

	@Override
	public DogInfo getDogInfoByRecommend(int dogInfoNo, User user) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dogInfoNo", dogInfoNo);
		map.put("user", user);
		return sqlSession.selectOne("DogInfoMapper.getDogInfoByRecommend", map);
	}

	@Override
	public DogInfo getDogInfo(int dogInfoNo) throws Exception {
		return sqlSession.selectOne("DogInfoMapper.getDogInfo", dogInfoNo);
	}

	@Override
	public void updateDogInfo(DogInfo dogInfo) throws Exception {
		sqlSession.update("DogInfoMapper.updateDogInfo", dogInfo);
	}

	@Override
	public List<DogInfo> getDogInfoList(Search search, User user) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("search", search);
		map.put("user", user);
		
		return sqlSession.selectList("DogInfoMapper.getDogInfoList", map);
	}

	@Override
	public void deleteDogInfo(DogInfo dogInfo) throws Exception {
		sqlSession.update("DogInfoMapper.deleteDogInfo",dogInfo);

	}

	@Override
	public void updateRecommend(DogInfo dogInfo) throws Exception {
		sqlSession.update("DogInfoMapper.updateRecommend", dogInfo);

	}

	@Override
	public int getTotalCount(Search search,User user) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("search", search);
		map.put("user", user);
		return sqlSession.selectOne("DogInfoMapper.getTotalCount", map);
	}

	@Override
	public void updateViewCount(DogInfo dogInfo) throws Exception {
		sqlSession.update("DogInfoMapper.updateViewCount", dogInfo);

	}

	@Override
	public void updateRecommendInfo(RecommendInfo recommendInfo) throws Exception {
		sqlSession.update("DogInfoMapper.updateRecommendInfo", recommendInfo);

	}

	@Override
	public void addRecommendInfo(RecommendInfo recommendInfo) throws Exception {
		sqlSession.insert("DogInfoMapper.addRecommendInfo", recommendInfo);
	}

	@Override
	public int getRecommendInfo(DogInfo dogInfo) throws Exception {
		return sqlSession.selectOne("DogInfoMapper.getRecommendInfo", dogInfo);
	}

	@Override
	public void deleteRecommendInfo(int dogInfoNo, User user) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dogInfoNo", dogInfoNo);
		map.put("user", user);
		sqlSession.delete("DogInfoMapper.deleteRecommendInfo", map);

	}

	@Override
	public int getTopicCount(String dogInfoTopic,User user) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dogInfoTopic", dogInfoTopic);
		map.put("user", user);
		return sqlSession.selectOne("DogInfoMapper.countDogInfoTopic", map);
	}
}
