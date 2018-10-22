package com.withdog.common;


//==>����Ʈȭ���� �𵨸�(�߻�ȭ/ĸ��ȭ)�� Bean 
public class Search {
	
	///Field
	private int currentPage;
	private String searchCondition;
	private String searchKeyword;
	private int pageSize;
	//==> ����Ʈȭ�� currentPage�� �ش��ϴ� ȸ�������� ROWNUM ��� SELECT ���� �߰��� Field 
	//==> UserMapper.xml �� 
	//==> <select  id="getUserList"  parameterType="search"	resultMap="userSelectMap">
	//==> ����
	private int endRowNum;
	private int startRowNum;
	private int priceUpDown;
	private int recently;
	private String searchStartDay;
	private String searchEndDay;
	
	private int sorting;
	private String prodType;
	private String role;

	//�����
	private String dogBreed;
	private String sido;
	private String sigungu;
	private String abandDogState;
	private String abandDogGender;


	///Constructor
	public Search() {
	}
	
	///Method
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int paseSize) {
		this.pageSize = paseSize;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	//==> Select Query �� ROWNUM ������ �� 
	public int getEndRowNum() {
		return getCurrentPage()*getPageSize();
	}
	//==> Select Query �� ROWNUM ���� ��
	public int getStartRowNum() {
		return (getCurrentPage()-1)*getPageSize()+1;
	}

	public int getSorting() {
		return sorting;
	}

	public void setSorting(int sorting) {
		this.sorting = sorting;
	}


	public String getProdType() {
		return prodType;
	}

	public void setProdType(String prodType) {
		this.prodType = prodType;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
	
	public String getSearchStartDay() {
		return searchStartDay;
	}

	public void setSearchStartDay(String searchStartDay) {
		this.searchStartDay = searchStartDay;
	}

	public String getSearchEndDay() {
		return searchEndDay;
	}

	public void setSearchEndDay(String searchEndDay) {
		this.searchEndDay = searchEndDay;
	}

	public String getDogBreed() {
		return dogBreed;
	}

	public void setDogBreed(String dogBreed) {
		this.dogBreed = dogBreed;
	}

	public String getSido() {
		return sido;
	}

	public void setSido(String sido) {
		this.sido = sido;
	}

	public String getSigungu() {
		return sigungu;
	}

	public void setSigungu(String sigungu) {
		this.sigungu = sigungu;
	}

	public String getAbandDogState() {
		return abandDogState;
	}

	public void setAbandDogState(String abandDogState) {
		this.abandDogState = abandDogState;
	}

	public String getAbandDogGender() {
		return abandDogGender;
	}

	public void setAbandDogGender(String abandDogGender) {
		this.abandDogGender = abandDogGender;
	}

	@Override
	public String toString() {
		return "Search [currentPage=" + currentPage + ", searchCondition=" + searchCondition + ", searchKeyword="
				+ searchKeyword + ", pageSize=" + pageSize + ", endRowNum=" + endRowNum + ", startRowNum=" + startRowNum
				+ ", priceUpDown=" + priceUpDown + ", recently=" + recently + ", searchStartDay=" + searchStartDay
				+ ", searchEndDay=" + searchEndDay  + ", sorting=" + sorting + ", prodType="
				+ prodType + ", role=" + role + ", dogBreed=" + dogBreed + ", sido=" + sido + ", sigungu=" + sigungu
				+ ", abandDogState=" + abandDogState + ", abandDogGender=" + abandDogGender + "]";
	}

	




}