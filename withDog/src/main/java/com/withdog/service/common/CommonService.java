package com.withdog.service.common;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Point;
import com.withdog.service.domain.PushToken;

//==> ȸ���������� ������ ���� �߻�ȭ/ĸ��ȭ�� Service  Interface Definition  
public interface CommonService {
	
	public Map<String,Object> getMyPointList(Point point) throws Exception;
	
	public void addPointinfo(Point point)throws Exception;
	
	public int getCurrentPoint(Point point)throws Exception;
	
	public Map<String,Object> getMyPointList(Search search , String userId) throws Exception;
	
	public void deletePushToken(String deviceId) throws Exception;
		
	public void addPushToken(PushToken pushToken) throws Exception;
	
	public List<String> getPushToken(String userId) throws Exception;
}