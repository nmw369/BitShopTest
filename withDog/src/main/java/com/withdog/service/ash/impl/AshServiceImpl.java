package com.withdog.service.ash.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.withdog.common.Search;
import com.withdog.service.ash.AshDAO;
import com.withdog.service.ash.AshService;
import com.withdog.service.domain.AfterAsh;
import com.withdog.service.domain.Ash;
import com.withdog.service.domain.Consulting;
import com.withdog.service.domain.HealingDog;

@Service("ashServiceImpl")
public class AshServiceImpl implements AshService {

	@Autowired
	@Qualifier("ashDAOImpl")
	private AshDAO ashDAO;

	public AshServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addHealingDog(HealingDog healingDog) throws Exception {
		ashDAO.addHealingDog(healingDog);

	}

	@Override
	public HealingDog getHealingDog(int healingDogNo) throws Exception {
		return ashDAO.getHealingDog(healingDogNo);
	}
	@Override
	public HealingDog getHealingDog2(int healingDogNo) throws Exception {
		return ashDAO.getHealingDog2(healingDogNo);
	}

	@Override
	public void updateHealingDog(HealingDog healingDog) throws Exception {
		ashDAO.updateHealingDog(healingDog);
	}

	@Override
	public List<HealingDog> getHealingDogList() throws Exception {
		return ashDAO.getHealingDogList();
	}

	@Override
	public List<HealingDog> getHealingDogListByDate(String ashReservationDate) throws Exception {
		// TODO Auto-generated method stub
		return ashDAO.getHealingDogListByDate(ashReservationDate);
	}

	@Override
	public Map<String, Object> getHealingDogList(Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		List<HealingDog> list = ashDAO.getHealingDogList(search);
		int totalCount = ashDAO.getTotalCount(search);

		map.put("list", list);
		map.put("totalCount", totalCount);
		return map;
	}

	@Override
	public List<HealingDog> getConsultingDogList() throws Exception {
		// TODO Auto-generated method stub
		return ashDAO.getConsultingDogList();
	}

	@Override
	public void addConsulting(Consulting consulting) throws Exception {
		// TODO Auto-generated method stub
		ashDAO.addConsulting(consulting);
	}

	@Override
	public Map<String, Object> getMyConsultingList(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		return ashDAO.getMyConsultingList(search, userId);
	}

	public void updateConsultingState(Consulting consulting) throws Exception {
		ashDAO.updateConsultingState(consulting);
	}

	public Map<String, Object> getConsultingAdminList(Search search) throws Exception {
		return ashDAO.getConsultingAdminList(search);
	}

	@Override
	public void addAshReservation(Ash ash) throws Exception {
		ashDAO.addAshReservation(ash);
	}

	@Override
	public Ash getAshReservation(int ashReservationNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Ash> getAshReservationByHealingDog(int healingDogNo) throws Exception {
		// TODO Auto-generated method stub
		return ashDAO.getAshReservationByHealingDog(healingDogNo);
	}

	@Override
	public List<Ash> getAshReservationList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getAshReservationAdminList(Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Ash> list = ashDAO.getAshReservationAdminList(search);
		int totalCount = ashDAO.getTotalCountByAdminASH(search);

		map.put("list", list);
		map.put("totalCount", totalCount);

		return map;
	}

	@Override
	public List<Ash> getAllAshReservationList() throws Exception { // 모든 예약현황 가져오기
		return ashDAO.getAllAshReservationList();
	}

	@Override
	public Ash getAshReservationAdmin(int ashReservationNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Ash getAshReservationTime(int healingDogNo, String ashReservationDate) throws Exception {
		// TODO Auto-generated method stub
		return ashDAO.getAshReservationTime(healingDogNo, ashReservationDate);
	}

	@Override
	public Ash getAshReservationTimeCount(int healingDogNo, String ashReservationDate) throws Exception {
		// TODO Auto-generated method stub
		return ashDAO.getAshReservationTimeCount(healingDogNo, ashReservationDate);
	}

	@Override
	public void updateAshReservationAdmin(Ash ash) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public Map<String, Object> getAshMyReservationList(Search search, String userId) throws Exception { // 나의예약ㅇ리스트
		Map<String, Object> map = new HashMap<String, Object>();
		List<Ash> list = ashDAO.getAshMyReservationList(search, userId);
		int totalCount = ashDAO.getTotalCountByMyASH(search, userId);

		map.put("list", list);
		map.put("totalCount", totalCount);
		return map;
	}

	@Override
	public Ash getAshMyReservation(int ashReservationNo) throws Exception {
		// TODO Auto-generated method stub
		return ashDAO.getAshMyReservation(ashReservationNo);
	}

	@Override
	public void updateAshMyReservation(Ash ash) throws Exception {
		ashDAO.updateAshMyReservation(ash);

	}

	@Override
	public void updateMyReservationCondition(Ash ash) throws Exception {
		ashDAO.updateMyReservationCondition(ash);
	}

	@Override
	public Ash getAshMyReservationByUser(Ash ash, String userId) throws Exception {
		// TODO Auto-generated method stub
		return ashDAO.getAshMyReservationByUser(ash, userId);
	}

	@Override
	public List<Ash> getAshReservationTimeCountByAndroid(String ashReservationDate) throws Exception {
		return ashDAO.getAshReservationTimeCountByAndroid(ashReservationDate);
	}

}
