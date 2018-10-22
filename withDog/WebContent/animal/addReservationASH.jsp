<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<jsp:include page="/common/css.jsp" />

<title>예약 정보 입력</title>
</head>
<body>
<script type="text/javascript">
function close_pop(flag) {
    $('#insertAddress').hide();
    $('#insertAddress2').hide();
    $('#insertPhone').hide();
};


$(function () {
	//도로명 주소  우편번호 검색 클릭시
	$("#searchPost").on("click" , function() {
		var pop = window.open("http://localhost:8080/user/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	});
					
	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
//			alert(roadFullAddr);
		$("input[name=ashReservationAddress1]").val(roadAddrPart1);
		$("input[name=ashReservationAddress2]").val(addrDetail);
	}	
	window.jusoCallBack = jusoCallBack;
})


///////////////카카오페이
$(function () {
	$("#kakaoPay").on("click", function () {
		if($("input[name=ashReservationAddress1]").val()==""){
			$("#insertAddress").show(); //주소 입력해라
			return;
		}
		if($("input[name=ashReservationAddress2]").val()==""){
			$("#insertAddress2").show(); //상세주소 입력해라
			return;
		}
		if($("input[name=ashReservationPhone]").val()==null || $("input[name=ashReservationPhone]").val()==""){
			$("#insertPhone").show(); //번호 입력해라
			return;
		}
		
	usePoint = 	$("input[name=usePoint]").val();
		window.open("", "popup_window", "left=300,width=500,height=500,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");
		$("form").attr("method","post").attr("target","popup_window").attr("action","/ash/kakaoPay/"+usePoint).submit();
	})
})




$(function () {
		var currentPoint = ${currentPoint};
		console.log("현재포인트 : " + currentPoint)
		var totalPrice = 	uncomma($("input[name=totalPrice]").val());
		var usePoint;
		$("input[name=ashReservationPrice2]").val(comma(totalPrice));
		$("input[name=ashReservationPrice]").val(totalPrice);
	$("input[name=usePoint]").on("keyup", function () {
		usePoint = 	$("input[name=usePoint]").val();
		if(usePoint>currentPoint){
			$("input[name=usePoint]").val(currentPoint);
			usePoint = 	$("input[name=usePoint]").val();	
		}
		$("input[name=ashReservationPrice2]").val(comma(totalPrice-usePoint));
		$("input[name=ashReservationPrice]").val(totalPrice-usePoint);
	})
})

$(function () {
	var ashReservationEtc = $("input[name=ashReservationEtc]").val();
	console.log(ashReservationEtc)
	$("input[name=ashReservationEtc]").on("keyup", function () {
		console.log(ashReservationEtc.length)
	})
	
})

function comma(str) { 
    str = String(str); 
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'); 
} 

function uncomma(str) { 
    str = String(str); 
    return str.replace(/[^\d]+/g, ''); 
}




</script>


	<jsp:include page="../layout/header.jsp" />
		
	<!-- head section -->
	<section class="content-top-margin page-title parallax3 parallax-fix page-title-blog">
	   <img class="parallax-background-img" src="../images/sub/300_bg.jpg" alt=""  />
	   <div class="container">
	       <div class="row">
	           <div class="col-md-12 col-sm-12 text-center wow fadeInUp">
	               <!-- page title -->
	               <h1 class="white-text">동물교감 치유 서비스 예약 정보 입력</h1>
	               <!-- end page title -->
	               <!-- page title tagline -->
	               <span class="white-text xs-display-none">Register and modify product information.</span>
	               <!-- end title tagline -->
	            </div>
	        </div>
	    </div>
	</section>
	<!-- end head section -->
		        
    <!-- content section -->
    <!-- 상단  -->
        <section class="no-padding-bottom no-padding-top margin-three">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-10 text-center center-col">
                        <span class="margin-one no-margin-top display-block letter-spacing-2">Register information</span>
                        <h1>예약내역</h1>
                        <div class="separator-line bg-black margin-two no-margin-bottom"></div>
                        <p class="text-p width-120 center-col margin-two no-margin-bottom">치유견 이름 : ${healingDog.healingDogName} | 담당 치유사 : ${healingDog.healingDogHealer} </p>
                    </div>
                </div>
            </div>
        </section>
        <!-- end 상단  -->

		<!-- 정보1   -->
		<div class="container">
			<div class="row no-margin-bottom">
				<div class="col-md-6 col-sm-6 text-center xs-margin-bottom-ten">
<!-- 					<img src="http://placehold.it/300x300" alt=""/> -->
					<img  src = "/images/uploadFiles/healingDog/${healingDog.healingDogimage}" width="300px" height="300px" alt=""/>
				</div>
			
				<div class="col-md-6 col-sm-6 sm-margin-bottom-ten">
					<div class="col-md-8 col-sm-12 no-padding">
						<ul class="list-line margin-ten text-med">
							<li id="dogBreed"><span class="font-weight-600">예약자 이름:</span> ${user.userName}</li>
							<li id="dogAge"><span class="font-weight-600">예약일시: </span> ${ashReservationDate} ${ashReservationTime=='0'?'[오전 10:00 ~ 13:00]':'[오후 14:00 ~ 17:00]'}</li>
							<li id="dogName"><span class="font-weight-600">서비스 이용금액:</span> 100,000원</li>
							<li id="dogChar"><span class="font-weight-600">예상적립 포인트:</span> 1,000Point 적립예정</li>
							<li id="healer"><span class="font-weight-600">결제일:</span> ${mTime} </li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- 정보1 끝   -->
		
	
		<!--  예약 하단 시작 -->
		<section class="bg-gray margin-three padding-three">
            <div class="container">
                <div class="row">
                    <!-- section title -->
                     <div class="col-md-8 col-sm-8 center-col text-center">
                        <div>
                            <i class="icon-hotairballoon large-icon"></i>
                        	<span class="margin-one no-margin-top display-block letter-spacing-2">Healing dog schedule</span>
                            <h1>결제정보</h1>
                        	<div class="separator-line bg-black margin-two no-margin-bottom"></div>
                        </div>
                    </div>
                    <!-- end section title -->
                </div>
                
                <div class="row margin-five no-margin-bottom">
                    <div class="col-md-12">
                        <div class="col-md-6 col-sm-8 center-col">
                       		<!--form-->
                       		<form>  
	                        	<input type="hidden"  name="ashReservationName" value="${user.userName}">
	                        	<input type="hidden"  name="ashReservationDate" value="${ashReservationDate}">
	                        	<input type="hidden"  name="ashReservationTime" value="${ashReservationTime}">
	                        	<input type="hidden"  name="healingDog.healingDogNo" value="${healingDog.healingDogNo}">
                            	<h6 class="black-text no-margin-top margin-one no-letter-spacing"><strong>주소</strong></h6>
	                        	<input type="text" id="textbox" name="ashReservationAddress1" class="input-round big-input" value="${user.address1}">
	                        	<span class="col-md-12 no-padding">
	                        	<input type="text" id="textbox" name="ashReservationAddress2" class="input-round big-input col-md-8" value="${user.address2}">
	                        	<a class="highlight-button btn no-margin pull-right post-search col-md-4 text-center" id="searchPost">우편번호 검색</a>
	                        	</span>
	                        	
	                        	<h6 class="black-text no-margin-top margin-one no-letter-spacing"><strong>전화번호</strong></h6>
	                        	<input type="text" id="textbox" name="ashReservationPhone" class="input-round big-input" value="${user.phone}">
                            
                            	<h6 class="black-text no-margin-top margin-one no-letter-spacing"><strong>특이사항</strong></h6>
	                        	<input type="text" id="textbox" name="ashReservationEtc" class="input-round big-input"  maxlength="40"  placeholder="40자 미만으로 입력해주세요" value="">
	                        	
	                        	<h6 class="black-text no-margin-top margin-one no-letter-spacing"><strong>* 총금액</strong></h6>
	                        	<input type="text" id="textbox" name="totalPrice" class="input-round big-input" value="100,000" readonly>
	                        	
	                        	<h6 class="black-text no-margin-top margin-one no-letter-spacing"><strong>사용할 포인트</strong><span> &nbsp;(현재 보유 포인트 : ${currentPoint} point)</span></h6>
	                        	<c:if test="${currentPoint==0}">
	                        		<input type="text" id="textbox" name="usePoint2" class="input-round big-input" value="" disabled="disabled" placeholder="사용할 수 있는 포인트가 없습니다.">
	                        		<input type="hidden" id="textbox" name="usePoint" class="input-round big-input" value="0" disabled="disabled" placeholder="사용할 수 있는 포인트가 없습니다.">
	                        	</c:if>
	                        	<c:if test="${currentPoint!=0}">
	                        		<input type="text" id="textbox" name="usePoint" class="input-round big-input" value="0">
	                        	</c:if>
	                        	
	                        	<h6 class="black-text no-margin-top margin-one no-letter-spacing"><strong>* 결제수단</strong></h6>
	                        	<input type="text" id="textbox" name="paymentOption" class="input-round big-input" value="카카오페이" readonly>
                            
                            	 <h6 class="black-text no-margin-top margin-one no-letter-spacing"><strong>* 최종 결제금액</strong></h6>
	                        	<input type="text" id="textbox" name="ashReservationPrice2" class="input-round big-input" value="" readonly>
	                        	<input type="hidden" id="textbox" name="ashReservationPrice" class="input-round big-input" value="" readonly>
                            
                            </form>
                            <!--end form-->
                            <div class="text-center margin-five">
                             	<a id="kakaoPay" style="cursor: pointer;" class="btn-small-black-border-light btn btn-medium btn-round button xs-margin-bottom-five">결제하기</a>
                     		</div>
                     		
       					</div>	

				   </div>
				</div>  
			</div>	<!-- end container --> 

       	
	</section>
	
	  <!-- 1. 주소입력 모달 -->
    <div id="insertAddress" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />주소를 입력하세요.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
      <!-- 1. 주소입력 모달 -->
	  <!-- 2. 상세주소입력 모달 -->
    <div id="insertAddress2" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />상세주소를 입력하세요.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
      <!-- 2. 상세주소입력 모달 -->
	  <!-- 3. 번호입력 모달 -->
    <div id="insertPhone" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />전화번호를 입력하세요.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
      <!-- 3. 번호입력 모달 -->


	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />

</body>
</html>