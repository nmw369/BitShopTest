<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>판매관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" 	content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<link rel="stylesheet" href="../css/purchase.css" />

<!-- 공통 -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<jsp:include page="../common/css.jsp" />
<script type="text/javascript">

//pageNavigation
function fncGetList(currentPage) {
	$("#currentPage").val(currentPage)
	$("form").attr("method", "POST").attr("action", 	"/purchase/getSalesListAdmin").submit();
}

	//상세정보버튼
	$(function() {
		$(".getSales").on("click", function() {
				var index = $(".getSales").index(this);
				var purchaseNo = $($("input[name='purchaseNo']")[index]).val();
				
				self.location = "/purchase/getSalesAdmin?purchaseNo=" + purchaseNo;
		});
	});
	
	//배송하기버튼 컨디션 변경 에이젝스
	$(function(){
		//배송하기버튼 클릭시
		$("a[name='tran']").on("click", function(){
			//각 인덱스 값 제대로 확인
			var index = $("a[name='tran']").index(this);
			//해당 인덱스의 넘버 확인
			var purchaseNo = $($("input[name='purchaseNo']")[index]).val();
			
			//스윗얼러트
			swal({
				 //세팅
				  title: "배송하기",
				  text: "상품을 배송 하시겠습니까?",
				  //icon: "success",
				  buttons: true,
				  //dangerMode: true,
				})
			//오케이 누르면 밸류에 트루값 넣어주면서 이프문 실행
			.then(function(value){
				if(value){

					swal("상품을 배송 하였습니다.", {
					      icon: "success",
					    });

					$.ajax({
							//레스트갈때 컨디션을 2로 설정
							url : "/purchase/json/updatePurchaseConditionAdmin/2/" + purchaseNo,
							method : "GET",
							dataType : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							}, success : function(JSONData , status) {
								//alert("레스트갔다옴")
								//업데이트 성공 후 판매완료텍스트를 배송중으로 변경
								$(".text").text("배송중");
								//구매날짜 공백처리
								$(".date").text("");
								//버튼 안보이게 설정
								$($("a[name='tran']")[index]).attr("style", "display:none;");
							}
					});
				}
			});
			
		});
	});
	
	$(function(){
		$("a[name=getProduct1]").on("click", function(){
			var index = $("a[name=getProduct1]").index(this);
			var prodNo = $($("input[name='prodNo']")[index]).val();
			
			self.location = "/product/updateProductAdmin?prodNo=" + prodNo;
		});
		
		$("a[name=getProduct2]").on("click", function(){
			var index = $("a[name=getProduct2]").index(this);
			var prodNo = $($("input[name='prodNo']")[index]).val();
			
			self.location = "/product/updateProductAdmin?prodNo=" + prodNo;
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
				
				<form>
				
					<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
				
			
				<h1 align="center">판매관리</h1>
				
				
					<div>

						<table class="my-order-unit">
						
							<colgroup>
								<col class="my-order-unit__col-item">
								<col class="my-order-unit__col-opt" />
							</colgroup>
							
							<tbody>
								<c:set var="prePurchaseNo" value=""/>
								<c:set var="nowPurchaseNo" value=""/>
								
								<c:forEach var="purchase" items="${list}">
								<c:set var="nowPurchaseNo" value="${purchase.purchaseNo}"/>
								
								
									<c:set var="count" value="0"/>
									<c:forEach var="purchaseCount" items="${list}">
										<c:if test="${nowPurchaseNo == purchaseCount.purchaseNo}">
											<c:set var="count" value="${count + 1 }"/>
										</c:if>
									</c:forEach>
								
								<c:if test="${prePurchaseNo != nowPurchaseNo}">
								
								<tr style="height:40px;"><td colspan="2"></td></tr>
								
								<tr class="my-purchase-list__item"  style="border:1px solid #e7e7e7;">
									<td colspan="2">
									<div class="my-purchase-list__item-head text-left">
											<span class="my-purchase-list__item-sub-info">
												주문일 &nbsp;${purchase.purchaseDate}&nbsp;&nbsp;<span class="text-xsmall gray-text" style="vertical-align:2px;">회원아이디&nbsp;${purchase.user.userId}</span>
												<input 	type="hidden" name="purchaseNo" value="${purchase.purchaseNo}" />
											</span>
											<span style="float:right">
												<a href="#" class="getSales">
													주문상세보기
													<span class="fa fa-chevron-right"></span>
												</a>
											</span>
									</div>
									</td>
								</tr>
								</c:if>
			
								<tr style="border:1px solid #e7e7e7;">
								
									<td class="my-order-unit__area-item-group col-md-9">

										<div class="my-order-unit__area-item">

											<div>
												<div class="product-thumbnail">
													<a target="_blank" class="my-order-unit__link-thumb js_myEventLog" name="getProduct1">
														<img 	src="/images/store/${purchase.product.prodImage}" width="120" height="120" alt="" class="my-order-unit__thumb-img">
													</a>
												</div>

												<div class="my-order-unit__item-info">
													<a target="_blank" class="my-order-unit__link-info js_myEventLog" name="getProduct2">
															
														<div class="my-order-unit__info-name my-font--13 text-left">
																<img src="https://image15.coupangcdn.com/image/my/common/badge/rocket_logo.png" 	width="56" height="14" class="my-icon-badge" />
																${purchase.product.prodName}
														</div>
														
													</a>

													<div class="my-order-unit__info-ea">
														<p class="gray-text" style="margin-bottom:5px; font-size:12px">구매번호 : ${purchase.purchaseNo}</p>
														<input type="hidden" value="${purchase.product.prodNo}" name="prodNo"/>
														${purchase.product.price}<span class="text-xsmall">원</span> / ${purchase.purchaseQuantity}<span class="text-xsmall">개</span>
													</div>

												</div>
												
											</div>
											
										</div>
									</td>

									<c:if test="${prePurchaseNo != nowPurchaseNo}">
									<td class="my-order-unit__area-opt" rowspan="${count}">
										<c:choose>
											<c:when test="${purchase.purchaseCondition == '0'}">
												<div class="my-order-unit__status my-font--15">
												<span class="my-color--black">
													<strong style="font-size:15px; color:#709dbd; ">회원구매취소</strong>
													<div class="my-color--green">${fn:substring(purchase.cancelDate,0,10)}</div>
													<a name="tran" class="display-none" style="cursor:pointer;">배송하기</a>
												</span>
												</div>
											</c:when>
											<c:when test="${purchase.purchaseCondition == '1'}">
												<div class="my-order-unit__status my-font--15">
												<span>
													<strong style="font-size:15px; color:#709dbd; " class="text">판매완료</strong>
													<div class="date">${fn:substring(purchase.purchaseDate,0,10)}</div>
												</span>
												</div>
												<div class="my-order-unit__btn-group">
													<div class="my-order-unit__btn-row">
														<a name="tran" class="box-sky" style="cursor:pointer;">배송하기</a>
													</div>
												</div>
											</c:when>
											<c:when test="${purchase.purchaseCondition == '2'}">
												<div class="my-order-unit__status my-font--15">
												<span class="my-color--black">
													<strong style="font-size:15px; color:#709dbd; ">배송중</strong>
													<a name="tran" class="display-none" style="cursor:pointer;">배송하기</a>
												</span>
												</div>
											</c:when>
											<c:otherwise>
												<div class="my-order-unit__status my-font--15">
													<span class="my-color--black">
														<strong style="font-size:15px; color:#709dbd; ">배송완료</strong>
														<div class="my-color--green">${fn:substring(purchase.divyDate,0,10)}</div>
													</span>
												</div>
											</c:otherwise>
										</c:choose>
									</td>
									</c:if>
								</tr>
								<c:set var="prePurchaseNo" value="${nowPurchaseNo}"/>
						</c:forEach>
							</tbody>
						</table>
						
					</div>
				
				<div class="col-md-12 col-sm-12 col-xs-12 wow fadeInUp" align="center">
					<!-- pagination -->
					<jsp:include page="../common/pageNavigator_new.jsp"></jsp:include>
					<!-- end pagination -->
				</div>
				
				</form>
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