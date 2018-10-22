package com.withdog.service.user;

import java.util.List;
import java.util.Map;

import com.withdog.common.Search;
import com.withdog.service.domain.User;

public interface UserDAO {
	
	//Android//
	// 회원정보 조회 SELECT ONE 
	public User getUser2(String userId) throws Exception;

	// 회원가입 INSERT
	public void addUser(User user) throws Exception;

	// 회원정보 조회 SELECT ONE
	public User getUser(String userId) throws Exception;

	// 회원정보 수정 UPDATE
	public void updateUser(User user) throws Exception;

	// 비밀번호 수정 UPDATE
	public void updatePassword(User user) throws Exception;

	// 회원 탈퇴 UPDATE
	public void deleteUser(User user) throws Exception;

	// 로그인 SELECT ONE
	public User loginUser(User user) throws Exception;

	// 로그아웃
	public void logoutUser(User user) throws Exception;

	// 회원 ID 찾기 SELECT ONE
	public User findUserId(User user) throws Exception;

	// 회원 비밀번호 찾기
	public void findUserPassword(User user) throws Exception;

	// 회원정보리스트 Admin
	public List<User> getUserListAdmin(Search search) throws Exception;

	// 게시판 Page 처리를 위한 전체Row(totalCount) return
	public int getTotalCount(Search search) throws Exception;

	// 접속일변경
	public void updateRecentlyDate(String userId) throws Exception;

	// 휴면 계정 핸드폰, 이름 확인
	public User checkPhone(User user) throws Exception;

	// 휴면 회원 설정 Admin
	public void updateUserList() throws Exception;

	// 휴면 회원 해제 :: 휴면 > 정상
	public void updateUserCon(String userId) throws Exception;

	// snsID찾기 :: sns 로그인 , sns 연동시 DB에 확인
	public User findSnsId(User user) throws Exception;

	// snsID 연동
	public void updateSnsId(User user) throws Exception;

	// 회원 컨디션 비율
	public Map<String, Object> getUserConRate() throws Exception;

	// 오늘기준 휴면 리스트_어드민
	public Map<String, Object> getUserConListAdmin(Search search) throws Exception;

	// 최근 5일 기준 회원 통계 _어드민
	public Map<String, Object> getUserCount5day(Search search) throws Exception;

	// 회원가입시 이메일 중복 확인
	public User checkUserEmail(String email) throws Exception;
	
	//유저 이메일 주소 가져오기
	public List<User> getUsersEmail() throws Exception;
}