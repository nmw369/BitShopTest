package com.withdog.service.common.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.withdog.common.Search;
import com.withdog.service.common.CommonDAO;
import com.withdog.service.common.CommonService;
import com.withdog.service.domain.Fund;
import com.withdog.service.domain.Point;
import com.withdog.service.domain.PushToken;

//==> 회원관리에서 서비스할 내용 추상화/캡슐화한 Service  Interface Definition  

@Service("commonServiceImpl")
public class CommonServiceImpl implements CommonService{

	@Autowired
	@Qualifier("CommonDAOImpl")
	private CommonDAO commonDAO;
	
	
	
	@Override
	public Map<String, Object> getMyPointList(Point point) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}



	@Override
	public void addPointinfo(Point point) throws Exception {
		System.out.println("addPoint Start");
		//포인트로만 구매한경우
		if(point.getUsePoint()!=0&&point.getPoint()==0) {
			System.out.println("포인트만사용");
			commonDAO.usePoint(point);
		}
		//현금결제로 적립만한경우
		else if(point.getUsePoint()==0&&point.getPoint()!=0){
			System.out.println("현금만사용");
			commonDAO.savePoint(point);
		}
		//현금결제+포인트 사용 으로 적립및 사용 전부 있는경우
		else {
			System.out.println("현금+포인트 둘다 사용");
			commonDAO.savePoint(point);
			System.out.println("왜안될까?");
			System.out.println(point.getUsePoint());
			commonDAO.usePoint(point);
			
		}
		
	}


	

	@Override
	public int getCurrentPoint(Point point) throws Exception {
		return commonDAO.getCurrentPoint(point);
	}



	@Override
	public Map<String, Object> getMyPointList(Search search, String userId) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		List<Point> list = commonDAO.getMyPointList(search , userId);
		int totalCount = commonDAO.getTotalCount(search,userId);
		map.put("list", list);
		map.put("totalCount",totalCount);
		
		return map;
	}
	
	
	@Override
	public void deletePushToken(String deviceId) throws Exception{
		commonDAO.deletePushToken(deviceId);
	}
	
	@Override
	public void addPushToken(PushToken pushToken) throws Exception{
		commonDAO.addPushToken(pushToken);
	}	
	
	@Override
	public List<String> getPushToken(String userId) throws Exception{
		return commonDAO.getPushToken(userId);
	}
		
}