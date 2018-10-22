package com.withdog.service.user;

import java.util.Map;

import org.codehaus.jackson.JsonNode;

import com.withdog.common.Search;
import com.withdog.service.domain.User;

public interface UserService {
	
	//Android//
	// ȸ������ ��ȸ SELECT ONE
	public User getUser2(String userId) throws Exception;

	// ȸ������
	public void addUser(User user) throws Exception;

	// ������Ȯ��
	public User getUser(String userId) throws Exception;

	// ȸ����������
	public void updateUser(User user) throws Exception;

	// ��й�ȣ ����
	public void updatePassword(User user) throws Exception;

	// ȸ��Ż��
	public void deleteUser(User user) throws Exception;

	// �α��� 
	public User loginUser(User user) throws Exception;

	// �α׾ƿ�
	public void logoutUser(User user) throws Exception;

	// ȸ�� ID �ߺ� Ȯ��
	public boolean checkUserId(String userId) throws Exception;

	// ȸ�� ID ã��
	public User findUserId(User user) throws Exception;

	// ȸ�� ��й�ȣ ã��
	public void findUserPassword(User user) throws Exception;

	// ȸ����������Ʈ Admin
	public Map<String, Object> getUserListAdmin(Search search) throws Exception;
	
	//�α��ν� ������ ����
	public void updateRecentlyDate(String userId) throws Exception;
	
	//�޸� ���� �ڵ���, �̸� Ȯ��
	public User checkPhone(User user) throws Exception;
	
	//�޸� ȸ�� ���� Admin
	public void updateUserList() throws Exception;
	
	//�޸� ȸ�� ���� :: �޸� > ���� 
	public void updateUserCon(String userId) throws Exception;
	
	//�̸��� ������ �ӽú�й�ȣ �߼� :: htmlText ������ ���� ����
	public boolean sendEmail(String userEmail, String htmlText) throws Exception;
	
	//�̸��� ������ �����Ϸ� �߼� :: htmlText ������ ���� ����
		public boolean sendConfirmEmail(String userEmail, String htmlText,String title ) throws Exception;
	
	//���ں����� :: conText  ���ں����� ����
	public boolean sendText(String userPhoneNo, String conText) throws Exception;
	
	//snsIDã�� :: sns �α��� , sns ������ DB�� Ȯ��
	public User findSnsId(User user)throws Exception;
	
	//snsID ���� 
	public void  updateSnsId(User user)throws Exception;
	
	//ȸ�� ����� ���� 
	public   Map<String, Object>  getUserConRate()throws Exception;
	
	//���ñ��� �޸�  ����Ʈ_����
	public Map<String, Object> getUserConListAdmin(Search search) throws Exception;
	
	//�ֱ� 5�� ���� ȸ�� ��� _����
	public Map<String, Object> getUserCount5day(Search search) throws Exception;
	
	// ȸ�����Խ� �̸��� �ߺ� Ȯ��
	public User checkUserEmail(String email) throws Exception;
	
	//���� �̸���
	public void sendAdvEmail() throws Exception;
	
}