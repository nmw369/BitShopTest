<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" 	content="width=device-width,initial-scale=1.0,maximum-scale=1" />
    
<!-- <!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>DevExtreme Demo</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" /> -->
	
<title>오늘 기준 휴면회원 리스트</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>	


<script type="text/javascript">

	$(function() {
		
		//오늘 가입회원 클릭시
		$("#todayJoin").on("click",function(){
			$("#searchCondition").val("3");
			$("#currentPage").val(1);
			$("form").attr("method", "POST").attr("action", "/user/getUserConListAdminOne").submit();
			
		});
		
		//오늘 휴면회원 클릭시
		$("#todayChange").on("click",function(){
			$("#searchCondition").val("2");
			$("#currentPage").val(1);
			$("form").attr("method", "POST").attr("action", "/user/getUserConListAdminOne").submit();
		});
		
		//오늘 탈퇴회원 클릭시
		$("#todayLeave").on("click",function(){
			
			$("#searchCondition").val("4");
			$("#currentPage").val(1);
			$("form").attr("method", "POST").attr("action", "/user/getUserConListAdminOne").submit();
		});
		
		
	}); //제이쿼리 끝
		
		
	//하단 페이지 클릭시
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/user/getUserConListAdmin").submit();
	}
	
</script>


</head>

<body class="dx-viewport">
	
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
		    
			    <h2 align="center">최근 5일 기준 회원 리스트</h2>
	
				<!-- 차트 인크루드 -->
				<jsp:include page="getUserConAdmin.jsp" />
		  	
		  		
		  		<div class="col-md-12" style="margin-top:100px;"> 
					<div class="col-md-6">
				       <a href="#" class="highlight-button input-round text-center" id="todayJoin" >오늘가입회원</a>
				      <a href="#" class="highlight-button input-round text-center" id="todayChange" >오늘휴면회원</a>
				      <a href="#" class="highlight-button input-round text-center" id="todayLeave">오늘탈퇴회원</a>
	   				</div>
			   		
			   		<form> <!--start form-->
						  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						  <input type="hidden" id="currentPage" name="currentPage" value=""/>
						  <input type="hidden" id="searchCondition" name="searchCondition" value=""/>
					</form>   <!--end form-->
		
				    <div class="col-md-6">
		    			<p class="text-primary">
		    				전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    			</p>
		    		</div>	
		    		
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
	    						<th align="left">
		    						<c:choose>
											<c:when test="${search.searchCondition=='2'}">휴면회원으로 변경일 </c:when>
											<c:when test="${search.searchCondition=='4'}"></c:when>
									  		<c:otherwise></c:otherwise>	
									  </c:choose>
	    						</th>
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
							  <td align="left">${user.changeDate} </td>
							  
						</tr>
	    			 	</c:forEach>
					</tbody>
				</table>
				<!--  end table End -->
	  
				<div class="col-md-12 col-sm-12 col-xs-12 wow fadeInUp" align="center">
					<!-- pagination -->
					<jsp:include page="../common/pageNavigator_new.jsp"></jsp:include>
					<!-- end pagination -->
				</div> 
				
			</div>
			<!-- end content  -->
		
		</div><!-- end row -->
	</div><!-- end container -->
</section>	
     
     <jsp:include page="../layout/footer.jsp" />

	<jsp:include page="../common/js.jsp" />
	    
	
</body>

</html>