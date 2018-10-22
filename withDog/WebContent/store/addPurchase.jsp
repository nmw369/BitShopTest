<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<jsp:include page="../common/css.jsp" />

<title>구매하기 - 결제정보입력</title>

<script type="text/javascript">


//도로명 주소  우편번호 검색 클릭시
$(function(){
	$("#searchPost").on("click" , function() {
		var pop = window.open("http://localhost:8080/user/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	});
					
	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		// alert(roadFullAddr);
		$("#address1").val("[" + zipNo + "]"+ roadAddrPart1);
		$("#address2").val(addrDetail);
	}	
	window.jusoCallBack = jusoCallBack;
});


//사용포인트와 총금액 이벤트
$(function () {
	
	//현재포인트를 변수에 담기
	var currentPoint = ${currentPoint};
	
	//반복문에서 구한 총합금액을 total에 넣기
	var totalPrice = $("input[name=purchasePrice]").val();
	//사용포인트 변수선언
	var usePoint;
	
	//totalPrice를 콤마메소드를 통해 자릿수마다 콤마붙여서 #purchasePrice에 있는 텍스트 변경
 	$("#purchasePrice").text(comma(Math.floor(totalPrice)));
	$("#savePoint").text(comma(Math.floor(totalPrice*0.01)));
	
	//바인딩용
// 	$("input[name=purchasePrice]").val(totalPrice);
	
	//유즈포인트입력창에서 키보드에 손을 떼는 순간
	$("input[name=usePoint]").on("keyup", function () {
		//입력된 사용포인트 value를 유즈포인트에 담기 
		usePoint = $("input[name=usePoint]").val();
		
		var noChangePrice = $("input[name=noChangePrice]").val();
		
		//alert(noChangePrice-usePoint);
		
		//현재포인트보다 사용포인트가 크면
		if(usePoint>currentPoint){
			//사용포인트입력창에 현재포인트값으로 변경
			$("input[name=usePoint]").val(currentPoint);
			//다시 변경된 포인트값을 유즈포인트에 담기
			usePoint = 	$("input[name=usePoint]").val();	
		}
		//상품가격-사용포인트가 0보다 작을때 입력창에 순수상품가격넣어주기
		if(noChangePrice-usePoint<0){
			$("input[name=usePoint]").val(noChangePrice);
			usePoint = 	$("input[name=usePoint]").val();
		}
		//포인트창 공백일때 0넣기
		if(usePoint == ''){
			$("input[name=usePoint]").val(0);
		}
		
		//입력된 사용포인트로 #usePoint에 있는 텍스트(0)를 변경
		$("#usePoint").text(comma(usePoint));
		
		//토탈값 빼기 유즈포인트한 값으로 #purchasePrice에 있는 텍스트를 변경
		$("#purchasePrice").text(comma(totalPrice-usePoint));
		$("#savePoint").text(comma(Math.floor((totalPrice-usePoint)*0.01)));
		
		//바인딩용
		var i = totalPrice-usePoint;
		$("input[name=purchasePrice]").val(i);
	})
	
	//금액 세자리수마다 콤마찍기
	function comma(str) { 
	    str = String(str); 
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'); 
	} 

});

// 그냥결제
// $(function(){
// 	$("#addPurchase").on("click", function () {
// 		var prodNo = ${purchase.product.prodNo};
//  		$("form").attr("method", "POST").attr("action", "/purchase/addPurchase?prodNo=" +prodNo).submit();
// 	})
// });


//카카오페이
$(function () {
	$("#kakaoPay").on("click", function () {
		var usePoint = 	$("input[name=usePoint]").val();
		window.open("", "popup_window", "left=300,width=500,height=500,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");
		$("form").attr("method","post").attr("target","popup_window").attr("action","/purchase/kakaoPay?userPoint="+usePoint).submit();
	})
});
</script>
</head>
<body>
		
		<jsp:include page="/layout/header.jsp" />
		
		<!-- head section -->
         <section class="content-top-margin page-title parallax3 parallax-fix page-title-blog">
            <img class="parallax-background-img" src="../images/sub/500_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center wow fadeInUp">
                        <!-- page title -->
                        <h1 class="white-text">Checkout</h1>
                        <!-- end page title -->
                        <!-- page title tagline -->
                        <span class="white-text xs-display-none">Payment after entering purchase information.</span>
                        <!-- end title tagline -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
        
        
        <!-- content section -->
        <section class="bg-gray-light">
            <div class="container clearfix">
            <form>
                <div class="row margin-seven no-margin-top">
                    <div class="col-md-6 col-xs-12 alert-style4 center-col">
                        <div class="alert alert-warning border text-uppercase black-text letter-spacing-1 text-small">Returning customer? <a href="#" class="font-weight-600 text-decoration-underline">Click here to login</a></div>
                    </div>
                </div>
                <div class="row margin-five no-margin-top">
                    <div class="col-md-6 col-sm-12 center-col sm-margin-bottom-seven">
                        <p class="black-text font-weight-600 text-uppercase text-large">배송정보</p>
                            <div class="col-md-12 no-padding">
                                <label>구매자이름:</label>
                                <input type="text" name="userName" value="${user.userName}" readonly>
                            </div>
                            <div class="col-md-12 no-padding">
                                <label>수령인:</label>
                                <input type="text" name="receiverName" value="${user.userName}">
                            </div>
                            <div class="col-md-12 no-padding">
                                <label>배송주소:</label>
                            </div>
                            <div class="col-md-12 no-padding">
                                <input type="text" name="receiverAddr1" id="address1" class="col-md-9" value="${user.address1}">
                                <input type="button" class="highlight-button2 btn no-margin pull-right post-search col-md-3"  id="searchPost" value="우편번호검색">
                                <input type="text" name="receiverAddr2" id="address2" value="${user.address2}">
                            </div>
                            <div class="col-md-12 no-padding">
                                <label>연락처:</label>
                                <input type="text" name="receiverPhone" value="${user.phone}" placeholder="'-'없이 입력해주세요.">
                                
                            </div>
                            <div class="col-md-12 no-padding">
                                <label>배송메시지:</label>
                                <div class="select-style">
                                    <select name="divyRequest" style="padding-top:11px; padding-bottom:11px">
                                        <option selected="selected">배송시 요청사항 선택</option>
                                        <option >부재시 경비실에 맡겨주세요.</option>
                                        <option >부재시 휴대폰으로 연락바랍니다.</option>
                                        <option >집 앞에 놓아주세요.</option>
                                        <option >택배함에 놓아주세요.</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-12 no-padding">
                            	<p class="border-top"></p>
                                <label>포인트:</label>
                                <c:if test="${currentPoint==0}">
	                        		<input type="text" name="usePoint" value="0" disabled="disabled">
	                        		<input type="hidden" name="usePoint" value="0">
	                        	</c:if>
	                        	<c:if test="${currentPoint!=0}">
	                        		<input type="text"  name="usePoint" value="0">
	                        	</c:if>
                                <p class="text-right display-block gray-text">[ ${currentPoint} point 보유 ]</p>
                            </div>
                            <div class="col-md-12 no-padding">
     	                       <p class="border-top"></p>
                                <label>결제수단:</label>
                                <div class="wrap pull-right">
									<input type="radio" name="paymentOption" id="radio" class="checkbox" checked>
									<label for="radio" class="input-label radio  no-margin-top">카카오페이</label>
                                  		<input type="hidden" name="prodNoList" id="prodNoList" value="" />
										<input type="hidden" name="cartQuantityList" id="cartQuantityList" value="" />
								</div>
                            </div>
                        
                    </div>
                    
                </div>
                
                <div class="row margin-five sm-margin-bottom-seven">
                    <div class="col-sm-10 shop-cart-table center-col">
                        <table class="table shop-cart text-center">
                            <thead>
                                <tr>
                                    <th class="first"></th>
                                    <th class="text-left text-uppercase font-weight-600 letter-spacing-2 text-small black-text">상품정보</th>
                                    <th class="text-left text-uppercase font-weight-600 letter-spacing-2 text-small black-text">상품수량</th>
                                    <th class="text-left text-uppercase font-weight-600 letter-spacing-2 text-small black-text">상품금액</th>
                                </tr>
                            </thead>
                            <tbody><!--list[0] 장바구니에서 넘어온 리스트나 바로구매로 넘어온 상품이나 무조건 0은 있기때문  -->
                     	       <c:set var="sum" value="0"/>
                            	<c:forEach var="cart" items="${list}">
                            	<c:set var="sum" value="${sum + cart.product.price * cart.cartQuantity}"/>
                                <tr>
                                    <td class="product-thumbnail text-center">
                                        <img src = "/images/store/${cart.product.prodImage}" width="120" height="120"/>
                                    </td>
                                    <td class="text-left">
                                        <a href="#">${cart.product.prodName}</a>
                                        <span class="text-uppercase display-block text-small margin-two">상품번호: ${cart.product.prodNo}</span>
                                        <input type="hidden" name="prodNo" value="${cart.product.prodNo}" />
                                    </td>
                                    <td class="product-quantity">
                                       <input type="text" name="cartQuantity" value="${cart.cartQuantity}" class="col-md-3 text-center" readonly/>
                                       <input type="hidden" name="cartNo" value="${cart.cartNo}"/>     
                                    </td>
                                    <td class="product-subtotal text-left">${cart.product.price}원
                                    	<input type="hidden" name="price" value="${cart.product.price}">
                                   	</td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-10 col-sm-10 center-col">
                        <table class="table cart-total">
                            <tbody>
                                <tr>
                                    <th class="padding-two text-right no-padding-right text-uppercase letter-spacing-2 text-small xs-no-padding">적립예정포인트</th>
                                    <td class="padding-two text-uppercase text-right no-padding-right black-text text-small xs-no-padding" id="savePoint"></td>
                                </tr>
                                <tr>
                                    <th class="padding-two text-right no-padding-right text-uppercase letter-spacing-2 text-small xs-no-padding">사용포인트</th>
                                    <td  id="usePoint" class="padding-two text-uppercase text-right no-padding-right  black-text text-small xs-no-padding">
                                    	0
                                    </td>
                                </tr>
                                <tr>
                                    <th class="padding-two text-right no-padding-right text-uppercase letter-spacing-2 text-small xs-no-padding">배송비</th>
                                    <td class="padding-two text-uppercase text-right no-padding-right black-text text-small xs-no-padding">Free</td>
                                </tr>
                                <tr>
                                    <td colspan="2" class="padding-one no-padding-right xs-no-padding">
                                        <hr>
                                    </td>
                                </tr>
                                <tr class="total">
                                    <th class="padding-two text-uppercase text-right no-padding-right font-weight-600 text-large xs-no-padding">총 주문금액</th>
                                    <td id="purchasePrice" class="padding-two text-uppercase text-right no-padding-right font-weight-600 black-text text-large no-letter-spacing xs-no-padding">
                                   		0
                                   	</td>
                               		<input type="hidden" name="purchasePrice" value="${sum}" />
                               		<input type="hidden" name="noChangePrice" value="${sum}" />
                               	</tr>
                               	<tr>
                                    <td colspan="2" class="padding-one no-padding-right xs-no-padding">
                                        <hr class="no-margin-bottom">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
<!--                         <a href="#" class="highlight-button-black-background btn no-margin pull-right checkout-btn xs-width-100 xs-text-center"  id="addPurchase" >결제하기</a> -->
                        <a href="#" class="highlight-button-black-background btn no-margin pull-right checkout-btn xs-width-100 xs-text-center"  id="kakaoPay" >결제하기</a>
                    </div>
                </div>
            </form>
            </div>
        </section>
        <!-- end content section -->
        
        
        
        
		
		
<%-- 		<jsp:include page="../layout/footer.jsp" /> --%>
	
		<jsp:include page="../common/js.jsp" />
</body>
</html>