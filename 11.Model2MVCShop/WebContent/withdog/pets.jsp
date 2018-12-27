<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
	<head>
		<meta charset="EUC-KR">
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		
		<!--   jQuery , Bootstrap CDN  -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
		
		<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
		<style>
	        body {
	            padding-top : 70px;
background: url("images/uploadFiles/dog.jpg") no-repeat center center fixed; 
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
     font-size: 1.5vw;
	        }
	        #test p{
    font-size: 7vw;
}
#test1 p{
    font-size: 8vw;
}
    	</style>
		<!-- 글자 반반 색상변경 -->
<style type="text/css">
   /* #test p{color:blue;} */
   #test p{
   position: relative;
  display: inline-block;
  background: linear-gradient(-90deg, #3498db 50%,#ffffff 50%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  white-space: nowrap;
   }
   #test1 p{
   position: relative;
  display: inline-block;
  background: linear-gradient(-90deg, #ffffff 50%,#3498db  50%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  white-space: nowrap;
   }
</style>
<!-- css편집을 위한 링크 -->
<link rel="stylesheet" href="/css/animate.css" />

<script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
<script>
  $(function(){
	  $('#test').removeClass().addClass("slideInDown animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	      $(this).removeClass();
	    });
	  $('#test1').removeClass().addClass("slideInLeft animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	      $(this).removeClass();
	    });
  });
  

</script>
	</head>
	
	<body>
	
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
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >펫 커밍</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">펫커밍이란?</a></li>
						<li><a href="#">구성원소개</a></li>
					</ul>
				</li>
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >userId</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">내정보보기</a></li>
						<li><a href="#">결제내역</a></li>
						<li><a href="#">유기견입양내역</a></li>
						<li><a href="#">동물매개치료내역</a></li>
						<li><a href="#">찜목록</a></li>
						<li><a href="#">장바구니</a></li>
						<li><a href="#">후원기록</a></li>
					</ul>
				</li>
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >유기견분양</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">입양안내</a></li>
						<li><a href="#">입양공고</a></li>
						<li><a href="#">유기동물보호센터</a></li>
					</ul>
				</li>
				
				
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >동물매개치료</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">동물매개치료란?</a></li>
						<li><a href="#">동물매개치료활동</a></li>
						<li><a href="#">동물매개치료신청</a></li>
						<li><a href="#">실시간 영상 상담</a></li>
					</ul>
				</li>
				
				
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >애견백과</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">견종백과사전</a></li>
						<li><a href="#">애견상식</a></li>						
					</ul>
				</li>
				
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >펫커밍 스토어</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">애견용품</a></li>
						<li><a href="#">애견식품</a></li>
						<li><a href="#">장바구니</a></li>						
					</ul>
				</li>
				
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >커뮤니티</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">펫 커밍 활동</a></li>
						<li><a href="#">펫 커밍 후기</a></li>
						<li><a href="#">펫 커밍 반려견 영상</a></li>
					
					</ul>
				</li>
				
				
				<li class="dropdown">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<span >유기견후원</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">유기견정보</a></li>
						<li><a href="#">후원현황</a></li>
						<li><a href="#">후원후기</a></li>
						
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
   	 	
   	 	
 <div class="container">  	 	
   	 	<div class="row">
  <div class="col-md-3">
  	  
  	<div class="panel panel-info">
  		<div class="panel-heading">
  			<h3 class="panel-titel">
  				<i class="glyphicon glyphicon-heart">
  					Quick bar
  				</i>
  			</h3>
  		</div>
  	<ul class="list-group">
  		<li class="list-group-item"><a href="/petsmain.jsp">관리자</a></li>		
	  	<li class="list-group-item"><a href="#">채팅상담(챗봇)</a></li>
		<li class="list-group-item"><a href="#">반려견실시간영상</a></li>
		<li class="list-group-item"><a href="#">가까운병원/보호소</a></li>
  	</ul>
  	</div>
  	</div>
  
	</div>
	</div>	


<div id="test">
<p>Welcome to</p>
</div>
<div id="test1" align="right">
<p> The Pets Comming</p>
</div>
	
	
	</body>
</html>