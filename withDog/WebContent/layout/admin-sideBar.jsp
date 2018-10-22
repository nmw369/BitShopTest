<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
	<jsp:include page="../common/css.jsp" />
	<title>Admin page</title>
	
	
	 <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script type="text/javascript">
	
	$(function () {
		
		//스토어
		$("a:contains('판매관리')").on("click",function(){
	 		$(self.location).attr("href","/purchase/getSalesListAdmin");	 			 		
	 	});
		
		$("a:contains('상품문의관리')").on("click",function(){
	 		$(self.location).attr("href","/inquiry/getInquiryListAdmin");	 			 		
	 	});
		
		
		//펀드
		$( "a:contains('회원별 후원내역')" ).on("click" , function() {
			$(self.location).attr("href","/fund/getFundUserListAdmin");
 		});
		
		
		//동물교감치유
	 	$( "a:contains('예약관리')" ).on("click" , function() {
			$(self.location).attr("href","/ash/getAshReservationAdminList");
 		});
	 	
	 	$("a:contains('영상상담신청관리')").on("click",function(){
	 		$(self.location).attr("href","/ash/getConsultingAdminList");	 			 		
	 	});
	 	
		
		//회원
	 	$( "a:contains('회원관리')" ).on("click" , function() {
			$(self.location).attr("href","/user/getUserListAdmin");
 		});
		
	 	$( "a:contains('회원전체통계')" ).on("click" , function() {
			$(self.location).attr("href","/user/getRateAllUserCon");
 		});
	 	
	 	$( "a:contains('최근5일 통계')" ).on("click" , function() {
			$(self.location).attr("href","/user/getUserConListAdmin");
 		});
	 	
		
	});
	
	</script>

</head>

<body>
		
 <!-- sidebar  -->
    
     <!-- widget  -->
     <div class="widget">
         <h5 class="widget-title font-alt">스토어</h5>
         <div class="thin-separator-line bg-dark-gray no-margin-lr"></div>
         <div class="widget-body">
             <ul class="category-list">
                 <li><a href="#">판매관리</a></li>
                 <li><a href="#">상품문의관리</a></li>
             </ul>
         </div>
     </div>
     <!-- end widget  -->
     
      <!-- widget  -->
     <div class="widget">
         <h5 class="widget-title font-alt">크라우드펀딩</h5>
         <div class="thin-separator-line bg-dark-gray no-margin-lr"></div>
         <div class="widget-body">
             <ul class="category-list">
                 <li><a href="#">회원별 후원내역</a></li>
             </ul>
         </div>
     </div>
     <!-- end widget  -->
     
     <!-- widget  -->
     <div class="widget">
         <h5 class="widget-title font-alt">동물교감치유</h5>
         <div class="thin-separator-line bg-dark-gray no-margin-lr"></div>
         <div class="widget-body">
             <ul class="category-list">
                 <li><a href="#">예약관리</a></li>
                 <li><a href="#">영상상담신청관리</a></li>
             </ul>
         </div>
     </div>
     <!-- end widget  -->
     
     <!-- widget  -->
     <div class="widget">
         <h5 class="widget-title font-alt">회원</h5>
         <div class="thin-separator-line bg-dark-gray no-margin-lr"></div>
         <div class="widget-body">
             <ul class="category-list">
                 <li><a href="#">회원관리</a></li>
                 <li><a href="#">회원전체통계</a></li>
                 <li><a href="#">최근5일 통계</a></li>
             </ul>
         </div>
     </div>
     <!-- end widget  -->
     
     
     <!-- widget  -->
     <div class="widget">
         <h5 class="widget-title font-alt">빠른 상담</h5>
         <div class="thin-separator-line bg-dark-gray no-margin-lr"></div>
         <div class="widget-body">
             <ul class="category-list">
                 <li><a href="/quick/getChatBotList">빠른상담 관리</a></li>
                 <li><a href="/quick/getRateChatBot">질문 통계</a></li>
             </ul>
         </div>
     </div>
     <!-- end widget  -->
    
                       
        
</body>
</html>