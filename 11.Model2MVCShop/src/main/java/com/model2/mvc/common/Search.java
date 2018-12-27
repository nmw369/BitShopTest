package com.model2.mvc.common;


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
	//�߰����
	private String sorting;
	private String daySorting="";
	private int cancelCode;
	
	
	
	///Constructor
	public Search() {
	}
	
	
	
	///Method
	
	
	public int getPageSize() {
		return pageSize;
	}
	public int getCancelCode() {
		return cancelCode;
	}



	public void setCancelCode(int cancelCode) {
		this.cancelCode = cancelCode;
	}



	public String getSorting() {
		return sorting;
	}



	public void setSorting(String sorting) {
		this.sorting = sorting;
	}



	public String getDaySorting() {
		return daySorting;
	}



	public void setDaySorting(String daySorting) {
		this.daySorting = daySorting;
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
	
	
	
	public void setEndRowNum(int endRowNum) {
		this.endRowNum = getCurrentPage()*getPageSize();
	}



	public void setStartRowNum(int startRowNum) {
		this.startRowNum = (getCurrentPage()-1)*getPageSize()+1;
	}



	@Override
	public String toString() {
		return "Search [currentPage=" + currentPage + ", searchCondition="
				+ searchCondition + ", searchKeyword=" + searchKeyword
				+ ", pageSize=" + pageSize + ", endRowNum=" + endRowNum
				+ ", startRowNum=" + startRowNum + "]";
	}
}