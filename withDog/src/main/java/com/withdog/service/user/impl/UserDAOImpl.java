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
	public User getUser2(String userId) throws Exception { //��� �ȵ��׽�Ʈ
		
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
		System.out.println("������Ʈ �ϱ�����"+user);
		sqlSession.update("UserMapper.updateUser", user);

	}

	@Override
	public void updatePassword(User user) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteUser(User user) throws Exception {
		System.out.println("���� ��� ��"+user);
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

	//ȸ����������Ʈ ����
	@Override
	public List<User> getUserListAdmin(Search search) throws Exception {
		return sqlSession.selectList("UserMapper.getUserList", search);
	}
	
	// �Խ��� Page ó���� ���� ��ü Row(totalCount)  return
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
		
		//��üȸ����
		int allUser = sqlSession.selectOne("UserMapper.getCountAllUser");
		System.out.println("1111111111111111111��üȸ�� Ȯ��"+allUser);
		
		//�޸�ȸ���� usrCon0
		int userCon0 =  sqlSession.selectOne("UserMapper.getCountUserCon0");
		System.out.println("2222222222222�޸�ȸ�� Ȯ��"+userCon0);
		
		//Ż��ȸ���� usrCon2
		int userCon2 =  sqlSession.selectOne("UserMapper.getCountUserCon2");
		System.out.println("33333333333Ż��ȸ�� Ȯ��"+userCon2);
		
		//����ȸ���� userCon1
		int userCon1 = allUser -userCon0-userCon2;
		System.out.println("444444444444����ȸ�� Ȯ��"+userCon1);
	
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("allUser",  allUser);
		map.put("userCon0",  userCon0);
		map.put("userCon1", userCon1 );
		map.put("userCon2", userCon2 );
		
		System.out.println("555555555555��Ȯ��"+map);
		return map;
	}

	@Override
	public   Map<String, Object> getUserConListAdmin(Search search) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//����Ʈ �̱�
		List<User> list = null;
		list = sqlSession.selectList("UserMapper.getUserConList", search);
		
		//ī��Ʈ �̱�
		int totalCount = sqlSession.selectOne("UserMapper.getUserConCount", search);
		
		map.put("list",  list);
		map.put("totalCount",  totalCount);
		
		System.out.println("���ٳ�ͼ�"+map);
		return map;
	}

	@Override
	public Map<String, Object> getUserCount5day(Search search) throws Exception {
		
		// 2-�޸� 0    //  3 -���� 1  // 4 - Ż�� 2
		
		///�޸�ȸ��
		//���ñ��� ��ġ�����  
		search.setSearchCondition("2");
		 int userConZeroToday = sqlSession.selectOne("UserMapper.getUserConCount", search);
		//�Ϸ���
		 int userConZeroCheck1 = sqlSession.selectOne("UserMapper.check1", search);
		 //2����
		 int userConZeroCheck2 = sqlSession.selectOne("UserMapper.check2", search);
		 //3����
		 int userConZeroCheck3= sqlSession.selectOne("UserMapper.check3", search);
		 //4����
		 int userConZeroCheck4 = sqlSession.selectOne("UserMapper.check4", search);
		 
		 //�޸�ȸ�� 5�� ��Żī��Ʈ ����Ʈ�� �ֱ�
		// int [] userConZero = {userConZeroToday,userConZeroCheck1,userConZeroCheck2,userConZeroCheck3,userConZeroCheck4};
		 
		 ///����ȸ��
		//���ñ��� ��ġ�����  
		search.setSearchCondition("3");
		 int userConOneToday = sqlSession.selectOne("UserMapper.getUserConCount", search);
		//�Ϸ���
		 int userConOneCheck1 = sqlSession.selectOne("UserMapper.check1", search);
		 //2����
		 int userConOneCheck2 = sqlSession.selectOne("UserMapper.check2", search);
		 //3����
		 int userConOneCheck3= sqlSession.selectOne("UserMapper.check3", search);
		 //4����
		 int userConOneCheck4 = sqlSession.selectOne("UserMapper.check4", search);
		 
		//����ȸ�� 5�� ��Żī��Ʈ ����Ʈ�� �ֱ�
		// int [] userConOne = {userConOneToday,userConOneCheck1,userConOneCheck2,userConOneCheck3,userConOneCheck4};
		 
		 ///Ż��ȸ��
		//���ñ��� ��ġ�����  
		search.setSearchCondition("4");
		 int userConTwoToday = sqlSession.selectOne("UserMapper.getUserConCount", search);
		//�Ϸ���
		 int userConTwoCheck1 = sqlSession.selectOne("UserMapper.check1", search);
		 //2����
		 int userConTwoCheck2 = sqlSession.selectOne("UserMapper.check2", search);
		 //3����
		 int userConTwoCheck3= sqlSession.selectOne("UserMapper.check3", search);
		 //4����
		 int userConTwoCheck4 = sqlSession.selectOne("UserMapper.check4", search);
		 
		//Ż��ȸ�� 5�� ��Żī��Ʈ ����Ʈ�� �ֱ�
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

			System.out.println(">>>>>>>>>>>>>>>>>>��Ȯ��"+map);
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
