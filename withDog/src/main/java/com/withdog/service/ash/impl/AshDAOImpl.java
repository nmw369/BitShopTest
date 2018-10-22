package com.withdog.service.ash.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.withdog.common.Search;
import com.withdog.service.ash.AshDAO;
import com.withdog.service.domain.Ash;
import com.withdog.service.domain.Consulting;
import com.withdog.service.domain.HealingDog;

@Repository("ashDAOImpl")
public class AshDAOImpl implements AshDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public AshDAOImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addHealingDog(HealingDog healingDog) throws Exception {
		sqlSession.insert("ASHMapper.addHealingDog", healingDog);
	}

	@Override
	public HealingDog getHealingDog(int healingDogNo) throws Exception {
		return sqlSession.selectOne("ASHMapper.getHealingDog",healingDogNo);
	}
	@Override
	public HealingDog getHealingDog2(int healingDogNo) throws Exception {
		return sqlSession.selectOne("ASHMapper.getHealingDog2",healingDogNo);
	}

	@Override
	public void updateHealingDog(HealingDog healingDog) throws Exception {
		sqlSession.update("ASHMapper.updateHealingDog",healingDog);
		
	}

	@Override
	public List<HealingDog> getHealingDogList() throws Exception {
		return sqlSession.selectList("ASHMapper.getAllHealingDog");
	}
	
	@Override
	public List<HealingDog> getHealingDogListByDate(String ashReservationDate) throws Exception {
		// 날짜별로 힐링독 가져오기
		return sqlSession.selectList("ASHMapper.getHealingDogListByDate",ashReservationDate);
	}
	

	@Override
	public List<HealingDog> getHealingDogList(Search search) throws Exception {
		return sqlSession.selectList("ASHMapper.getHealingDogList", search);
	}
	@Override
	public List<HealingDog> getConsultingDogList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ASHMapper.getConsultingDogList");
	}

	@Override
	public void addConsulting(Consulting consulting) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("ASHMapper.addConsulting", consulting);
	}

	@Override
	public Map<String, Object> getMyConsultingList(Search search, String userId) throws Exception{
		// TODO Auto-generated method stub
		
		System.out.println("여기??");
		Map<String, Object> mapIn = new HashMap<String, Object>();
		mapIn.put("search", search);
		mapIn.put("userId", userId);	
		
		int totalCount = sqlSession.selectOne("ASHMapper.getMyConsultingListCount", userId);
		System.out.println("여기2??");
		List<Consulting> list = sqlSession.selectList("ASHMapper.getMyConsultingList", mapIn);

		System.out.println("여기3??");
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("totalCount", totalCount);
		map.put("list", list);

		return map;
	}
	
	public void updateConsultingState(Consulting consulting) throws Exception{
		sqlSession.update("ASHMapper.updateConsultingState", consulting);
	}
	
	public Map<String, Object> getConsultingAdminList(Search search) throws Exception{
		int totalCount = sqlSession.selectOne("ASHMapper.getConsultingAdminListCount");
		List<Consulting> list = sqlSession.selectList("ASHMapper.getConsultingAdminList", search);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("totalCount", totalCount);
		map.put("list", list);

		return map;
	}


	@Override
	public void addAshReservation(Ash ash) throws Exception {
		sqlSession.insert("ASHMapper.addAshReservation",ash);
		
	}

	@Override
	public Ash getAshReservation(int ashReservationNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public Ash getAshReservationTime(int healingDogNo, String ashReservationDate) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("healingDogNo", healingDogNo);
		map.put("ashReservationDate", ashReservationDate);
		return sqlSession.selectOne("ASHMapper.getAshReservationTime",map);
	}
	
	@Override
	public Ash getAshReservationTimeCount(int healingDogNo, String ashReservationDate) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("healingDogNo", healingDogNo);
		map.put("ashReservationDate", ashReservationDate);
		return sqlSession.selectOne("ASHMapper.getAshReservationTimeCount",map);
	}


	@Override
	public List<Ash> getAshReservationList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Ash> getAshReservationAdminList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ASHMapper.getAshReservationAdminList",search);
	}
	
	@Override
	public List<Ash> getAllAshReservationList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ASHMapper.getAllAshReservationList");
	}



	@Override
	public Ash getAshReservationAdmin(int ashReservationNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<Ash> getAshReservationByHealingDog(int healingDogNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ASHMapper.getAshReservationByHealingDog",healingDogNo);
	}

	@Override
	public void updateAshReservationAdmin(Ash ash) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Ash> getAshMyReservationList(Search search,String userId) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("search", search);
		map.put("userId", userId);
		System.out.println("dao 가기 전 map : " + map);
		
		return sqlSession.selectList("ASHMapper.getAshMyReservationList", map);
	}

	@Override
	public Ash getAshMyReservation(int ashReservationNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ASHMapper.getAshMyReservation", ashReservationNo);
	}
	
	@Override
	public Ash getAshMyReservationByUser(Ash ash, String userId) throws Exception{
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("ash", ash);
		map.put("userId", userId);
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ASHMapper.getAshMyReservationByUser", map);
	}


	@Override
	public void updateAshMyReservation(Ash ash) throws Exception {
		sqlSession.update("ASHMapper.updateAshMyReservation", ash);
	}
	
	@Override
	public void updateMyReservationCondition(Ash ash) throws Exception {
		sqlSession.update("ASHMapper.updateMyReservationCondition", ash);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ASHMapper.getTotalCount", search);
	}
	
	@Override
	public int getTotalCountByMyASH(Search search,String userId) throws Exception {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("search", search);
		map.put("userId", userId);
		return sqlSession.selectOne("ASHMapper.getTotalCountByMyASH", map);
	}

	@Override
	public int getTotalCountByAdminASH(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ASHMapper.getTotalCountByAdminASH", search);
	}

	@Override
	public List<Ash> getAshReservationTimeCountByAndroid(String ashReservationDate) throws Exception {
		return sqlSession.selectList("ASHMapper.getAshReservationTimeCountByAndroid", ashReservationDate);
	}









}
