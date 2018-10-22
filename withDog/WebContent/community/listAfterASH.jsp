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

	<title>동물교감 치유 후기 게시판</title>
	<style type="text/css">
	
	</style>
</head>



<script type="text/javascript">
function close_pop(flag) {
	self.location = "/user/loginUser";
    $('#loginModal').hide();
};


$(function () {
	$("#addAfterAshButton").on("click", function () {
		var userId = "${user.userId}";
		if(userId==null || userId=="" || userId==" "){
			swal("알 림", "로그인 후 이용가능합니다.").then(function(value){
				self.location = "/user/loginUser";
			});
			//$("#loginModal").show(); // 로그인하세요
			return;
		}
		else{
		self.location="/afterAsh/addAfterAsh";
		}
	})
})


function changeSelect () {
	$.ajax({
		url : "/ash/json/getAllHealingDogList",
		method : "GET",
		datatype : "json",
		headers : {
			"Accept" : "application/json",
			"Content-Type" : "application/json"
		},
		success : function (data) {
			console.log(data)
			for(var i = 0; i<data.healingDogs.length; i++){
			var healingDogNo = data.healingDogs[i].healingDogNo;
			var healingDogName = data.healingDogs[i].healingDogName;
			
					$.ajax({
						url : "/dogBreedDic/json/getDogBreed2",
						method : "POST",
						datatype : "json",
						async : false,
						data : JSON.stringify({
							dogNo : data.healingDogs[i].healingDogBreed.dogNo
						}),
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function (data) {
							console.log(data)
							$("select[name=searchKeyword]").append($('<option value='+healingDogNo+'>'+ healingDogName+' ['+data.key.dogBreedKO+']'+'</option>'));
						}
					})
			}
		}
	})
}


$(function name() {
	$("#searchButton").on("click", function () {
		fncGetList(1)
	})
})


$(function () {
	changeSelect();
	$("select[name=searchCondition]").on("change", function () {
		$("select[name=searchKeyword]").empty();
		changeSelect();
	})
})


function fncGetList(currentPage) {
 	$("#currentPage").val(currentPage)
	$("form").attr("method","post").attr("action","/afterAsh/listAfterAsh").submit();
}



</script>

<body>

	<jsp:include page="/layout/common-header.jsp" />
	<input type="hidden" name="userId" value="${!empty sessionUser.userId?sessionUser.userId:''}">
	 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog">
            <!-- 딤효과 <div class="opacity-medium bg-black"></div>-->
            <img class="parallax-background-img" src="../images/sub/603_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/603_tit.png"></h1>
                        <!-- end page title -->
                        <!-- page title tagline -->
                        <!-- 서브타이틀 <span class="white-text">1234</span>-->
                        <!-- end title tagline -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
        
        <!-- 검색 영역 시작 -->
        <div class="row">
	        <div id="addcomment" class="col-md-6 col-sm-12 blog-comment-form-main center-col text-center">
	            <div class="blog-comment-form">
	                <form>
	                	<input type="hidden" id="currentPage" name="currentPage" value=""/>
	                	<!-- select -->
                    	<!-- end select -->
	                    <select name="searchKeyword" class="col-md-8" style="padding-bottom:13px; padding-right:10px;">
	                    	<option value="0">원하시는 치유견을 선택하세요.</option>
	                    		<!-- 옵션 넣어라 -->
	                     </select>
                    	<!-- end select -->
                        <!-- button  -->
                        	<a id="searchButton" href="#" class="highlight-button-dark btn btn-medium btn-round button xs-margin-bottom-five">검색</a>
                        <!-- end button  -->
                     </form>
                 </div>
              </div>
          </div>
        <!-- end 검색 영역  -->
        
        <!-- 슬라이드 영역 시작 -->
            <div class="container padding-four">
                <div class="row text-center">
                    <div id="owl-demo" class="owl-carousel owl-theme dark-pagination dark-pagination-without-next-prev-arrow carousel slide">
                        <div class="item"><img src ="/images/uploadFiles/dogInfo/${listByViewCount[0].afterASHImageList[0]}" data-slide-to="0" alt="First slide" /></div>
                        <div class="item"><img src ="/images/uploadFiles/dogInfo/${listByViewCount[1].afterASHImageList[0]}" data-slide-to="1" alt="Second slide"/></div>
                        <div class="item"><img src ="/images/uploadFiles/dogInfo/${listByViewCount[2].afterASHImageList[0]}" data-slide-to="2" alt="Third slide"/></div>
                    </div>
                </div>
            </div>
        <!-- end 슬라이드 영역  -->
        
		<!-- 리스트 시작 -->
        <section class="wow fadeIn no-padding">
            <div class="container">
                <div class="row">
                <c:if test="${empty list}">
	                    	<h1 align="center">등록된 후기가 없습니다.</h1>
                </c:if>
                <c:forEach var="list" items="${list}">
                   	<div class="col-md-4 col-sm-4">
                        <div class="blog-post">
                            <div class="blog-post-images"><a href="getAfterASH.jsp">
                            
                            <c:if test="${empty list.afterASHImage || list.afterASHImage==''}">
                            	<a href="/afterAsh/getAfterAsh?afterASHNo=${list.afterASHNo}"><img src="http://placehold.it/800x500" alt=""></a>
                            </c:if>
                            <c:if test="${!empty list.afterASHImage }">
                            	<a href="/afterAsh/getAfterAsh?afterASHNo=${list.afterASHNo}"><img src ="/images/uploadFiles/dogInfo/${list.afterASHImageList[0]}" width="800px" height="500px" alt=""/></a>
                            </c:if>
                            </a></div>
                            <a href="getAfterASH.jsp" class="fund-title border-bottom border-gray" style="padding-bottom:10px;">${list.afterASHTitle} <a style="color: red">${list.deleteFlag==1?"(삭제된게시물)":""}</a></a><br/>
	                       <span class="fund-raising">회원ID ${list.user.userId } | 작성일 ${list.regDate} | 조회수 : ${list.viewCount}</span>
                        </div>
                    </div> 
               </c:forEach>
                    
                   <!-- pagination -->
	        		<jsp:include page="../common/pageNavigator_new.jsp"></jsp:include>
               	  <!-- end pagination -->   
                    
                </div><!-- end row -->
                   
                 <div class="text-center">
					<a style="cursor: pointer;" id="addAfterAshButton" ><span class="highlight-button btn btn-medium pull-right">후기 등록하기 </span></a>
				</div>
				
              </div><!-- end container -->       

         </section>
    	 <!-- end 리스트 -->
    	 
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