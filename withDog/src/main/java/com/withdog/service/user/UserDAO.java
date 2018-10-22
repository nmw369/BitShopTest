package com.withdog.service.user;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.User;

public interface UserDAO {
	
	//Android//
	// ȸ������ ��ȸ SELECT ONE 
	public User getUser2(String userId) throws Exception;

	// ȸ������ INSERT
	public void addUser(User user) throws Exception;

	// ȸ������ ��ȸ SELECT ONE
	public User getUser(String userId) throws Exception;

	// ȸ������ ���� UPDATE
	public void updateUser(User user) throws Exception;

	// ��й�ȣ ���� UPDATE
	public void updatePassword(User user) throws Exception;

	// ȸ�� Ż�� UPDATE
	public void deleteUser(User user) throws Exception;

	// �α��� SELECT ONE
	public User loginUser(User user) throws Exception;

	// �α׾ƿ�
	public void logoutUser(User user) throws Exception;

	// ȸ�� ID ã�� SELECT ONE
	public User findUserId(User user) throws Exception;

	// ȸ�� ��й�ȣ ã��
	public void findUserPassword(User user) throws Exception;

	// ȸ����������Ʈ Admin
	public List<User> getUserListAdmin(Search search) throws Exception;

	// �Խ��� Page ó���� ���� ��üRow(totalCount) return
	public int getTotalCount(Search search) throws Exception;

	// �����Ϻ���
	public void updateRecentlyDate(String userId) throws Exception;

	// �޸� ���� �ڵ���, �̸� Ȯ��
	public User checkPhone(User user) throws Exception;

	// �޸� ȸ�� ���� Admin
	public void updateUserList() throws Exception;

	// �޸� ȸ�� ���� :: �޸� > ����
	public void updateUserCon(String userId) throws Exception;

	// snsIDã�� :: sns �α��� , sns ������ DB�� Ȯ��
	public User findSnsId(User user) throws Exception;

	// snsID ����
	public void updateSnsId(User user) throws Exception;

	// ȸ�� ����� ����
	public Map<String, Object> getUserConRate() throws Exception;

	// ���ñ��� �޸� ����Ʈ_����
	public Map<String, Object> getUserConListAdmin(Search search) throws Exception;

	// �ֱ� 5�� ���� ȸ�� ��� _����
	public Map<String, Object> getUserCount5day(Search search) throws Exception;

	// ȸ�����Խ� �̸��� �ߺ� Ȯ��
	public User checkUserEmail(String email) throws Exception;
	
	//���� �̸��� �ּ� ��������
	public List<User> getUsersEmail() throws Exception;
}