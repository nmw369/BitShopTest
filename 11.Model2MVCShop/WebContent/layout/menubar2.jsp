<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	.dropdown:hover > .dropdown-menu{
		display : block;
	}
	
	.rightMenu{
		position:absolute;
		float:right;
		top:0;
		left:158px;
	}
</style>




<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<!-- <a class="navbar-brand" href="/index.jsp">Pets Comming</a> -->
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
			<button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target">

			<ul class="nav navbar-nav">
				
				<li class="dropdown">
						
							<li class="dropdown">
								<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
									<span >크라우드펀딩(후원)</span>
									<span class="caret"></span>
								</a>
								<ul class="dropdown-menu rightMenu">
									<li><a href="#">크라우드 펀딩 안내</a></li>
									<li><a href="#">크라우드 펀딩 리스트</a></li>
									<li><a href="#">완료된 후원 리스트</a></li>
									<li><a href="#">크라우드펀딩 신청문의</a></li>
								
								</ul>
							</li>
							
						</ul>
					</li>
				
				
				
				
								
			</ul>
	      
	        	
	              </div> 	
	    		</div>
    	</div>
   	 	<!-- div : Block 형식 공간분할
   	 	span : Inline형식 공간분할
   	 	==>각종 Tag를 Block/Inline형식 Tag로 분할하면
   	 	Block 형식 Tag:div,h1~h6,p,ol,ul,li,table,form -->
   	 	
   	 	



<script type="text/javascript">
	function loginCheck(){
		/* var id=$('input:text').val();
		var pw=$('input:password').val();
		
		if(id == null || id.length < 1){
			alert('아이디를 입력하지 않았습니다.');
			$('input:text').focus();
			return;
		}
		
		if(pw == null || pw.length < 1){
			alert('비밀번호를 입력하지 않았습니다.');
			$('input:password').focus();
			return;
		} */
		
/* 		$('.navbar-form').attr('method','get').attr('action','${param.uri}user/login').submit(); */
		
		$('.navbar-form').attr('method','get').attr('action','user/NaverLogin').submit();
		
		/* $('.navbar-form').attr('method','get').attr('action','/NaverLogin').submit(); */
		
		/* $(window.parent.frames["rightFrame"].document.location).attr("href","/user/NaverLogin"); */
	}
	
	$(function(){
	
		$("a.user-info").bind("click",function(){
			self.location.href="/user/getUser?userId=${sessionScope.user.userId}";
		});
	
		$("a:contains('크라우드펀딩(후원)')").bind("click", function(){
			self.location.href="/withdog.jsp";
		});
		
		$("a:contains('크라우드 펀딩 리스트')").bind("click", function(){
			self.location.href="/product/addProductView";
		});
	
		$("a:contains('크라우드 펀딩 안내')").bind("click", function(){
			self.location.href="/product/listProduct?menu=manage";
		});
	
		$("a:contains('완료된 후원 리스트')").bind("click", function(){
			self.location.href="/purchase/listSale?cancelCode=0";
		});
		$("a:contains('크라우드펀딩 신청문의')").bind("click", function(){
			self.location.href="/purchase/mainView";
		});
	
		$("a:contains('상품검색')").bind("click", function(){
			self.location.href="/product/listProduct?menu=search";
		});
	
		$("a:contains('구매이력조회')").bind("click", function(){
			self.location.href="/purchase/listPurchase?searchKeyword=purchaseList&searchCondition=${user.userId}";
		});
		
		$("a:contains('구매취소목록')").bind("click", function(){
			self.location.href="/purchase/cancelList?cancelCode=1";
		});
		
		$("button:contains('Log in')").bind("click",function(){
			loginCheck();
		});
		
		$(".navbar-form button:contains('Sign in')").bind("click",function(){
			self.location.href="/user/addUser";
		});
		
		
		$("a:contains('로그아웃')").bind("click",function(){
			self.location.href="/user/logout";
		});
		
		$("a:contains('실시간채팅')").bind("click",function(){
			popWin 
			= window.open("/product/chating","popWin", "left=300,top=200,width=500,height=250,marginwidth=0,marginheight=0,scrollbars=no,scrolling=no,menubar=no,resizable=no");
		});
		
		
		/* $(".navbar-form button:contains('카카오')").bind("click",function(){
			self.location.href="${param.uri}purchase/kakaoPay";
		}); */
	
	});
</script>

