<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" 	content="width=device-width,initial-scale=1.0,maximum-scale=1" />
	
<title>회원 관리 리스트</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>	  
<script type="text/javascript">

	$(function() {
		
		//검색버튼 이벤트
		 $( "#search" ).on("click" , function() {
			 fncGetList(1);
		});
		
		
		//엔터키 이벤트 ( 검색 클릭한것처럼)
		$("#searchKeyword").keydown(function(event){
	       if(event.keyCode==13){
	    	   $("#search").trigger('click');
	        }
	    });
	
		/*
		//회원정보 간략보기
		$(  "td:nth-child(6)" ).on("click" , function() {
			
				var userId = $(this).children().children().children().val();
				
				$.ajax( 
						{
							url : "/user/json/getUser/"+userId ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {

								var displayValue = "<h6>"
															+"휴대폰 : <br/>"+JSONData.phone+"<br/>"
															+"가입일 : <br/>"+JSONData.joinDate+"<br/>"
															+"포인트 : <br/>"+JSONData.currentPoint+"<br/>"
															+"ROLE : <br/>"+JSONData.role+"<br/>"
															+"</h6>";
								$("h6").remove();
								$( "#"+userId+"" ).html(displayValue);
							}
					});
									
		});*/
		
		
		//userId 에 회원정보보기  Event 처리(Click)
		 $(function() {
			
			$( "td:nth-child(3)" ).on("click" , function() {
				
				 self.location ="/user/getUserAdmin?userId="+$(this).text().trim();
			});
						
			
		});	
		
		
		
	}); //제이쿼리 끝
		
	
		
	//하단 페이지 클릭시
	function fncGetList(currentPage) {
		alert(currentPage);
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/user/getUserListAdmin").submit();
	}
	
</script>	

<style type="text/css">
<!-- 검색어 버튼 -->
	#pDiv{
		position:relative; 
	}	
	
	#search{
		position: absolute;
		top:0px;
		left:200px;
		width: 80px;
	}
	
	#searchKeyword{
		position: absolute;
		top:0px;
		left:-10px;
	}
 
 	#searchKeyword{
		position: absolute;
		top:0px;
		left:-10px;
	}
 </style>
 
 
</head>

<body>
	
	<jsp:include page="/layout/common-header.jsp" />
     
     
     <!-- head section -->
	<section class="page-title parallax3 parallax-fix page-title-blog">
	<img class="parallax-background-img" src="../images/sub/305_bg.jpg" alt="" />
	<div class="container">
		<div class="row">
			<div class="col-md-12 col-sm-12 text-center animated fadeInUp">
				<div class="no-margin-top margin-one"></div>
				<!-- page title -->
				<h1 class="white-text tit_png">
					<img src="../images/sub/admin_tit.png">
				</h1>
				<!-- end page title -->
			</div>
		</div>
	</div>
	</section>
	<!-- end head section -->
	
	
	<section class="wow fadeIn">
	<div class="container">
	<div class="row">
		
			<!-- sidebar  -->
			<div class="col-md-2 col-sm-3 sidebar">
				<jsp:include page="/layout/admin-sideBar.jsp" />
			</div>
			<!-- end sidebar  -->
			
			
		    
		    
		    <!-- content -->
		    <div class="col-md-9 col-sm-9 col-md-offset-1">
		    
			    <h2 align="center">회원관리리스트</h2>
			    <hr/>
			    
			    <div class="col-md-12" id="pDiv">
			    
				    	<div class="col-md-4" style="margin-top:5px">
			    			<p class="text-primary">
			    				전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
			    			</p>
			    		</div>	
			    
				   <form>
				    
					  <div class="form-group col-md-3">
					  
					   <select class="form-control" name="searchCondition" >
							<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
							<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
							<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>계정상태 :휴면</option>
							<option value="3"  ${ ! empty search.searchCondition && search.searchCondition==3 ? "selected" : "" }>계정상태 :정상</option>
							<option value="4"  ${ ! empty search.searchCondition && search.searchCondition==4 ? "selected" : "" }>계정상태 :탈퇴</option>
						</select>
					  </div>
					  
					  <div class="form-group col-md-3">
					     	<label class="sr-only" for="searchKeyword">검색어</label>
						    	<input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
						    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
						    			 
							  	<input type="button"class="highlight-button-dark btn no-margin post-search" id="search" value="검색"/>
								  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
								  <input type="hidden" id="currentPage" name="currentPage" value=""/>
					  </div>
					</form>  
					
				</div>
		
				<!--  table Start /////////////////////////////////////-->
			      <table class="table table-hover table-striped" >
			        
                     <thead>
                         <tr>
                         	<th align="center">No</th>
                         	<th align="left">계정상태</th>
     						<th align="left" >회원 ID</th>
     						<th align="left">회원명</th>
   							<th align="left">최근접속일</th>
                         </tr>
                     </thead>
                    
                     <tbody>
                        <c:set var="i" value="0" />
						<c:forEach var="user" items="${list}">
						<c:set var="i" value="${ i+1 }" />
						<tr>
							  <td align="center">${ i }</td>
							  
							  <td align="left">
								  <c:choose>
										<c:when test="${user.userCondition=='0'}">휴면 </c:when>
										<c:when test="${user.userCondition=='2'}">탈퇴 </c:when>
								  		<c:otherwise>정상</c:otherwise>	
								  </c:choose>
							  </td>
							  
							  <td align="left" value="${user.userId}"><a href="#">${user.userId}</a></td>
							  <td align="left">${user.userName}</td>
							  <td align="left">${user.recentlyDate}</td>
						</tr>
	    			 	</c:forEach>
					</tbody>
				</table>
				  <!--  table End /////////////////////////////////////-->
	  
	  
				<div class="col-md-12 col-sm-12 col-xs-12 wow fadeInUp" align="center">
					<!-- pagination -->
					<jsp:include page="../common/pageNavigator_new.jsp"></jsp:include>
					<!-- end pagination -->
				</div> 
				
		
			</div>
			<!-- end content  -->
	
	</div>
	</div>
	</section>	
     
     <jsp:include page="../layout/footer.jsp" />

	<jsp:include page="../common/js.jsp" />
	    
	
</body>

</html>