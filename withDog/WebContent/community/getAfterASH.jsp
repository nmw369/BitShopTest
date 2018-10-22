<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script async custom-element="amp-video" src="https://cdn.ampproject.org/v0/amp-video-0.1.js"></script>	
	
	<jsp:include page="/common/css.jsp" />

	<title>동물교감 치유 후기 상세</title>
</head>
<script type="text/javascript">
$(function () {
	$("a[name=deleteAfterAsh]").on("click", function () {
		$('#isDelete').show();
	})
})

$(function () {
	$("#ok").on("click", function () {
		$('#isDelete').hide();
		self.location = "/afterAsh/deleteAfterAsh?afterAshNo=${afterAsh.afterASHNo}";
		
	})
	$("#cancel").on("click", function () {
		$('#isDelete').hide();
	})
})


$(function () {
	var healingDogNo = ${afterAsh.healingDog.healingDogNo}
	$.ajax({
		url : "/ash/json/getHealingDog/"+healingDogNo,
		method : "GET",
		datatype : "json",
		headers : {
			"Accept" : "application/json",
			"Content-Type" : "application/json"
		},
		success : function (data) {
			$.ajax({
				url : "/dogBreedDic/json/getDogBreed2",
				method : "POST",
				datatype : "json",
				data : JSON.stringify({
					dogNo : data.healingDog.healingDogBreed.dogNo
				}),
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function (data) {
					console.log(data)
					$("#dogBreed").html('<span class="font-weight-600">치유견종:</span>'+data.key.dogBreedKO);
				}
			})
			$("#dogName").html('<span class="font-weight-600">치유견 이름:</span>'+data.healingDog.healingDogName);
			$("#dogAge").html('<span class="font-weight-600">치유견 생년월일:</span>'+data.healingDog.healingDogBirth);
			$("#dogChar").html('<span class="font-weight-600">치유견 성격:</span>'+data.healingDog.healingDogChar);
			$("#healer").html('<span class="font-weight-600">담당 치유사:</span>'+data.healingDog.healingDogHealer);
			$("#healingDogImg").attr('src','/images/uploadFiles/healingDog/'+data.healingDog.healingDogimage);
			
		}
	})
})


</script>
<body>

		<jsp:include page="../layout/header.jsp" />
		
		<!-- head section -->
         <section class="content-top-margin page-title parallax3 parallax-fix page-title-blog">
            <img class="parallax-background-img" src="../images/sub/300_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center wow fadeInUp">
                        <!-- page title -->
                        <h1 class="white-text">동물교감 후기 상세</h1>
                        <!-- end page title -->
                        <!-- page title tagline -->
                        <span class="white-text xs-display-none">with Dog</span>
                        <!-- end title tagline -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
        
        <!--  내용 영역  시작 //onepage-personal.html -->
        <section id="features" class="border-bottom no-padding-bottom xs-onepage-section">
            <div class="container">
            
            	<!--  제목  시작  -->
                <div class="row border-bottom border-gray text-center">
                    <div class="col-md-12 col-sm-6 sm-margin-bottom-ten">
                        <!-- post title  -->
                        <h2>${afterAsh.afterASHTitle}</h2>
                        <!-- end post title  -->
                        <!-- post date and categories  -->
                        <div class="blog-date" style="margin-bottom:20px">
                        	<a href="blog-masonry-3columns.html">회원ID ${afterAsh.user.userId}</a> | Date ${afterAsh.regDate}| 조회수 : ${afterAsh.viewCount}<a href="#"></a><i class="fa pull-right" ></i></a>
                       	</div>
                        <!-- end date and categories   -->
                    </div>
                </div>
                <!-- end 제목 -->
                
            	<!--  내용 1  시작  -->
            	<section class= "border-bottom border-gray">
	                <div class="row" >
	                    <!-- section title -->
	                    <div class="col-md-12 text-center">
	                        <span class="title-number">01</span><h3 class="section-title no-padding">치유견 정보</h3>
	                    </div>
	                    <!-- end section title -->
	                </div>
	                <div class="row margin-ten no-margin-bottom">
	                    <div class="col-md-6 col-sm-6 text-center xs-margin-bottom-ten">
<!-- 	                        <img src="http://placehold.it/300x300" alt=""/> -->
	                        <img id="healingDogImg" src = "" alt="" width="400px" height="400px"/>
	                    </div>
	                    <div class="col-md-6 col-sm-6 sm-margin-bottom-ten">
	                        <div class="col-md-12 col-sm-12 no-padding">
	                            <ul class="list-line margin-ten text-med">
	                                <li id="dogBreed"></li>
	                                <li id="dogName"></li>
	                                <li id="dogAge"></li>
	                                <li id="dogChar"></li>
	                                <li id="healer"></li>
	                            </ul>
	                        </div>
	                    </div>
	                </div>
	             </section> 
                <!-- end 내용 1 -->
                
                <!--  내용 2  시작  // blog-single-full-width.html -->
               <section class= "border-bottom border-gray">
	                <div class="row">
	                    <!-- section title -->
	                    <div class="col-md-12 text-center">
	                        <span class="title-number">02</span><h3 class="section-title no-padding">치유 후기</h3>
	                    </div>
	                    <!-- end section title -->
	                </div>
	                <div class="row margin-ten no-margin-bottom">
	                    <div class="col-md-12 col-sm-6 sm-margin-bottom-ten">
	                        <!-- post details text -->
	                        <p name=afterASHContent class="text-large">${afterAsh.afterASHContent}</p>
	                        <!-- end post details text -->
	                    </div>
	                </div>
            	</section>
                <!-- end 내용 2 -->
                
                <!--  내용 3  시작  //portfolio-grid-gutter-3columns.html-->
               <section class= "border-bottom border-gray" >
	                <div class="row">
	                    <!-- section title -->
	                    <div class="col-md-12 text-center">
	                        <span class="title-number">03</span><h3 class="section-title no-padding">교감 치유 사진</h3>
	                    </div>
	                    <!-- end section title -->
	                </div>
	                <div class="row no-margin-bottom">
	                    <div class="col-md-12 col-sm-6 sm-margin-bottom-ten">
	                        <div class="col-md-12 col-sm-12 no-padding">
              			     <!-- portfolio section -->
						        <section class="work-3col gutter no-margin-top content-section">
						            <div class="container">
						                <div class="row">
						                    <div class="col-md-12 grid-gallery overflow-hidden" >
						                        <div class="tab-content">
						                            <!-- work grid -->
						                            <ul class="grid masonry-items">
						                             <!-- work item ( external page ) -->
						                             <c:if test="${!empty afterAsh.afterASHImage}">
 						                             <c:forEach var="a" items="${afterAsh.afterASHImageList}">
						                                <li class="html wordpress lightbox-gallery">
						                                    <figure>
						                                        <div class="gallery-img">
						                                        	<a href="/images/uploadFiles/dogInfo/${a}" title="">
						                                        	 <img  src = "/images/uploadFiles/dogInfo/${a}" width="400px" height="200px" alt=""/></a>
						                                        <figcaption>
						                                            <i class="icon-camera"></i>
						                                            <h3>함께할개</h3>
						                                            <p>With Dog</p>
						                                        </figcaption>
						                                    </figure>
						                                </li>
						                                </c:forEach>
 						                                </c:if>
						                                <!-- work item ( lightbox gallery ) -->
						                                <!-- end work item -->
						                             </ul>  
												</div>
	              							</div>
	              						</div>
	              					</div>
	              				</section>
	              			</div>
	              		</div>	
	              	</div>		
                </section>
                <!-- end 내용  3  -->
                
              <%--   <!--  내용 4  시작  -->
                <section>
	                <div class="row">
	                    <!-- section title -->
	                    <div class="col-md-12 text-center">
	                        <span class="title-number">04</span><h3 class="section-title no-padding">교감 치유 동영상</h3>
	                    </div>
	                    <!-- end section title -->
	                </div>
	                <div class="row margin-ten no-margin-bottom">
	                    <div class="col-md-12 col-sm-6 sm-margin-bottom-ten">
	                        <div class="col-md-12 col-sm-12 no-padding">
	 							<!-- 비디오 시작 -->
						        <section class="wow fadeIn no-padding bg-black">
						            <div class="container">
						                <div class="row margin-ten">
						                    <!-- video popup -->
						                    <div class="col-md-5 col-sm-10 text-center center-col white-text wow fadeIn">
						                        <a class="popup-youtube" href="https://www.youtube.com/watch?v=mcixldqDIEQ"><i class="icon-video white-text large-icon margin-ten no-margin-top"></i></a>
						                        <h1 class="white-text video-title">Open Video in Popup</h1>
						                        <h6>What's the story behind the project? Check the episode to discover how the Make Sense Project was built.</h6>
				
						                        
						                        
						                    </div>
						                    <!-- end video popup -->
						                </div>
						            </div>
						        </section>
		                        <!-- end비디오 시작 -->
	                        </div>
	                    </div>
	                </div>
	            </section>    --%>
                <!-- end 내용  4  -->
                <div class="text-center">
					<a href="/afterAsh/listAfterAsh"><span class="highlight-button btn btn-medium pull-right">목록으로</span></a>
					<c:if test="${user.userId==afterAsh.user.userId}">
					<a href="/afterAsh/updateAfterAsh?afterASHNo=${afterAsh.afterASHNo}"><span class="highlight-button btn btn-medium pull-right">수정</span></a>
					<a style="cursor: pointer;" name="deleteAfterAsh"><span class="highlight-button btn btn-medium pull-right">삭제</span></a>
					</c:if>
					<c:if test="${user.role=='admin'}">
					<a style="cursor: pointer;" name="deleteAfterAsh"><span class="highlight-button btn btn-medium pull-right">삭제</span></a>
					</c:if>
				</div>
            </div>
            		       <!--                  <amp-video
													  width="640"
													  height="360"
													  src="/images/uploadFiles/dogInfo/tokyo.mp4"
													  poster="/images/uploadFiles/dogInfo/20180715170356래브라도 리트리버.jpg"
													   controls>
													  <div fallback>
													    <p>This browser does not support the video element.</p>
													  </div>
												</amp-video> -->
            
        </section> 
        <!-- end 내용 영역  -->
    <!-- 1. 삭제여부 모달 -->
    <div id="isDelete" style="background-color: rgba(0,0,0,0.4); width: 100%"  class="modal col-lg-3 col-md-4 col-sm-5 center-col text-center">
      <div class="col-lg-3 col-md-6 col-sm-7 col-xs-11 center-col bg-white text-center modal-popup-main animated fadeIn"  style=" padding:35px; top: 30%">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">알 림</span></b></span></p>
                <p class="borderline-gray"></p>
                <p style="text-align: center; line-height: 1.5;"><br />삭제하시겠습니까?</p>
                <p><br /></p>
            <div style="cursor:pointer; text-align: center;padding-bottom: 10px;padding-top: 10px;">
                <span id="ok" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >확인</span>
                <span id="cancel" class="highlight-button-dark btn btn-medium no-margin pop_bt" style="font-size: 13pt;" >취소</span>
            </div>
      </div>
    </div>
      <!-- 1. 삭제여부 모달 -->
	
	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>