<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<jsp:include page="/common/css.jsp" />

	<title>동물교감 치유 후기 상세</title>
<style type="text/css">
img{
	max-width:100%;
	max-height:100%;
}
	
</style>

</head>
<script type="text/javascript">
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
	                        <p class="text-large">${afterAsh.afterASHContent}</p>
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
						                             <c:forEach var="a" items="${afterAsh.afterASHImageList}">
						                                <li class="html wordpress lightbox-gallery">
						                                    <figure>
						                                        <div class="gallery-img">
						                                        	<a href="/images/uploadFiles/dogInfo/${a}"  title="">
						                                        	 <img  src = "/images/uploadFiles/dogInfo/${a}" width="400px" height="200px" alt=""/></a>
						                                        <figcaption>
						                                            <i class="icon-camera"></i>
						                                            <h3>함께할개</h3>
						                                            <p>With Dog</p>
						                                        </figcaption>
						                                    </figure>
						                                </li>
						                                </c:forEach>
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
                
                <!--  내용 4  시작  -->
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
	            </section>    
                <!-- end 내용  4  -->
                <div class="text-center">
					<a href="/afterAsh/listAfterAsh"><span class="highlight-button btn btn-medium pull-right">목록으로</span></a>
				</div>
            </div>
        </section> 
        <!-- end 내용 영역  -->

	
	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>