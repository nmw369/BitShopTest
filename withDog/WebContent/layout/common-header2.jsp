<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
  var hs = jQuery.noConflict();
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
hs(function(){
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
	$( ".logo-logo-dark" ).on("click" , function() {
		self.location = "/common/mainPage";
	 });
	
});
</script>
<title>header</title>
</head>
<body>
<!-- navigation panel -->
        <nav class="navbar navbar-default navbar-fixed-top nav-transparent overlay-nav sticky-nav nav-white nav-border-bottom" role="navigation">
            <div class="container">
                <div class="row">    
                    <!-- logo -->
                    <div class="col-md-2 pull-left"> 
                    	<a class="logo-light" href="#"><img alt="" src="../images/logo-white.png" class="logo" /></a>
                    	<a class="logo-dark" href="#"><img alt="" src="../images/logo-black.png" class="logo" /></a>
                   	</div>
                    <!-- end logo -->
                    
                    <!-- 로그인, 마이페이지  -->
                    <div class="col-md-2 no-padding-left search-cart-header pull-right">
                        <div class="top-cart">
                            <c:choose>
                            	<c:when test="${sessionScope.user==null}">
                             		<a href="/user/loginUser"><div class="subtitle">로그인</div></a>
                             	</c:when>
                            	<c:when test="${sessionScope.user!=null}">
                             		<a href="/user/logoutUser"><div class="subtitle">로그아웃</div></a>
                             		<a href="/common/myPageMain?role=${sessionScope.user.role}"><i class="fa  fa-user" ></i><div class="subtitle">${sessionScope.user.role != 'admin'?"마이페이지":"관리자페이지"}</div></a>
                             	</c:when>
                            </c:choose>
                        </div>
                    </div>
                    <!-- end 로그인,마이페이지  -->
                    
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
                    <div class="col-md-8 no-padding-right accordion-menu">
                        <div class="navbar-collapse collapse">
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
                                                <li class="dropdown-header">회사소개</li>
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
                                
                                <!-- menu item  동물교감치유서비스-->
                                <li class="dropdown panel">
                                    <a href="#collapse2" class="dropdown-toggle collapsed" data-toggle="collapse" data-parent="#accordion" data-hover="dropdown">동물교감치유<i class="fa fa-angle-down"></i></a>
                                    <!-- sub menu -->
                                    <ul id="collapse2" class="dropdown-menu mega-menu panel-collapse collapse">
                                        <li class="mega-menu-column col-sm-6">
                                            <!-- sub menu item  -->
                                            <ul>
                                                <li class="dropdown-header">동물교감치유 서비스</li>
                                                <li><a href="/ash/getASHInfo">동물교감치유 서비스란</a></li>
                                                <li><a href="/ash/listHealingDog">치유견 소개</a></li>
                                                <li><a href="/ash/listAsh">예약하기</a></li>
                                                <li><a href="/ash/getConsultingDogList">영상상담 신청<span class="menu-new">new</span></a></li>
                                            </ul>
                                            <!-- end sub menu item  -->
                                        </li>
                                    </ul>
                                    <!-- end sub menu -->
                                </li>
                                <!-- end menu item -->
                                
                                <!-- menu item 유기견 분양-->
                                <li class="dropdown panel">
                                    <a href="#collapse3" class="dropdown-toggle collapsed" data-toggle="collapse" data-parent="#accordion" data-hover="dropdown">유기견 입양<i class="fa fa-angle-down"></i></a>
                                    <!-- sub menu -->
                                    <ul id="collapse3" class="dropdown-menu mega-menu panel-collapse collapse">
                                        <li class="mega-menu-column col-sm-3">
                                            <!-- sub menu item  -->
                                            <ul>
                                                <li class="dropdown-header">유기견 입양</li>
                                               <li><a href="/abandDog/getAbandDogInfo">유기견 입양 안내</a></li>
                                                <li><a href="/abandDog/getAbandDogList">유기견 분양 공고<span class="menu-new">new</span></a></li>
                                            </ul>
                                            <!-- end sub menu item  -->
                                        </li>
                                    </ul>
                                    <!-- end sub menu -->
                                </li>
                                <!-- end menu item -->
                                
                                <!-- menu item 스토어-->
                                <li class="dropdown panel">
                                    <a href="#collapse4" class="dropdown-toggle collapsed" data-toggle="collapse" data-parent="#accordion" data-hover="dropdown">스토어<i class="fa fa-angle-down"></i></a>
                                    <!-- sub menu -->
                                    <ul id="collapse4" class="dropdown-menu mega-menu panel-collapse collapse">
                                        <!-- sub menu column  -->
                                        <li class="mega-menu-column col-sm-3">
                                            <!-- sub menu item  -->
                                            <ul>
                                                <li class="dropdown-header">스토어</li>
                                                <li><a href="#">애견용품 </a></li>
                                                <li><a href="#">애견식품<span class="menu-new">new</span></a></li>
                                            </ul>
                                            <!-- end sub menu item  -->
                                        </li>
                                        <!-- end sub menu column  -->
                                    </ul>
                                    <!-- end sub menu -->
                                </li>
                                <!-- end menu item -->
                                
                                <!-- menu item 커뮤니티-->
                                <li class="dropdown panel simple-dropdown">
                                    <a href="#collapse5" class="dropdown-toggle collapsed" data-toggle="collapse" data-parent="#accordion" data-hover="dropdown">커뮤니티<i class="fa fa-angle-down"></i></a>
                                    <!-- sub menu -->
                                    
                                            <!-- sub menu item  -->
                                            <ul id="collapse5" class="dropdown-menu mega-menu panel-collapse">
		                                        <li class="dropdown-header">커뮤니티</li>
		                                        <li><a href="/dogBreedDic/getDogBreed">견종백과</a></li>
		                                        <li><a href="/dogInfo/listDogInfo">애견상식</a></li>
		                                        <li><a href="/afterAsh/listAfterAsh">동물교감치유후기</a></li>
<!-- 		                                        <li><a href="../community/listOutSideSNS.jsp">SNS게시판</a></li> -->
<!-- 		                                        <li><a href="../community/listChatRoom.jsp">채팅방</a></li> -->
		                                    </ul>
                                            <!-- end sub menu item  -->
                                    <!-- end sub menu -->
                                </li>
                                <!-- end menu item -->
                                
                                <!-- menu item 크라우드 펀딩-->
                                <li class="dropdown panel simple-dropdown">
                                    <a href="#collapse6" class="dropdown-toggle collapsed" data-toggle="collapse" data-parent="#accordion" data-hover="dropdown">크라우드펀딩 <i class="fa fa-angle-down"></i></a>
                                    <!-- sub menu single -->
                                    <!-- sub menu item  -->
                                    <ul id="collapse6" class="dropdown-menu panel-collapse collapse" role="menu">
                                       <li class="dropdown-header">크라우드펀딩</li>
                                        <li><a href="/fund/fundGuid">크라우드펀딩이란?</a></li>
                                        <li><a href="/fund/getFundList">크라우드펀딩 목록</a></li>
                                        <li><a href="/fund/getFundResultList">완료된펀딩목록</a></li>
                                        <li><a href="/fund/fundReq">크라우드펀딩 신청 문의</a></li>
                                    </ul>
                                    <!-- end sub menu item  -->
                                    <!-- end sub menu single -->
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