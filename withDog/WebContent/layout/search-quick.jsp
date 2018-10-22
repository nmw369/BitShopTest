<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
	<jsp:include page="../common/css.jsp" />
	<style type="text/css">
	.quick{
		position:relative;
		right:300px;		
		float:right;
		width:70px;
		height:40px;
		background-color:#000;
		border-radius:30px;
		z-index:999;
		color:#fff;
	}
	
	.quick i {
		position:absolute;
		top:10px;
		right:12px;
		color:#fff;
	}
	</style>
	
	 <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function() {
		// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
		var floatPosition = parseInt($(".quick").css('top'));
		// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

		$(window).scroll(function() {
			// 현재 스크롤 위치를 가져온다.
			var scrollTop = $(window).scrollTop();
			var newPosition = scrollTop + floatPosition + "px";

			$(".quick").stop().animate({
				"top" : newPosition
			}, 700);

		}).scroll();

	});
	


	</script>

</head>

<body>

	<div class="search-cart-header">
		<div class="top-search">
			<a href="#search-header" class="quick header-search-form">
					<i class="fa fa-search search-button"><span style="font-size:13px;"> 검색</span></i>
			</a>
		</div>
	
		<form id="search-header" method="post" action="/product/listProduct" name="search-header" class="mfp-hide search-form-result">
           <div class="search-form position-relative">
               <button type="submit" class="fa fa-search close-search search-button" id="searchBtn"></button>
               <input type="text" name="searchKeyword" id="searchKeyword" class="search-input" placeholder="Enter your keywords..."  value="${! empty search.searchKeyword ? search.searchKeyword : '' }"   autocomplete="off">
               <input type="hidden" name="prodType" value="2">
           </div>
         </form>
	     
     </div>


        
</body>
</html>