<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>나의 구매내역</title>
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
	$("form").attr("method", "GET").attr("action", 	"/purchase/getMyPurchaseList").submit();
}

	//상세정보버튼
	$(function() {
		$(".getPurchase").on("click", function() {
				var index = $(".getPurchase").index(this);
				//alert(index + "index찍기")
				var purchaseNo = $($("input[name='purchaseNo']")[index]).val();
				//alert(purchaseNo)
				
				self.location = "/purchase/getMyPurchase?purchaseNo=" + purchaseNo;
		});
	});
	
	//배송정보수정
	$(function() {
		$("a[name='update']").on("click", function() {
				var index = $("a[name='update']").index(this);
				var purchaseNo = $($("input[name='purchaseNo']")[index]).val();
				//alert(purchaseNo)
				
				self.location = "/purchase/updateMyPurchase?purchaseNo=" + purchaseNo;
		});
	});
	
	
	
	$(function(){
		//1.구매취소버튼 컨디션 변경 에이젝스
		$("a[name='cancel']").on("click", function(){
			var index = $("a[name='cancel']").index(this);
			var purchaseNo = $($("input[name='purchaseNo']")[index]).val();
			
			swal({
				 //세팅
				  title: "구매취소",
				  text: "상품을 구매취소 하시겠습니까?",
				  //icon: "success",
				  buttons: true,
				  //dangerMode: true,
				})
			//오케이 누르면 밸류에 트루값 넣어주면서 이프문 실행
			.then(function(value){
				if(value){
					swal("상품을 구매취소 하였습니다.", {
					      icon: "success",
					    });
					
					$.ajax({
						url : "/purchase/json/updateCancelPurchaseCondition/0/" + purchaseNo,
						method : "GET",
						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						}, success : function(JSONData , status) {
							$($("a[name='cancel']")[index]).attr("style", "display:none;");
							$($("a[name='update']")[index]).attr("style", "display:none;");
							$(".text01").text("구매취소");
							//구매취소일 오늘날짜로 변경
							var d = new Date();
//								alert(d.getFullYear() +"-"+ (d.getMonth() + 1) +"-"+  d.getDate())
							$(".date01").text(d.getFullYear() +"-" + "0" + (d.getMonth() + 1) +"-" + "0" +  d.getDate());
						}
			});
				}
			});
			
					
		});
	});
	
	
	$(function(){
		//1.구매확정버튼 컨디션 변경 에이젝스
		$("a[name='purchaseOk']").on("click", function(){
			var index = $("a[name='purchaseOk']").index(this);
			var purchaseNo = $($("input[name='purchaseNo']")[index]).val();
			
			swal({
				 //세팅
				  title: "구매확정",
				  text: "상품을 구매확정 하시겠습니까?",
				  //icon: "success",
				  buttons: true,
				  //dangerMode: true,
				})
			//오케이 누르면 밸류에 트루값 넣어주면서 이프문 실행
			.then(function(value){
				if(value){

					swal("상품을 구매확정 하였습니다.", {
					      icon: "success",
					    });
					
					$.ajax({
						url : "/purchase/json/updateMyPurchaseCondition/3/" + purchaseNo,
						method : "GET",
						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						}, success : function(JSONData , status) {
							$(".text02").text("배송완료");
							
							//배송완료일 오늘날짜로 변경
							var d = new Date();
							$(".date02").text(d.getFullYear() +"-" + "0" + (d.getMonth() + 1) +"-" + "0" +  d.getDate());
							
							$($("a[name='purchaseOk']")[index]).attr("style", "display:none;");
							$($("a[name='review']")[index]).attr("style", "padding:8px 15px 9px; cursor:pointer;");
							
						}
					});
				}
			});
			
					
		});
	});
	
	//구매후기쓰기 버튼 클릭 시
	$(function(){
		$("a[name='review']").on("click", function(){
			var index = $("a[name='review']").index(this);
			var purchaseNo = $($("input[name='purchaseNo']")[index]).val();

			$("input[name='indexNo']").val(index);
			var newIndex = $("input[name='indexNo']").val();
			
				$.ajax({
				url : "/purchase/json/getPurchaseProduct/" + purchaseNo,
				method : "GET",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				}, success : function(JSONData , status) {
					
					
// 					alert(JSONData.purchaseReviewProduct.length);
					if(JSONData.purchaseReviewProduct.length == 0){
						$(".mfp-close").trigger('click');
						swal("알 림", "이미 후기등록을 완료하셨습니다.");
					}else{
						
						//등록 후 타이틀, 내용을 공백으로 비우기
						$('input[name="reviewTitle"]').val('');
						$('textarea[name="reviewContent"]').val('');
						
						$($(".add-rating i")[0]).trigger('click');
						
						$("#prodSelect").html("");
						str='<option>구매상품선택</option>'
						//prodSelect의 옵션 상품명 반복해서 리스트 뽑기
						for(i=0; i<JSONData.purchaseReviewProduct.length; i++){
							str+= '<option value="' + JSONData.purchaseReviewProduct[i].cartNo + '">' + JSONData.purchaseReviewProduct[i].product.prodName + '</option>'
						}
						//뽑은 리스트 다시 공백인 html에 넣기
	       				$("#prodSelect").append(str);
					}
					
				}
			});
		});
	});
	
	
	//구매후기 등록 버튼 클릭시
	$(function(){
		$("#addReview").on("click", function(){
			fncAddReview();
		});
	});
	

	//구매후기 등록실행
	function fncAddReview(){
		//Form 유효성 검증
		var userId= '${user.userId}';
		var reviewTitle = $("input[name='reviewTitle']").val();
		var reviewContent = $("textarea[name='reviewContent']").val();
		var reviewScore = $('input[name="reviewScore"]').val();
		var cartNo = $("#prodSelect option:selected").val();
		var index = $("input[name='indexNo']").val();
		
		if(userId == null || userId.length<1){
			swal("알 림", "로그인 후 이용가능합니다.").then(function(value){
				self.location = "/user/loginUser";
			});
			return;
		}
		if(reviewTitle == null || reviewTitle.length<1){
			swal("알 림", "후기 제목은 반드시 입력하여야 합니다.");
			return;
		}
		
		if(reviewContent == null || reviewContent.length<1){
			swal("알 림", "후기 내용은 반드시 입력하셔야 합니다.");
			return;
		}
		
		if(reviewScore == null || reviewScore.length<1){
			swal("알 림", "평점은 반드시 선택하셔야 합니다.");
			return;
		}
		
		$.ajax(
				{
					url : "/review/json/addReview/"+cartNo,
					method : "POST",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : JSON.stringify({
						//필드명 : 보낼데이터,
						reviewTitle : reviewTitle,
						reviewContent : reviewContent,
						reviewScore : reviewScore
					}),
					success : function(JSONData , status){
						$(".mfp-close").trigger('click');
						swal("알 림", "후기등록이 완료되었습니다.", "success");
// 						$($("a[name='review']")[index]).attr("style", "padding:8px 15px 9px;").text("후기작성 완료");
						
					}
				})
			}
	
	//평점 컬러변경 이벤트
	$(function(){
		$(".add-rating i").on("click", function(){
			var index = $(".add-rating i").index(this);
			
			for(i=0; i<5; i++){
				if(i<=index){
					$($(".add-rating i")[i]).css('color','#ffd200');
				}else{
					$($(".add-rating i")[i]).css('color','##b8b8b8');
				}
			}
		
			$("#reviewScore").val(index+1);
		});
	});
	
	$(function(){
		$("a[name=getProduct1]").on("click", function(){
			var index = $("a[name=getProduct1]").index(this);
			var prodNo = $($("input[name='prodNo']")[index]).val();
			
			self.location = "/product/getProduct?prodNo=" + prodNo;
		});
		
		$("a[name=getProduct2]").on("click", function(){
			var index = $("a[name=getProduct2]").index(this);
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
				
				<form>
					<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
				
			
				<h1 align="center">나의 구매내역</h1>
				
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
												주문일 &nbsp;${purchase.purchaseDate}
												<input 	type="hidden" name="purchaseNo" value="${purchase.purchaseNo}" />
											</span>
											<span style="float:right">
												<a href="#" class="getPurchase">
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
												<span class="">
													<strong style="font-size:15px; color:#709dbd; ">구매취소</strong>
													<div>${fn:substring(purchase.cancelDate,0,10)} 취소</div>
													<a name="cancel" style="display:none;" alt="어디인덱스의 버튼인지 확인하기 위한 무기능버튼">구매취소</a>
													<a name="update" style="display:none;" alt="어디인덱스의 버튼인지 확인하기 위한 무기능버튼">배송정보 수정</a>
													<a name="purchaseOk" style="display:none;" alt="어디인덱스의 버튼인지 확인하기 위한 무기능버튼">구매확정</a>
													<a name="review" style="display:none;" alt="어디인덱스의 버튼인지 확인하기 위한 무기능버튼">구매후기 쓰기</a>
												</span>
												</div>
											</c:when>
											<c:when test="${purchase.purchaseCondition == '1'}">
												<div class="my-order-unit__status my-font--15">
												<span>
													<strong class="text01" style="font-size:15px; color:#709dbd; ">구매완료</strong>
													<div class="date01">${fn:substring(purchase.purchaseDate,0,10)}</div>
												</span>
												</div>
												<div class="my-order-unit__btn-group">
													<div class="my-order-unit__btn-row">
														<a style="cursor:pointer;" name="cancel" class="box-sky">구매취소</a>
														<input type="hidden"  name="purchaseQuantity" value="${purchase.purchaseQuantity}" />
														<input type="hidden" name="cancelDate" value="${purchase.cancelDate}" />
													</div>
													<div class="my-order-unit__btn-row">
														<a href="#"  name="update" class="highlight-box-sky" style="padding:8px 15px 9px">배송정보 수정</a>
														<a name="purchaseOk" style="display:none;" alt="어디인덱스의 버튼인지 확인하기 위한 무기능버튼">구매확정</a>
														<a name="review" style="display:none;" alt="어디인덱스의 버튼인지 확인하기 위한 무기능버튼">구매후기 쓰기</a>
													</div>
												</div>
											</c:when>
											<c:when test="${purchase.purchaseCondition == '2'}">
												<div class="my-order-unit__status my-font--15">
												<span class="">
													<strong class="text02" style="font-size:15px; color:#709dbd; ">배송중</strong>
													<div class="date02">${fn:substring(purchase.purchaseDate,0,10)} 구매</div>
												</span>
												</div>
												<div class="my-order-unit__btn-group">
													<div class="my-order-unit__btn-row">
														<a style="cursor:pointer;" name="purchaseOk" class="box-sky">구매확정</a>
														<a name="cancel" style="display:none;" alt="어디인덱스의 버튼인지 확인하기 위한 무기능버튼">구매취소</a>
														<a name="update" style="display:none;" alt="어디인덱스의 버튼인지 확인하기 위한 무기능버튼">배송정보 수정</a>
														<a href="#review" name="review" class="box-sky popup-with-zoom-anim" style="display:none; padding:8px 15px 9px; cursor:pointer;">구매후기 쓰기</a>
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="my-order-unit__status my-font--15">
												<span class="">
													<strong style="font-size:15px; color:#709dbd; ">배송완료</strong>
													<div>${fn:substring(purchase.divyDate,0,10)} 도착</div>
												</span>
												</div>
												<div class="my-order-unit__btn-group">
													<div class="my-order-unit__btn-row">
														<a href="#review" name="review" class="box-sky popup-with-zoom-anim" style="padding:8px 15px 9px; cursor:pointer;">구매후기 쓰기</a>
														<a name="cancel" style="display:none;" alt="어디인덱스의 버튼인지 확인하기 위한 무기능버튼">구매취소</a>
														<a name="update" style="display:none;" alt="어디인덱스의 버튼인지 확인하기 위한 무기능버튼">배송정보 수정</a>
														<a name="purchaseOk" style="display:none;" alt="어디인덱스의 버튼인지 확인하기 위한 무기능버튼">구매확정</a>
													</div>
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
						
						
						
						<!-- 구매후기 팝업 -->
	                        <div class="col-md-9 col-sm-9 no-padding margin-five">
	                            
	                            <!-- modal popup -->
		                        <div class="col-lg-3 col-md-4 col-sm-5 center-col text-center">
			                        <!-- modal popup -->
			                        <div id="review" class="zoom-anim-dialog mfp-hide col-lg-5 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main">
			                            <span class="fund-modal slider-subtitle5 black-text no-margin-bottom" style="letter-spacing:0;">구매후기 쓰기</span>
			                            <div class="borderline-gray"></div>
			                            
			                                 <div class="blog-comment-form">
                                                <!-- comment form -->
                                                <form name="reviewForm">
                                                	<!-- input  -->
                                                    <p class="add-rating" style="margin-top:20px; margin-bottom:10px;">
	                                                    <label class="rating">평점</label>
                                                    	<i class="fa fa-star text-extra-large2"></i><i class="fa fa-star text-extra-large2" ></i><i class="fa fa-star text-extra-large2"></i><i class="fa fa-star text-extra-large2"></i><i class="fa fa-star text-extra-large2"></i>
                                                    	<input type="hidden" name="reviewScore" id="reviewScore" value="1"/>
                                                    	<input type="hidden" name="indexNo" value="" />
                                                   	</p>
                                                    <!-- end input -->
                                                   <select id="prodSelect"  name="cartNo" class="light-gray-text">
                                                		<option>구매상품선택</option>
                                                		<option value="${purchase.cartNo}">${purchase.product.prodName}</option>
                                                	</select>
                                                    <!-- input  -->
                                                    <input type="text" name="reviewTitle" placeholder="후기제목">
                                                    <!-- end input -->
                                                    <!-- textarea  -->
                                                    <textarea rows="5" name="reviewContent" placeholder="후기내용"></textarea>
                                                    <!-- end textarea  -->
                                                    <!-- button  -->
                                                    <button id="addReview" class="box-sky btn btn-medium center-col no-margin">후기등록</button>
                                                    <!-- end button  -->
                                                </form>
                                                <!-- end comment form -->
                                            </div>
				                       
			                        </div>
			                        <!-- end modal popup -->
			                    </div>
		                        <!-- end modal popup -->
		                        
	                        </div>
		                <!-- end 구매후기 팝업 --> 
		                
						
					</div>
					
				
				<div class="col-md-12 col-sm-12 col-xs-12 wow fadeInUp" align="center">
					<!-- pagination -->
					<jsp:include page="../common/pageNavigator_new.jsp"></jsp:include>
					<!-- end pagination -->
				</div>
				
				</form>
				</div>

			<!--  end content -->

		</div>
	</div>
	</section>

	<jsp:include page="../layout/footer.jsp" />

	<jsp:include page="../common/js.jsp" />

</body>

</html>