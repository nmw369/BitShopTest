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

	<title>결제 완료 </title>
</head>
<script type="text/javascript">

</script>
<body>
<script type="text/javascript">
$(function(){
	if('${state}'=='1'){
		alert("결제가 취소 되었습니다.");
		window.close();
	}
	if('${state}'=='2'){
		alert("결제실패!!! 다시시도해 주세요");
		window.close();
	}
	if('${state}'=='3'){
		var a = ${ash.ashReservationNo}
		
		/* opener.location.href='/ash/addReservationASHView?state=3&ashReservationNo='+a; */
	}
});

</script>
<c:if test="${state=='3'}">

		
		
			<!-- head section -->
	<section class="content-top-margin page-title parallax3 parallax-fix page-title-blog">
	   <img class="parallax-background-img" src="../images/sub/300_bg.jpg" alt="" />
	   <div class="container">
	       <div class="row">
	           <div class="col-md-12 col-sm-12 text-center wow fadeInUp">
	               <!-- page title -->
	               <h1 class="white-text">결제가 완료 되었습니다.</h1>
	               <!-- end page title -->
	               <!-- page title tagline -->
	               <span class="white-text xs-display-none">Your reservation is complete.</span>
	               <!-- end title tagline -->
	            </div>
	        </div>
	    </div>
	</section>
	<!-- end head section -->
	
	
    <!-- 상단  -->
        <section class="no-padding-bottom no-padding-top margin-three">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-10 text-center center-col">
                        <span class="margin-one no-margin-top display-block letter-spacing-2">Register information</span>
                        <h1>결제완료</h1>
                        <div class="separator-line bg-black margin-two no-margin-bottom"></div>
                        <p class="text-p width-120 center-col margin-two no-margin-bottom">치유견 이름 : ${ash.healingDog.healingDogName} | 담당 치유사 : ${ash.healingDog.healingDogHealer} </p>
                        <p class="text-p width-120 center-col margin-one no-margin-bottom"> 예약일시 : ${ash.ashReservationDate} ${ash.ashReservationDate=='0'?'오전 10:00~13:00':'오후 14:00~17:00'} </p>
                    </div>
                </div>
            </div>
        </section>
        <!-- end 상단  -->
                         
				<!--  치유견 정보  -->
				<div class="container">
				<div class="row no-margin-bottom">
					<div class="col-md-6 col-sm-6 text-center xs-margin-bottom-ten">
<!-- 						<img src="http://placehold.it/300x300" alt=""/> -->
						<img  src = "/images/uploadFiles/healingDog/${ash.healingDog.healingDogimage}" width="300px" height="300px" alt=""/>
					</div>

					<div class="col-md-6 col-sm-6 sm-margin-bottom-ten">
						<div class="col-md-8 col-sm-12 no-padding">
							<ul class="list-line margin-ten text-med">
							<fmt:parseNumber var="test" value = "${ash.ashReservationPrice*0.01}" integerOnly="true"></fmt:parseNumber>
								<li id="dogBreed"><span class="font-weight-600">예약번호:</span>${ash.ashReservationNo}</li>
								<li id="dogName"><span class="font-weight-600">결제금액:</span>${ash.ashReservationPrice}원 (${test}포인트 적립예정)</li>
								<li id="dogAge"><span class="font-weight-600">결제일: </span>${ash.purchaseDate} </li>
								<li id="dogChar"><span class="font-weight-600">예약자 이름:</span>${ash.ashReservationName}</li>
								<li id="healer"><span class="font-weight-600">결제수단:</span>카카오페이</li>
							</ul>
						</div>
					</div>
				</div>
				</div>
				<!--  치유견 정보 끝-->
			
            </div>

        </section>

        <!-- end content section -->
	<!--  예약 하단 끝 -->
	
	
	
	<jsp:include page="/common/js.jsp" />
	</c:if>
</body>
</html>