<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>나의 구매내역 수정</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<link rel="stylesheet" href="../css/purchase.css" />

<!-- 공통 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<jsp:include page="../common/css.jsp" />
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
	
	//수정버튼 
	$(function(){
		$("#updatePurchase").on("click", function(){
			$("form").attr("method", "POST").attr("action", "/purchase/updateMyPurchaseConfirm?purchaseNo=${purchaselist[0].purchaseNo}").submit();
		});
	});
</script>

<style type="text/css">
table th, td {
	text-align: center;
	font-size: 13px;
}

table td {
	font-size: 12px;
}
</style>

</head>

<body>

	<jsp:include page="/layout/common-header.jsp" />

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


	<section class="wow fadeIn">
	<div class="container">
		<div class="row">

			<!-- sidebar  -->
			<div class="col-md-2 col-sm-3 sidebar">
				<jsp:include page="/layout/mypage-sideBar.jsp" />
			</div>
			<!-- end sidebar  -->

			
			<!-- content -->
			<div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-1">
			
				<h1 class="margin-four-bottom" align="center">나의 구매내역 수정</h1>

					<div class="row margin-five sm-margin-bottom-seven">
	                    <div class="col-sm-10 shop-cart-table center-col">
	                        <table class="table shop-cart text-center">
	                            <thead class="border-tb">
	                                <tr>
	                                    <td colspan="2" class="text-left text-uppercase letter-spacing-1 text-small ">구매번호 : ${purchaselist[0].purchaseNo}</td>
	                                    <td colspan="3" class="text-right text-uppercase letter-spacing-1 text-small">${purchaselist[0].purchaseDate} 구매</td>
	                                </tr>
	                            </thead>
	                            <tbody>
	                            	<c:forEach var="purchase" items="${purchaselist}">
	                                <tr class="border-bottom">
	                                    <td class="product-thumbnail text-center no-padding-right">
	                                        <img src = "/images/store/${purchase.product.prodImage}" width="120" height="120" class="product-thumbnail-round"/>
	                                    </td>
	                                    <td colspan="2" class="text-left no-padding-left">
	                                        <span class="display-block text-xsmall margin-two">주문번호: ${purchase.cartNo}</span>
	                                        <span class="text-med">${purchase.product.prodName}</span>
	                                         <span class="display-block margin-two">수량 : ${purchase.purchaseQuantity}</span>
	                                    </td>
	                                </tr>
	                                </c:forEach>
	                            </tbody>
	                        </table>
	                        
	                        <div class="blog-single-full-width-form">
	                        	<form>
	                        	<p class="display-block border-bottom-sky font-weight-600" style="padding-bottom:8px; font-size:18px; color:#709dbd;">구매정보</p>
		                        <div class="col-md-12 no-padding">
	                                <label>수령인:</label>
	                                <input type="text" name="receiverName" value="${purchaselist[0].receiverName}" style="background-color:#fff;" />
	                            </div>
	                            <div class="col-md-12 no-padding">
	                                <label>연락처:</label>
	                                <input type="text" name="receiverPhone" value="${purchaselist[0].receiverPhone}" style="background-color:#fff;"/>
	                            </div>
	                            <div class="col-md-12 no-padding">
	                                <label>배송주소:</label>
	                                <a class="highlight-button btn-small f-right" id="searchPost"  style="cursor:pointer;">우편번호 검색</a>
	                            </div>
	                            <div class="col-md-6 no-padding">
	                                <input type="text" name="receiverAddr1" id="address1" value="${purchaselist[0].receiverAddr1}" style="background-color:#fff;" readonly/>
	                            </div>
	                            <div class="col-md-6 no-padding">
	                                <input type="text" name="receiverAddr2" id="address2" value="${purchaselist[0].receiverAddr2}" style="background-color:#fff;"/>
	                            </div>
	                        </form>
                            </div>
                            <div class="text-center">
                            	<a class="highlight-button-dark" style="cursor:pointer;" id="updatePurchase">수정</a>
	                        </div>
	                        
	                    </div>
	                    
					</div>
					
					

				</div>

			</div>
			<!--  end content -->

		</div>
	</div>
	</section>

	<jsp:include page="../layout/footer.jsp" />

	<jsp:include page="../common/js.jsp" />

</body>

</html>