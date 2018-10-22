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

//==> ȸ���������� ������ ���� �߻�ȭ/ĸ��ȭ�� Service  Interface Definition  

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
		//����Ʈ�θ� �����Ѱ��
		if(point.getUsePoint()!=0&&point.getPoint()==0) {
			System.out.println("����Ʈ�����");
			commonDAO.usePoint(point);
		}
		//���ݰ����� �������Ѱ��
		else if(point.getUsePoint()==0&&point.getPoint()!=0){
			System.out.println("���ݸ����");
			commonDAO.savePoint(point);
		}
		//���ݰ���+����Ʈ ��� ���� ������ ��� ���� �ִ°��
		else {
			System.out.println("����+����Ʈ �Ѵ� ���");
			commonDAO.savePoint(point);
			System.out.println("�־ȵɱ�?");
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