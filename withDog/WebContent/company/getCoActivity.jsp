<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1" />

<jsp:include page="/common/css.jsp" />


<title>활동내역</title>

<style type="text/css">

	.blog-details{
		color: #000;
		font-size: 14px;
		letter-spacing: 2px;
		padding-top :10px
		margin: 5px 0 20px;
		margin-top:20px;    
	}


</style>


<!-- 카운터 css -->
<style type="text/css">
<link rel="stylesheet" href="progresscircle.css">
</style>

<!-- 카운터 js -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" 
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" 
        crossorigin="anonymous">
</script>  

<script src="../js/progresscircle.js"></script>

<script type="text/javascript">

$(function(){
	  $('.circlechart').circlechart();

	});

</script>

</head>


<body>


	<jsp:include page="/layout/common-header.jsp" />
	
	
	 <!-- head section -->
         <section class="page-title parallax3 parallax-fix page-title-blog">
            <!-- 딤효과 <div class="opacity-medium bg-black"></div>-->
            <img class="parallax-background-img" src="../images/sub/100_bg.jpg" alt="" />
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-12 text-center animated fadeInUp">
                        <div class="no-margin-top margin-one"></div>
                        <!-- page title -->
                        <h1 class="white-text tit_png"><img src="../images/sub/102_tit.png"></h1>
                        <!-- end page title -->
                        <!-- page title tagline -->
                        <!-- 서브타이틀 <span class="white-text">1234</span>-->
                        <!-- end title tagline -->
                    </div>
                </div>
            </div>
        </section>
        <!-- end head section -->
        
        <!-- 소개글 content section -->
        <section class="no-padding-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-sm-10 text-center center-col">
                    
<!--                         <span class="margin-one no-margin-top display-block letter-spacing-2">With dog Activities</span> -->
<!--                         <h1>함께할개 활동내역 소개 </h1> -->
<!--                         <div class="separator-line bg-black margin-two no-margin-bottom"></div> -->
                        <img src="../images/title/t1_2.png">	
                        <p class="text-p width-120 center-col margin-two no-margin-bottom">사람이 동물과의 교감을 통해 정서적, 인지적, 사회적, 신체적인 문제를 예방하고 회복 효과를 얻는다. <br> 
                        	동물매개치유의 효과는 과학적으로 밝혀진 것만 수십 가지에 이른다. 대표적인 것이 질병 예방과 심리 치유 효과다.<br>
                        	치유활동에 참여하는 반려견은 활동 중 스트레스를 받지 않도록 정기적으로 건강관리를 받는다.<br>
                        	충분히 휴식을 취할 수 있도록 활동 횟수·시간도 조정한다</p>
                    </div>
                </div>
            </div>
        </section>
        
        
        <!-- content section -->
        <section class="wow fadeIn">
            <div class="container">
                <div class="row blog-3col">
                    <!-- post item -->
                    <div class="col-md-4 col-sm-6 col-xs-6 blog-listing wow fadeInUp" data-wow-duration="300ms">
                        <div class="blog-image"><img src="../images/company/image6.JPG" alt=""/></div>
                        <div class="blog-details">
                            <div class="blog-date">Posted by <a href="#">with dog</a> | 2018년 7월 31일</div>
                            <div class="blog-title"><a href="#">서울시 초등학교 동물교감치유 시행</a></div>
                            <div class="blog-title"><a href="#">동물교감교육은 동물매개심리 전문가의 지도 하에 이뤄진다. 세부적으로  동물 집 꾸미기,돌보기와 산책하기 ,감정나누기,동물 몸 알아보기 등의 활동으로 구성된다.아이들은 프로그램 기간 동안 함께 지낼 반려견에게 어울리는 이름을 지어주고, 반려견과 간단한 기본훈련을 진행한다.</a></div>
                            <div class="separator-line bg-black no-margin-lr"></div>
                        </div>
                    </div>
                    <!-- end post item -->
                    <!-- post item -->
                    <div class="col-md-4 col-sm-6 col-xs-6 blog-listing wow fadeInUp" data-wow-duration="600ms">
                        <div class="blog-image"><a href="#"><img src="../images/company/image5.JPG" alt=""/></a></div>
                        <div class="blog-details">
                            <div class="blog-date">Posted by <a href="#">with dog</a> | 2018년 6월 25일 </div>
                            <div class="blog-title"><a href="#">동물과 교감하며 심리치유 '호응'</a></div>
                            <div class="blog-title"><a href="#"> 치유사와 반려견이 사회복지관, 양로시설, 지역아동센터 등을 방문해 함께 어울리는 서울시의 '동물교감치유활동'이 호응을 얻고 있다.서울시는 취약계층의 정서 안정, 신체 활동을 위해 2015년 시작한 동물교감치유가 2천회를 돌파했다고 10일 밝혔다.</a></div>
                            <div class="separator-line bg-black no-margin-lr"></div>
                        </div>
                    </div>
                    <!-- end post item -->
                    <!-- post item -->
                    <div class="col-md-4 col-sm-6 col-xs-6 blog-listing wow fadeInUp" data-wow-duration="900ms">
                        <div class="blog-image"><a href="#"><img src="../images/company/image4.JPG" alt=""/></a></div>
                        <div class="blog-details">
                            <div class="blog-date">Posted by <a href="#">with dog</a> | 2018년 5월 25일</div>
                            <div class="blog-title"><a href="#">방과 후 시작하는 동물교감</a></div>
                            <div class="blog-title"><a href="#">실제 동물교육 프로그램에 참여한 아이들의 정서 함양 효과도 큰 것으로 확인됐다. 사전 대비 사후 변화를 조사한 결과 지난해  어린이 93명을 대상으로 참여 후 효과를 조사한 결과 참여한 아동의 경우 이전보다 인성은 13.4%,사회성은 14.5%,자아 존중감은 15% 각각 높아진 것으로 나타났다.</a></div>
                            <div class="separator-line bg-black no-margin-lr"></div>
                        </div>
                    </div>
                    <!-- end post item -->
                           <!-- post item -->
                    <div class="col-md-4 col-sm-6 col-xs-6 blog-listing wow fadeInUp" data-wow-duration="300ms">
                        <div class="blog-image"><img src="../images/company/image3.JPG" alt=""/></div>
                        <div class="blog-details">
                            <div class="blog-date">Posted by <a href="#">with dog | 2018년 4월 20일</div>
                             <div class="blog-title"><a href="#">병원에서 새로운 대안으로 떠오르는 동물교감치유</a></div>
                            <div class="blog-title"><a href="#">동물교감 치유 서비스 이용 후 사교성과 대인 적응성은 각각 15.0%, 13.1% 높아졌고, 주도성은 24.7%까지 올랐다.지속적으로 동물매개교육의 모델을 개발하면서 자폐나 치매 등 도움이 필요한 사람들을 대상으로 동물교감치유의 과학적인 효과를 검증해 나갈 계획이다.</a></div>
                            <div class="separator-line bg-black no-margin-lr"></div>
                        </div>
                    </div>
                    <!-- end post item -->
                    <!-- post item -->
                    <div class="col-md-4 col-sm-6 col-xs-6 blog-listing wow fadeInUp" data-wow-duration="600ms">
                        <div class="blog-image"><a href="#"><img src="../images/company/image2.JPG" alt=""/></a></div>
                        <div class="blog-details">
                            <div class="blog-date">Posted by <a href="#">with dog</a> | 2018년 3월 15일</div>
                            <div class="blog-title"><a href="#">치유사와 함께 방문하는 서비스 제공</a></div>
                            <div class="blog-title"><a href="#">서울시는 취약계층의 정서안정과 신체활동을 위해 시작한 '동물교감 치유활동'이 2000회를 돌파했다고 10일 밝혔다.'동물교감 치유활동'은 반려견과 주인이 함께 지역아동센터, 사회복지관, 양로시설을 방문해 동물과 함께 놀면서 아동과 어르신의 심리적 안정과 신체발달을 촉진하는 활동이다.</a></div>
                            <div class="separator-line bg-black no-margin-lr"></div>
                        </div>
                    </div>
                    <!-- end post item -->
                    <!-- post item -->
                    <div class="col-md-4 col-sm-6 col-xs-6 blog-listing wow fadeInUp" data-wow-duration="900ms">
                        <div class="blog-image"><a href="#"><img src="../images/company/image1.JPG" alt=""/></a></div>
                        <div class="blog-details">
                            <div class="blog-date">Posted by <a href="#">with dog</a> | 2018년 2월 25일</div>
                            <div class="blog-title"><a href="#">동물 교감치유 서비스 제공</a></div>
                            <div class="blog-title"><a href="#">동물교감치유서비스에 함께하는 반려견은 건강검진과 사회성·경계성 평가를 통해 적합 판정을 받아야 한다.참여하는 반려견은 건강검진을 통해 건강관리를 받고, 활동 중에 스트레스를 받지 않도록 충분한 휴식을 취할 예정이다.동물과 교감으로 몸과 마음을 치유하는데 큰 도움이 되고 있다.</a> </div>
                            <div class="separator-line bg-black no-margin-lr"></div>
                        </div>
                    </div>
                    <!-- end post item -->
        
        </section>
        <!-- end content section -->
		
	<jsp:include page="/layout/footer.jsp" />
	
	<jsp:include page="/common/js.jsp" />
	
</body>
</html>