<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>판매 상세정보</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<link rel="stylesheet" href="../css/purchase.css" />

<!-- 공통 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<jsp:include page="../common/css.jsp" />
<script type="text/javascript">
	
	//상품이미지 클릭시 상품상세로 이동
	$(function(){
		$("a[name=getProduct1]").on("click", function(){
			var index = $("a[name=getProduct1]").index(this);
			var prodNo = $($("input[name='prodNo']")[index]).val();
			
			self.location = "/product/getProduct?prodNo=" + prodNo;
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
            <img class="parallax-background-img" src="../images/sub/305_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/admin_tit.png"></h1>
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
			<div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-1">
			
				<h1 class="margin-four-bottom" align="center">판매 상세정보</h1>

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
	                                    	<a name="getProduct1">
	                                        	<img src = "/images/store/${purchase.product.prodImage}" width="120" height="120" class="product-thumbnail-round"/>
	                                        </a>
	                                    </td>
	                                    <td colspan="2" class="text-left no-padding-left">
	                                        <span class="display-block text-xsmall margin-two">주문번호: ${purchase.cartNo}</span>
	                                        <span class="text-med">${purchase.product.prodName}</span>
	                                         <span class="display-block margin-two">수량 : ${purchase.purchaseQuantity}</span>
	                                         <input type="hidden" name="prodNo" value="${purchase.product.prodNo}"/>
	                                    </td>
	                                </tr>
	                                </c:forEach>
	                            </tbody>
	                        </table>
	                        
	                        
	                        <div class="blog-single-full-width-form overflow-hidden">
	                        	<p class="display-block border-bottom-sky font-weight-600" style="padding-bottom:8px; font-size:18px; color:#709dbd;">구매정보</p>
		                        <div class="col-md-12 no-padding">
	                                <label>회원아이디:</label>
	                                <input type="text" name="receiverName" value="${purchaselist[0].user.userId}" style="background-color:#fff;" disabled />
	                            </div>
	                            <div class="col-md-12 no-padding">
	                                <label>구매자이름:</label>
	                            </div>
	                            <div class="col-md-12 no-padding">
	                                <input type="text" value="${purchaselist[0].user.userName}" style="background-color:#fff;" disabled />
	                            </div>
	                            <div class="col-md-12 no-padding">
	                                <label>결제금액:</label>
	                                <input type="text" value="${purchaselist[0].purchasePrice}" style="background-color:#fff;" disabled />
	                            </div>
	                            <div class="col-md-12 no-padding">
	                                <label>사용포인트:</label>
	                                <input type="text" name="usePoint" value="${purchaselist[0].usePoint}" style="background-color:#fff;" disabled />
	                            </div>
                            </div>
                            
                            
	                        <div class="blog-single-full-width-form overflow-hidden" style=" margin-top:30px;">
	                        	<p class="border-bottom-sky font-weight-600" style="padding-bottom:8px; font-size:18px; color:#709dbd;">배송정보</p>
		                        <div class="col-md-12 no-padding">
	                                <label>수령인:</label>
	                                <input type="text" name="receiverName" value="${purchaselist[0].receiverName}" style="background-color:#fff;" disabled />
	                            </div>
	                            <div class="col-md-12 no-padding">
	                                <label>수령인연락처:</label>
	                                <input type="text" name="receiverName" value="${purchaselist[0].receiverPhone}" style="background-color:#fff;" disabled />
	                            </div>
	                            <div class="col-md-12 no-padding">
	                                <label>배송주소:</label>
	                            </div>
	                            <div class="col-md-12 no-padding">
	                                <input type="text" value="${purchaselist[0].receiverAddr1} ${purchaselist[0].receiverAddr2}" style="background-color:#fff;" disabled />
	                            </div>
	                            <div class="col-md-12 no-padding">
	                                <label>배송요청사항:</label>
	                                <input type="text"  value="${purchaselist[0].divyRequest}" style="background-color:#fff;" disabled />
	                            </div>
	                            <div class="col-md-12 no-padding">
	                                <label>배송완료일:</label>
	                                <input type="text"  value="${purchaselist[0].divyDate}" style="background-color:#fff;" disabled />
	                            </div>
                            </div>
                            
                            
                            <div class="blog-single-full-width-form"  style=" margin-top:30px;">
	                        	<p class="display-block border-bottom-sky font-weight-600" style="padding-bottom:8px; font-size:18px; color:#709dbd; ">취소정보</p>
		                        <div class="col-md-12 no-padding">
	                                <label>구매취소일:</label>
	                                <input type="text"  value="${purchaselist[0].cancelDate}" style="background-color:#fff;" disabled />
	                            </div>
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