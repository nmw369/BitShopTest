package com.withdog.service.common.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.withdog.common.Search;
import com.withdog.service.common.CommonDAO;
import com.withdog.service.domain.Point;
import com.withdog.service.domain.PushToken;

//==> 회원관리에서 서비스할 내용 추상화/캡슐화한 Service  Interface Definition

@Repository("CommonDAOImpl")
public class CommonDAOImpl implements CommonDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	
	
	@Override
	public Map<String, Object> getMyPointList(Point point) throws Exception {
		return null;
	}



	@Override
	public void savePoint(Point point) throws Exception {
	
			System.out.println("FundPointSAVE");
			
			System.out.println("check:"+point.getUser().getUserId());
			
			//현재포인트가 없는 사람도 적립은 되야함
			int currentPoint=0;
			
			if(sqlSession.selectOne("CommonMapper.currentPoint", point)!=null) {
				currentPoint=sqlSession.selectOne("CommonMapper.currentPoint", point);
			}
			
			System.out.println(":::::"+currentPoint);
			int resultPoint = currentPoint + point.getPoint();
			System.out.println(resultPoint);
			point.setCurrentPoint(resultPoint);
			
			
			System.out.println(point.toString());
			//System.out.println(point.getFund().getFundMyPriceNo());
			sqlSession.insert("CommonMapper.addPointSave",point);
			System.out.println("FundPointSAVE END");
		
	}



	@Override
	public void usePoint(Point point) throws Exception {
		System.out.println("addPointDAO STart");
		
		System.out.println("FundPoint");
				
		System.out.println("check:"+point.getUser().getUserId());
						
		int currentPoint=sqlSession.selectOne("CommonMapper.currentPoint", point);
		
		System.out.println(":::::"+currentPoint);
		int resultPoint = currentPoint - point.getUsePoint();
		System.out.println(resultPoint);
		point.setCurrentPoint(resultPoint);
		
		
		System.out.println(point.toString());
		sqlSession.insert("CommonMapper.addPointUse",point);
		

	}

	
	


	@Override
	public int getCurrentPoint(Point point) throws Exception {
		int currentPoint =(sqlSession.selectOne("CommonMapper.currentPoint", point)!=null? sqlSession.selectOne("CommonMapper.currentPoint", point) : 0); 
		return currentPoint;
	}



	@Override
	public List<Point> getMyPointList(Search search , String userId) throws Exception {
		System.out.println("PointList Start");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userId", userId);
		map.put("search", search);
		return sqlSession.selectList("CommonMapper.myPointList",map);
	}



	@Override
	public int getTotalCount(Search search,String userId) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userId", userId);
		map.put("search", search);
		return sqlSession.selectOne("CommonMapper.getTotalCount",map);
	}


	@Override
	public void deletePushToken(String deviceId) throws Exception{
		sqlSession.delete("CommonMapper.deletePushToken", deviceId);
	}
	
	@Override
	public void addPushToken(PushToken pushToken) throws Exception{
		sqlSession.insert("CommonMapper.addPushToken", pushToken);
	}
	
	@Override
	public List<String> getPushToken(String userId) throws Exception{
		return sqlSession.selectList("CommonMapper.getPushToken", userId);
	}
		
}