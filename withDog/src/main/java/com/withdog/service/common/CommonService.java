package com.withdog.service.common;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Point;
import com.withdog.service.domain.PushToken;

//==> 회원관리에서 서비스할 내용 추상화/캡슐화한 Service  Interface Definition  
public interface CommonService {
	
	public Map<String,Object> getMyPointList(Point point) throws Exception;
	
	public void addPointinfo(Point point)throws Exception;
	
	public int getCurrentPoint(Point point)throws Exception;
	
	public Map<String,Object> getMyPointList(Search search , String userId) throws Exception;
	
	public void deletePushToken(String deviceId) throws Exception;
		
	public void addPushToken(PushToken pushToken) throws Exception;
	
	public List<String> getPushToken(String userId) throws Exception;
}