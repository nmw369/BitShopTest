<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
	<jsp:include page="../common/css.jsp" />
	<title>회원정보 조회</title>
	
	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script type="text/javascript">
	
			
		$(function () {
			
			//가입일 시간 빼기
			var joinDate =$("#joinDate").text().substring( 0, 10 );
			$("#joinDate").text(joinDate);
			
			//좋아하는 견종 dogNo => dogBreedKO
			var dogNum  = "${user.dogNo}";
			
			$.ajax(
				{
				url : "/dogBreedDic/json/getDogBreed2",
				method : "post",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					dogNo : dogNum
				}),
				success : function(JSONData , status) {
					
					var displayValue = JSONData.key.dogBreedKO;
					$( "#dogName" ).text(displayValue);
				}
			
			});// end of ajax
			
			//회원정보 수정화면  연결
			$("#changeGo").on("click" , function() {
				
				var role ="${sessionScope.user.role}";
				var userId ="${user.userId}";
				
				
				if(role=='user'){
					self.location = "/user/updateUser";
				}else{
					self.location = "/user/updateUserAdmin?userId="+userId;	
				}
			});
			
				
	
		});//end 제이쿼리
	</script>
	
</head>

<body>

	<jsp:include page="../layout/header.jsp" /> 
<!-- 	<!-- head section --> 
<!-- 	 <section class="content-top-margin page-title parallax3 parallax-fix page-title-blog"> -->
<!-- 	   <img class="parallax-background-img" src="../images/sub/300_bg.jpg" alt="" /> -->
<!-- 	   <div class="container"> -->
<!-- 	       <div class="row"> -->
<!-- 	           <div class="col-md-12 col-sm-12 text-center wow fadeInUp"> -->
<!-- 	                <h1 class="white-text">회원 상세정보 조회</h1> -->
<!-- 	               <span class="white-text xs-display-none">Register and modify user information.</span> -->
<!-- 	            </div> -->
<!-- 	        </div> -->
<!-- 	    </div> -->
<!-- 	</section>  -->
<!-- 	<!-- end head section --> 


	<!-- head section -->
	<section class="page-title parallax3 parallax-fix page-title-blog">
	<img class="parallax-background-img" src="../images/sub/304_bg.jpg"
		alt="" />
	<div class="container">
		<div class="row">
			<div class="col-md-12 col-sm-12 text-center animated fadeInUp">
				<div class="no-margin-top margin-one"></div>
				<!-- page title -->
				<h1 class="white-text tit_png">
					<img src="../images/sub/myPage_tit.png">
				</h1>
				<!-- end page title -->
			</div>
		</div>
	</div>
	</section>
	<!-- end head section -->

  
	<!-- content section -->
	<section class="wow fadeIn">
	<div class="container">
		<div class="row">
		
			<!-- sidebar  -->
			<div class="col-md-2 col-sm-3 sidebar">
				<c:choose>
						<c:when test="${sessionScope.user.role=='admin'}"><jsp:include page="/layout/admin-sideBar.jsp" /></c:when>
				  		<c:otherwise><jsp:include page="/layout/mypage-sideBar2.jsp" /></c:otherwise>	
			  	</c:choose>	
				
			</div>
			<!-- end sidebar  -->
			
			<!-- content -->
			<div class="col-md-9 col-sm-9 col-md-offset-1">	
				
					<h2 style="margin-bottom:35px" class="text-center">회원정보</h2>
					<hr/>
					<div class="row">
					  		<div class="col-xs-4 col-md-4"><strong>아이디</strong></div>
							<div class="col-xs-8 col-md-8">${user.userId}</div>
					</div>
					<hr/>
					
					<div class="row">
					  		<div class="col-xs-4 col-md-4"><strong>이 름</strong></div>
							<div class="col-xs-8 col-md-8">${user.userName}</div>
					</div>
				
					<hr/>
				
					<div class="row">
						<div class="col-xs-4 col-md-4 "><strong>생년월일</strong></div>
						<div class="col-xs-8 col-md-8">${user.birth}</div>
					</div>
				
					<hr/>
				
					<div class="row">
				 		<div class="col-xs-4 col-md-4 "><strong>이메일</strong></div>
						<div class="col-xs-8 col-md-8">${user.email}</div>
					</div>
				
					<hr/>
				
					<div class="row">
				 		<div class="col-xs-4 col-md-4 "><strong>전화번호</strong></div>
						<div class="col-xs-8 col-md-8">${user.phone}</div>
					</div>
				
					<hr/>
				
					<div class="row">
				 		<div class="col-xs-4 col-md-4 "><strong>주소</strong></div>
				 		<div class="col-xs-8 col-md-4">${user.postNo}&nbsp; &nbsp;${user.address1}</div>
					</div>
					<div class="row">
						<div class="col-xs-4 col-md-4"></div>
						<div class="col-xs-8 col-md-4">${user.address2}</div>
					</div>
				
					<hr/>
				
				
					<div class="row">
				 		<div class="col-xs-4 col-md-4 "><strong>좋아하는 견종</strong></div>
						<div class="col-xs-8 col-md-8" id="dogName">${user.dogNo}</div>
					</div>
				
					<hr/>
				
					<div class="row">
				 		<div class="col-xs-4 col-md-4 "><strong>가입일</strong></div>
						<div class="col-xs-8 col-md-8" id="joinDate">${user.joinDate}</div>
					</div>
				
					<hr/>
					
					<div class="row">
				 		<div class="col-xs-4 col-md-4"><strong>현재포인트</strong></div>
						<div class="col-xs-8 col-md-8">${user.currentPoint}point</div>
					</div>
				
					<hr/>
					
					<div class="row">
				 		<div class="col-xs-4 col-md-4"><strong>SNS 계정연동관리</strong></div>
						<div class="col-xs-8 col-md-8"></div>
					</div>
				
					<hr/>
					
					<!-- 네이버 -->
					<div class="row">
				 		<div class="col-xs-4 col-md-4"><img src ="../images/login/n_icon.png"><strong>네이버</strong></div>
						<div class="col-xs-8 col-md-8">
							<c:choose>
								<c:when test="${user.snsNaverId==null}">연결된 정보가 없습니다.</c:when>
						  		<c:otherwise><span style="color:#6682bb;">연동완료</span></c:otherwise>	
						  	</c:choose>
						</div>
					</div>
					
					<hr/>
					
					<!-- 카카오 -->
					<div class="row">
				 			<div class="col-xs-4 col-md-4"><img src ="../images/login/k_icon.png"><strong>카카오</strong></div>
							<div class="col-xs-8 col-md-8">
							<c:choose>
								<c:when test="${user.snsKakaoId==null}">연결된 정보가 없습니다.</c:when>
						  		<c:otherwise><span style="color:#6682bb;">연동완료</span></c:otherwise>	
						  	</c:choose>
							</div>
					</div>
					
					<hr/>
					
					<!-- 구글 -->
					<div class="row">
				 		<div class="col-xs-4 col-md-4"><img src ="../images/login/g_icon.png"><strong>구글</strong></div>
				 		<div class="col-xs-8 col-md-8">
					 		<c:choose>
								<c:when test="${user.snsGoogleId==null}">연결된 정보가 없습니다.</c:when>
						  		<c:otherwise><span style="color:#6682bb;">연동완료</span></c:otherwise>	
						  	</c:choose>
						</div>
					</div>
					
					<hr/>
					
					<!-- 페이스북 -->
					<div class="row">
				 		<div class="col-xs-4 col-md-4"><img src ="../images/login/f_icon.png"><strong>페이스북</strong></div>
						<div class="col-xs-8 col-md-8">
				 			<c:choose>
								<c:when test="${user.snsFacebookId==null}">연결된 정보가 없습니다.</c:when>
						  		<c:otherwise><span style="color:#6682bb;">연동완료</span></c:otherwise>	
						  	</c:choose>
						</div>
					</div>
					
					<hr/>
				 
					<c:if test="${sessionScope.user.role=='admin'}"> 
						<div class="row">
					 		<div class="col-xs-4 col-md-2"><strong>계정상태</strong></div>
					 		<div class="col-xs-8 col-md-4" >
						 		 <c:choose>
									<c:when test="${user.userCondition=='0'}">휴면 </c:when>
									<c:when test="${user.userCondition=='2'}">탈퇴 </c:when>
							  		<c:otherwise>정상</c:otherwise>	
							  	</c:choose>
							</div>
						</div>
						<hr/>
						<div class="row">
					 		<div class="col-xs-4 col-md-2"><strong>최근접속일</strong></div>
							<div class="col-xs-8 col-md-4" >${user.recentlyDate}</div>
						</div>
					
						<hr/>
						
						<div class="row">
					 		<div class="col-xs-4 col-md-2"><strong>탈퇴일</strong></div>
							<div class="col-xs-8 col-md-4">${user.leaveDate}</div>
						</div>
					
						<hr/>
						
						<div class="row">
							<div class="col-xs-4 col-md-2"><strong>탈퇴사유</strong></div>
					  
					    	<div class="col-xs-8 col-md-4">
					    	  <c:choose>
								<c:when test="${user.leaveReason=='1'}">동물교감치유 서비스 불만 </c:when>
								<c:when test="${user.leaveReason=='2'}">이용빈도 낮음 </c:when>
								<c:when test="${user.leaveReason=='3'}">개인정보유출 우려 </c:when>
								<c:when test="${user.leaveReason=='4'}">스토어상품 배송 지연 </c:when>
						  		<c:otherwise></c:otherwise>	
						  	  </c:choose>
					  		</div>
						
						</div>
										
						<hr/>
						
						<div class="row">
					 		<div class="col-xs-4 col-md-2"><strong>권한</strong></div>
							<div class="col-xs-8 col-md-4">${user.role}</div>
						</div>
					
						<hr/>
					
					
					</c:if>
					
					<div class="text-center">
						<button class="highlight-button btn no-margin post-search pull-left" id="changeGo">회원정보수정</button>
					</div>
				
				</div>
			</div>	
		</div>	<!-- row -->
	</div><!-- container1 -->
		

		
		
	</section>
	<!-- end content section -->
        
	<jsp:include page="../layout/footer.jsp" /> 
	<jsp:include page="../common/js.jsp" />

</body>
</html>