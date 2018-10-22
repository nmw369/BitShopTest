<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<jsp:include page="/common/css.jsp" />

	<title>예약정보 상세조회</title>
</head>
<script type="text/javascript">

</script>
<body>
<script type="text/javascript">
$(function () {
	$("#cancelReservation").on("click", function () {
		$("#isCancelReservation").show();
		$("#cancelReservationOk").on("click", function () {
			self.location = "/ash/updateMyReservationCondition?ashReservationNo="+${ash.ashReservationNo}+"&cancel=1";
		})
		$("#cancelReservationNo").on("click", function () {
			$("#isCancelReservation").hide();
		})
	})
	
	$("#updateReservation").on("click", function () {
		$("#isUpdateReservation").show();
		$("#updateReservationOk").on("click", function () {
			self.location = "/ash/updateAshMyReservation?ashReservationNo="+${ash.ashReservationNo};
		})
		$("#updateReservationNo").on("click", function () {
			$("#isUpdateReservation").hide();
		})
	})
})
</script>

		<jsp:include page="../layout/header.jsp" />
		
	<!-- head section -->
	<section class="page-title parallax3 parallax-fix page-title-blog">
	<img class="parallax-background-img" src="../images/sub/304_bg.jpg" alt="" />
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
	
	    <!-- 상단  -->
	<section class="wow fadeIn">
	<div class="container">
	<div class="row">
                
			<!-- sidebar  -->
			<div class="col-md-2 col-sm-3 sidebar">
				<jsp:include page="/layout/mypage-sideBar.jsp" />
			</div>
			<!-- end sidebar  -->
	
    <!-- 상단  -->
        <div class="col-md-9 col-sm-9 col-xs-12">
            <div class="text-center center-col">
                        <span class="margin-one no-margin-top display-block letter-spacing-2">Reservation Information</span>
                        <h1>예약조회</h1>
                        <div class="separator-line bg-black margin-two no-margin-bottom"></div>
                        <p class="text-p width-120 center-col margin-two no-margin-bottom">치유견 이름 : ${ash.healingDog.healingDogName} | 담당 치유사 : ${ash.healingDog.healingDogHealer} </p>
                        <p class="text-p width-120 center-col margin-one no-margin-bottom"> 예약일시 : ${ash.ashReservationDate} ${ash.ashReservationDate=='0'?'오전 10:00~13:00':'오후 14:00~17:00'} </p>
            </div>
        <!-- end 상단  -->
                         
				<!--  치유견 정보  -->
				<div class="container">
				<div class="row no-margin-bottom">
					<div class="col-md-6 col-sm-6 text-center xs-margin-bottom-ten">
<!-- 						<img src="http://placehold.it/300x300" alt=""/> -->
						<img class="margin-ten"  src = "/images/uploadFiles/healingDog/${ash.healingDog.healingDogimage}" width="300px" height="300px" alt=""/>
					</div>

					<div class="col-md-6 col-sm-6 sm-margin-bottom-ten">
						<div class="col-md-9 col-sm-12 no-padding">
							<ul class="list-line margin-ten text-med">
							<fmt:parseNumber var="test" value = "${ash.ashReservationPrice*0.01}" integerOnly="true"></fmt:parseNumber>
								<li><span class="font-weight-600">예약번호:</span>${ash.ashReservationNo}</li>
								<li><span class="font-weight-600">예약자명:</span>${ash.ashReservationName}</li>
								<li><span class="font-weight-600">주소:</span>${ash.ashReservationAddress1} ${ash.ashReservationAddress2	}</li>
								<li><span class="font-weight-600">전화번호:</span>${ash.ashReservationPhone}</li>
								<li><span class="font-weight-600">특이사항:</span>${ash.ashReservationEtc}</li>
								<c:if test="${ash.ashReservationCondition==0}">
									<li><span class="font-weight-600">예약상태:</span>예약완료</li></c:if>
								<c:if test="${ash.ashReservationCondition==1}">
									<li><span class="font-weight-600">예약상태:</span>출장확정</li></c:if>
								<c:if test="${ash.ashReservationCondition==2}">
									<li><span class="font-weight-600">예약상태:</span>출장완료</li></c:if>
								<c:if test="${ash.ashReservationCondition==3}">
									<li><span class="font-weight-600">예약상태:</span>예약취소</li></c:if>
								<li><span class="font-weight-600">결제일: </span>${ash.purchaseDate} </li>
								<li><span class="font-weight-600">결제금액:</span>${ash.ashReservationPrice}원 (총 금액 : 100,000, 포인트사용 ${100000-ash.ashReservationPrice})</li>
								<li><span class="font-weight-600">결제수단:</span>카카오페이</li>
								<li><span class="font-weight-600">적립포인트:</span>${test}포인트</li>
							</ul>
						</div>
					</div>
				</div>
				</div>
				<!--  치유견 정보 끝-->
				<div class="row text-center margin-five">
				<c:if test="${ash.ashReservationCondition==0}">
					<a style="cursor: pointer;" id="updateReservation" class="highlight-button-dark2 btn btn-medium no-margin-right no-margin-bottom margin-two btn-round">예약수정</a>
					<a style="cursor: pointer;" id="cancelReservation" class="highlight-button-dark2 btn btn-medium no-margin-right no-margin-bottom margin-two btn-round">예약취소</a>
				</c:if>
				<c:if test="${ash.ashReservationCondition==1 || ash.ashReservationCondition==2}">예약 수정 및 취소가 불가능한 상태입니다.</c:if>
				<c:if test="${ash.ashReservationCondition==3}">예약 취소상태입니다.</c:if>
				
				<c:if test="${user.role=='admin'}">
					<a style="cursor: pointer;" class="highlight-button-dark2 btn btn-medium no-margin-right no-margin-bottom margin-two btn-round" href="/ash/getAshReservationAdminList">목록으로</a>
				</c:if>
				<c:if test="${user.role=='user'}">
					<a style="cursor: pointer;" class="highlight-button-dark2 btn btn-medium no-margin-right no-margin-bottom margin-two btn-round" href="/ash/getMyReservationASHList">목록으로</a>
				</c:if>
				</div>
            </div>

        </section>

        <!-- end content section -->
	<!--  예약 하단 끝 -->
	
	  <!-- 1. 예약취소 여부-->
    <div id="isCancelReservation" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />예약을 취소하시겠습니까?</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;">
                <span id="cancelReservationOk" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >확인</span>
                <span id="cancelReservationNo" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >취소</span>
            </div>
      </div>
    </div>
      <!-- 1. 예약취소 여부-->
	  <!-- 2. 예약수정 여부-->
    <div id="isUpdateReservation" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />예약을 수정하시겠습니까?</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;">
                <span id="updateReservationOk" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >확인</span>
                <span id="updateReservationNo" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >취소</span>
            </div>
      </div>
    </div>
      <!-- 2. 예약수정 여부-->
	
	
	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
</body>
</html>