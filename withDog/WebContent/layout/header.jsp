
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.nav > li{
margin-top:5px;
margin-bottom:0px;
}
</style>
<script type="text/javascript">
$(function(){
// 	//구매하기 버튼 이벤트
// 	$("#purchase").on("click", function(){
// 		self.location = "/purchase/addPurchase";
// 	});

	//상품이미지 클릭시 이벤트
	$(document).on("click", ".headerProdImage", function(){
		var index = $(".headerProdImage").index(this);
		var prodNo = $($("input[name='headerProdNo']")[index]).val();
		self.location = "/product/getProduct?prodNo=" + prodNo;
	});

	
	//장바구니 버튼 이벤트
	$("#cartList").on("click", function(){
		self.location = "/cart/getCartList";
	});
	
	//장바구니리스트 삭제 (리바인딩방식 : $(document).on 동적으로 생성했을때 다시 바인딩 해주는 방식)
	$(document).on("click", ".remove", function(){
		var index = $(".remove").index(this);
		var cartNo = $($("input[name='cartNo']")[index]).val();
		fncDeleteCart(cartNo, index);
	});
});

function fncDeleteCart(cartNo, index){
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
					getToolCartList();
				}
			}
		)
}

function getToolCartList(){
	//카트정보 받아오는 에이젝스
	$.ajax(
        {
           url : "/cart/json/getToolCartList",
           method : "GET",
           dataType : "json",
           headers : {
              "Accept" : "application/json",
              "Content-Type" : "application/json"
           },
        success : function(JSONData , status){
        	var sum = 0;
        	
//         	alert(JSONData.list.length)
        	//리스트 태그부분 공백처리 후 에이젝스 뿌려주기위한 과정
        	$("#toolCartList").html("");
        	for(i=0; i<JSONData.list.length; i++){
        		str='<li>'
                       + '<a title="Remove item" class="remove" style="cursor:pointer;">×</a>'
                       +'<input type="hidden" name="cartNo" value="'+JSONData.list[i].cartNo+'"/>'
                       + '<a href="#" class="headerProdImage">'
                       +  '<img width="90" height="90" src="/images/store/' + JSONData.list[i].product.prodImage + '">'+JSONData.list[i].product.prodName
                       +'<input type="hidden" name="headerProdNo" value="'+JSONData.list[i].product.prodNo+'"/>'
                       + '</a>'
                       + '<span class="quantity">' + JSONData.list[i].cartQuantity + ' × <span>' + JSONData.list[i].product.price + '원</span></span>'
              		   + '</li>'
              		   
              		 //공백인 toolCartList에 str 넣어주기
              		 $("#toolCartList").append(str);
              		   
              		 //총금액 구하기 (리스트의 수량곱하기상품가격을 sum에 넣어주기)
              		  sum += JSONData.list[i].cartQuantity * JSONData.list[i].product.price;
        	}//for문 end
        	
        	//amount클래스에 있는 텍스트를 sum값으로 변경
        	$(".amount").text(sum + "원");
        	
        	//리스트 카운트
        	$("#toolTipSubtitle").text("("+ JSONData.list.length + ")");
        	
        }
     });//ajax end
}

//툴팁용 장바구니리스트
$(function(){
	getToolCartList();
});







$(function(){
	$( ".mypage" ).on("click" , function() {
		var user = "${sessionScope.user}";
		if(user == ""){
			self.location = "/user/loginUser";
		}else{
			self.location = "/common/myPageMain?role=${sessionScope.user.role}";
		}
	 });
	
	
	$( "a[href='#']:contains('애견용품')" ).on("click" , function() {
		self.location = "/product/listProduct?prodType=0";
	 });
	
	$( "a[href='#']:contains('애견식품')" ).on("click" , function() {
		self.location = "/product/listProduct?prodType=1";
	 });
	
	//로고 클릭시
	$( ".logo-light" ).on("click" , function() {
		self.location = "/common/mainPage";
	 });
	
	//로고 클릭시
	$( ".logo-dark" ).on("click" , function() {
		self.location = "/common/mainPage";
	 });
	
});
</script>
<title>header</title>
</head>
<body>
<!-- navigation panel -->

		
		
        <nav class="navbar navbar-default navbar-fixed-top nav-transparent overlay-nav sticky-nav nav-border-bottom bg-white" role="navigation">
                    
            <div class="container">
            
                <div class="row">    
                    <!-- logo -->
                    <div class="col-md-2 pull-left"> 
                    	<a class="logo-light" href="#"><img alt="" src="../images/logo-black.png" class="logo" /></a>
                    	<a class="logo-dark" href="#"><img alt="" src="../images/logo-black.png" class="logo" /></a>
                   	</div>
                    <!-- end logo -->
                    
                    
                    <!-- toggle navigation -->
                    <div class="navbar-header col-sm-8 col-xs-2 pull-right">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        	<span class="sr-only">Toggle navigation</span> 
                        	<span class="icon-bar"></span>
                        	<span class="icon-bar"></span>
                        	<span class="icon-bar"></span>
                        </button>
                    </div>
                    <!-- toggle navigation end -->
                    
                    <!-- main menu -->
                    <div class="col-md-10 no-padding-right accordion-menu">
                    
                        <div class="navbar-collapse collapse">
                        	<ul class="col-md-7 col-xs-12 pull-right navbar-sm"  style="font-size:12px;">
                        				<c:if test="${sessionScope.user!=null}">
				                    	<li class="f-right mme top-cart no-padding-bottom" style="padding-right:10px;"><a class="shopping-cart no-padding-bottom" style="cursor:pointer;"><i class="fa  fa-shopping-cart no-margin-top"></i>장바구니 <span class="subtitle" id="toolTipSubtitle"></span></a>
					                    	<!-- shopping bag content -->
				                            <div class="cart-content">
				                                <ul class="cart-list" id="toolCartList" style="z-index:999;">
				                                    <li>
				                                        <a title="Remove item" class="remove" href="#">×</a>
				                                        <a href="#">
				                                            <img width="90" height="90" alt="" src="http://placehold.it/90x90">상품명
				                                        </a>
				                                        <span class="quantity">1 × <span>0원</span></span>
				                                        <a href="#">Edit</a>
				                                    </li>
				                                </ul>
				                                <p class="total">금액: <span class="amount">0원</span></p>
				                                <p class="buttons">
				                                    <a id="cartList" class="btn btn-very-small-white no-margin-bottom margin-seven no-margin-lr">장바구니</a>
				                                </p>
				                            </div>
				                            <!-- end shopping bag content -->
				                    	</li>
				                    	</c:if>
				                    	<li class="f-right mme" style="padding-right:10px;"><a class="mypage" href="#"><i class="fa  fa-user" ></i>${sessionScope.user.role != 'admin'?"마이페이지":"관리자페이지"}</a></li>
					                    <c:choose>
                            				<c:when test="${sessionScope.user==null}">
					                 		   <li class="f-right mme" style="padding-left:10px;"><a href="/user/addUser">회원가입</a></li>
					                    		<li class="f-right mme" style="padding-left:10px;"><a href="/user/loginUser">로그인</a></li>
					                    	</c:when>
					                    	<c:when test="${sessionScope.user!=null}">
					                    	<li class="f-right mme" style="padding-right:10px;"><a href="/user/logoutUser">로그아웃</a></li>
					                    	</c:when>
				                    	</c:choose>
					                <!-- 로그인 후 -->
			                    <!-- end 로그인,마이페이지  -->
                        	</ul>
                        	
                            <ul id="accordion" class="nav navbar-nav panel-group">
                            
                                <!-- menu item 회사소개-->
                                <li class="dropdown panel">
                                    <a href="#collapse1" class="dropdown-toggle collapsed" data-toggle="collapse" data-parent="#accordion" data-hover="dropdown">회사소개 <i class="fa fa-angle-down"></i></a>
                                    <!-- sub menu -->
                                    <ul id="collapse1" class="dropdown-menu mega-menu ">
                                        <!-- sub menu column  -->
                                        <li class="mega-menu-column col-sm-3">
                                            <!-- sub menu item  -->
                                            <ul>
                                                <li><a href="/common/getCoInfo">회사소개</a></li>
                                                <li><a href="/common/getCoActivity">활동내역</a></li>
                                            </ul>
                                            <!-- end sub menu item  -->
                                        </li>
                                        <!-- sub menu column end -->
                                    </ul>
                                    <!-- end sub menu -->
                                </li>
                                <!-- end menu item -->
                                
                                <!-- menu item 동물교감치유서비스-->
                                <li class="dropdown panel">
                                    <a href="#collapse2" class="dropdown-toggle collapsed" data-toggle="collapse" data-parent="#accordion" data-hover="dropdown">동물교감치유 <i class="fa fa-angle-down"></i></a>
                                    <!-- sub menu -->
                                    <ul id="collapse2" class="dropdown-menu mega-menu ">
                                        <!-- sub menu column  -->
                                        <li class="mega-menu-column col-sm-3">
                                            <!-- sub menu item  -->
                                            <ul>
                                                <li><a href="/ash/getASHInfo">동물교감치유 서비스란</a></li>
                                                <li><a href="/ash/listHealingDog">치유견 소개</a></li>
                                                <li><a href="/ash/listAsh">예약하기</a></li>
                                                <li><a href="/ash/getConsultingDogList">영상상담 신청<span class="menu-new">new</span></a></li>
                                            </ul>
                                            <!-- end sub menu item  -->
                                        </li>
                                        <!-- sub menu column end -->
                                    </ul>
                                    <!-- end sub menu -->
                                </li>
                                <!-- end menu item -->
                                
                                
                                <!-- menu item 유기견 분양-->
                                <li class="dropdown panel">
                                    <a href="#collapse3" class="dropdown-toggle collapsed" data-toggle="collapse" data-parent="#accordion" data-hover="dropdown">유기견 분양 <i class="fa fa-angle-down"></i></a>
                                    <!-- sub menu -->
                                    <ul id="collapse3" class="dropdown-menu mega-menu ">
                                        <!-- sub menu column  -->
                                        <li class="mega-menu-column col-sm-3">
                                            <!-- sub menu item  -->
                                            <ul>
                                                <li><a href="/abandDog/getAbandDogInfo">유기견 입양 안내</a></li>
                                                <li><a href="/abandDog/getAbandDogList">유기견 분양 공고<span class="menu-new">new</span></a></li>
                                            </ul>
                                            <!-- end sub menu item  -->
                                        </li>
                                        <!-- sub menu column end -->
                                    </ul>
                                    <!-- end sub menu -->
                                </li>
                                <!-- end menu item -->
                                
                                
                                <!-- menu item 스토어-->
                                <li class="dropdown panel">
                                    <a href="#collapse4" class="dropdown-toggle collapsed" data-toggle="collapse" data-parent="#accordion" data-hover="dropdown">스토어<i class="fa fa-angle-down"></i></a>
                                    <!-- sub menu -->
                                    <ul id="collapse4" class="dropdown-menu mega-menu ">
                                        <!-- sub menu column  -->
                                        <li class="mega-menu-column col-sm-3">
                                            <!-- sub menu item  -->
                                            <ul>
                                                <li><a href="#">애견용품 </a></li>
                                                <li><a href="#">애견식품<span class="menu-new">new</span></a></li>
                                            </ul>
                                            <!-- end sub menu item  -->
                                        </li>
                                        <!-- sub menu column end -->
                                    </ul>
                                    <!-- end sub menu -->
                                </li>
                                <!-- end menu item -->
                                
                                
                                <!-- menu item 커뮤니티-->
                                <li class="dropdown panel">
                                    <a href="#collapse5" class="dropdown-toggle collapsed" data-toggle="collapse" data-parent="#accordion" data-hover="dropdown">커뮤니티<i class="fa fa-angle-down"></i></a>
                                    <!-- sub menu -->
                                    <ul id="collapse5" class="dropdown-menu mega-menu ">
                                        <!-- sub menu column  -->
                                        <li class="mega-menu-column col-sm-3">
                                            <!-- sub menu item  -->
                                            <ul>
                                                <li><a href="/dogBreedDic/getDogBreed">견종백과</a></li>
		                                        <li><a href="/dogInfo/listDogInfo">애견상식</a></li>
		                                        <li><a href="/afterAsh/listAfterAsh">동물교감치유후기</a></li>
                                            </ul>
                                            <!-- end sub menu item  -->
                                        </li>
                                        <!-- sub menu column end -->
                                    </ul>
                                    <!-- end sub menu -->
                                </li>
                                <!-- end menu item -->
                                
                                
                                
                                <!-- menu item 크라우드 펀딩-->
                                <li class="dropdown panel">
                                    <a href="#collapse6" class="dropdown-toggle collapsed" data-toggle="collapse" data-parent="#accordion" data-hover="dropdown">크라우드 펀딩<i class="fa fa-angle-down"></i></a>
                                    <!-- sub menu -->
                                    <ul id="collapse6" class="dropdown-menu mega-menu ">
                                        <!-- sub menu column  -->
                                        <li class="mega-menu-column col-sm-3">
                                            <!-- sub menu item  -->
                                            <ul>
                                               <li><a href="/fund/fundGuid">크라우드펀딩이란?</a></li>
		                                        <li><a href="/fund/getFundList">크라우드펀딩 목록</a></li>
		                                        <li><a href="/fund/getFundResultList">완료된펀딩목록</a></li>
		                                        <li><a href="/fund/fundReq">크라우드펀딩 신청 문의</a></li>
                                            </ul>
                                            <!-- end sub menu item  -->
                                        </li>
                                        <!-- sub menu column end -->
                                    </ul>
                                    <!-- end sub menu -->
                                </li>
                                <!-- end menu item -->
                                
                            </ul>
                        </div>
                    </div>
                    <!-- end main menu -->
                </div>
            </div>
        </nav>
        <!-- end navigation panel -->
</body>
</html>