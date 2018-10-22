<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<jsp:include page="/common/css.jsp" />

<title>애견상식</title>



<style type="text/css">
/* .aaaa{
overflow: hidden;
text-overflow: ellipsis;
display: -webkit-box;
-webkit-line-clamp: 3; /* 라인수 */
-webkit-box-orient: vertical;
word-wrap:break-word; 
line-height: 1.2em;
height: 3.6em; /* line-height 가 1.2em 이고 3라인을 자르기 때문에 height는 1.2em * 3 = 3.6em */
} */


/* start 툴팁 css꾸미기 */
	a.tip {
	    position: relative;
	}
	
	a.tip span {
	    display: none;
	    position: absolute;
/* 	    top: -80px; */
	    width: 400px;
	    height : 50px;
	    line-height: 40px;
	    opacity:0.7;
	    text-align : center;
	    vertical-align : middle;
	    padding: 5px;
	    z-index: 100;
	    background: #F59F16;
	    color: #fff;
	    -moz-border-radius: 5px; /* 파폭 박스 둥근 정도 */
	    -webkit-border-radius: 5px; /* 사파리 박스 둥근 정도 */
	}
	a.tip.no span {
	    display: none;
	    position: absolute;
/* 	    top: -80px; */
	    width: 400px;
	    height : 50px;
	    line-height: 40px;
	    opacity:0.7;
	    align-content : center;
	    padding: 5px;
	    z-index: 100;
	    background: RED;
	    color: #fff;
	    -moz-border-radius: 5px; /* 파폭 박스 둥근 정도 */
	    -webkit-border-radius: 5px; /* 사파리 박스 둥근 정도 */
	}
	
	a:hover.tip span {
	    display: block;
	}
	/* end 툴팁 css꾸미기 */
	

</style>

</head>

<body>

<script type="text/javascript">
var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ? true : false;

jQuery(document).ready(function($){
if(!isMobile) {
	$(document).ready(function() {
		
		// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
		var floatPosition = parseInt($(".sidebar").css('top'));
		// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );
// 	 if($(window).outerHeights())
		$(window).scroll(function() {
			var percent = ($(window).scrollTop() / ($(document).height() - $(window).height())) * 100;
			console.log(percent)
			console.log($(window).scrollTop()); 
			// 현재 스크롤 위치를 가져온다.
			if($(window).scrollTop() >300 &&percent <80){
				var scrollTop = $(window).scrollTop();
				var newPosition = scrollTop + floatPosition-400 + "px";
				
			
			}else if( percent >80){
				var scrollTop = $(window).scrollTop();
				var newPosition = scrollTop + floatPosition-700 + "px";
			}
			
			else if($(window).scrollTop() <300){
				return;
			}
// 			if($(window).scrollTop() >300 &&$(window).scrollTop() <1500){
// 				var scrollTop = $(window).scrollTop();
// 				var newPosition = scrollTop + floatPosition-500 + "px";
				
			
// 			}else if( $(window).scrollTop() >1500){
// 				var scrollTop = $(window).scrollTop();
// 				var newPosition = scrollTop + floatPosition-700 + "px";
// 			}
			
// 			else if($(window).scrollTop() <300){
// 				var scrollTop = $(window).scrollTop();
// 				var newPosition = scrollTop + floatPosition + "px";
// 			}
			
	 
			/* 애니메이션 없이 바로 따라감
			 $("#floatMenu").css('top', newPosition);
			 */
	 
			$(".sidebar").stop().animate({
				"top" : newPosition
			}, 200);
	 
		}).scroll();
	 
	});

}
});




function close_pop(flag) {
	self.location = "/user/loginUser";
    $('#loginModal').hide();
};

$(function () {
	$("#addDogInfoButton").on("click", function () {
		var userId = $("input[name=userId]").val()
		if(userId==null || userId=="" || userId==" "){
			swal("알 림", "로그인 후 이용가능합니다.").then(function(value){
				self.location = "/user/loginUser";
			});
			//$("#loginModal").show(); // 로그인하세요
			return;
		}
		else{
		self.location="/dogInfo/addDogInfo";
		}
	})
})

$(function () {
	$(".topic").on("click", function () {
		$("input[name=searchKeyword]").val("")
		$("input[name=searchCondition]").val($(this).val())
		fncGetList(1)
	})
	
	$("#sortingByView").on("click", function () {
		$("input[name=searchKeyword]").val("")
		$("input[name=sorting]").val(10)
		fncGetList(1)
	})
	
	$("#sortingByRecom").on("click", function () {
		$("input[name=searchKeyword]").val("")
		$("input[name=sorting]").val(11)
		fncGetList(1)
	})
	
	$("#searchButton").on("click", function () {
		$("input[name=searchCondition]").val("")
		$("input[name=sorting]").val(0)	
		fncGetList(1)
	})
	
	$("input[name=searchKeyword]").keydown(function (key) {				
		if(key.keyCode ==13){
			$("input[name=searchCondition]").val("")
			$("input[name=sorting]").val(0)	
			fncGetList(1);
		}
	});			
	
})


function fncGetList(currentPage) {
 	$("#currentPage").val(currentPage)
	$("form").attr("method","POST").attr("action","/dogInfo/listDogInfo").submit();
}


</script>


	<jsp:include page="/layout/common-header.jsp" />
	
	<input type="hidden" name="userId" value="${!empty sessionUser.userId?sessionUser.userId:''}">
	 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog">
            <img class="parallax-background-img" src="../images/sub/602_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/602_tit.png"></h1>
                        <!-- end page title -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
        
        
        <!-- content section -->
        <section class="wow fadeIn">
            <div class="container">
                <div class="row">
                
                    <!-- content  -->
                    <div class="col-md-8 col-sm-8">
                    
	                    <c:set var="i" value="0"/>
	                    <c:if test="${empty list}">
	                    	<h1>등록된 애견상식이 없습니다.</h1>
	                    </c:if>
						<c:forEach var="list" items="${list}">
						<c:set var="i" value="${i+1}"/>
                    
                        <!-- post item -->
                        <div class="blog-listing blog-listing-classic wow fadeIn">
                        
                            <!-- post image -->
                            <div class="blog-image" style="float:left; margin-right:15px; margin-bottom:15px;">
                            <a href="/dogInfo/getDogInfo?dogInfoNo=${list.dogInfoNo}">
                             <c:if test="${empty list.dogInfoImage}">
                            	<img  src="http://placehold.it/400x245" alt=""/>
                            </c:if>
                            <c:if test="${!empty list.dogInfoImage}">
                            	<img  src = "/images/uploadFiles/dogInfo/${list.dogInfoImage}" width="400px" height="200px" alt=""/>
                            </c:if>
                            </a>
                            
                            
                            
                            </div>
                            <!-- end post image -->
                            
                            <div class="blog-details">
                          
                                <div class="info-small-title" style="padding-top: 5px;">
                                  <c:choose>
                            	<c:when test="${list.dogInfoTopic=='1'}">
                            		<훈련>
                            	</c:when> 
                            	<c:when test="${list.dogInfoTopic=='2'}">
                            		<번식>
                            	</c:when> 
                            	<c:when test="${list.dogInfoTopic=='3'}">
                            		<위생>
                            	</c:when> 
                            	<c:when test="${list.dogInfoTopic=='4'}">
                            		<음식>
                            	</c:when> 
                            	<c:when test="${list.dogInfoTopic=='5'}">
                            		<행동>
                            	</c:when> 
                            	<c:when test="${list.dogInfoTopic=='6'}">
                            		<미용>
                            	</c:when> 
                            	<c:when test="${list.dogInfoTopic=='7'}">
                            		<기타>
                            	</c:when> 
                            </c:choose>
                                 |  조회수 ${list.viewCount}
                                 |  
                                 
                                 <span>${list.regDate}</span>
                                 </div>
                                <div class="info-title" style="margin-bottom:5px;">${list.dogInfoTitle} <a style="color: red">${list.deleteFlag==1?"(삭제된게시물)":""}</a></div>
                            		<%-- 작성자ID : ${list.user.userId} --%>
                                
                                <%-- <div class="aaaa">${list.dogInfoContent}</div> --%>
                                <!-- <div class="separator-line bg-black no-margin-lr margin-four"></div> -->
                                <div class="separator-line bg-black no-margin-lr margin-one"></div>
                                <div>
                                	<a class="info-like"><i class="fa fa-thumbs-o-up small-icon"></i>${list.recommended}</a>
                                	<a class="info-dislike"><i class="fa fa-thumbs-o-down small-icon"></i>${list.notRecommended}</a></div>
                                 	<c:if test="${list.notRecommended>=10}"> <!-- 나중에 조건 10보다 크게 줘야한다 -->
	                               		<c:if test="${(list.notRecommended/(list.recommended + list.notRecommended))*100>=20 && list.notRecommended/(list.recommended + list.notRecommended)*100<50}">
											<a id="getDogInfo" class="tip highlight-button btn btn-medium xs-no-margin-bottom" href="/dogInfo/getDogInfo?dogInfoNo=${list.dogInfoNo}">자세히 보기<span>부정확한 정보일 수 있습니다.</span></a>	
										 </c:if>
	                               		<c:if test="${(list.notRecommended/(list.recommended + list.notRecommended))*100>=50}">
											<a id="getDogInfo" class="tip no highlight-button btn btn-medium xs-no-margin-bottom" href="/dogInfo/getDogInfo?dogInfoNo=${list.dogInfoNo}">자세히 보기<span>부정확한 정보입니다.</span></a>	
										 </c:if>
									 </c:if>
									 <c:if test="${list.notRecommended<10 || (list.notRecommended/(list.recommended + list.notRecommended))*100<=20}"> <!-- 나중에 조건 10보다 크게 줘야한다 -->
                               			<a id="getDogInfo" class="tip highlight-button btn btn-medium xs-no-margin-bottom" href="/dogInfo/getDogInfo?dogInfoNo=${list.dogInfoNo}">자세히 보기</a>	
									 </c:if>
                            </div>
                        </div>
                        <!-- end post item -->
                        </c:forEach>
                        
                     
                    </div>
                    <!-- end content  -->
                    
                    
                    <!-- sidebar  -->
                    <form>
                    <input type="hidden" id="searchCondition" name="searchCondition" value="${!empty search.searchCondition?search.searchCondition:''}"/>
                    <input type="hidden" id="sorting" name="sorting" value="${!empty search.sorting?search.sorting:''}"/>
<!--                     <div class="col-md-3 col-sm-4 col-md-offset-1 xs-margin-top-ten sidebar floatMenu"> -->
                    <div class="col-md-3 col-sm-4 col-md-offset-1 xs-margin-top-ten sidebar">
                        <!-- widget  -->
                        <div class="widget">
                            
                                <i id="searchButton" class="fa fa-search close-search search-button"></i>
                                <input type="text" placeholder="아이디 또는 제목 입력" class="search-input" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : '' }" >
                                <input type="hidden" id="currentPage" name="currentPage" value=""/>
                                
                            
                        </div>
                        <!-- end widget  -->
                        <!-- widget  -->
                        <div class="widget">
                            <h5 class="info-sidebar-title font-weight-200">주제</h5>
                            <div class="thin-separator-line bg-dark-gray no-margin-lr"></div>
                            <div class="widget-body">
                                <ul class="category-list">
                                    <li class="topic" value="8" style="cursor:pointer"><a>전체보기<span ><!-- 건수  -->${topicCount[7]}</span></a></li>
                                    <li class="topic" value="1" style="cursor:pointer"><a>훈련<span ><!-- 건수  -->${topicCount[0]}</span></a></li>
                                    <li class="topic" value="2" style="cursor:pointer"><a>번식<span>${topicCount[1]}</span></a></li>
                                    <li class="topic" value="3" style="cursor:pointer"><a>위생<span>${topicCount[2]}</span></a></li>
                                    <li class="topic" value="4" style="cursor:pointer"><a>음식<span>${topicCount[3]}</span></a></li>
                                    <li class="topic" value="5" style="cursor:pointer"><a>행동<span>${topicCount[4]}</span></a></li>
                                    <li class="topic" value="6" style="cursor:pointer"><a>미용<span>${topicCount[5]}</span></a></li>
                                    <li class="topic" value="7" style="cursor:pointer"><a>기타<span>${topicCount[6]}</span></a></li>
                                    
                                </ul>
                            </div>
                        </div>
                        <!-- end widget  -->
                        <!-- widget  -->
                        <div class="widget">
                            <h5 class="info-sidebar-title font-weight-200">검색조건</h5>
                            <div class="thin-separator-line bg-dark-gray no-margin-lr"></div>
                            <div class="widget-body tags">
                                <a style="cursor: pointer;" id="sortingByView">조회순</a>
                                <a style="cursor: pointer;" id="sortingByRecom">추천순</a>
                                
                            </div>
                        <span style="cursor: pointer;" id="addDogInfoButton" class="highlight-button btn btn-medium" >애견상식 등록</span>
                        </div>
                        
                        <!-- end widget  -->
                    </div>
                    <!-- end sidebar  -->
                    </form>
                    
                </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12 wow fadeInUp">
                        <!-- pagination -->
						<jsp:include page="../common/pageNavigator_new.jsp"></jsp:include>
                        <!-- end pagination -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end content section -->
        
   	<!-- 1. 로그인하세요 모달 -->   	 
    <div id="loginModal" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
   		 <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />로그인 후 이용가능합니다.</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >닫기</span>
            </div>
      </div>
    </div>
      <!-- 1. 로그인하세요 모달 -->
        
	
	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>