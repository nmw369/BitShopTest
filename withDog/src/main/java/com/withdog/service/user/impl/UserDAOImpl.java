package com.withdog.service.user.impl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.withdog.common.Search;
import com.withdog.service.domain.User;
import com.withdog.service.user.UserDAO;

@Repository("userDAOImpl")
public class UserDAOImpl implements UserDAO {
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public UserDAOImpl() {
		System.out.println(this.getClass());
	}

	/////////////////////////////////////////////////
	//Android//
	@Override
	public User getUser2(String userId) throws Exception { //장원 안드테스트
		
		return sqlSession.selectOne("UserMapper.getUser", userId);
		
	}
	///////////////////////////////////////////////////
	
	
	///Method
	@Override
	public void addUser(User user) throws Exception {
		sqlSession.insert("UserMapper.addUser", user);
	}

	@Override
	public User getUser(String userId) throws Exception {
		
		if(sqlSession.selectOne("UserMapper.getUser", userId)!=null) {
			return sqlSession.selectOne("UserMapper.getUser", userId);
		}else {
			return new User();	
		}
		
	}
	

	@Override
	public void updateUser(User user) throws Exception {
		System.out.println("업데이트 하기전에"+user);
		sqlSession.update("UserMapper.updateUser", user);

	}

	@Override
	public void updatePassword(User user) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteUser(User user) throws Exception {
		System.out.println("유저 디비 전"+user);
		sqlSession.update("UserMapper.deleteUser", user);

	}


	@Override
	public User loginUser(User user) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void logoutUser(User user) throws Exception {
		// TODO Auto-generated method stub

	}


	@Override
	public User findUserId(User user) throws Exception {
		return sqlSession.selectOne("UserMapper.findUserId", user);
	}

	@Override
	public void findUserPassword(User user) throws Exception {
		// TODO Auto-generated method stub

	}



	@Override
	public void updateRecentlyDate(String userId) throws Exception {
		sqlSession.update("UserMapper.updateRecentlyDate", userId);
		
	}

	//회원관리리스트 어드민
	@Override
	public List<User> getUserListAdmin(Search search) throws Exception {
		return sqlSession.selectList("UserMapper.getUserList", search);
	}
	
	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	@Override
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("UserMapper.getTotalCount", search);
	}

	@Override
	public User checkPhone(User user) throws Exception {
		return sqlSession.selectOne("UserMapper.checkPhone", user);
	}

	@Override
	public void updateUserList() throws Exception {
		sqlSession.update("UserMapper.updateUserList");
	}

	@Override
	public void updateUserCon(String userId) throws Exception {
		sqlSession.update("UserMapper.updateUserCon",userId);
	}

	@Override
	public User findSnsId(User user) throws Exception {
			return sqlSession.selectOne("UserMapper.findSnsId", user);
	}

	@Override
	public void  updateSnsId(User user) throws Exception {
		sqlSession.update("UserMapper.connectSnsId",user);
	}

	@Override
	public Map<String, Object> getUserConRate() throws Exception {
		
		//전체회원수
		int allUser = sqlSession.selectOne("UserMapper.getCountAllUser");
		System.out.println("1111111111111111111전체회원 확인"+allUser);
		
		//휴면회원수 usrCon0
		int userCon0 =  sqlSession.selectOne("UserMapper.getCountUserCon0");
		System.out.println("2222222222222휴면회원 확인"+userCon0);
		
		//탈퇴회원수 usrCon2
		int userCon2 =  sqlSession.selectOne("UserMapper.getCountUserCon2");
		System.out.println("33333333333탈퇴회원 확인"+userCon2);
		
		//정상회원수 userCon1
		int userCon1 = allUser -userCon0-userCon2;
		System.out.println("444444444444정상회원 확인"+userCon1);
	
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("allUser",  allUser);
		map.put("userCon0",  userCon0);
		map.put("userCon1", userCon1 );
		map.put("userCon2", userCon2 );
		
		System.out.println("555555555555맵확인"+map);
		return map;
	}

	@Override
	public   Map<String, Object> getUserConListAdmin(Search search) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//리스트 뽑기
		List<User> list = null;
		list = sqlSession.selectList("UserMapper.getUserConList", search);
		
		//카운트 뽑기
		int totalCount = sqlSession.selectOne("UserMapper.getUserConCount", search);
		
		map.put("list",  list);
		map.put("totalCount",  totalCount);
		
		System.out.println("디비다녀와서"+map);
		return map;
	}

	@Override
	public Map<String, Object> getUserCount5day(Search search) throws Exception {
		
		// 2-휴면 0    //  3 -정상 1  // 4 - 탈퇴 2
		
		///휴면회원
		//오늘기준 서치컨디션  
		search.setSearchCondition("2");
		 int userConZeroToday = sqlSession.selectOne("UserMapper.getUserConCount", search);
		//하루전
		 int userConZeroCheck1 = sqlSession.selectOne("UserMapper.check1", search);
		 //2일전
		 int userConZeroCheck2 = sqlSession.selectOne("UserMapper.check2", search);
		 //3일전
		 int userConZeroCheck3= sqlSession.selectOne("UserMapper.check3", search);
		 //4일전
		 int userConZeroCheck4 = sqlSession.selectOne("UserMapper.check4", search);
		 
		 //휴면회원 5일 토탈카운트 리스트에 넣기
		// int [] userConZero = {userConZeroToday,userConZeroCheck1,userConZeroCheck2,userConZeroCheck3,userConZeroCheck4};
		 
		 ///정상회원
		//오늘기준 서치컨디션  
		search.setSearchCondition("3");
		 int userConOneToday = sqlSession.selectOne("UserMapper.getUserConCount", search);
		//하루전
		 int userConOneCheck1 = sqlSession.selectOne("UserMapper.check1", search);
		 //2일전
		 int userConOneCheck2 = sqlSession.selectOne("UserMapper.check2", search);
		 //3일전
		 int userConOneCheck3= sqlSession.selectOne("UserMapper.check3", search);
		 //4일전
		 int userConOneCheck4 = sqlSession.selectOne("UserMapper.check4", search);
		 
		//정상회원 5일 토탈카운트 리스트에 넣기
		// int [] userConOne = {userConOneToday,userConOneCheck1,userConOneCheck2,userConOneCheck3,userConOneCheck4};
		 
		 ///탈퇴회원
		//오늘기준 서치컨디션  
		search.setSearchCondition("4");
		 int userConTwoToday = sqlSession.selectOne("UserMapper.getUserConCount", search);
		//하루전
		 int userConTwoCheck1 = sqlSession.selectOne("UserMapper.check1", search);
		 //2일전
		 int userConTwoCheck2 = sqlSession.selectOne("UserMapper.check2", search);
		 //3일전
		 int userConTwoCheck3= sqlSession.selectOne("UserMapper.check3", search);
		 //4일전
		 int userConTwoCheck4 = sqlSession.selectOne("UserMapper.check4", search);
		 
		//탈퇴회원 5일 토탈카운트 리스트에 넣기
		 //int [] userConTwo = {userConTwoToday,userConTwoCheck1,userConTwoCheck2,userConTwoCheck3,userConTwoCheck4};
		 
		 Map<String, Object> map = new HashMap<String, Object>();
		 
			map.put("userConZeroToday",  userConZeroToday);
			map.put("userConZeroCheck1",  userConZeroCheck1);
			map.put("userConZeroCheck2", userConZeroCheck2 );
			map.put("userConZeroCheck3",  userConZeroCheck3);
			map.put("userConZeroCheck4",  userConZeroCheck4);
			
			map.put("userConOneToday",  userConOneToday);
			map.put("userConOneCheck1",  userConOneCheck1);
			map.put("userConOneCheck2", userConOneCheck2 );
			map.put("userConOneCheck3",  userConOneCheck3);
			map.put("userConOneCheck4",  userConOneCheck4);
			
			map.put("userConTwoToday",  userConTwoToday);
			map.put("userConTwoCheck1",  userConTwoCheck1);
			map.put("userConTwoCheck2", userConTwoCheck2 );
			map.put("userConTwoCheck3",  userConTwoCheck3);
			map.put("userConTwoCheck4",  userConTwoCheck4);

			System.out.println(">>>>>>>>>>>>>>>>>>맵확인"+map);
			return map;
	}

	@Override
	public User checkUserEmail(String email) throws Exception {
		
		return sqlSession.selectOne("UserMapper.checkUserEmail", email);
	}
	
	@Override
	public List<User> getUsersEmail() throws Exception {
		List<User> list =  sqlSession.selectList("UserMapper.getUsersEmail");
		return list;
		
	}
}//end of class
