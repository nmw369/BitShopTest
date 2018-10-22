package com.withdog.service.user;

import java.util.Map;

import org.codehaus.jackson.JsonNode;

import com.withdog.common.Search;
import com.withdog.service.domain.User;

public interface UserService {
	
	//Android//
	// 회원정보 조회 SELECT ONE
	public User getUser2(String userId) throws Exception;

	// 회원가입
	public void addUser(User user) throws Exception;

	// 내정보확인
	public User getUser(String userId) throws Exception;

	// 회원정보수정
	public void updateUser(User user) throws Exception;

	// 비밀번호 수정
	public void updatePassword(User user) throws Exception;

	// 회원탈퇴
	public void deleteUser(User user) throws Exception;

	// 로그인 
	public User loginUser(User user) throws Exception;

	// 로그아웃
	public void logoutUser(User user) throws Exception;

	// 회원 ID 중복 확인
	public boolean checkUserId(String userId) throws Exception;

	// 회원 ID 찾기
	public User findUserId(User user) throws Exception;

	// 회원 비밀번호 찾기
	public void findUserPassword(User user) throws Exception;

	// 회원정보리스트 Admin
	public Map<String, Object> getUserListAdmin(Search search) throws Exception;
	
	//로그인시 접속일 변경
	public void updateRecentlyDate(String userId) throws Exception;
	
	//휴면 계정 핸드폰, 이름 확인
	public User checkPhone(User user) throws Exception;
	
	//휴면 회원 설정 Admin
	public void updateUserList() throws Exception;
	
	//휴면 회원 해제 :: 휴면 > 정상 
	public void updateUserCon(String userId) throws Exception;
	
	//이메일 보내기 임시비밀번호 발송 :: htmlText 보내는 메일 내용
	public boolean sendEmail(String userEmail, String htmlText) throws Exception;
	
	//이메일 보내기 결제완료 발송 :: htmlText 보내는 메일 내용
		public boolean sendConfirmEmail(String userEmail, String htmlText,String title ) throws Exception;
	
	//문자보내기 :: conText  문자보내는 내용
	public boolean sendText(String userPhoneNo, String conText) throws Exception;
	
	//snsID찾기 :: sns 로그인 , sns 연동시 DB에 확인
	public User findSnsId(User user)throws Exception;
	
	//snsID 연동 
	public void  updateSnsId(User user)throws Exception;
	
	//회원 컨디션 비율 
	public   Map<String, Object>  getUserConRate()throws Exception;
	
	//오늘기준 휴면  리스트_어드민
	public Map<String, Object> getUserConListAdmin(Search search) throws Exception;
	
	//최근 5일 기준 회원 통계 _어드민
	public Map<String, Object> getUserCount5day(Search search) throws Exception;
	
	// 회원가입시 이메일 중복 확인
	public User checkUserEmail(String email) throws Exception;
	
	//광고 이메일
	public void sendAdvEmail() throws Exception;
	
}