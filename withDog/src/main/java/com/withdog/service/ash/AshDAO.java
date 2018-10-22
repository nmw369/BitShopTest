package com.withdog.service.ash;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.Ash;
import com.withdog.service.domain.Consulting;
import com.withdog.service.domain.HealingDog;

public interface AshDAO {

	public void addHealingDog(HealingDog healingDog) throws Exception;

	public HealingDog getHealingDog(int healingDogNo) throws Exception;
	
	public HealingDog getHealingDog2(int healingDogNo) throws Exception;

	public void updateHealingDog(HealingDog healingDog) throws Exception;

	public List<HealingDog> getHealingDogList() throws Exception;

	public List<HealingDog> getHealingDogList(Search search) throws Exception;

	public List<HealingDog> getHealingDogListByDate(String ashReservationDate) throws Exception;
	// ÄÁ¼³ÆÃ
	public List<HealingDog> getConsultingDogList() throws Exception;

	public void addConsulting(Consulting consulting) throws Exception;

	public Map<String, Object> getMyConsultingList(Search search, String userId) throws Exception;

	public void updateConsultingState(Consulting consulting) throws Exception;

	public Map<String, Object> getConsultingAdminList(Search search) throws Exception;
	//
	public void addAshReservation(Ash ash) throws Exception;

	public Ash getAshReservation(int ashReservationNo) throws Exception;

	public List<Ash> getAshReservationList(Search search) throws Exception;

	public List<Ash> getAllAshReservationList() throws Exception;

	public List<Ash> getAshReservationAdminList(Search search) throws Exception;

	public Ash getAshReservationAdmin(int ashReservationNo) throws Exception;

	public Ash getAshReservationTime(int healingDogNo, String ashReservationDate) throws Exception;

	public Ash getAshReservationTimeCount(int healingDogNo, String ashReservationDate) throws Exception;
	
	public List<Ash> getAshReservationTimeCountByAndroid(String ashReservationDate) throws Exception;

	public List<Ash> getAshReservationByHealingDog(int healingDogNo) throws Exception;

	public void updateAshReservationAdmin(Ash ash) throws Exception;

	public List<Ash> getAshMyReservationList(Search search, String userId) throws Exception;

	public Ash getAshMyReservationByUser(Ash ash, String userId) throws Exception;

	public Ash getAshMyReservation(int ashReservationNo) throws Exception;

	public void updateAshMyReservation(Ash ash) throws Exception;

	public void updateMyReservationCondition(Ash ash) throws Exception;

	public int getTotalCount(Search search) throws Exception;

	public int getTotalCountByMyASH(Search search, String userId) throws Exception;

	public int getTotalCountByAdminASH(Search search) throws Exception;

}
