<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<jsp:include page="../common/css.jsp" />
<script type="text/javascript">

$(function(){
	//카트수량 변경
	$(".cartQuantityBox").on("change", function(){
		var index = $(".cartQuantityBox").index(this);
		var cartQuantity = $($(".cartQuantityBox option:selected")[index]).val()*1;
		var cartNo = $($("input[name='cartNo']")[index]).val();
		var price = $($("input[name='price']")[index]).val();
		var prodQuantity = $($("input[name='prodQuantity']")[index]).val();
// 		alert("인덱스 : " +index);
// 		alert("카트수량 : " +cartQuantity);
// 		alert("카트번호 : " +cartNo);
// 		alert("금액 : " +price);

		if(parseInt(cartQuantity) > parseInt(prodQuantity)){
			swal("알 림", "재고 수량을 초과할 수 없습니다.\n수량을 다시 선택해주세요.");
			return;
		}
		
		$.ajax(
                {
                   url : "/cart/json/updateCart/"+ cartNo + "/" + cartQuantity,
                   method : "GET",
                   dataType : "json",
                   headers : {
                      "Accept" : "application/json",
                      "Content-Type" : "application/json"
                   },
                success : function(JSONData , status){
                	//변경된 수량곱하기상품금액을 투프라이스 밸류에 담아줌
                	$($("input[name='toPrice']")[index]).val(price*cartQuantity);
                	
                	//변경된 수량으로 총금액계산 다시
                	fncSumCart();
                	
                	//툴팁용 리스트 업데이트
                	getToolCartList();
                }
             });
	});
});

//카트 전체금액
function fncSumCart(){
	
	var listSize = ${list.size()};
	var sumCart = 0;

	for(i=0; i<listSize; i++){
		if($($("input[name='cartCheck']")[i]).prop("checked")){
			sumCart += parseInt($($("input[name='toPrice']")[i]).val());
		}
	}
	$(".sumPrice").text(comma(sumCart));
}

//금액 세자리수마다 콤마찍기
function comma(str) { 
    str = String(str); 
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,'); 
} 

//체크박스 이벤트
$(function(){
	$("#allCheck").on("click",function(){
		if($("#allCheck").prop("checked")){
			$("input[name='cartCheck']:checkbox").each(function(){
				$(this).prop('checked', true);
			});
		}else{
			$("input[name='cartCheck']:checkbox").each(function(){
				$(this).prop('checked', false);
			});
		}
		fncSumCart();
	});
	
	$("input[name='cartCheck']").on("click", function(){
		fncSumCart();
	});
});

//상품이미지 클릭시 이벤트
$(function(){
	$(".prodImage").on("click", function(){
		var index = $(".prodImage").index(this);
		var prodNo = $($("input[name='prodNo']")[index]).val();
		
		self.location = "/product/getProduct?prodNo=" + prodNo;
	});
});

//나의정보수정버튼 이벤트
$(function(){
	$("#updateUser").on("click", function(){
		self.location = "/user/updateUser";
	});
});

//계속쇼핑하기 이벤트
$(function(){
	$("#keepShop").on("click", function(){
		self.location = "/product/listProduct?prodType=0";
	});
});


//장바구니 개별 삭제
$(function(){
	
	$(".deleteCart").on("click",function(){
		var index = $(".deleteCart").index(this);
		var cartNo = $($("input[name='cartNo']")[index]).val();
// 		alert(index + " : index");
// 		alert(cartNo + " : cartNo");
		
		$.ajax(
                {
                   url : "/cart/json/deleteCart/"+cartNo,
                   method : "GET",
                   dataType : "json",
                   headers : {
                      "Accept" : "application/json",
                      "Content-Type" : "application/json"
                   },
                success : function(JSONData , status){
                	var tr =$($(".cartTr")[index]);
            		tr.remove();
            		//삭제후 체크된 상품 계산 메소드 다시 부름
            		fncSumCart();
            		//툴팁용 리스트 업데이트
                	getToolCartList();
                }
             });
		
	});
});


//장바구니 비우기
$(function(){
	
	$("#deleteAllCart").on("click",function(){
		var userId = $(".userId").val();
// 		alert(userId + " : userId");
		
		$.ajax(
                {
                   url : "/cart/json/deleteAllCart/"+userId,
                   method : "GET",
                   dataType : "json",
                   headers : {
                      "Accept" : "application/json",
                      "Content-Type" : "application/json"
                   },
                success : function(JSONData , status){
                	$(".tbody").html("");
                	//툴팁용 리스트 업데이트
                	getToolCartList();
                }
             });
		
	});
});

//구매하기
$(function(){

	$("#cartAddPurchase").on("click", function(){
		var cartList = "";
		var listSize = ${list.size()};
		
		for(i=0; i<listSize; i++){
			if($($("input[name='cartCheck']")[i]).prop("checked")){
				cartList += ($($("input[name='cartNo']")[i]).val()) + ",";
			}
		}

		if(cartList == ""){
			swal("알 림", "1개 이상의 상품을 선택해주세요.");
			return;
		}
		
		location.href="/purchase/addPurchaseView?cartList=" + cartList;
	});
});
</script>

<title>장바구니</title>
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
                        <h1 class="white-text">Shopping Cart</h1>
                        <!-- end page title -->
                        <!-- page title tagline -->
                        <span class="white-text xs-display-none">Lorem Ipsum is simply dummy text of the printing.</span>
                        <!-- end title tagline -->
                    </div>
                </div>
                
            </div>
        </section>
        <!-- end head section -->
        
        
        <!-- content section -->
        <section class="content-section">
            <div class="container">
                <div class="row">
                    <div class="col-sm-12 shop-cart-table">
                        <table class="table shop-cart text-center no-margin-bottom">
                            <thead>
                                <tr>
                                    <th class="text-center text-small">
                                    	<input type="checkbox" id="allCheck" class="checkbox no-margin">
										<label for="allCheck" class="input-label radio text-small no-margin">전체선택</label>
									</th>
                                    <th colspan="2" class="text-center  text-small black-text">상품정보</th>
                                    <th class="text-left  text-small black-text">상품수량</th>
                                    <th class="text-center  text-small black-text">상품금액</th>
                                    <th></th>
                                </tr>
                            </thead>
                            
                            
                            <tbody class="tbody">
                            
                            <c:set var="i" value="0"/>
                            <c:forEach var="cart" items="${list}">
                            <c:set var="i" value="${i+1}"/>
                            
                                <tr class="cartTr">
                             	   	<td class="text-center">
                                        <input type=${cart.cartQuantity <= cart.product.prodQuantity ? "checkbox" : "hidden"} id="cartCheck${i}" class="checkbox" name="cartCheck">
											<label  for="cartCheck${i}" class="input-label radio"/>
                                    </td>
                                    <td class="product-thumbnail text-center">
                                        <a class="prodImage" href="#"><img src = "/images/store/${cart.product.prodImage}" width="120" height="120"/></a>
                                    </td>
                                    <td class="text-left">
                                        <a href="#">${cart.product.prodName}</a>
                                        <span class="display-block text-small margin-two">상품번호: ${cart.product.prodNo}</span>
                                        <span class="display-block magenta-text text-small margin-two">${cart.cartQuantity <= cart.product.prodQuantity?"":"재고없음"}</span>
                                        <input type="hidden" name="prodNo" value="${cart.product.prodNo}" />
                                        <input type="hidden" name="prodQuantity" value="${cart.product.prodQuantity}" />
                                        <input type="hidden" name="cartNo" value="${cart.cartNo}"/>
                                    </td>

                                    <td class="product-quantity">
                                        <div class="select-style med-input shop-shorting shop-shorting-cart no-border-round">
                                            <select class="cartQuantityBox">
                                                <option value="1" ${cart.cartQuantity ==1 ? 'selected' : '' }>1</option>
                                                <option value="2" ${cart.cartQuantity ==2 ? 'selected' : '' }>2</option>
                                                <option value="3" ${cart.cartQuantity ==3 ? 'selected' : '' }>3</option>
                                                <option value="4" ${cart.cartQuantity ==4 ? 'selected' : '' }>4</option>
                                                <option value="5" ${cart.cartQuantity ==5 ? 'selected' : '' }>5</option>
                                            </select>
                                        </div>
                                    </td>
                                    <td class="product-subtotal text-center">${cart.product.price}원</td>
                                    <input type="hidden"  name="price" value="${cart.product.price}" />
                                    <input type="hidden"  name="toPrice" value="${cart.product.price * cart.cartQuantity}"/>
                                    <td class="product-remove text-center">
                                        <a class="deleteCart" style="cursor:pointer;"><i class="fa fa-times"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-sm-12 cupon padding-five border-top border-bottom">
                        <a style="cursor:pointer;"class="highlight-button btn btn-medium no-margin pull-left" id="deleteAllCart">장바구니 비우기</a>
                        <button class="highlight-button btn btn-medium no-margin pull-right continue-shopping" id="keepShop">계속 쇼핑하기</button>
                    </div>
                    <div class="col-sm-12 padding-five no-padding-bottom">
                        <div class="col-md-5 col-sm-5 calculate no-padding-left xs-margin-bottom-ten xs-no-padding">
                            <div class="panel panel-default border">
                                <div class="panel-heading no-padding" id="headingTwo" role="tablist">
                                    <a href="#collapse-two-link2" data-parent="#collapse-two" data-toggle="collapse" class="collapsed">
                                        <h4 class="panel-title no-border black-text font-weight-600 letter-spacing-2">나의 배송지 정보<span class="pull-right"><i class="fa fa-plus" style="margin-top:7px;"></i></span></h4>
                                    </a>
                                </div>
                                <div class="panel-collapse collapse" id="collapse-two-link2" style="height: 0px;">
                                    <div class="panel-body">
                                        <form action="#">
                                            <div class="form-wrap">
                                                <div class="form-group">
                                                    <input type="text" value="Post Code : ${user.postNo}" style="background-color:#fff;" disabled>
                                                    <input type="text" value="${user.address1}" style="background-color:#fff;" disabled>
                                                    <input type="text" value="${user.address2}" style="background-color:#fff;" disabled>
                                                    <input type="button" class="highlight-button btn btn-very-small no-margin pull-left" id="updateUser" value="나의 정보수정" />
                                                    <input type="hidden" class="userId" value="${user.userId}" />
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-7 col-md-offset-1 no-padding-right xs-no-padding">
                            <table class="table cart-total">
                                <tbody>
                                    <tr>
                                        <th class="padding-two text-right no-padding-right font-weight-600 letter-spacing-2 text-small xs-no-padding">Cart Subtotal</th>
                                        <td class="padding-two text-right no-padding-right font-weight-600 black-text xs-no-padding sumPrice">0</td>
                                    </tr>
                                    <tr>
                                        <th class="padding-two text-right no-padding-right text-uppercase font-weight-600 letter-spacing-2 text-small xs-no-padding">배송비</th>
                                        <td class="padding-two text-uppercase text-right no-padding-right font-weight-600 black-text text-small xs-no-padding">Free</td>
                                    </tr>
                                    <tr>
                                        <td class="padding-one no-padding-right xs-no-padding" colspan="2">
                                            <hr>
                                        </td>
                                    </tr>
                                    <tr class="total">
                                        <th class="padding-two text-right no-padding-right font-weight-600 text-large xs-no-padding">총 주문금액</th>
                                        <td class="padding-two text-right no-padding-right font-weight-600 black-text text-large no-letter-spacing xs-no-padding sumPrice">0</td>
                                    </tr>
                                    <tr>
                                        <td class="padding-one no-padding-right xs-no-padding" colspan="2">
                                            <hr class="no-margin-bottom">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <a class="highlight-button-black-background btn no-margin pull-right checkout-btn" id="cartAddPurchase">구매하기</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- end content section -->
        
        
        
        
		
		
<%-- 		<jsp:include page="/layout/footer.jsp" /> --%>
	
		<jsp:include page="../common/js.jsp" />
</body>
</html>